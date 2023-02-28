// SPDX-License-Identifier: MLT
pragma solidity ^0.8;
contract EventContract{
    struct Event{
        address organizer;
        string name;
        uint date;
        uint price;
        uint ticketCount;
        uint ticketRemain;
    }
    mapping(uint=>Event) public events;// crearting mapping for multiple events
    mapping(address=>mapping(uint =>uint)) public tickets;// this mapping is used to hold the event tickets
    uint public nextId;// id of the event

    function  createEvent(string memory name,uint date,uint price,uint ticketCount) external {
        require (date>block.timestamp,"You can organize event for future");
        require(ticketCount>0,"you can organize event only if you create more tha 0 tickets");
        events[nextId]=Event(msg.sender, name,date,price,ticketCount,ticketCount);// holding event on event[0]
        nextId++;// then updating the event

    }
    // this function is used to buy tickets
 function buyTicket(uint id,uint quantity) external payable{
   require(events[id].date!=0,"This Event does not exsit");
   require(events[id].date>block.timestamp,"Event has already occured");
    Event storage _event = events[id];
   require(msg.value==(_event.price*quantity),"Ethere is not enough");
   require(_event.ticketRemain>=quantity,"Not enough tickets");
   _event.ticketRemain-=quantity;
   tickets[msg.sender][id]+=quantity;

 }
}