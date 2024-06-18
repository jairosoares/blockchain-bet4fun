// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../BaseEventUtils.sol";

contract CollectionNFTEventUtils is BaseEventUtils {
  
    using EventUtils for EventUtils.AddressItems;
    using EventUtils for EventUtils.UintItems;
    using EventUtils for EventUtils.IntItems;
    using EventUtils for EventUtils.BoolItems;
    using EventUtils for EventUtils.Bytes32Items;
    using EventUtils for EventUtils.BytesItems;
    using EventUtils for EventUtils.StringItems;

    function emitNftMinted(
        EventEmitter eventEmitter, 
        address to, 
        uint256 tokenId) external 
    {
        EventUtils.EventLogData memory eventData;
        eventData.addressItems.initItems(1);
        eventData.addressItems.setItem(0, "to", to);

        eventData.uintItems.initItems(1);
        eventData.uintItems.setItem(0, "tokenId", tokenId);
        eventEmitter.emitEventLog(
            msg.sender,
            "NftMinted",
            eventData
        );
    }


    function emitNftNotMinted(
        EventEmitter eventEmitter, 
        address to, 
        uint256 tokenId,
        string memory _msg) external 
    {
        EventUtils.EventLogData memory eventData;
        eventData.addressItems.initItems(1);
        eventData.addressItems.setItem(0, "to", to);

        eventData.uintItems.initItems(1);
        eventData.uintItems.setItem(0, "tokenId", tokenId);

        eventData.stringItems.initItems(1);
        eventData.stringItems.setItem(0, "_msg", _msg);
        eventEmitter.emitEventLog(
            msg.sender,
            "NftMinted",
            eventData
        );
    }

}