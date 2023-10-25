// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {A, B, C} from "src/DelegateCallChaining.sol";
import "forge-std/Test.sol";

contract DelegateCallChainingTest is Test {
    A public a;
    B public b;
    C public c;

    function setUp() public {
        a = new A();
        b = new B();
        c = new C();
    }

    function testFlowOfDelegateChaining() public {
        address alice = makeAddr("Alice");
        vm.startPrank(alice);
        (bool callOk,) = a.delegateCallIntoB(2, 3, address(b), address(c));
        vm.stopPrank();

        assertTrue(callOk);
    }
}
