// SPDX-License-Identifier: None
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    constructor(string memory _name, string memory _symbol, uint256 _totalSupply) ERC20(_name, _symbol){
        _mint(msg.sender, _totalSupply);
    }
}