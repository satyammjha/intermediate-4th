# DegenToken

This project implements an ERC-20 token called **DegenToken (DGN)** along with a basic in-game store where users can redeem items by spending their tokens. The token uses OpenZeppelin's ERC20 standard and provides additional functionality for token issuance, transfers, and burning.

## Key Features

- **ERC-20 Token**: `DegenToken` is a custom ERC-20 token.
- **Token Issuance**: The owner can issue tokens to specific addresses.
- **In-Game Store**: Users can redeem tokens to buy in-game items like skins, jackets, and guns.
- **Token Burning**: Users can burn their own tokens to reduce the supply.
- **Inventory System**: Tracks the number of items redeemed by each player.

## Prerequisites

Before running the contract, ensure you have the following:

- **MetaMask**: MetaMask should be installed in your browser, as this contract interacts with MetaMask through the injected Web3 provider.
- **Remix IDE**: You will need to use Remix IDE to compile, deploy, and interact with the smart contract.

## Contract Overview

### Inheritance and Libraries

- `ERC20`: Inherits from OpenZeppelin's ERC20 contract to create a token that follows the ERC20 standard.
- `Ownable`: Inherits from OpenZeppelin's `Ownable` to restrict certain functions to the contract owner (like issuing tokens or adding items to the store).

### Key Functions

- **Constructor**: Initializes the token name as `DegenToken` and the symbol as `DGN`. It also adds some predefined items to the store (e.g., "Skin", "Gun", "Jacket").

```solidity
constructor() ERC20("DegenToken", "DGN") {
    _addItem("Skin", 300, "A super cool skin for accessories");
    _addItem("Gun", 370, "Snow gun which releases Icet");
    _addItem("Jacket", 360, "Adventurousous biker's Jacket");
}
```

- **issueTokens**: Allows the contract owner to issue (mint) new tokens to a given address.
  
  ```solidity
  function issueTokens(address to, uint256 amount) public onlyOwner {
      _mint(to, amount);
  }
  ```

- **sendTokens**: Allows users to send tokens to another address.

- **redeem**: Allows users to redeem tokens for in-game items. The cost of the item is deducted from their balance.

- **destroyTokens**: Allows users to burn a specific number of their own tokens.

- **_addItem**: A helper function used by the owner to add new items to the store.

- **listAllItems**: Returns a list of all available in-game items.

## Deployment on Remix IDE

1. **Open Remix IDE**:
   - Visit [Remix IDE](https://remix.ethereum.org) in your browser.
   
2. **Install MetaMask**:
   - Ensure you have the MetaMask extension installed and set up in your browser.
   - Connect MetaMask to the Remix IDE by selecting the "Injected Web3" option.

3. **Copy the Contract**:
   - Copy the entire Solidity code into a new `.sol` file in Remix.

4. **Compile the Contract**:
   - In the **Solidity Compiler** tab, select version `0.8.18` or above.
   - Click on **Compile**.

5. **Deploy the Contract**:
   - In the **Deploy & Run Transactions** tab, choose the `Injected Web3` environment (this should be MetaMask).
   - Click on **Deploy** and confirm the transaction in MetaMask.

6. **Interact with the Contract**:
   - After deployment, you can interact with the contract using Remix or a frontend that connects to MetaMask.

## Interacting with MetaMask

To interact with this contract using MetaMask on Remix:

1. **Connect MetaMask**: Ensure MetaMask is connected and funded with ETH to pay for gas fees.
2. **Issue Tokens**: As the owner, you can issue tokens by calling the `issueTokens` function and providing the recipient's address and token amount.
3. **Redeem Items**: Use the `redeem` function to redeem store items by providing the item ID and sufficient token balance.
4. **Check Inventory**: Use the `getPlayerInventory` function to check how many items a player has redeemed.

## Store Items

Initial items in the store:

| Item ID | Name  | Price (DGN) | Description                         |
|---------|-------|-------------|-------------------------------------|
| 1       | Skin  | 300         | A super cool skin for accessories   |
| 2       | Gun   | 370         | Snow gun which releases Icet        |
| 3       | Jacket| 360         | Adventurous biker's Jacket          |

## Token Functions

### Token Transfers

- **sendTokens(recipient, amount)**: Transfer tokens to another player.
- **getBalance(account)**: Check the balance of a specific address.

### Burn Tokens

- **destroyTokens(amount)**: Burn (destroy) a specified amount of tokens from the caller's balance.


## License

This project is licensed under the MIT License.

---
## Author
Satyam Jha (satyammjha0@gmail.com)
