// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

/////////////////////////////////////
// What prompted this cute little experiment?
// The Tornado Cash Governance Hack.
// Here's a writeup explaining the hack: https://www.zaryabs.com/tornado-cash-governance-hack/
/////////////////////////////////////
contract RandomContract {
    uint256 aVeryImportantNumber;

    constructor(uint256 randomNumber) {
        aVeryImportantNumber = randomNumber;
    }
}

contract DeterministicDeployer {
    address public deployedAddress;
    address public calculatedDeploymentAddress;
    uint256 public randomContractNumber = 5;
    bytes32 public create2Salt = bytes32("0x123abc");

    function deployRandomContractAtSpecificAddress() public returns (address) {
        RandomContract randomContract = new RandomContract{salt: create2Salt}(randomContractNumber);
        deployedAddress = address(randomContract);
        return deployedAddress;
    }

    function determineDeploymentAddressOfRandomContract() public {
        bytes32 bytecode = getBytecode();
        calculatedDeploymentAddress =
            address(uint160(uint256(keccak256(abi.encode(bytes1(0xFF), address(this), create2Salt, bytecode)))));
    }

    function getBytecode() public view returns (bytes32 bytecode) {
        bytes memory creationCode = type(RandomContract).creationCode;
        bytecode = keccak256(abi.encodePacked(creationCode, abi.encode(randomContractNumber)));
    }

    function checkAddressDeterminism() public view returns (bool isEqual) {
        isEqual = (calculatedDeploymentAddress == deployedAddress);
    }
}
