pragma solidity ^0.5.7;


contract ISwordForge {
    uint internal constant WOOD_RATE = 50;
    uint internal constant STONE_RATE = 30;
    uint internal constant IRON_RATE = 15;
    uint internal constant DIAMOND_RATE = 5;
    
    event newSword(uint _id, Material _grip, Material _crossguard, Material _blade);
    event newForge(address _at, address _owner);
    
    enum Material {WOOD, STONE, IRON, DIAMOND}
    
    struct Sword {
        Material grip;
        Material crossguard;
        Material blade;
    }
    
    /**
     * Create a new sword. Emits an event about the sword.
     * @dev onlyPrimary only the LootBox can forge new swords. Implement modifier.
     **/
    function forgeSword(uint _id) public;
    
    /**
     * Generate a random uint8 between 1 and 100
     * @param _offset input for added entropy
     * @return the random uint8 value
     **/
    function randomOffset(uint _offset) private view returns (uint8);
    
     /**
     * Randomly generate a Material value
     * @dev Materials should return uint [0-3] for [WOOD, STONE, IRON, DIAMOND]
     * @param _offset input for added entropy
     * @return Material the newly, randomly generated Material
     **/
    function getMaterial(uint _offset) private view returns (Material);
    
    /**
     * View a Sword's components
     * @dev Materials should return uint [0-3] for [WOOD, STONE, IRON, DIAMOND]
     * @param _id the id of the sword being searched for
     * @param grip the Material of the grip
     * @param crossguard the Material of the crossguard
     * @param blade the Material of the blade
     **/
    function getSword(uint _id) public view returns (Material grip, Material crossguard, Material blade);
    
    /**
     * View the odds that determine the composition of a new Sword
     * @return wood the percent chance a material will return WOOD
     * @return stone the percent chance a material will return STONE
     * @return iron the percent chance a material will return IRON 
     * @return diamond the percent chance a material will return DIAMOND
     **/
    function getMaterialDropRates() public pure returns (uint wood, uint stone, uint iron, uint diamond) {
        return (WOOD_RATE, STONE_RATE, IRON_RATE, DIAMOND_RATE);
    }
}
    