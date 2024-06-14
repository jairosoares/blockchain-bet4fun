// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (utils/Strings.sol)

pragma solidity ^0.8.19;

/**
 * @dev String parse array.
 */
library StringUtil {

    function split(string memory str, string memory delimiter) internal pure returns (string[] memory) {
        bytes memory b = bytes(str);
        bytes memory d = bytes(delimiter);
        uint256 count = 1;

        for (uint256 i = 0; i < b.length; i++) {
            if (b[i] == d[0]) {
                count++;
            }
        }

        string[] memory parts = new string[](count);
        uint256 lastIndex = 0;
        uint256 partIndex = 0;

        for (uint256 i = 0; i < b.length; i++) {
            if (b[i] == d[0]) {
                parts[partIndex++] = substring(str, lastIndex, i);
                lastIndex = i + 1;
            }
        }

        parts[partIndex] = substring(str, lastIndex, b.length);
        return parts;
    }

    function substring(string memory str, uint256 startIndex, uint256 endIndex) internal pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex - startIndex);
        for (uint256 i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = strBytes[i];
        }
        return string(result);
    }

    function stringToUint(string memory s) internal pure returns (uint256) {
        bytes memory b = bytes(s);
        uint256 result = 0;
        for (uint256 i = 0; i < b.length; i++) {
            if (uint8(b[i]) >= 48 && uint8(b[i]) <= 57) {
                result = result * 10 + (uint8(b[i]) - 48);
            }
        }
        return result;
    }

    function isEmpty(string memory s) internal pure returns (bool) {
        return bytes(s).length == 0;
    }

    function isNotEmpty(string memory s) internal pure returns (bool) {
        return bytes(s).length != 0;
    }

    function asBool(string memory s) internal pure returns (bool) {
        if (keccak256(abi.encodePacked(s)) == keccak256(abi.encodePacked("true"))) {
            return true;
        } else {
            return false;
        }
    }

}