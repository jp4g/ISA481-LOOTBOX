pragma solidity ^0.5.7;

import './SwordForge.sol';
import './ISwordToken.sol';
import 'http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC721/ERC721Enumerable.sol';
import 'http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Secondary.sol';

contract SwordToken is ISwordToken, ERC721Enumerable, Secondary {

    Counters.Counter index;
    SwordForge Forge;
    
    event newSwordTokenContract(address _at, address _owner);

    /**
     * Construct a new SwordToken Smart Contract
     **/
    constructor () public {
        Forge = new SwordForge();
        emit newSwordTokenContract(address(this), msg.sender);
    }
    
    function forge(address to) public onlyPrimary returns (uint tokenID) {
        require(to != address(0), "ERC721: mint to the zero address");
        tokenID = index.current();
        index.increment();
        Forge.forgeSword(tokenID);
        super._mint(to, tokenID);
    }
    
    function getSword(uint _id) public view returns (uint grip, uint crossguard, uint blade) {
        return Forge.getSwordNumerical(_id);
    }

}