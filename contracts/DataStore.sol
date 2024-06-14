// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DataStore {
    mapping(bytes32 => uint256) public uintValues;
    mapping(bytes32 => int256) public intValues;
    mapping(bytes32 => string) public stringValues;
    mapping(bytes32 => address) public addressValues;
    mapping(bytes32 => bool) public boolValues;
    mapping(bytes32 => bytes) public bytesValues;
    mapping(bytes32 => bytes32) public bytes32Values;

    function setUint(bytes32 key, uint256 value) external {
        uintValues[key] = value;
    }
    function getUint(bytes32 key) external view returns (uint256) {
        return uintValues[key];
    }

    function setInt(bytes32 key, int256 value) external {
        intValues[key] = value;
    }
    function getInt(bytes32 key) external view returns (int256) {
        return intValues[key];
    }

    function setString(bytes32 key, string calldata value) external {
        stringValues[key] = value;
    }
    function getString(bytes32 key) external view returns (string memory) {
        return stringValues[key];
    }

    function setAddress(bytes32 key, address value) external {
        addressValues[key] = value;
    }
    function getAddress(bytes32 key) external view returns (address) {
        return addressValues[key];
    }

    function setBool(bytes32 key, bool value) external {
        boolValues[key] = value;
    }
    function getBool(bytes32 key) external view returns (bool) {
        return boolValues[key];
    }

    function setBytes(bytes32 key, bytes calldata value) external {
        bytesValues[key] = value;
    }
    function getBytes(bytes32 key) external view returns (bytes memory) {
        return bytesValues[key];
    }

    function setBytes32(bytes32 key, bytes32 value) external {
        bytes32Values[key] = value;
    }
    function getBytes32(bytes32 key) external view returns (bytes32) {
        return bytes32Values[key];
    }

    function incrementUint(bytes32 key, uint256 value) external returns (uint256) {
        uint256 nextUint = uintValues[key] + value;
        uintValues[key] = nextUint;
        return nextUint;
    }
    
    function decrementUint(bytes32 key, uint256 value) external returns (uint256) {
        uint256 nextUint = uintValues[key] - value;
        uintValues[key] = nextUint;
        return nextUint;
    }

    function incrementInt(bytes32 key, int256 value) external returns (int256) {
        int256 nextInt = intValues[key] + value;
        intValues[key] = nextInt;
        return nextInt;
    }

    function decrementInt(bytes32 key, int256 value) external returns (int256) {
        int256 nextInt = intValues[key] - value;
        intValues[key] = nextInt;
        return nextInt;
    }

    function setContractName(address contractAddress, string calldata name) external {
        bytes32 key = keccak256(abi.encodePacked("contractName", contractAddress));
        stringValues[key] = name;
    }

    function getContractName(address contractAddress) external view returns (string memory) {
        bytes32 key = keccak256(abi.encodePacked("contractName", contractAddress));
        return stringValues[key];
    }

}
