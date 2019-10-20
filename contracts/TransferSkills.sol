pragma solidity >=0.4.21 <0.6.0;

contract TransferSkills {

  event Message(address indexed _sender, address indexed _receiver, uint256 _time, string message);
  event PublicKeyUpdated(address indexed _sender, string _key, string _keytype);

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

  function lastIndex(address _owner) constant returns (uint256) {
      return last_msg_index[_owner];
  }
    
  function getLastMessage(address _who) constant returns (address, string, uint256) {
    require(last_msg_index[_who] > 0);
    return (messages[_who][last_msg_index[_who] - 1].from, messages[_who][last_msg_index[_who] - 1].text, messages[_who][last_msg_index[_who] - 1].time);
  }
    
  function getMessageByIndex(address _who, uint256 _index) constant returns (address, string, uint256) {

    return (messages[_who][_index - 1].from, messages[_who][_index - 1].text, messages[_who][_index - 1].time);
  }
    
}

