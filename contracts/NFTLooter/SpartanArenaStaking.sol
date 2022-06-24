// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract SpartanArenaStaking is SafeERC20 {
    // ---------- Vars ----------
    address public spartaAddress; // SPARTA base contract address
    address public chanceContract; // Spartan arena chance contract address
    uint256 private globalStaked; // Total SPARTA staked globally

    // ---------- Maps ----------
    mapping(address => uint256) private mapMemberStake; // Total SPARTA staked by user
    mapping(address => uint256) private mapMemberTimestamp; // Timestamp user last staked

    // ---------- Events ----------
    event MemberDeposits(address indexed member, uint256 amount);
    event MemberWithdraws(address indexed member, uint256 amount);

    // ---------- Constructor ----------
    constructor(address base) {
        spartaAddress = base;
    }

    // Restrict access (Use a role access library)

    // ---------- Setters ----------

    // GIVE THIS A 'PROTOCOL' ROLE/PERMISSION SO ONLY CAN BE (EXTERNALLY) SET BY THE 'CHANCE' CONTRACT
    function resetMemberTimestamp(address member) external {
        mapMemberTimestamp[member] = block.timestamp + 60;
    }

    function initChanceContract (address chanceAddress) external {
        chanceContract = chanceAddress;
          // Assign 'PROTOCOL' role to 'Chance' contract (so it can reset member's stake time)
    }

    // ---------- Actions ----------

    function deposit(uint256 amount) external {
        require(amount > 0, "!VALID"); // Must be a valid amount | #EmptyEvents
        safeTransferFrom(
            spartaAddress,
            msg.sender,
            address(this),
            amount
        );
        mapMemberStake[msg.sender] += amount;
        globalStaked += amount;
        mapMemberTimestamp[msg.sender] = block.timestamp; // Only required on deposit, withdrawal (even if not 100% withdrawal) should keep timestamp
        emit MemberDeposits(msg.sender, amount);
    }

    function withdraw(uint256 amount) external {
        uint256 _memberStaked = mapMemberStake[msg.sender]; // Store in memory | #SaveGas
        require(_memberStaked > 0, "!STAKED"); // Must have existing stake
        require(amount > 0 && amount <= _memberStaked, "!VALID"); // Must be a valid amount | #EmptyEvents
        mapMemberStake[msg.sender] = _memberStaked - amount;
        globalStaked -= amount;
        safeTransfer(spartaAddress,  msg.sender,  amount);
        emit MemberWithdraws(msg.sender, amount);
    }

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
