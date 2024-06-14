// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract AccessControlManager is AccessControl {
    bytes32 public constant AUTHORIZED_CONTRACT = keccak256("AUTHORIZED_CONTRACT");

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function authorizeContract(address contractAddress) external onlyRole(DEFAULT_ADMIN_ROLE) {
        grantRole(AUTHORIZED_CONTRACT, contractAddress);
    }

    function revokeContract(address contractAddress) external onlyRole(DEFAULT_ADMIN_ROLE) {
        revokeRole(AUTHORIZED_CONTRACT, contractAddress);
    }
   
    function onlyAuthorizadContract(address _address) public view returns (bool) {
        return hasRole(AUTHORIZED_CONTRACT, _address);
    }

}
