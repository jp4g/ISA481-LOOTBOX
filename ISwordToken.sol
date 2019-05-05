pragma solidity ^0.5.7;

contract ISwordToken {
    
    string private constant _name = "ISA481 LootBox";
    string private constant _symbol = "LOOTBOX";
    
    event newSwordTokenContract(address _at, address _owner);
    
    /**
     * Forge a new sword and mint a Sword Token to represent it.
     * @dev Only the lootbox should call this function
     * @param to the address recieving the Sword Token
     * @return the uint ID of the forged sword and token
     */
    function forge(address to) public returns (uint);
    
    /**
     * @dev Gets the token name.
     * @return string representing the token name
     */
    function name() external pure returns (string memory) {
        return _name;
    }

    /**
     * @dev Gets the token symbol.
     * @return string representing the token symbol
     */
    function symbol() external pure returns (string memory) {
        return _symbol;
    }
}