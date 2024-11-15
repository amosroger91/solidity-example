// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownership {

    address public owner;
    uint public lastTransferTimestamp;

    // Event to log ownership transfers
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // Modifier to restrict function to the current owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;  // Set the deployer as the owner
        lastTransferTimestamp = block.timestamp;
    }

    // Function to transfer ownership
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner cannot be the zero address");
        
        address previousOwner = owner;
        owner = newOwner; // Change the owner

        // Log the ownership transfer event
        emit OwnershipTransferred(previousOwner, newOwner);
        
        lastTransferTimestamp = block.timestamp;  // Update the timestamp of the last transfer
    }

    // Function to allow the contract to receive ETH (if necessary)
    receive() external payable {}
}
