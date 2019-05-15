pragma solidity ^0.5.7;
import './ISwordForge.sol';
import 'http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol';
import "http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Secondary.sol";

contract SwordForge is ISwordForge, Secondary {
    
    using SafeMath for uint;
    mapping (uint => Sword) private swords;
    
    constructor() public payable {
        emit newForge(address(this), msg.sender);
    }
    
    function forgeSword(uint _id) public onlyPrimary { 
       swords[_id].grip = getMaterial(0);
       swords[_id].crossguard = getMaterial(1);
       swords[_id].blade = getMaterial(2);
       emit newSword(_id, swords[_id].grip, swords[_id].crossguard, swords[_id].blade);
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

    function getSword(uint _id) public view onlyPrimary returns (Material grip, Material crossguard, Material blade) {
        return (swords[_id].grip, swords[_id].crossguard, swords[_id].blade);
    }
    
    function getSwordNumerical(uint _id) public view onlyPrimary returns (uint8 grip, uint8 crossguard, uint8 blade) {
        return (uint8(swords[_id].grip), uint8(swords[_id].crossguard), uint8(swords[_id].blade));
    }
}