// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockLink is ERC20 {
    constructor() ERC20("Mock Link", "LINK") {
        _mint(msg.sender, 1000000 * 10 ** uint(decimals())); // Mint 1,000,000 tokens to the contract deployer
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

}
