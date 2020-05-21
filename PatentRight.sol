pragma solidity ^0.5.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/drafts/Counters.sol";
import "./IPatentRight.sol";


contract PatentRight is IPatentRight {
    using Counters for Counters.Counter;
    Counters.Counter patentRight_ids;
    
    struct patentGrant {
        address owner;
        string uri;
    }
    
    mapping(uint => patentGrant) public patentRights;
    
    modifier onlyPatentrightOwner(uint patentRight_id) {
        require(patentRights[patentRight_id].owner == msg.sender, "You are not the owner of this patenet");
        _;
    }
    event Patent(uint patentRight_id, address owner, string reference_uri);
    event License(uint patentRight_id, string reference_uri );   //OpenSource is License
    event Assign(uint patentRight_id, address new_owner);    //Transfer is assign
    // function copyrights(uint copyright_id) public returns(patentGrant memory) {
    // }
    function patentGranted(string memory reference_uri) public {   // copyrightWork
        patentRight_ids.increment();
        uint id = patentRight_ids.current();
        patentRights[id] = patentGrant(msg.sender, reference_uri);
        emit Patent(id, msg.sender, reference_uri);
    }
    
    function licensePatent(string memory reference_uri) public {
        patentRight_ids.increment();
        uint id = patentRight_ids.current();
        patentRights[id].uri = reference_uri;
        emit License(id, reference_uri);
    }
    
    function assignPatent(uint patentRight_id, address new_owner) public onlyPatentrightOwner(patentRight_id) {
        patentRights[patentRight_id].owner = new_owner;
        emit Assign(patentRight_id, new_owner);
    }
    
    
    function deedPatentOwnership(uint patentRight_id) public onlyPatentrightOwner(patentRight_id) {
        assignPatent(patentRight_id, address(0));
        emit License(patentRight_id, patentRights[patentRight_id].uri);
    }
}