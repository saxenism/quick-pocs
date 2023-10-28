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
 *  The idea is nothing crazy, it's actually pretty simple.
 *     If we consider that this contract to be the core contract for a protocol
 *     and then some other protocol builds on top of this and depends upon the `isAllowedToWithdraw` function
 *     to carry out some operation on their own protocols for a user, then they can be blindsided.
 *     How?
 *     Well, the *attacker* would call `withdraw` with an `amount` that might make the `not allowed to withdraw`, but since they have
 *     control over the execution flow when calling the function `withdraw` and that time their balance hasn't been updated, they can call the
 *     function that queries `isAllowedToWithdraw` and do something that they are now not eligible to do.
 */
