// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "hardhat/console.sol";
import "./utils/StringUtil.sol";
import "./AccessControlManager.sol";
import "./DataStore.sol";
import "./EventEmitter.sol";
import "./Keys.sol";

contract BaseContract {
    using EventUtils for EventUtils.StringItems;
    
    DataStore dataStore;
    EventEmitter eventEmitter;
    AccessControlManager accessControlManager;

    modifier onlyAuthorized() {
        bool authorized = accessControlManager.onlyAuthorizadContract(msg.sender);
        if (!authorized) {
            /*
                IMPORTANTE:
                1) "revert" quando acontece, nao eh disparado os eventos que estao dentro do metodo chamado
                2) "revert PermissionAccessDenied()" nao aparece nos logs de errors do javascript
                    revert("Caller is not authorized!") sim
            */
            //emit PermissionDenied(msg.sender, "Caller is not authorized!");
            //revert PermissionAccessDenied();
            revert("Caller is not authorized!");
        }
        _;
    }

    function initializeBase(
        address _dataStore, 
        address _eventEmitter, 
        address _accessControlManager,
        address _contractAddress,
        string memory _contractName) internal {
        dataStore = DataStore(_dataStore);
        eventEmitter = EventEmitter(_eventEmitter);
        accessControlManager = AccessControlManager(_accessControlManager);
        dataStore.setContractName(_contractAddress, _contractName);
    }

    function setEventEmitter(address _eventEmitter) public onlyAuthorized {
        eventEmitter = EventEmitter(_eventEmitter);
    }

    function uintTostr(uint256 _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }

    function strToUint(string memory s) internal pure returns (uint256) {
        bytes memory b = bytes(s);
        uint256 result = 0;
        for (uint256 i = 0; i < b.length; i++) {
            if (uint8(b[i]) >= 48 && uint8(b[i]) <= 57) {
                result = result * 10 + (uint8(b[i]) - 48);
            }
        }
        return result;
    }

    function strToUint16(string memory s) internal pure returns (uint16) {
        bytes memory b = bytes(s);
        uint16 result = 0;
        for (uint16 i = 0; i < b.length; i++) {
            if (uint8(b[i]) >= 48 && uint8(b[i]) <= 57) {
                result = result * 10 + (uint8(b[i]) - 48);
            }
        }
        return result;
    }

    function split(
        string memory str,
        string memory delimiter,
        uint16 expectedParts
    ) internal pure returns (string[] memory) {
        string[] memory parts = new string[](expectedParts);
        bytes memory strBytes = bytes(str);
        bytes memory delimiterBytes = bytes(delimiter);

        uint256 partCount = 0;
        uint256 lastIndex = 0;

        for (uint256 i = 0; i < strBytes.length; i++) {
            if (strBytes[i] == delimiterBytes[0]) {
                parts[partCount] = substring(str, lastIndex, i);
                partCount++;
                lastIndex = i + 1;
            }
        }

        parts[partCount] = substring(str, lastIndex, strBytes.length);
        return parts;
    }

    function substring(
        string memory str,
        uint256 startIndex,
        uint256 endIndex
    ) internal pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex - startIndex);

        for (uint256 i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = strBytes[i];
        }

        return string(result);
    }

    // helper function to compare strings
    function isEqual(string memory a, string memory b)
        public pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) ==
            keccak256(abi.encodePacked((b))));
    }

    function isNotEqual(bytes memory a, bytes memory b)
        public pure returns (bool) {
        return !isEqual(string(a),string(b));
    }

    function boolToString(bool input) public pure returns (string memory) {
        //TODO: KKK
        if (input) {
            return "true";
        } else {
            return "false";
        }
    }

    function isEmpty(string memory _value) public pure returns (bool) { 
        return bytes(_value).length == 0;
    }

    function isEmpty(uint16 _value) public pure returns (bool) { 
        return _value == 0;
    }

    function isEmpty(uint256 _value) public pure returns (bool) { 
        return _value == 0;
    }

    function isEmpty(address _value) public pure returns (bool) { 
        return _value == address(0);
    }

}