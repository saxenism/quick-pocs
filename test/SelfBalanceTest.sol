// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {AssemblyBalanceCheck} from "src/selfBalance.sol";
import "forge-std/Test.sol";

contract SelfBalanceTest is AssemblyBalanceCheck, Test {
    AssemblyBalanceCheck assemblyBalanceCheck;

    function setUp() public {
        assemblyBalanceCheck = new AssemblyBalanceCheck();

        (bool success,) = address(assemblyBalanceCheck).call{value: 5 ether}("");
        require(success, "Ether transfer from the contract to test contract failed");
    }

    function testBalanceWithDifferentFunctions() public {
        uint256 balance1 = assemblyBalanceCheck.checkBalanceSolidity();
        uint256 balance2 = assemblyBalanceCheck.checkBalanceAssemblySelfBalance();
        uint256 balance3 = assemblyBalanceCheck.checkBalanceAssemblyBalance();

        assertEq(balance2, 5 ether);
        assertEq(balance1, balance2);
        assertEq(balance2, balance3);
    }
}
