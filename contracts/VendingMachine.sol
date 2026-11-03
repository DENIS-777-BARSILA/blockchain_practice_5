// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract VendingMachine {
    // state variables
    address public owner;
    mapping (address => uint) public cupcakeBalances;
    string private _symbol;

    // set the owner as the address that deployed the contract
    // set the initial vending machine balance to 100
    constructor(string memory symbol_) {
        owner = msg.sender;
        cupcakeBalances[address(this)] = 100;
        _symbol = symbol_;
    }

    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    function balanceOf(address account) public view virtual returns (uint256) {
        return cupcakeBalances[account];
    }

    function getVendingMachineBalance() public view returns (uint) {
        return cupcakeBalances[address(this)];
    }

    // Let the owner refill the vending machine
    function refill(uint amount) public {
        require(msg.sender == owner, "Only the owner can refill.");
        cupcakeBalances[address(this)] += amount;
    }

    // Purchase cupcake from the vending machine
    function purchase(uint amount) public payable {
        require(msg.value >= amount * 1e9, "You must pay at least 1 gwei per cupcake");
        require(cupcakeBalances[address(this)] >= amount, "Not enough cupcakes in stock to complete this purchase");
        cupcakeBalances[address(this)] -= amount;
        cupcakeBalances[msg.sender] += amount;
    }
}