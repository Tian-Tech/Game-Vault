# Game-Vault
My Solidity Game VAult
```
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract GameStorage{

    string [] public game;

    address public owner;

    event NewlyAddedGame (string);

    constructor () {

        owner = msg.sender;

    }

    function addGame (string memory _game) public {
        require (msg.sender == owner, "Only Owner can Add Game");
        game.push(_game);
        emit NewlyAddedGame(_game);

    }

    function getGameIndex (uint256 _index) public view returns (string memory) {
        return game[_index];
    }


    function totalGames() public view returns (uint256) {
        return game.length;
    }

    function deleteGame () public {
        require (msg.sender == owner, "Only Owner can Delete Game");
        delete game;
    }

    function deleteGameatIndex (uint256 _index) public {
        require(msg.sender == owner, "Only Owner can Delete Game"); 
        delete game[_index];

    }
}

```
