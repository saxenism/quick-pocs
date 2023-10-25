// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

contract AssemblyBalanceCheck {
    function checkBalanceSolidity() public view returns(uint256 balance) {
        balance = address(this).balance;
    }

    function checkBalanceAssemblySelfBalance() public view returns(uint256 contractBalance) {
        assembly {
            contractBalance := selfbalance()
        }
    }

    function checkBalanceAssemblyBalance() public view returns(uint256 contractBalance) {
        assembly {
            contractBalance := balance(address())
        }
    }

    function checkContractAddress() public view returns(bool isEqual) {
        address solidityAddress = address(this);  




        
        address assemblyAddress;
        assembly {
            assemblyAddress := address()
        }
        isEqual = (solidityAddress == assemblyAddress);
    }

    receive() external payable {}
}