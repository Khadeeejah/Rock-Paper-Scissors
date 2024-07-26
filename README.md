# Building a Trustless Rock-Paper-Scissors Game with Solidity

In this tutorial, we will explore how to build a Rock-Paper-Scissors game using Solidity. One of the key features of a smart contract is its trustless nature, ensuring that neither Jack nor Jill can cheat in the process and no third party can tamper with the result.

## Key Criteria

To ensure the integrity and fairness of the game, we must meet the following criteria:
...
08. No Prior Knowledge: Jack and Jill should not know each other's choices before submission
09. Immutable Choices: Neither Jack nor Jill can change their choice after submission
10. Tamper-Proof: Third parties cannot tamper with the choices
11. Determine Winner: The smart contract can determine the winner based on the choices

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


