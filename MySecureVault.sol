```
solidity 

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract SecureVault {

    address public owner;

    struct Secret {
        string title;
        string encryptedMessage;
        uint256 addedAt;

    }

    mapping (address => Secret[]) public userSecret;

    event NewlyAddedSecret (string, address);
    event UpdatedSecret (string, uint256, address);

    modifier onlyOwner() {
        require (owner == msg.sender, "Unathorized Access");
        _;
    }

    constructor () {
        owner = msg.sender;
        
    }

    function addSecret (string memory _title, string memory _encryptedMessage) public {

    Secret memory newSecret = Secret ({

        title : _title,
        encryptedMessage : _encryptedMessage,
        addedAt : block.timestamp
    }); 
        userSecret[msg.sender].push(newSecret);

        emit NewlyAddedSecret (_title, msg.sender);
    }
    
    function viewSecret(uint256 _index) public view returns (string memory _title, string memory _encryptedMessage, uint256 addedAt){
        require (_index < userSecret[msg.sender].length, "Unauthorized Access");
        Secret memory secret = userSecret[msg.sender][_index]; 
        return (secret.title,secret.encryptedMessage,secret.addedAt);
    }

    function updateSecret (uint256 _index, string memory _newTitle, string memory _newEncryptedMessage) public {
       require (_index < userSecret[msg.sender].length, "Only Sender can update Secret");
        Secret memory updatedsecret = Secret ({

        title : _newTitle,
        encryptedMessage : _newEncryptedMessage,
        addedAt : block.timestamp
         });
        userSecret[msg.sender][_index]=(updatedsecret);

        emit UpdatedSecret (_newTitle, _index, owner);
    }

    function deleteSecret () public {

        delete userSecret[msg.sender];

    }
    
    function deleteUserSecret (address _user) public onlyOwner {
        delete (userSecret[_user]);
         }
    
    function secretlength () public view returns (uint256) {
        return userSecret[msg.sender].length;

    }
}

```
