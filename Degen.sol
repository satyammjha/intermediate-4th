// SPDX-License-Identifier: MIT
/*
Your task is to create a ERC20 token and deploy it on the Avalanche network for Degen Gaming.
 The smart contract should have the following functionality:

1) Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
2) Transferring tokens: Players should be able to transfer their tokens to others.
3) Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
4) Checking token balance: Players should be able to check their token balance at any time.
5) Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract CryptoToken is ERC20, Ownable {

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
    }

    event AssetTransfer(address indexed from, address indexed to, uint256 amount);
    event ItemsExchanged(address indexed user, uint256 itemAmount, uint256 tokensSpent);

    uint256 private totalMinted;

    struct ExchangedItem {
        uint256 itemCount;
        uint256 tokensUsed;
    }

    mapping(address => ExchangedItem[]) private userExchanges;

    uint256 public itemTokenPrice = 1; // 1 CRP token per item by default

    function totalSupply() public view override returns (uint256) {
        return totalMinted;
    }

    function generateTokens(address recipient, uint256 quantity) public onlyOwner {
        require(recipient != address(0), "Error: Cannot mint to zero address");
        _mint(recipient, quantity);
        totalMinted += quantity;
        emit AssetTransfer(address(0), recipient, quantity);
    }

    function destroyTokens(address holder, uint256 quantity) public {
        require(holder != address(0), "Error: Cannot burn from zero address");
        _burn(holder, quantity);
        totalMinted -= quantity;
        emit AssetTransfer(holder, address(0), quantity);
    }

    function transferAssets(address from, address to, uint256 quantity) public returns (bool) {
        require(from != address(0), "Error: Invalid sender");
        require(to != address(0), "Error: Invalid recipient");
        _transfer(from, to, quantity);
        emit AssetTransfer(from, to, quantity);
        return true;
    }

    function getBalance(address account) public view returns (uint256) {
        require(account != address(0), "Error: Invalid address");
        return balanceOf(account);
    }

    function exchangeTokensForItems(uint256 itemCount) public {
        require(itemCount > 0, "Error: Must exchange at least one item");
        uint256 requiredTokens = itemCount * itemTokenPrice;
        require(balanceOf(_msgSender()) >= requiredTokens, "Error: Insufficient balance");

        _burn(_msgSender(), requiredTokens);

        userExchanges[_msgSender()].push(ExchangedItem({
            itemCount: itemCount,
            tokensUsed: requiredTokens
        }));

        emit ItemsExchanged(_msgSender(), itemCount, requiredTokens);
    }

    function getUserExchanges(address user) public view returns (ExchangedItem[] memory) {
        require(user != address(0), "Error: Invalid address");
        return userExchanges[user];
    }

    function displayExchanges(address user) public view returns (string memory) {
        require(user != address(0), "Error: Invalid address");
        ExchangedItem[] memory exchanges = userExchanges[user];
        require(exchanges.length > 0, "Error: No exchanges found");

        string memory output = "";
        for (uint256 i = 0; i < exchanges.length; i++) {
            output = string(abi.encodePacked(
                output,
                "Exchange ", uintToStr(i + 1), ": ",
                "Items: ", uintToStr(exchanges[i].itemCount),
                " Tokens Used: ", uintToStr(exchanges[i].tokensUsed),
                "\n"
            ));
        }
        return output;
    }

    function uintToStr(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 digitsCount;
        uint256 tempValue = value;
        while (tempValue != 0) {
            digitsCount++;
            tempValue /= 10;
        }
        bytes memory buffer = new bytes(digitsCount);
        while (value != 0) {
            digitsCount -= 1;
            buffer[digitsCount] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
