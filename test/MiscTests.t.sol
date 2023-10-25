// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import "forge-std/Test.sol";

contract MiscTests is Test {
    modifier numLessThan50(uint256 num) {
        require(num < 50, "Num >= 50");
        _;
    }

    modifier numLessThan60(uint256 num) {
        require(num < 60, "Num >= 60");
        _;
    }

    modifier numLessThan100(uint256 num) {
        require(num < 100, "Num >= 100");
        _;
    }

    // This test is to test which error statment would pop up first.
    /////////////
    // Ok, so the modifiers are run in the same order that they are included in the function, ie, from left to right.
    // First the >60 check happens, then >50 and then >100.
    /////////////
    function test_orderOfExecutionOfModifiers() public numLessThan60(345) numLessThan50(345) numLessThan100(345) {
        assertTrue(true);
    }
}
