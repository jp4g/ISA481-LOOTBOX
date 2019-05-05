pragma solidity ^0.5.7;

import './SwordForge.sol';
import 'http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC721/ERC721Enumerable.sol';
import 'http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Secondary.sol';

contract SwordToken is ERC721Enumerable, Secondary {
    string private constant _name = "ISA481 SWORD";
    string private constant _symbol = "SWORD";
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
    
    /**
     * Forge a new sword and mint a Sword Token to represent it.
     * @dev Only the lootbox should call this function
     * @param to the address recieving the Sword Token
     */
    function _forge(address to) public onlyPrimary {
        require(to != address(0), "ERC721: mint to the zero address");
        Forge.forgeSword(index.current());
        super._mint(to, index.current());
        index.increment();
    }

}