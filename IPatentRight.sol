pragma experimental ABIEncoderV2;
pragma solidity ^0.5.0;

interface IPatentRight {

    struct IpatentGrant {
        address owner;
        string uri;
    }

    event Patent(uint patentRight_id, address owner, string reference_uri);

    event License(uint patentRight_id, string reference_uri);

    event Assign(uint patentRight_id, address new_owner);

    function patentRights(uint patentRight_id) external returns(IpatentGrant memory);

    function patentGranted(string calldata reference_uri) external;

    function licensePatent(string calldata reference_uri) external;

    function deedPatentOwnership(uint patentRight_id) external;

    function assignPatent(uint patentRight_id, address new_owner) external;
}