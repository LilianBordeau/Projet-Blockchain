pragma solidity ^0.6.12;

// SPDX-License-Identifier: GPL-3.0

import "./Ownable.sol";
import "./SafeMath.sol";

contract Election is Ownable {

using SafeMath for uint256;

    // Model a Candidate
    struct Member {
        uint256 id;
        string name;
        uint voteCount;
        uint memberType;
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

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Member) public members;
    // Store Candidates Count
    mapping(uint => Resolution) public resolutions;
    // Store Resolutions Count
    uint public resolutionsCount;
    uint public membersCount;
    uint public voteCount;

    // voted event
    event votedEvent ( uint indexed _candidateId);
    
    // voted event
    event endOfVote ();

    function addMembers (string memory _name) public {
        membersCount ++;
        members[membersCount] = Member(membersCount, _name, 0, 0);
    }
    
     function voteCandidate (uint _candidateId) public {
        
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= membersCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        members[_candidateId].voteCount ++;
        
        voteCount++;
        
        // check for end of vote
        if (voteCount >= membersCount)
        {
            uint indexMax = 0;
            uint max = 0;
            
            for (uint i = 1; i <= membersCount; i++) 
            {
                if(members[i].voteCount > max)
                {
                    indexMax = i ;
                }
            }
            members[indexMax].memberType = 1;
            
            // trigger end of vote event
            emit endOfVote();
        }
        
        // trigger voted event
        emit votedEvent (_candidateId);
    }
    

    
     // voted resolution event
    event votedResolutionEvent ( uint indexed _resolutionId);
    
    function addResolution (string memory _label, string memory _description) public {
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
