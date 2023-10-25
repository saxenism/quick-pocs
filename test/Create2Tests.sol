// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import {DeterministicDeployer} from "src/CREATE2DeterministicAddressDeployment.sol";
import "forge-std/Test.sol";

contract Create2Test is Test {
    DeterministicDeployer deployer;

    function setUp() public {
        deployer = new DeterministicDeployer();
    }

    function test_deploymentAddressCanBeDeterminedUsingCREATE2() public {
        assertTrue(deployer.checkAddressDeterminism());
    }
}
