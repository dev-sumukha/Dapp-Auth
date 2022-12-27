// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Auth{
    event error(string message);

    struct User{
        address id;
        string name;
        string password;
        uint aadharNum;
        bool isUserLoggedIn;
    }

    mapping(address => User) public userList;

    // registering the user
    function register(string memory _name,string memory _password,uint _aadharNum) public {
        require(userList[msg.sender].id != msg.sender,"user has alreaddy registered");
        userList[msg.sender].id = msg.sender;
        userList[msg.sender].name = _name;
        userList[msg.sender].password = _password;
        userList[msg.sender].aadharNum = _aadharNum;
        userList[msg.sender].isUserLoggedIn = false;
    }   

    function login(address id,string memory _password) public returns(bool){
        
        if(keccak256(abi.encodePacked(userList[id].password)) == keccak256(abi.encodePacked(_password))){
            userList[id].isUserLoggedIn = true;
            return userList[id].isUserLoggedIn;
        } else {
            emit error("something went wrong");
            return false;
        }
    }

    function checkIsUserLogged(address id) public view returns(bool){
        return userList[id].isUserLoggedIn;
    }
}