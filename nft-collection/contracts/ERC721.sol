// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ERC721 {
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    mapping (address=>uint256) internal _balances;
    mapping (uint256=>address) internal _owners;
    mapping (address=>mapping(address=>bool)) private _operatorApprovals;
    mapping (uint256=>address) private _tokenApprovals;
    
    // Total this ERC721 from owner address
    function balanceOf(address owner) external view returns(uint256) {
        require (owner != address(0), "Owner is 0 address !");
        return _balances[owner];
    }

    // Get owner of NFT
    function ownerOf(uint256 tokenId) public view returns(address){
        address owner = _owners[tokenId];
        require(owner!=address(0), "Owner address is 0 ");
        return owner;
    }

    // Ability enable and disable operator (this is for marketplace)
    function setApprovalForAll(address operator, bool approved) external{
        _operatorApprovals[msg.sender][operator] = approved;

        emit ApprovalForAll(msg.sender, operator, approved);
    }

    // Check if operator address is operator of owner address
    function isApprovedForAll(address  owner, address operator) public view returns (bool){
        require(owner != address(0),"Owner is 0 address");
        require(operator!=address(0), "Operator is 0 address");

        return _operatorApprovals[owner][operator];
    }

    // Update an approved address for NFT
    function approve(address to, uint256 tokenId) public payable{
        address owner = ownerOf(tokenId);
        require(msg.sender == owner || isApprovedForAll(owner,msg.sender), "You are not allowed to approve");

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }
    
    // Get the approved for an NFT
    function getApproved(uint256 tokenId) public view returns (address){
        require(_owners[tokenId] != address(0),"Token Id does not exist");
        return _tokenApprovals[tokenId];
    }

    // Transfer ownership of a single NFT
    function transferFrom(address from, address to, uint256 tokenId) public payable{
        address owner = ownerOf(tokenId);

        require(
            msg.sender == owner ||
            getApproved(tokenId) == msg.sender ||
            isApprovedForAll(owner, msg.sender),
            "Not allowed to transfer"
        );
        
        require(_owners[tokenId] != address(0),"Token Id does not exist");
        require(owner == from, "from is not the owner");
        require(to != address(0), "to address is the 0 address");


        approve(address(0), tokenId);
        _balances[from] -= 1;
        _balances[to] -=1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);

    }

    // Use to transfer NFT to contract, to check contract has ability to receive NFT or not 
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public payable{
        transferFrom(from, to, tokenId);

        require(_checkOnERC721Received(), "Receiver not implemented");
    }

    // Be used to check a smc has able to receive NFT
    function _checkOnERC721Received( ) private pure returns(bool){
        return true;
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) external payable{
        safeTransferFrom(from, to, tokenId, "");
    }

    // EIP165 proposal, use for a third side application 
    function supportInterface(bytes4 interfaceID) public pure virtual returns(bool){
        return interfaceID == 0x80ac58cd;
    }
}