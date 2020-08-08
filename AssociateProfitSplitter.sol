pragma solidity ^0.5.0;
// SPDX-License-Identifier: UNLICENSED

contract AssociateProfitSplitter { 
        
    address payable employee_one; 
    address payable employee_two;
    address payable employee_three; 
    
    //constructor
    constructor(address payable _one, address payable _two, 
        address payable _three) public {
            employee_one = _one;
            employee_two = _two;
            employee_three = _three;
    }
    
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        uint amount = msg.value / 3;
        employee_one.transfer(amount);
        employee_two.transfer(amount);
        employee_three.transfer(amount);
        uint remainder = msg.value - amount * 3;
        msg.sender.transfer(remainder);
    }
    
    function() external payable {
        deposit();
    }
}
