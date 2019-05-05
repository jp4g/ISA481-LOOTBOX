# ISA481 Final Project: Transparent LootBoxes

This is an ERC721 implementation of a "Loot Box" prototype. If you are unacquainted with the topic,
search "lootboxes ea gambling for kids".

# @Thomas Steps:
1. Paste files into Remix
2. Set"Gas limit" to '4500000'
3. Deploy LootBox.sol to desired network through MetaMask Web3
4. Run 'getContracts()'. Paste the result into "Deploy at address" for a SwordToken
5. Set "value" to "0.1 ether"
6. Run 'openBox()' in "LootBox" to open a new lootbox. The transaction will return the $ID.
7. Run 'getSword()' with input '$ID' in "SwordToken" to view the Sword materials.