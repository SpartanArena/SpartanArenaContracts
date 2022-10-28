// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract UpDownArena is AccessControl {
    // ---------- Interfaces ----------
    using SafeERC20 for IERC20;

    // ---------- Vars ----------
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant MODERATOR_ROLE = keccak256("MODERATOR_ROLE");
    address public poolAddr; // Pool address
    address public baseAddr; // Base/main token having its value predicted
    address public quoteAddr; // Quote 'currency' to measure the baseToken value in
    address public reserveAddr; // Address for the reserve holdings

    uint256 public secsPerArena; // Number of seconds per arena
    uint256 public reserveShare; // Basis point share going to the reserve
    uint256 public runnerShare; // Basis point share going to the 'runners' who successfully help finalise the arena
    uint256 public runnerMinCount; // Number of runners required to finalise the arena
    uint256 public runnerMinSparta; // Minimum SPARTA the runner must be holding to participate

    uint256 public currentArena; // Current arena
    uint256 public runnerCount; // Count of runners of current arena
    uint256 public runnerLastBlock; // Block of most recent runner call
    uint256 public reserve; // Rerserve LP unit balance

    // Need mapping & struct for user's "position"
    mapping(uint256 => Arena) public arenas;

    struct Arena {
        uint256 arenaId;
        uint256 startTime;
        uint256 closeTime;
        uint256 finalTime;
        uint256 closePrice;
        uint256 finalPrice;
        uint256 upCount;
        uint256 downCount;
        uint256 totalAmount;
        uint256 rewardPerShare;
    }

    // ---------- Events ----------

    // ---------- Modifiers ----------

    // ---------- Constructor ----------
    constructor(
        address _poolAddr,
        address _reserveAddr,
        uint256 _secsPerArena,
        uint256 _reserveShare,
        uint256 _runnerShare,
        uint256 _runnerMinCount,
        uint256 _runnerMinSparta
    ) {
        _setupRole(ADMIN_ROLE, msg.sender);
        _setupRole(MODERATOR_ROLE, msg.sender);
        poolAddr = _poolAddr;
        reserveAddr = _reserveAddr;
        // baseToken = interface in pool and get BASE;
        // quoteToken = interface in pool and get TOKEN;
        secsPerArena = _secsPerArena;
        reserveShare = _reserveShare;
        runnerShare = _runnerShare;
        runnerMinCount = _runnerMinCount;
        runnerMinSparta = _runnerMinSparta;
    }

    // ---------- Setters ----------

    // ---------- Actions ----------
    /** Create new Arena **/
    function createArena() external {}

    /** Predict price will go up **/
    function goingUp() external {}

    /** Predict price will go down **/
    function goingDown() external {}

    /**
     * Any user can help derive the Arena's final price
     * These users are dubbed 'runners'
     * Successful runners share a portion of the prize pool (runnerShare)
     * Successive runners must call with:
     * - A unique block
     * - A unique msg.sender
     * - Be holding > runnerMinSparta
     */
    function finaliseArena() external {
        // Check block is > runnerLastBlock
        // Check holding > runnerMinSparta
        // Check msg.sender is unique (will require a loop)
        // ---
        // Get pool-derived result
        // Add runner info object to Arena
        // --- If (runnerCount + 1) >= runnerMinCount ---
        // loop runner's prices and get avg
        // do other logic (calc & allocate prize pool mappings for winners & runners)
        // reset runnerCount
        // --- else ---
        // increment runnerCount
        // set current block to runnerLastBlock
    }

    /** Claim rewards (winners & runners) **/
    function claimReward() external {}

    /** Manually recover an ERC20 accidentally sent to contract **/
    function recoverToken(
        address _token,
        address _recipient,
        uint256 _amount
    ) external onlyRole(ADMIN_ROLE) {
        // Maybe add a require to make sure the LP token or whatever prize asset is not able to be removed
        // i.e. only intended wrongly-received assets can be recovered (as intended)
        IERC20(_token).safeTransfer(_recipient, _amount);
        // add event emit
    }

    // ---------- Getters ----------
}
