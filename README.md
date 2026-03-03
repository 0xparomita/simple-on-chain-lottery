# Simple On-Chain Lottery

This repository contains a high-quality, flat-structured implementation of a blockchain-based lottery system. It demonstrates how to manage a pool of participants and distribute a prize pool automatically.

## Features
* **Ticket System:** Users enter the lottery by sending a fixed amount of ETH.
* **Prize Pool:** All entry fees are held in the contract until a winner is picked.
* **Automated Payout:** The contract automatically transfers the entire balance to the winner.
* **Security:** Only the manager can trigger the winner selection, but the logic is transparently coded.

## Getting Started
1. Deploy `Lottery.sol`.
2. Users call `enter()` and send the required `0.01 ETH`.
3. The manager calls `pickWinner()` once enough players have joined.
4. The contract selects a winner based on block difficulty and timestamp, sends the funds, and resets for the next round.

## License
MIT
