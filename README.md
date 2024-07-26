# Building a Trustless Rock-Paper-Scissors Game with Solidity

In this tutorial, we will explore how to build a Rock-Paper-Scissors game using Solidity. One of the key features of a smart contract is its trustless nature, ensuring that neither Jack nor Jill can cheat in the process and no third party can tamper with the result.

## Key Criteria

To ensure the integrity and fairness of the game, we must meet the following criteria:

...

1. No Prior Knowledge: Jack and Jill should not know each other's choices before submission
2. Immutable Choices: Neither Jack nor Jill can change their choice after submission
3. Tamper-Proof: Third parties cannot tamper with the choices
4. Determine Winner: The smart contract can determine the winner based on the choices

...

## Using Cryptographic Hash Functions

To achieve these criteria, we utilize a cryptographic function called a hash function. Hash functions are one-way functions that map data to a fixed-size number with the following properties:

...

1. Deterministic: Given the same input, the function always produces the same hash.
2. Unique: Different inputs produce different hashes.
3. Non-reversible: Given a hash, it’s computationally impossible to determine the original input.

...

## Implementing the Protocol

1. Choice and Nonce Generation:

* Jack and Jill pick their choice and generate a nonce (a large random number).

* They concatenate their choice with the nonce and compute the hash of the concatenated string.

* They submit this hash to the smart contract.

2. Revealing Choices:

* After both parties have submitted their hashes, they reveal their choices and nonces.

* The smart contract verifies that the revealed choice and nonce match the submitted hash.

* The choices are then stored.

3. Determine Result:

* After both parties reveal their choices, the smart contract computes the result and determines the winner.

## Code Implementation

Let's start by defining the smart contract and its key components.

## Step 1: Define State Variables and Choices

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Game {
    bytes32 public constant ROCK = "ROCK";
    bytes32 public constant PAPER = "PAPER";
    bytes32 public constant SCISSORS = "SCISSORS";

    mapping(address => bytes32) public choices;
}
```

* ROCK, PAPER, SCISSORS: These constants represent the possible choices in the game, stored as bytes32 values.

* Choices: A mapping that keeps track of the hashed choices made by each player. The key is the player's address, and the value is the hashed choice

## Step 2: Play Function

The play the function allows a player to record their hashed choice.

```solidity
function play(bytes32 choice) public {
    require(choice == ROCK || choice == PAPER || choice == SCISSORS, "Invalid choice");
    choices[msg.sender] = choice;
}
```

* Validation: Ensures the choice is valid (must be either the hashed version of ROCK, PAPER, or SCISSORS).

* Recording the Choice: Stores the player's hashed choice in the choices mapping

## Step 3: Evaluate Function

The evaluate function determines the winner between two players, Jack and Jill, by verifying the hashed choices with the revealed choices and randomness values.

```solidity
function evaluate(
    address jack, 
    bytes32 jackChoice, 
    bytes32 jackRandomness,  
    address jill, 
    bytes32 jillChoice, 
    bytes32 jillRandomness
) external view returns (address) {
    require(keccak256(abi.encodePacked(jackChoice, jackRandomness)) == choices[jack], "Invalid jack choice or randomness");
    require(keccak256(abi.encodePacked(jillChoice, jillRandomness)) == choices[jill], "Invalid jill choice or randomness");

    if (jackChoice == jillChoice) {
        return address(0); // Draw
    } 
    if ((jackChoice == ROCK && jillChoice == PAPER) || (jillChoice == ROCK && jackChoice == PAPER)) {
        return jackChoice == ROCK ? jack : jill;
    } 
    if ((jackChoice == SCISSORS && jillChoice == PAPER) || (jillChoice == SCISSORS && jackChoice == PAPER)) {
        return jackChoice == SCISSORS ? jack : jill;
    } 
    if ((jackChoice == ROCK && jillChoice == SCISSORS) || (jillChoice == ROCK && jackChoice == SCISSORS)) {
        return jackChoice == ROCK ? jack : jill;
    } 
    revert("Invalid choices");
}
```

* Validation of Choices: Ensures the revealed choices and randomness match the previously recorded hashed choices.

* Draw Check: If both players make the same choice, it's a draw.

* Determine Winner: Checks all possible winning combinations and returns the address of the winning player.

## Conclusion

Building a trustless Rock-Paper-Scissors game using Solidity demonstrates the power and potential of smart contracts in creating fair and transparent systems. By leveraging cryptographic hash functions, we ensure that neither player can cheat or gain an unfair advantage, maintaining the integrity of the game. This tutorial walks through the essential steps of implementing the protocol, from defining state variables and recording choices to evaluating the winner. With this foundation, developers can explore and innovate in the realm of decentralized applications, creating more complex and secure games and systems on the blockchain.

By following this tutorial, you now have a basic understanding of how to implement a secure and fair Rock-Paper-Scissors game using Solidity. This mechanism ensures fairness and prevents players from changing their choices after seeing their opponent's choice.
