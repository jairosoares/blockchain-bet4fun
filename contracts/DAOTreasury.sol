// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./BaseContract.sol";
import "./GeneralEventUtils.sol";
//Porque esse IERC20.sol entrou em conflito com o IERC20.sol declarodo em TransferFunds.sol?
//import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IERC20} from "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract DAOTreasury is OwnableUpgradeable, BaseContract {
    GeneralEventUtils eventUtils;
    
    IERC20 public usdcToken;
    IERC20 public b4fToken;
    uint256 public proposalCount;

     // Guarda os fundos recebidos
    uint256 public totalFunds;

    error TransferFailed(uint256 amount);
    
    struct Proposal {
        uint256 id;
        address proposer;
        string description;
        uint256 voteCount;
        uint256 endTime;
        mapping(address => bool) votes;
    }

    mapping(uint256 => Proposal) public proposals;
    mapping(address => uint256) public stakedTokens;

    modifier hasStake() {
        require(stakedTokens[msg.sender] > 0, "Must stake B4F to participate");
        _;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(
        address _dataStore, 
        address _eventEmitter,
        address _accessControlManager, 
        address _usdcTokenAddress) public initializer {
        __Ownable_init(msg.sender);
        initializeBase(_dataStore, _eventEmitter,_accessControlManager, address(this), "DAOTreasury");
        eventUtils = new GeneralEventUtils();
        usdcToken = IERC20(_usdcTokenAddress);
    }

    function createProposal(string memory _description) external hasStake {
        proposalCount++;
        Proposal storage newProposal = proposals[proposalCount];
        newProposal.id = proposalCount;
        newProposal.proposer = msg.sender;
        newProposal.description = _description;
        newProposal.endTime = block.timestamp + 1 weeks;
        eventUtils.emitProposalCreated(eventEmitter, proposalCount, msg.sender, _description);
    }

    function vote(uint256 _proposalId) external hasStake {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp < proposal.endTime, "Voting period ended");
        require(!proposal.votes[msg.sender], "Already voted");

        proposal.voteCount += stakedTokens[msg.sender];
        proposal.votes[msg.sender] = true;

        eventUtils.emitVoted(eventEmitter, _proposalId, msg.sender);
    }

    function stake(uint256 _amount) external {
        require(b4fToken.transferFrom(msg.sender, address(this), _amount), "Transfer failed");
        stakedTokens[msg.sender] += _amount;
    }

    function unstake(uint256 _amount) external {
        require(stakedTokens[msg.sender] >= _amount, "Insufficient staked tokens");
        stakedTokens[msg.sender] -= _amount;
        require(b4fToken.transfer(msg.sender, _amount), "Transfer failed");
    }

    // Método para receber fundos do contrato League
    function sendAmount(uint256 amount) external {
        require(amount > 0, "DAOTreasury.sendAmount: amount not informed");
        require(usdcToken.transferFrom(msg.sender, address(this), amount), "Transfer failed to DAOTreasury");
        totalFunds += amount;
        eventUtils.emitFundsReceived(eventEmitter, msg.sender, amount);
    }

    // Função para transferir fundos do contrato DAOTreasury
    function transferFunds(address recipient, uint256 amount) external onlyOwner {
        require(amount <= totalFunds, "Insufficient funds");
        totalFunds -= amount;
        require(usdcToken.transfer(recipient, amount), "Transfer failed");
    }

}
