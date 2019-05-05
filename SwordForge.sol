pragma solidity ^0.5.7;

import './ISwordToken.sol';
import './SwordForge.sol';
import "http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC721/ERC721Enumerable.sol";
import "http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Secondary.sol";

contract SwordToken is ISwordToken, ERC721Enumerable, Secondary {
 
    ISwordForge Forge;
    Counters.Counter index;
 
    constructor () public {
        Forge = new SwordForge();
        emit newSwordTokenContract(address(this), msg.sender);
    }
    
    function forge(address to) public onlyPrimary returns (uint) {
        require(to != address(0), "ERC721: mint to the zero address");
        Forge.forgeSword(index.current());
        super._mint(to, index.current());
        index.increment();
        return (index.current() - 1);
    }
    
    /**
     * View a Sword's components
     * @dev Materials should return uint [0-3] for [WOOD, STONE, IRON, DIAMOND]
     * @dev cannot encode ENUM from one interface to another
     * @param _id the id of the sword being searched for
     * @param grip the Material of the grip
     * @param crossguard the Material of the crossguard
     * @param blade the Material of the blade
     **/
    function getSword(uint _id) public view returns (SwordForge.Material grip, SwordForge.Material crossguard, SwordForge.Material blade) {
        return Forge.getSword(_id);
    }
}

