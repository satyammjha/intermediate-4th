// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {


    struct Item {
        string name;
        uint256 price;
        string description;
    }

    mapping(uint256 => Item) public storeItems;
    mapping(address => uint256) public inventoryCount;
    uint256 public currentItemId = 1;

    constructor() ERC20("DegenToken", "DGN") {
        _addItem("Skin", 300, "A super cool skin for accessories");
        _addItem("Gun", 370, "Snow gun which releases Icet");
        _addItem("Jacket", 360, "Adventurousous biker's Jacket");
    }

    function issueTokens(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function sendTokens(address recipient, uint256 amount) public returns (bool) {
        require(amount > 0, "Cannot transfer zero tokens");
        require(recipient != address(0), "Cannot send to zero address");

        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function redeem(uint256 itemId) public returns (bool) {
        Item memory item = storeItems[itemId];
        require(bytes(item.name).length > 0, "Item does not exist");
        require(balanceOf(msg.sender) >= item.price, "Insufficient token balance");

        _burn(msg.sender, item.price); 
        inventoryCount[msg.sender] += 1;
        return true;
    }

    function getBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function destroyTokens(uint256 amount) public {
        require(amount > 0, "Cannot burn zero tokens");
        _burn(msg.sender, amount);
    }

    function _addItem(string memory name, uint256 price, string memory description) public onlyOwner {
        storeItems[currentItemId] = Item(name, price, description);
        currentItemId += 1;
    }


    function getPriceOfItem(uint256 itemId) public view returns (uint256) {
        return storeItems[itemId].price;
    }

    function getPlayerInventory(address player) public view returns (uint256) {
        return inventoryCount[player];
    }


    function listAllItems() public view returns (Item[] memory) {
        Item[] memory availableItems = new Item[](currentItemId - 1);
        for (uint256 i = 1; i < currentItemId; i++) {
            availableItems[i - 1] = storeItems[i];
        }
        return availableItems;
    }
}
