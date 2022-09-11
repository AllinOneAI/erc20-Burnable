// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./IERC20.sol";

contract iUseArchBtwERC20Token is IERC20 {
    

        
    //public
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name;
    string public symbol;
    uint8 public decimals;
    uint public totalSupply;
    address public owner;
    uint256 public afterTime;  

    constructor () {

       name = "I Use Arch Btw";
       symbol = "IUAB";
       decimals = 18;
       totalSupply = 1000^decimals;
       owner = msg.sender;
       afterTime = block.timestamp + 3 minutes;  
        balanceOf[msg.sender] = totalSupply;

    }  

/*/////

custom modifiers

*//////  

    modifier onlyOwner {                                                      //this modifier checks if it's owner of the contract, who calls the function
        require(msg.sender == owner, 
        "You can not mint tokens as you're not contract owner");
        _;
    }

    modifier canBurn {
        require(block.timestamp > afterTime, "It's not time yet");           // this modifier checks if it's enough time passed since deployment of the contract, so you can burn your tokens 
        _;
    }

/*/////

miscellaneous functions 

*/////

   // function setAfterTime() public {}

/*/////

core functions

*/////

    function transfer(address recipient, uint amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external onlyOwner {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external canBurn {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
