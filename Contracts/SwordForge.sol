pragma solidity ^0.5.7;
import 'http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol';

contract SwordForge {
    
    using SafeMath for uint;
    
    enum Material {WOOD, STONE, IRON, DIAMOND}
    
    mapping(uint => Sword) swords; 
    
    event newSword(uint256 id, Material handle, Material crossguard, Material blade);
    
    struct Sword {
        uint id;
        Material grip;
        Material crossguard;
        Material blade;
    }
    
    
    
    function forgeSword(uint _id) public { 
       Sword storage s = swords[_id];
       s.grip = getMaterial(randomOffset(0));
       s.crossguard = getMaterial(randomOffset(1));
       s.blade = getMaterial(randomOffset(2));
       s.id = _id;
       emit newSword(s.id, s.grip, s.crossguard, s.blade);
    }
    
    /// generate a random uint8 between 1 and 100
    function randomOffset(uint _offset) public view returns (uint8) { 
        return uint8(uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, _offset))).mod(100));
    }
    
    function getMaterial(uint _offset) public view returns (Material) {
        uint8 rng = randomOffset(_offset);
        if(rng < 49)
            return Material.WOOD;
        else if(rng < 79 && rng >= 49)
            return Material.STONE;
        else if(rng < 94 && rng >= 79)
            return Material.IRON;
        else
            return Material.DIAMOND;
    }
    
    function getSword(uint _id) public view returns (Material grip, Material crossguard, Material blade) {
        Sword memory sword = swords[_id];
        return (sword.grip, sword.crossguard, sword.blade);
    }
    
    function getPowerLevel(uint _id) public view returns (uint8 powerlevel) {
        Sword memory s = swords[_id];
        return (uint8(s.grip) + uint8(s.crossguard) + uint8(s.blade));
    }
    
}

