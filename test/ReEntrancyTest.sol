//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Vault, AliceAttacker, InnocentBob} from "src/ReEntrancy.sol";
import "forge-std/Test.sol";

contract ReEntrancyTest is Test {
    Vault vault;
    AliceAttacker alice;
    InnocentBob bob;

    function setUp() public {
        vault = new Vault();
        alice = new AliceAttacker();
        bob = new InnocentBob();

        alice.setVaultContract(address(vault));

        // assertEq(address(this).balance, 1 ether);
        address(alice).call{value: 5 ether}("");
        address(bob).call{value: 15 ether}("");
    }

    function test_Reentrancy() public {
        // Alice sends money to vault contract
        alice.depositMoneyIntoVault(5 ether);
        assertEq(address(vault).balance, 5 ether);

        // Bob sends money to vault contract
        bob.depositMoneyIntoVault(15 ether, address(vault));
        assertEq(address(vault).balance, 20 ether);

        vm.prank(address(alice));
        vault.withdrawMoney();

        assertEq(address(alice).balance, 20 ether);
    }
}
