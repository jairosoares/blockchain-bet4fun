// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../BaseContract.sol";
import "./CollectionNFTEventUtils.sol";

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract CollectionNFT is ERC721, ERC721URIStorage, BaseContract {
    CollectionNFTEventUtils eventUtils;

    string[] public ipfsUri;

    constructor(
        address _dataStore, 
        address _eventEmitter,
        address _accessControlManager, 
        string[] memory _uris) 
        ERC721("Bet4Fun NFT", "B4F")
    { 
        initializeBase(_dataStore, _eventEmitter,_accessControlManager, address(this), "CollectionNFT");
        initializeUris(_uris);
        eventUtils = new CollectionNFTEventUtils();
    }

    function initializeUris(string[] memory _uris) internal 
    {
        for (uint i = 0; i < _uris.length; i++) 
        {
            ipfsUri.push(_uris[i]);
        }
    }

    function addIpfsUri(string memory _uri) public onlyAuthorized()
    {
        ipfsUri.push(_uri);
    }

    function safeMint(address to, uint256 tokenId) public onlyAuthorized()
    {
        if (tokenId < ipfsUri.length) 
        {
            _safeMint(to, tokenId);
            _setTokenURI(tokenId, ipfsUri[tokenId]);
            eventUtils.emitNftMinted(eventEmitter, to, tokenId);
            console.log("NftMinted", to, tokenId);
        } else 
        {
            eventUtils.emitNftNotMinted(eventEmitter, to, tokenId, "Exceeded the number of tokens ids");
        }
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

}