// SPDX-License-Identifier: None
pragma solidity ^0.8.13;

import "./Token.sol";

contract SwapContract {
    Token public token;
    uint256 public rate;

    event BuyToken (address buyer, address token, uint256 amount, uint256 rate);
    event SellToken (address seller, address token, uint256 amount, uint256 rate);

    constructor() {
        token = new Token("Main Token", "MTK",1000000*10**18);
    }

    function buyTokens() public payable returns(bool) {
        uint256 tokenAmount = msg.value * rate;
        require(tokenAmount <= token.balanceOf(address(this)), "Have no enough token to buy");

        token.transfer(msg.sender,tokenAmount);
        emit BuyToken(msg.sender, address(token), tokenAmount, rate);
        return true;

    }

    function sellTokens(uint256 _amount) public payable returns(bool) {
        require(token.balanceOf(msg.sender) < _amount, "Balance is less than amount to sell");
        uint256 ethToken = _amount/ rate;
        require(address(this).balance > ethToken, "ETH balance is not enough to sell");

        token.transferFrom(msg.sender,address(this),_amount);
        (bool sent,) = msg.sender.call{value : ethToken}("");
        require(sent, "Transaction is failed");

        emit SellToken(msg.sender, address(token), _amount, rate);
        return true;


    }
}