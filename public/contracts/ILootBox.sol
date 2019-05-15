pragma solidity ^0.5.7;

contract Contributers {
    string constant internal JACK = "Jack Gilcrest";
    string constant internal THOMAS = "Thomas Wright";
    string constant internal HENRY = "Henry Teeter";
    string constant internal TYLER = "Tyler Davis";
    string constant internal MATT = "Matt Duffy";
    string constant internal ARTHUR = "Arthur Carvalho";
}

contract ILootBox is Contributers {
    
    uint256 internal constant PRICE = 0.02 ether;
    
    event newLootBox(address _at, address _swordTokenContract, address owner);
    event lootBoxOpened(address owner, uint _swordID);
    
    modifier sufficientValue(uint256 val) {
        require(val >= PRICE, "Insufficient funds sent to open new LootBox! Send 0.1 ETH.");
        _;
    }
    
    /**
     * Main lootbox method. If transaction is sent with sufficient funds, mints a new Sword
     * @dev Should be called by MetaMask user in web app
     * @dev sufficientValue refuse the transaction if insufficient funds are sent according to PRICE
     **/
    function openBox() public payable;
    
    /**
     * Get contextual contract addresses
     * @return address[0] the address of this LootBox contract
     * @return address[1] the address of this LooBox contract's SwordToken contract
     **/
    function getContracts() public view returns (address[2] memory);
    
    /**
     * This project was incubated by DR. Arhtur Carvalho of Miami University's ISA481: Blockchain and Business Applications.
     * @return 6 strings representing 5 group members + 1 professor
     **/
    function getContributers() external pure returns(string memory, string memory, string memory, string memory, string memory, string memory) {
        return (JACK, THOMAS, HENRY, TYLER, MATT, ARTHUR);
    }
    
    /**
     * View the price to open the LootBox
     * @return the price required for the LootBox to function and mint to the user
     **/
    function getPrice() external pure returns (uint price) {
        return PRICE;
    }
}