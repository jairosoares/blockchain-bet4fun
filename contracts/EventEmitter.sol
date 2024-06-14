// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "hardhat/console.sol";
import "./EventUtils.sol";
import "./DataStore.sol";

contract EventEmitter {
    DataStore dataStore;

     event EventLog(
        address msgSender,
        string contractName,
        string eventName,
        EventUtils.EventLogData eventData
    );

    constructor(
        address _dataStore) { 
        dataStore = DataStore(_dataStore);
    }

    function emitEventLog(
        address contractAdress,
        string memory eventName,
        EventUtils.EventLogData memory eventData
    ) external {
        console.log(eventName);
        emit EventLog(
            msg.sender,
            dataStore.getContractName(contractAdress),
            eventName,
            eventData
        );
    }

}