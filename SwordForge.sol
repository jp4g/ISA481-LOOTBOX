pragma solidity ^0.5.7;
import './ISwordForge.sol';
import 'http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol';
import 'http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Secondary.sol';

contract SwordForge is ISwordForge, Secondary {
    
    using SafeMath for uint;
    mapping (uint => Sword) private swords;
    
    constructor() public {
        emit newForge(address(this), msg.sender);
    }
    
    function forgeSword(uint _id) public onlyPrimary { 
       Sword storage s = swords[_id];
       swords[_id].grip = getMaterial(randomOffset(0));
       s.crossguard = getMaterial(randomOffset(1));
       s.blade = getMaterial(randomOffset(2));
       emit newSword(_id, s.grip, s.crossguard, s.blade);
    }
    
    function randomOffset(uint _offset) private view returns (uint8) { 
        return uint8(uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, _offset))).mod(100));
    }
    
    function getMaterial(uint _offset) private view returns (Material) {
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
        return (swords[_id].grip, swords[_id].crossguard, swords[_id].blade);
    }
}