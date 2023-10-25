// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

//////////////
// This contract is in response to the Question 3 from the **Hard** Section
// https://www.rareskills.io/post/solidity-interview-questions
// Shoutout to Jeff and Rareskills
//////////////

contract AssemblyBalanceCheck {
    function checkBalanceSolidity() public view returns (uint256 balance) {
        balance = address(this).balance;
    }

    function checkBalanceAssemblySelfBalance() public view returns (uint256 contractBalance) {
        assembly {
            contractBalance := selfbalance()
        }
    }

    function checkBalanceAssemblyBalance() public view returns (uint256 contractBalance) {
        assembly {
            contractBalance := balance(address())
        }
    }

    function checkContractAddress() public view returns (bool isEqual) {
        address solidityAddress = address(this);
        address assemblyAddress;
        assembly {
            assemblyAddress := address()
        }
        isEqual = (solidityAddress == assemblyAddress);
    }

    receive() external payable {}
}
