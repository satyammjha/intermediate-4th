# DegenToken ERC20 Smart Contract

## Overview

The **DegenToken** smart contract is an ERC20-compliant token that will be used on the **Degen Gaming** platform. This token has the following core functionalities:
1. **Minting**: The platform owner can mint new tokens to distribute as rewards to players.
2. **Transferring**: Players can transfer their tokens to others.
3. **Redeeming**: Players can redeem their tokens by burning them, which is useful for in-game purchases.
4. **Checking Balance**: Players can check their token balance at any time.
5. **Burning**: Anyone can burn tokens they own if they no longer need them.

The contract is implemented using OpenZeppelin's ERC20 and Ownable libraries to ensure security and best practices.

## Features

- **Minting New Tokens**: Only the owner of the contract (platform admin) can mint new tokens.
- **Transferring Tokens**: Standard ERC20 functionality allowing users to transfer tokens between addresses.
- **Redeeming Tokens**: Users can redeem their tokens by burning them from their balance.
- **Checking Balance**: Users can check their token balance at any time using a simple function.
- **Burning Tokens**: Any user can burn their tokens, permanently removing them from circulation.

## Requirements

Before you deploy this contract, make sure you have:
- **Metamask** set up with the Avalanche network.
- **Remix IDE** for writing, compiling, and deploying the contract.
- **Avalanche (AVAX) testnet or mainnet funds** for gas fees.
- **OpenZeppelin Contracts**: The contract uses OpenZeppelin’s ERC20 and Ownable contracts.

## How to Deploy Using Remix

### 1. Setup

#### Prerequisites
- **Metamask**: Make sure you have Metamask installed and connected to the Avalanche network (testnet or mainnet).
- **Remix IDE**: Go to [Remix IDE](https://remix.ethereum.org) in your browser.

#### Connecting to Avalanche Network
- **Avalanche Testnet (Fuji)**:
    - Network Name: Avalanche FUJI C-Chain
    - RPC URL: `https://api.avax-test.network/ext/bc/C/rpc`
    - ChainID: `43113`
    - Symbol: `AVAX`
    - Explorer URL: `https://testnet.snowtrace.io/`

- **Avalanche Mainnet**:
    - Network Name: Avalanche Mainnet C-Chain
    - RPC URL: `https://api.avax.network/ext/bc/C/rpc`
    - ChainID: `43114`
    - Symbol: `AVAX`
    - Explorer URL: `https://snowtrace.io/`

### 2. Smart Contract Code

Copy the following code and paste it into a new file in the Remix IDE:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    constructor() ERC20("Degen", "DGN") {}

    
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

   
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(amount > 0, "Transfer amount must be greater than zero");
        require(recipient != address(0), "Invalid address");

        _transfer(_msgSender(), recipient, amount);
        return true;
    }

   
    function redeem(uint256 amount) public returns (bool) {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance to redeem");
        _burn(msg.sender, amount);
        return true;
    }

  
    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function burn(uint256 amount) public {
        require(amount > 0, "Burn amount must be greater than zero");
        _burn(msg.sender, amount);
    }
}
```

### 3. Compile the Contract

1. In Remix, go to the **Solidity Compiler** tab.
2. Select the compiler version `0.8.18` (or a compatible version).
3. Click on **Compile DegenToken.sol**.

### 4. Deploy the Contract

1. Go to the **Deploy & Run Transactions** tab.
2. Ensure that **Environment** is set to **Injected Web3** (this connects Remix to your Metamask wallet).
3. Select your contract `DegenToken` in the contract dropdown.
4. Click on **Deploy**.
5. Confirm the transaction in Metamask.

### 5. Interact with the Contract

Once deployed, you can interact with the contract via the Remix interface or directly using Metamask.

#### Mint Tokens (Owner Only)
- **Function**: `mint(address to, uint256 amount)`
- Parameters:
    - `to`: The address to mint tokens to.
    - `amount`: The number of tokens to mint.

#### Transfer Tokens
- **Function**: `transfer(address recipient, uint256 amount)`
- Parameters:
    - `recipient`: The address to send tokens to.
    - `amount`: The number of tokens to transfer.

#### Redeem Tokens
- **Function**: `redeem(uint256 amount)`
- Parameters:
    - `amount`: The number of tokens to redeem (burn).

#### Check Balance
- **Function**: `checkBalance(address account)`
- Parameters:
    - `account`: The address whose balance you want to check.

#### Burn Tokens
- **Function**: `burn(uint256 amount)`
- Parameters:
    - `amount`: The number of tokens to burn.

### 6. Verify the Contract (Optional)

To verify the contract on the Avalanche Explorer (either testnet or mainnet):
1. Copy your contract address.
2. Go to the corresponding explorer ([Snowtrace](https://snowtrace.io/) for mainnet, or [testnet Snowtrace](https://testnet.snowtrace.io/) for Fuji testnet).
3. Search for your contract address and use the **Contract Verification** feature to submit your source code.

## Troubleshooting

- **Compiler Issues**: If you encounter any issues with compiling, ensure that the Solidity version in Remix matches the one used in the contract (`0.8.18`).
- **Metamask Errors**: Ensure you are connected to the Avalanche network and have AVAX tokens for gas fees.

## License

This project is licensed under the MIT License.
## Author
- Satyam Jha (satyammjha0@gmail.com)
