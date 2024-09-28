// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    mapping(address => bool) private _tokenHolders;
    mapping(address => string[]) private itemsRedeemed;
    string[] public redeemableItems;

    // Constructor to initialize the ERC20 token and the Ownable contract
    constructor() ERC20("Degen", "DGN") {
        redeemableItems.push("Choose Number respectively starting from 1");
        redeemableItems.push("Silver Loot Box");
        redeemableItems.push("Gold Loot Box");
        redeemableItems.push("Platinum Loot Box");
    }

    // Set the owner to the address that deploys the contract
    function _transferOwnership() internal {
        transferOwnership(msg.sender);
    }

    // Mint new tokens; only the owner can mint
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
        _addTokenHolder(to); // Track new token holder
    }

    // Check the names of redeemable items
    function getItemNames() public view returns (string[] memory) {
        return redeemableItems;
    }

    // Reward a player by transferring tokens
    function rewardPlayer(address receiver, uint256 amount) public onlyOwner {
        _transfer(msg.sender, receiver, amount); // Ensure transfer from owner
        _addTokenHolder(receiver); // Track new token holder
    }

    // Burn tokens
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
        _removeTokenHolderIfNeeded(msg.sender); // Remove holder if balance is zero
    }

    // Redeem items based on action number
    function redeem(uint256 action) public {
        uint256 requiredAmount;
        string memory itemRedeemed;

        if (action == 1) {
            requiredAmount = 20;
            itemRedeemed = redeemableItems[1];
        } else if (action == 2) {
            requiredAmount = 50;
            itemRedeemed = redeemableItems[2];
        } else if (action == 3) {
            requiredAmount = 100;
            itemRedeemed = redeemableItems[3];
        } else {
            revert("Invalid action");
        }

        require(balanceOf(msg.sender) >= requiredAmount, "Insufficient balance to redeem");
        _burn(msg.sender, requiredAmount);
        itemsRedeemed[msg.sender].push(itemRedeemed);
    }

    // Check balance of an account
    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    // Get redeemed items for a specific account
    function getRedeemedItems(address account) public view returns (string[] memory) {
        return itemsRedeemed[account];
    }

    // Override transfer function to track token holders
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        bool success = super.transfer(recipient, amount);
        if (success) {
            _addTokenHolder(recipient); // Track new token holder
        }
        return success;
    }

    // Private function to add a token holder
    function _addTokenHolder(address account) private {
        if (!_tokenHolders[account]) {
            _tokenHolders[account] = true;
        }
    }

    // Private function to remove a token holder if they have no tokens
    function _removeTokenHolderIfNeeded(address account) private {
        if (balanceOf(account) == 0) {
            _tokenHolders[account] = false;
        }
    }

    // Optional: Get the list of current token holders (note: this will not be efficient for a large number of holders)
    function getTokenHolders() public view returns (address[] memory) {
        uint256 holderCount = 0;
        for (uint256 i = 0; i < totalSupply(); i++) { // This is not optimal for large numbers; consider alternative storage
            // Logic to collect addresses can be implemented
            // Here you might need to implement a proper tracking system
        }
        address[] memory holders = new address[](holderCount);
        // Fill in the array with addresses of holders
        return holders;
    }
}

