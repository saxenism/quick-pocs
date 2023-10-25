// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

///////
/*
This contract is used to test exactly how many arguments can we put in an event.
From my research thus far, I can say that:
1. With Solidity + non-anonymous events -> 3 indexed parameters + 12 non-indexed parameters + 1 **implicit** event signature parameter
2. With Solidity + anonymous events -> 4 indexed parameters + 12 non-indexed parameters 

So, all in all we can see that we can accomodate 16 parameters into the events fields, but according to the answer here: https://stackoverflow.com/a/49432998
the number of arguments should have been 17. So, I don't really understand the mystery of this 1 missing parameter.

Follow the discussion on X: https://x.com/saxenism/status/1716696062755565778?s=20
*/
///////

contract EventDepth {
    event Foo(uint8 indexed,uint8 indexed,uint8 indexed,uint8 indexed,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8) anonymous;
    event Foo2(uint8 indexed,uint8 indexed,uint8 indexed,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8);

    function emitEvent() public {
        emit Foo(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
    }

    function viewEventSelector() public pure returns(bytes32 eventSelector, bool isEqual) {
        eventSelector = Foo2.selector;
        isEqual = (eventSelector == keccak256("Foo2(uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8,uint8)"));
    }

    //////////
    // This function would not compile since Foo is an anonymous event and therefore
    // does not have a selector
    //////////
    // function viewEventSelectorAnonymous() public pure returns(bytes32 eventSelector) {
    //     eventSelector = Foo.selector;
    // }
}