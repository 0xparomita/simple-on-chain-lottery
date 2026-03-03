// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Lottery
 * @dev A simple decentralized lottery contract.
 */
contract Lottery {
    address public manager;
    address payable[] public players;

    event WinnerPicked(address indexed winner, uint256 amount);

    constructor() {
        manager = msg.sender;
    }

    /**
     * @dev Allows a user to enter the lottery by sending 0.01 ETH.
     */
    function enter() public payable {
        require(msg.value == 0.01 ether, "Entry fee is exactly 0.01 ETH");
        players.push(payable(msg.sender));
    }

    /**
     * @dev Generates a pseudo-random number for winner selection.
     * Note: For production, use Chainlink VRF for true randomness.
     */
    function random() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, players)));
    }

    /**
     * @dev Picks a winner and transfers the contract balance.
     */
    function pickWinner() public {
        require(msg.sender == manager, "Only manager can pick winner");
        require(players.length > 0, "No players in lottery");

        uint256 index = random() % players.length;
        address payable winner = players[index];
        
        uint256 prizeAmount = address(this).balance;
        winner.transfer(prizeAmount);
        
        emit WinnerPicked(winner, prizeAmount);

        // Reset the lottery for the next round
        players = new address payable[](0);
    }

    /**
     * @dev Returns the list of players.
     */
    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }
}
