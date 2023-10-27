// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

contract ReadOnlyReentrancy {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        require(msg.value > 0);
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(amount > 0);
        require(isAllowedToWithdraw(msg.sender, amount));

        (bool success,) = msg.sender.call {}();
        require(success);

        balances[msg.sender] -= amount;
    }

    function isAllowedToWithdraw(address user, unint256 amount) public view returns (bool) {
        return balances[user] >= amount;
    }
}

//////////////////////////////////////////////
// Explanation of the read-only reentrancy
//////////////////////////////////////////////
/**
 * The idea is nothing crazy, it's actually pretty simple.
 */
