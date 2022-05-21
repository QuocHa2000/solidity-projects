pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Items is ERC1155, Ownable {

    uint256 public constant SWORD = 0;
    uint256 public constant SHIELD = 1;
    uint256 public constant GUN = 2; 
    uint256 public constant KNIFE = 3;
    uint256 public constant DART = 4; 

    string public name;
    string public symbol;
    string public baseUrl;
    uint256 public tokenCount;

    constructor(string memory _name, string memory _symbol, string memory _baseUrl) ERC1155(_baseUrl){
        name = _name;
        symbol = _symbol;
        baseUrl = _baseUrl;
    }

    function mintItem(uint256 itemId) public onlyOwner {
        _mint(msg.sender,itemId,1,"0x00");
    }

    function uri(uint256 _tokenId) override public view returns(string memory) {
        return string(abi.encodePacked(baseUrl, Strings.toString(_tokenId), ".json" ));
    }
}