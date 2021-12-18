// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract SpartanArenaStaking {
    // ---------- Vars ----------
    address public spartaAddress; // SPARTA base contract address
    address public chanceContract; // SPARTA base contract address
    uint256 private globalStaked; // Total SPARTA staked globally
    // ---------- Maps ----------
    mapping(address => uint256) private mapMemberStake; // Total SPARTA staked by user
    mapping(address => uint256) private mapMemberTimestamp; // Timestamp user last staked

    // ---------- Constructor ----------
    constructor() {
        // Assign 'PROTOCOL' role to 'Chance' contract (so it can reset member's stake time)
    }

    // Restrict access (Use a role access library)

    // ---------- Setters ----------

    // GIVE THIS A 'PROTOCOL' ROLE/PERMISSION SO ONLY CAN BE (EXTERNALLY) SET BY THE 'CHANCE' CONTRACT
    function resetMemberTimestamp(address member) external {
        mapMemberTimestamp[member] = block.timestamp + 60;
    }

    // ---------- Actions ----------

    function deposit(uint256 amount) external {}

    function withdraw(uint256 amount) external {}

    // ---------- Getters ----------

    function getMemberStake(address member) public view returns (uint256) {
        return mapMemberStake[member];
    }

    function getMemberTimestamp(address member) public view returns (uint256) {
        return mapMemberTimestamp[member];
    }

    function getGlobalStake() public view returns (uint256) {
        return globalStaked;
    }
}
