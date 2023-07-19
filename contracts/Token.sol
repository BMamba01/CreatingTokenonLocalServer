// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


// write a smart contract to create your own token on a local HardHat network. Once you have your contract, 
// you should be able to use remix to interact with it. 
// From remix, the contract owner should be able to mint tokens to a provided address. 
// Any user should be able to burn and transfer tokens.


contract Token{
    string public name;
    string public symbol;
    uint256 public totalSupply;


    mapping (address => uint256) private balance;
    address private owner;

    // Events for Transfer, Burn and Mint tokens
    event TransferTokens(address indexed sender, address indexed receiver, uint256 value);
    event BurnTokens(address indexed sender, uint256 value);
    event MintTokens(address indexed receiver, uint256 value);

    //  Constructor definition
    constructor(string memory _name, string memory _symbol, uint256 _totalsupply){
        name = _name;
        symbol = _symbol;
        totalSupply = _totalsupply;
        balance[msg.sender] = _totalsupply;
        owner = msg.sender;
    }

    // Functions for Transfer, Burn and Mint Tokens

    // to transfer tokens
    function transferTokens(address _receiver, uint256 _value) public returns (bool success){
        require(balance[msg.sender] >= _value, "Insufficient balance");
        require(_receiver != address(0), "Invalid address");        // address(0) === null addresss

        balance[msg.sender] -= _value;
        balance[_receiver] += _value;
        emit TransferTokens(msg.sender, _receiver, _value);
        return true;
    }

    // to burn tokens 
    function burnTokens(uint256 _value) public returns (bool success){
        require(balance[msg.sender] >= _value, "Insufficient Tokens!");
        
        balance[msg.sender] -= _value;
        totalSupply -= _value;
        emit BurnTokens(msg.sender, _value);

        return true;

    }

    // to check balance 
    function getBalance(address _account) public view returns (uint256) {
        return balance[_account];
    }


    // to mint tokens
    function mintTokens(address _receiver, uint256 _value) public returns (bool success){
        require(msg.sender == owner, "Only the contract owner can Mint Tokens");
        require(_receiver != address(0), "Invalid Address");

        balance[_receiver] += _value;
        totalSupply += _value;
        emit MintTokens(_receiver, _value);

        return true;
    }
}
