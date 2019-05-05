pragma solidity ^0.5.7;
import "./ILootBox.sol";
import "./SwordToken.sol";
import "http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract LootBox is ILootBox, Ownable {

    SwordToken Swords;

    /**
     * Construct the LootBox contract as well as SwordToken auxiliary contract
     * @dev requires gas limit of ~45000000
     **/
    constructor() public {
        Swords = new SwordToken();
        emit newLootBox(address(this), address(Swords), msg.sender);
    }
    
    function openBox() public payable sufficientValue(msg.value) {
        uint tokenID = Swords.forge(msg.sender);
        emit lootBoxOpened(msg.sender, tokenID);
    }
    
    function getContracts() public view returns (address[2] memory) {
        return ([address(this), address(Swords)]);
    }
}