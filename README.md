# Quick POCs

This repository contains all my small experiments regarding Solidity and the EVM in general, leveragaing the Foundry framework in the process.

## Quick Articles

### 1. Function Selectors and Gas

A function selector -> `bytes4(keccak256("function_signature"))`. 

EVM utilises a lookup table and searches for the function being called, linearly in that table. In the table, the function selectors are arranged linearly from lower hex value to higher hex values. So, if a function in your contract is used regularly and you name it in a way such that it's function selector remains towards the top, you can save gas (function is found in the 1st try rather than the nth try).

However, if in a contract the number of functions are more than 4, EVM uses binary search for function calls.