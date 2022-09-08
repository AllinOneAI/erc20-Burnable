// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./IERC20.sol";

contract iUseArchBtwERC20Token is IERC20 {
    

    constructor {

        uint256 private memory dTimeStamp = block.timestamp;

        //public
        mapping(address => uint256) public balanceOf;
        mapping(address => mapping(address => uint)) public allowance;
        string public name = "I Use Arch Btw";
        string public symbol = "IUAB";
        uint8 public decimals = 18;
        uint public totalSupply = 1000^decimals;
        address public owner = msg.sender;
        uint256 public afterTime = dTimeStamp + 3 minutes;   


    }  

/*/////

custom modifiers

*//////  

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    modofier canBurn{

    }

/*/////

miscellaneous functions 

*/////

    function setAfterTime() public {

    }

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

    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
