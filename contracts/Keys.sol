// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// @title Keys
// @dev Keys for values in the DataStore
library Keys {

    bytes32 public constant IS_PERFORM_AUTOMATION = keccak256(abi.encode("IS_PERFORM_AUTOMATION"));
    bytes32 public constant IS_UPKEEP = keccak256(abi.encode("IS_UPKEEP"));
    bytes32 public constant CONTRACT_NAME = keccak256(abi.encode("CONTRACT_NAME"));

}