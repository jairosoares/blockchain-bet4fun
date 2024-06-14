// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./BaseEventUtils.sol";

contract GeneralEventUtils is BaseEventUtils {

    using EventUtils for EventUtils.AddressItems;
    using EventUtils for EventUtils.UintItems;
    using EventUtils for EventUtils.IntItems;
    using EventUtils for EventUtils.BoolItems;
    using EventUtils for EventUtils.Bytes32Items;
    using EventUtils for EventUtils.BytesItems;
    using EventUtils for EventUtils.StringItems;

    function emitProposalCreated(
        EventEmitter eventEmitter, 
        uint256 _proposalId, 
        address _proposer, 
        string memory _description) external
    {
        EventUtils.EventLogData memory eventData;
        eventData.uintItems.initItems(1);
        eventData.uintItems.setItem(0, "proposalId", _proposalId);
        
        eventData.addressItems.initItems(1);
        eventData.addressItems.setItem(0, "proposer", _proposer);
        
        eventData.stringItems.initItems(1);
        eventData.stringItems.setItem(0, "description", _description);

        eventEmitter.emitEventLog(
            msg.sender,
            "ProposalCreated",
            eventData
        );
    }

    function emitVoted(
        EventEmitter eventEmitter, 
        uint256 _proposalId, 
        address _voter) external
    {
        EventUtils.EventLogData memory eventData;
        eventData.uintItems.initItems(1);
        eventData.uintItems.setItem(0, "proposalId", _proposalId);
        
        eventData.addressItems.initItems(1);
        eventData.addressItems.setItem(0, "voter", _voter);

        eventEmitter.emitEventLog(
            msg.sender,
            "Voted",
            eventData
        );
    }

 event UsdcTransferred(
        bytes32 messageId,
        uint64 destinationChainSelector,
        address receiver,
        uint256 amount,
        uint256 ccipFee
    );

    function emitFundsToCharityTransferred(
        EventEmitter eventEmitter, 
        bytes32 _messageId,
        uint64 _destinationChainSelector,
        address _receiver,
        uint256 _amount,
        uint256 _ccipFee) external
    {
        EventUtils.EventLogData memory eventData;
        eventData.bytes32Items.initItems(1);
        eventData.bytes32Items.setItem(0, "_messageId", _messageId);
        
        eventData.uintItems.initItems(1);
        eventData.uintItems.setItem(0, "destinationChainSelector", _destinationChainSelector);

        eventData.addressItems.initItems(1);
        eventData.addressItems.setItem(0, "receiver", _receiver);
        
        eventData.uintItems.initItems(2);
        eventData.uintItems.setItem(0, "amount", _amount);
        eventData.uintItems.setItem(1, "ccipFee", _ccipFee);

        eventEmitter.emitEventLog(
            msg.sender,
            "FundsToCharityTransferred",
            eventData
        );
    }

    function emitFundsReceived(
        EventEmitter eventEmitter, 
        address _from, 
        uint256 _amount) external
    {
        EventUtils.EventLogData memory eventData;
        eventData.addressItems.initItems(1);
        eventData.addressItems.setItem(0, "from", _from);
        
        eventData.uintItems.initItems(1);
        eventData.uintItems.setItem(0, "amount", _amount);

        eventEmitter.emitEventLog(
            msg.sender,
            "FundsToCharityTransferred",
            eventData
        );
    }
}