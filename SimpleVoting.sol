pragma solidity ^0.4.24;

contract SimpleVoting{
    
    struct Proposal{
        string date;
        string place;
        string purpose;
        uint cost;
        uint voteCount;
        bool vote;
    }
    
    struct Voter{
        bool isRegistered;
        bool hasVoted;
        uint votedProposalId;
    }
    
    enum WorkflowStatus{
        RegisteringVoters,
        ProposalsRegistrationStarted,
        ProposalsRegistrationEnded,
        VotingSessionStarted,
        VotingSessionEnded,
        VotesTallied
    }
    
    address public administrator;
    WorkflowStatus public workflowStatus;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;
    Proposal[] public completed_proposals;
    uint private winningProposalId;
    
    modifier onlyAdministrator(){
        require(msg.sender == administrator, "the caller of this function must be the administrator");
        _;
    }
    modifier onlyRegisteredVoter(){
        require(voters[msg.sender].isRegistered, "the caller of this function must be a registered voter");
        _;
    }
    modifier onlyDuringVotersRegistration(){
        require(workflowStatus == WorkflowStatus.RegisteringVoters);
        _;
    }
    modifier onlyDuringProposalsRegistration(){
        require(workflowStatus == WorkflowStatus.ProposalsRegistrationStarted);
        _;
    }
    modifier onlyAfterProposalsRegistration(){
        require(workflowStatus == WorkflowStatus.ProposalsRegistrationEnded);
        _;
    }
    modifier onlyDuringVotingSession(){
        require(workflowStatus == WorkflowStatus.VotingSessionStarted);
        _;
    }
    modifier onlyAfterVotingSession(){
        require(workflowStatus == WorkflowStatus.VotingSessionEnded);
        _;
    }
    modifier onlyAfterVotesTallied(){
        require(workflowStatus == WorkflowStatus.VotesTallied);
        _;
    }
    
    event VoterRegisteredEvent(address voterAddress);
    event ProposalsRegistrationStartedEvent();
    event ProposalsRegistrationEndedEvent();
    event ProposalRegisteredEvent(uint proposalId);
    event CompletedProposalRegisteredEvent(uint proposalId);
    event VotingSessionStartedEvent();
    event VotingSessionEndedEvent();
    event VotedEvent(address voter, uint proposalId);
    event VotesTalliedEvent();
    event WorkflowStatusChangeEvent(WorkflowStatus previousStatus, WorkflowStatus newStatus);
    
    constructor() public{
        administrator = msg.sender;
        workflowStatus = WorkflowStatus.RegisteringVoters;
    }
    
    function registerVoter(address _voterAddress)
        public onlyAdministrator onlyDuringVotersRegistration {
            require(!voters[_voterAddress].isRegistered, "the voter is already registered");
            
            voters[_voterAddress].isRegistered = true;
            voters[_voterAddress].hasVoted = false;
            voters[_voterAddress].votedProposalId = 0;
            
            emit VoterRegisteredEvent(_voterAddress);
        }
        
    function startProposalsRegistration()
        public onlyAdministrator onlyDuringVotersRegistration {
            workflowStatus = WorkflowStatus.ProposalsRegistrationStarted;
            
            emit ProposalsRegistrationStartedEvent();
            emit WorkflowStatusChangeEvent(WorkflowStatus.RegisteringVoters, workflowStatus);
        }
        
    function endProposalsRegistration()
        public onlyAdministrator onlyDuringProposalsRegistration{
            workflowStatus = WorkflowStatus.ProposalsRegistrationEnded;
            
            emit ProposalsRegistrationEndedEvent();
            emit WorkflowStatusChangeEvent(WorkflowStatus.ProposalsRegistrationStarted, workflowStatus);
        }
    
    function startVotingSession()
        public onlyAdministrator onlyDuringProposalsRegistration{
            workflowStatus = WorkflowStatus.VotingSessionStarted;
            
            emit VotingSessionStartedEvent();
            emit WorkflowStatusChangeEvent(WorkflowStatus.ProposalsRegistrationEnded, workflowStatus);
        }
    function endVotingSession()
        public onlyAdministrator onlyDuringVotingSession{
            workflowStatus = WorkflowStatus.VotingSessionEnded;
            
            emit VotingSessionEndedEvent();
            emit WorkflowStatusChangeEvent(WorkflowStatus.VotingSessionStarted, workflowStatus);
        }
        
    function registerProposal(string _date, string _place, string _purpose, uint _cost, bool _vote)
        public onlyAdministrator onlyDuringProposalsRegistration{
            proposals.push(Proposal({
                date: _date,
                place: _place,
                purpose: _purpose,
                cost: _cost,
                voteCount: 0,
                vote: _vote
            }));
            
            emit ProposalRegisteredEvent(proposals.length - 1);
        }
        
    function vote(uint proposalId)
       public  onlyRegisteredVoter onlyDuringVotingSession{
           require(!voters[msg.sender].hasVoted, "the caller has already voted");
           
           if(proposals[proposalId].vote){
               voters[msg.sender].hasVoted = true;
               voters[msg.sender].votedProposalId = proposalId;
               proposals[proposalId].voteCount += 1;
               emit VotedEvent(msg.sender, proposalId);
           }
           
           else{
               completed_proposals.push(Proposal({
                date: proposals[proposalId].date,
                place: proposals[proposalId].place,
                purpose: proposals[proposalId].purpose,
                cost: proposals[proposalId].cost,
                voteCount: 0,
                vote: false
            }));
                emit CompletedProposalRegisteredEvent(completed_proposals.length-1);
           }
       }
       
    function tallyVotes()
        public onlyAdministrator onlyAfterVotingSession{
            uint winningVoteCount = 0;
            uint winningProposalIndex = 0;
            
            for(uint i=0;i < proposals.length;i++){
                if(proposals[i].voteCount > winningVoteCount){
                    winningVoteCount = proposals[i].voteCount;
                    winningProposalIndex = i;
                }
            }
            
            winningProposalId = winningProposalIndex;
            
            completed_proposals.push(Proposal({
                date: proposals[winningProposalIndex].date,
                place: proposals[winningProposalIndex].place,
                purpose: proposals[winningProposalIndex].purpose,
                cost: proposals[winningProposalIndex].cost,
                voteCount: proposals[winningProposalIndex].voteCount,
                vote: true
            }));
            
            workflowStatus = WorkflowStatus.VotesTallied;
            emit VotesTalliedEvent();
            emit CompletedProposalRegisteredEvent(completed_proposals.length-1);
            emit WorkflowStatusChangeEvent(WorkflowStatus.VotingSessionEnded, workflowStatus);
        }
        
    function getProposalsNumber() public view
        returns (uint){
            return proposals.length;
        }
        
    function getProposalDescription(uint index) public view
        returns (string _date, string _place, string _purpose, uint _cost, bool _vote)
        {
            _date = proposals[index].date;
            _place = proposals[index].place;
            _purpose = proposals[index].purpose;
            _cost = proposals[index].cost;
            _vote = proposals[index].vote;
        }
    
    function getCompletedProposalsDescription(uint index) onlyAfterVotesTallied public view 
        returns (string _date, string _place, string _purpose, uint _cost, uint _voteCount){
             _date = completed_proposals[index].date;
            _place = completed_proposals[index].place;
            _purpose = completed_proposals[index].purpose;
            _cost = completed_proposals[index].cost;
            _voteCount = completed_proposals[index].voteCount;
        }
}
