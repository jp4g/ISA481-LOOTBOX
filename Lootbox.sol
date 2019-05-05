pragma solidity ^0.5.7;

contract LootBox is SwordOwnership {
    uint256 price = 0.1 ether;
    
    modifier sufficientValue(uint256 val) {
        require(val >= price, "Insufficient funds to open new LootBox");
        _;
    }
    
    function openBox() public payable sufficientValue(msg.value) {
        forgeSword();
    }
}