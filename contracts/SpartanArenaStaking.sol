// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract MyToken {

    // Vars & Maps
    uint256 private globalStaked; // Total SPARTA staked globally
    mapping(address => uint256) private mapMemberStake; // Total SPARTA staked by user
    mapping(address => uint256) private mapMemberTimestamp; // Timestamp user last staked

    constructor() {}

    // Setters

    // Actions
    function deposit(uint256 amount) external {}

    function withdraw(uint256 amount) external {}

    // Getters
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
