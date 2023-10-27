# Quick POCs

This repository contains all my small experiments regarding Solidity and the EVM in general, leveragaing the Foundry framework in the process.

## Quick Articles

### 1. Function Selectors and Gas

A function selector -> `bytes4(keccak256("function_signature"))`. 

EVM utilises a lookup table and searches for the function being called, linearly in that table. In the table, the function selectors are arranged linearly from lower hex value to higher hex values. So, if a function in your contract is used regularly and you name it in a way such that it's function selector remains towards the top, you can save gas (function is found in the 1st try rather than the nth try).

However, if in a contract the number of functions are more than 4, EVM uses binary search for function calls.

### 2. Essence of ReEntrancy

ReEntrancy of any type, whether it be the classic re-entrancy, cross-functional re-entrancy, cross-contract re-entrancy or even read-only re-entrancy stems from the root cause that the *attacker* was able to exploit the fact that one (or more) state change was not propogated correctly.

So, the way to think about re-entrancy would be best to think of from an attacker's perspective. Think, ok, this contract is calling me(or my contract) via this function and at this exact point in time I control the execution flow. Now, how can I leverage the state changes that have happened (or should have happened) prior to me getting the control of the call and then calling back into the same function, different function, different function in a different contract or even using the old return values from a view function to my advantage (or to manipulate the functioning of a third-party dependency decentralised application in case of read-only reentrancy).

The manual way to detect and gauge all possible attack vectors is to identify the calls happening to external addresses that give control of the execution flow to external contracts. Post that, list down all the exact state variable changes that have taken place (or should have and didn't) in the function that transferred the control and then find out all the externally/publically callable functions in the victim contract(s) that might be dependent on the changed values (and maybe using the non-updated values).

[This](https://www.youtube.com/watch?v=3T1t2ginfTg) is a pretty good resource to understand the essence of re-entrancy attacks.