// SPDX-License-Identifier: None
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AirDrop is ERC20() {
    bytes32 public immutable root;
    uint256 public immutable rewardAmount;

    mapping (address=>bool) claimed;
    constructor(bytes32 memory _root, uint256 _rewardAmount) ERC20("AirDrop Token", "ATK"){
        rewardAmount = _rewardAmount;
        root = _root;
    }

    function claimToken(bytes32[] calldata _proof) external  {
        require(!claimed[msg.sender], "User already claimed token.");
        bytes32 _leaf = keccak256(abi.encodePacked(msg.sender));
        require(MerkleProof.verify(_proof,root,_leaf), "Merkle proof is invalid");

        claimed[msg.sender] = true;
        _mint(msg.sender,rewardAmount);
    }
    
}
