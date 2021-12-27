// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "./SpartanArenaStaking.sol";

contract SpartanArenaChance {
    // ---------- Vars ----------
    address public BASE; // SPARTA base contract address
    address public TICKETS; // Tickets contract address
    uint256 public stakeTime; // Time required to be eligible for a dice roll

    // ---------- Events ----------

    // ---------- Interfaces ----------
    SpartanArenaStaking private _STAKING;

    // ---------- Constructor ----------
    constructor(address _base) {
        BASE = _base;
        stakeTime = 604800;
    }

    // ---------- Setters ----------
    function setStakingAddress(address stakingAddr) external {
        _STAKING = SpartanArenaStaking(stakingAddr);
    }

    function setTicketsAddress(address ticketsAddr) external {
        TICKETS = ticketsAddr;
    }

    function setStakeTime(uint256 _stakeTimeSecs) external {
        stakeTime = _stakeTimeSecs;
    }

    // ---------- Actions ----------

    // RollDice Function - **WE SHOULD PROBABLY RETURN THE NFT's ID (IF WIN) TOO**
    function rollDice() external returns (bool winner) {
        uint256 memberTimestamp = _STAKING.getMemberTimestamp(msg.sender); // Get member's staked timestamp
        if ((memberTimestamp + 604800) < block.timestamp) {
            return false; // MIGHT NEED TO AVOID A REVERT HERE IN CASE WE NEED TO CALL IT WITHOUT A REVERT, UI CAN CHECK VARS & HANDLE ERROR MESSAGES OFFCHAIN?
        }
        uint256 globalStake = _STAKING.getGlobalStake(); // Get globally staked SPARTA
        uint256 memberStake = _STAKING.getMemberStake(msg.sender); // Get member's staked SPARTA
        uint256 memberWeight = memberStake * globalStake / 10000; //Calc member's weight vs global
        
        _STAKING.resetMemberTimestamp(msg.sender); // Reset member's timestamp
        // ROLL THE DICE
        bool win = true; // DO RANDOM + WEIGHT LOGIC HERE TO ROLL DICE
        // IF WINNER:
        if (win) {
        // MINT NFT VIA TICKETS CONTRACT (GET THE MINTED NFT'S ID IF POSSIBLE)
            return true;
        }
        // IF NOT A WINNER:
        return false;
    }

  

    // ---------- Getters ----------
}
