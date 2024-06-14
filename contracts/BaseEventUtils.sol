// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./EventEmitter.sol";
import "./EventUtils.sol";

contract BaseEventUtils {

    using EventUtils for EventUtils.StringItems;

    function emitSimpleMessage(
        EventEmitter eventEmitter, 
        string memory _msg) public 
    {
        EventUtils.EventLogData memory eventData;
        eventData.stringItems.initItems(1);
        eventData.stringItems.setItem(0, "message", _msg);
        eventEmitter.emitEventLog(
            msg.sender,
            "SimpleMessage",
            eventData
        );
    }

}