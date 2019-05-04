pragma solidity ^0.5.7;

import './SwordForge.sol';
import 'http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC721/IERC721.sol';
import 'http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC721/IERC721Receiver.sol';
import 'http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/introspection/ERC165.sol';
import 'http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/drafts/Counters.sol';
import 'http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/Address.sol';
import 'http://github.com/OpenZeppelin/openzeppelin-solidity/contracts/access/roles/MinterRole.sol';

contract SwordOwnership is SwordForge, IERC721, ERC165, MinterRole {
    using SafeMath for uint256;
    using Counters for Counters.Counter;
    using Address for address;
    
    //ERC721 magic value
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
    
    mapping (uint => address) swordApprovals;
    mapping (address => mapping(address => bool)) operatorApprovals;
    mapping (address => Counters.Counter) ownedSwordCount;
    mapping (uint => address) swordOwner;
    
    /*
     *     bytes4(keccak256('balanceOf(address)')) == 0x70a08231
     *     bytes4(keccak256('ownerOf(uint256)')) == 0x6352211e
     *     bytes4(keccak256('approve(address,uint256)')) == 0x095ea7b3
     *     bytes4(keccak256('getApproved(uint256)')) == 0x081812fc
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c
     *     bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) == 0x42842e0e
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)')) == 0xb88d4fde
     *
     *     => 0x70a08231 ^ 0x6352211e ^ 0x095ea7b3 ^ 0x081812fc ^
     *        0xa22cb465 ^ 0xe985e9c ^ 0x23b872dd ^ 0x42842e0e ^ 0xb88d4fde == 0x80ac58cd
     */
    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;

    constructor () public {
        _registerInterface(_INTERFACE_ID_ERC721);
    }
    
    function balanceOf(address _owner) public view returns (uint256) {
        return Counters.current(ownedSwordCount[_owner]);
    }
    
    function ownerOf(uint256 _tokenId) public view returns (address) {
        return swordOwner[_tokenId];
    }
    
    function approve(address _approved, uint256 _tokenId) public {
        swordApprovals[_tokenId] = _approved;
        emit Approval(msg.sender, _approved, _tokenId);
    }
    
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_exists(tokenId), "ERC721: Sword not found.");
        return swordApprovals[tokenId];
    }
    
    /**
     * @dev Sets or unsets the approval of a given operator
     * An operator is allowed to transfer all tokens of the sender on their behalf.
     * @param to operator address to set the approval
     * @param approved representing the status of the approval to be set
     */
    function setApprovalForAll(address to, bool approved) public {
        require(to != msg.sender, "ERC721: you cannot approve yourself.");
        operatorApprovals[msg.sender][to] = approved;
        emit ApprovalForAll(msg.sender, to, approved);
    }
    
    /**
     * @dev Tells whether an operator is approved by a given owner.
     * @param owner owner address which you want to query the approval of
     * @param operator operator address which you want to query the approval of
     * @return bool whether the given operator is approved by the given owner
     */
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return operatorApprovals[owner][operator];
    }
    
    /**
     * @dev Transfers the ownership of a given token ID to another address.
     * Usage of this method is discouraged, use `safeTransferFrom` whenever possible.
     * Requires the msg.sender to be the owner, approved, or operator.
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function transferFrom(address from, address to, uint256 tokenId) public {
        require(isApprovedOrOwner(msg.sender, tokenId), "ERC721: msg.sender is not owner and not approved");
        _transfer(from, to, tokenId);
    }
    
    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg.sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes data to send along with a safe transfer check
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(from, to, tokenId, _data), "ERC721: transfer to non ERC721Receiver implementer");
    }
    
    /**
     * @dev Function to mint tokens.
     * @param to The address that will receive the minted tokens.
     * @param tokenId The token id to mint.
     * @return A boolean that indicates if the operation was successful.
     */
    function mint(address to, uint256 tokenId) public onlyMinter returns (bool) {
        _forge(to, tokenId);
        return true;
    }
    
    /**
     * @dev Internal function to forge a new swordtoken.
     * Reverts if the given token ID already exists.
     * @param to The address that will own the forged sword token
     * @param swordId uint256 ID of the sword to be forged
     */
    function _forge(address to, uint256 swordId) internal {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(swordId), "ERC721: sword already forged");
        SwordForge.forgeSword(swordId);
        swordOwner[swordId] = to;
        ownedSwordCount[to].increment();

        emit Transfer(address(0), to, swordId);
    }
    
     /**
     * @dev Internal function to invoke `onERC721Received` on a target address.
     * The call is not executed if the target address is not a contract.
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data) internal returns (bool) {
        if (!to.isContract()) {
            return true;
        }

        bytes4 retval = IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, _data);
        return (retval == _ERC721_RECEIVED);
    }

    /**
     * @dev Private function to clear current approval of a given token ID.
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _clearApproval(uint256 tokenId) private {
        if (swordApprovals[tokenId] != address(0)) {
            swordApprovals[tokenId] = address(0);
        }
    }

     /**
     * @dev Returns whether the specified token exists.
     * @param swordId uint256 ID of the sword to query the existence of
     * @return bool whether the sword exists
     */
    function _exists(uint256 swordId) internal view returns (bool) {
        address owner = swordOwner[swordId];
        return owner != address(0);
    }
    
    /**
     * @dev Returns whether the given spender can transfer a given token ID.
     * @param spender address of the spender to query
     * @param tokenId uint256 ID of the token to be transferred
     * @return bool whether the msg.sender is approved for the given token ID,
     * is an operator of the owner, or is the owner of the token
     */
    function isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }
    
    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownedSwordCount[_to].increment();
        ownedSwordCount[msg.sender].decrement();
        swordOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }
}
