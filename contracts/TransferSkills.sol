pragma solidity >=0.4.21 <0.6.0;


contract TransferSkills {

// fd
  mapping (address => string) message;
  mapping (address => string) file;

  function sendMessage(address  _recipient, string memory  _message) public {
    message[_recipient] = _message;
  }

  function readMessage() public view returns (string memory)  {
    return message[msg.sender];
  }


   function sendIPFSFile(address  _recipient, string memory  _file) public {
    file[_recipient] = _file;
  }

  function getIPFSFile() public view returns (string memory)  {
    return file[msg.sender];
  }

}