pragma solidity ^0.5.0;
// SPDX-License-Identifier: UNLICENSED

contract DeferredEquityPlan {
    
    address human_resources;

    address payable employee; // Bob
    bool active = true; // Employee active at start
    
    uint total_shares = 1000;
    uint annual_employee_distribution = 250;
    uint start_time = now;
    uint public unlock_time = now + 365 days;
    uint public distributed_shares;
    
    constructor(address payable _employee) public {
        human_resources = msg.sender;
        employee = _employee;
    }

    function distribute() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to execute this contract.");
        require(active == true, "Contract not active.");
        require(unlock_time <= now, "Shares have not vested yet");
        require(distributed_shares < total_shares, "Share have been completely distributed");
        
        unlock_time += 365 days;
        
        distributed_shares = (now - start_time) / 365 days * annual_employee_distribution;

        if (distributed_shares > 1000) {
            distributed_shares = 1000;
        }
    }

    // HR and employee can deactivate at will
    function deactivate() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to deactivate this contract.");
        active = false;
    }

    // Since we do not need to handle Ether in this contract, revert any Ether sent to the contract directly
    function() external payable {
        revert("Do not send Ether to this contract!");
    }
}