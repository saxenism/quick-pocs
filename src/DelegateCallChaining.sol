//SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

//////////////
// This contract is in response to the Question 3 from the **Advanced** Section
// https://www.rareskills.io/post/solidity-interview-questions
// Shoutout to Jeff and Rareskills
// Q. If a delegatecall is made to a contract that makes a delegatecall to another contract, who is msg.sender in the proxy, the first contract, and the second contract?
//////////////

contract A {
    event Foo(string, address);

    function delegateCallIntoB(uint256 x, uint256 y, address contractB, address contractC)
        public
        returns (bool, bytes memory)
    {
        emit Foo("Contract A msg.sender", msg.sender);
        (bool ok, bytes memory res) = contractB.delegatecall(
            abi.encodeWithSignature("delegateCallIntoC(uint256,uint256,address)", x, y, contractC)
        );
        return (ok, res);
    }
}

contract B {
    event Foo(string, address);

    function delegateCallIntoC(uint256 x, uint256 y, address contractC) public returns (uint256) {
        emit Foo("Contract B msg.sender", msg.sender);
        (bool ok, bytes memory res) = contractC.delegatecall(abi.encodeWithSignature("add(uint256,uint256)", x, y));
    }
}

contract C {
    event Foo(string, address);

    function add(uint256 x, uint256 y) public returns (uint256 sum) {
        emit Foo("Contract C msg.sender", msg.sender);
        sum = x + y;
    }
}
