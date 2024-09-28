# DegenToken Smart Contract

## Overview

The `DegenToken` is an ERC20 token smart contract built on the Ethereum blockchain using Solidity. This token is designed for use in a gaming ecosystem, allowing players to earn, transfer, redeem, and manage in-game tokens. The contract implements various functionalities such as minting, burning, and redeeming tokens for in-game items.

## Features

- **Minting Tokens**: Only the contract owner can mint new tokens and distribute them to players as rewards.
- **Transferring Tokens**: Players can transfer their tokens to other players.
- **Redeeming Tokens**: Players can redeem their tokens for various items in the in-game store.
- **Checking Token Balance**: Players can check their token balance at any time.
- **Burning Tokens**: Any player can burn their tokens if they are no longer needed.

## Prerequisites

To deploy and interact with the `DegenToken` smart contract, you will need the following:

- [Node.js](https://nodejs.org/) (with npm)
- [Truffle](https://www.trufflesuite.com/truffle) or [Hardhat](https://hardhat.org/)
- [Ganache](https://www.trufflesuite.com/ganache) (for local testing)
- A code editor such as [Visual Studio Code](https://code.visualstudio.com/)

## Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/yourusername/degen-token.git
   cd degen-token
Install Dependencies:

If you are using Truffle:

bash
Copy code
npm install -g truffle
npm install @openzeppelin/contracts
If you are using Hardhat:

bash
Copy code
npm install --save-dev hardhat @openzeppelin/contracts
Compile the Smart Contract:

If using Truffle:

bash
Copy code
truffle compile
If using Hardhat:

bash
Copy code
npx hardhat compile
Deploy the Smart Contract:

If using Truffle:

bash
Copy code
truffle migrate --network development
If using Hardhat:

Create a deployment script in the scripts folder, then run:

bash
Copy code
npx hardhat run scripts/deploy.js --network localhost
Contract Functions
mint(address to, uint256 amount)
Allows the owner to mint new tokens and assign them to a specified address.

rewardPlayer(address receiver, uint256 amount)
Allows the owner to reward a player by transferring tokens.

burn(uint256 amount)
Allows players to burn their tokens.

redeem(uint256 action)
Allows players to redeem tokens for in-game items based on the action specified.

checkBalance(address account)
Returns the token balance of a specified account.

getItemNames()
Returns the list of redeemable items available in the in-game store.

getRedeemedItems(address account)
Returns the list of items redeemed by a specified account.

transfer(address recipient, uint256 amount)
Allows a player to transfer tokens to another player.

Testing
You can write unit tests for the contract using JavaScript or TypeScript. Place your test files in the test directory and run:

bash
Copy code
truffle test
or

bash
Copy code
npx hardhat test
