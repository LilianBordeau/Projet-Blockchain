pragma solidity ^0.6.12;

// SPDX-License-Identifier: GPL-3.0

import "./Ownable.sol";
import "./SafeMath.sol";

contract Election is Ownable {

using SafeMath for uint256;

    // Model a Candidate
    struct Candidate {
        uint256 id;
        string name;
        uint voteCount;
    }
    
       // Model a Resolution
    struct Resolution {
        uint256 id;
        string label;
        string description;
        uint forVoteCount;
        uint neutralVoteCount;
        uint againstVoteCount;
    }
    
    modifier onlyowner { if (msg.sender == owner) _; }

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    mapping(uint => Resolution) public resolutions;
    // Store Resolutions Count
    uint public resolutionsCount;
    
    uint public candidatesCount;

    // voted event
    event votedEvent ( uint indexed _candidateId);

    function addCandidate (string memory _name) onlyowner private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
    
     function voteCandidate (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent (_candidateId);
    }
    
     // voted resolution event
    event votedResolutionEvent ( uint indexed _resolutionId);
    
    function addResolution (string memory _label, string memory _description) onlyowner private {
    resolutionsCount ++;
    resolutions[resolutionsCount] = Resolution(resolutionsCount,_label,_description,0,0,0);
    }

    function voteResolution(uint _resolutionId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid resolution
        require(_resolutionId > 0 && _resolutionId <= resolutionsCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update resolution vote Count
       // resolutions[_resolutionId].voteCount ++;

        // trigger voted event
        emit votedResolutionEvent (_resolutionId);
    }
}
