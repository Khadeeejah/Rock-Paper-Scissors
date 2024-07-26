// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// address 1 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
//  address 2 = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2



contract Game {
bytes32 public constant ROCK = "ROCK";
bytes32 public constant PAPER = "PAPER";
bytes32 public constant SCISSORS = "SCISSORS";

mapping (address => bytes32) public choices;

    function play(bytes32 choice )public {
    require(choices[msg.sender] == ROCK || choices[msg.sender] == PAPER || choices[msg.sender] == SCISSORS);
        choices[msg.sender] = choice;

    }

function evaluate(address jack, bytes32 jackChoice, bytes32 jackRandomness,  address jill, bytes32 jillChoice, bytes32 jillRandomness )
 external view returns (address) {
    require(keccak256(abi.encodePacked(jackChoice, jackRandomness)) == choices[jack]);
    require(keccak256(abi.encodePacked(jillChoice, jillRandomness)) == choices[jill]);


    // if they played a draw
    if(jackChoice == jillChoice){
        return address(0);
    }
    // check all possible winning combinations and declare the winner
    if ((jackChoice == ROCK && jillChoice == PAPER) ||
        (jillChoice == ROCK && jackChoice == PAPER)) {
      return jackChoice == ROCK ? jack : jill;   // Return either jack or jill depending on who chose ROCK
    }
    if ((jackChoice == SCISSORS && jillChoice == PAPER) ||
        (jillChoice == SCISSORS && jackChoice == PAPER)) {
      return jackChoice == SCISSORS ? jack : jill; // Return either jack or jill depending on who chose SCISSORS
    }
    if ((jackChoice == ROCK && jillChoice == SCISSORS) ||
        (jillChoice == ROCK && jackChoice == SCISSORS)) {
      return jackChoice == ROCK ? jack : jill;   // Return either jack or jill depending on who chose ROCK
    }

    revert("Invalid choices");                    // If all other conditions fail, revert with an error message.
}

}