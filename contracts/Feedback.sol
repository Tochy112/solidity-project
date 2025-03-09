// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

//create feedback contract
contract Feedback {
    address private owner;

   struct Feedbacks {
    string details;
    address userAddress;
   }

   Feedbacks[] private feedbacks;

   constructor() {
       owner = msg.sender;
   }

    //modifier just works like a middleware in this case
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
   
    // create a feedback
   function createFeedback(string memory _details, address _userAddress) public onlyOwner{
    feedbacks.push(Feedbacks(_details, _userAddress));
   }

    // fetch all feedbacks
   function getAllFeedbacks() public view returns(Feedbacks[] memory) {
    return feedbacks;
   }

    // delete a feedback
   function deleteFeedback(uint _index) public onlyOwner{
     require(_index < feedbacks.length, "No index found");
     
     for (uint i = 0; i < feedbacks.length - 1; i++) {
        feedbacks[i] = feedbacks[i + 1];
     }
     feedbacks.pop();
   }
}
