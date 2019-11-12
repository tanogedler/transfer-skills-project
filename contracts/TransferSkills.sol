// Solidiy varsion allowed by the compiler.
// Smart Contract TransferSkills written and compiled using Truffle
//
// v 0.1. on 10.23.2019
//
pragma solidity >=0.4.21 <0.6.0;

contract TransferSkills {
  // Struct  is intended to define a new type of structure or variable type
  struct message {
    address from;
    string  text;
    uint256 time;
  }

  // A very similar structure for the hashIPFS
  struct hashIPFS {
    address from;
    string hash;
    uint256 time;
  }

  // the event allows to make public and available the Message and the HashIPFS using RPC commands
  event Message(address indexed _sender, address indexed _botAddress, uint256 _time, string message);
  event HashIPFS(address indexed _sender, address indexed _botAddress, uint256 _time, string hashIPFS);

  // We define 3 mapping, one between an addresss and an integer for indexing the messages
  //and another one for mapping the address and the messages. 
  mapping (address => uint256) public last_msg_index;
  mapping (address => uint256) public last_hash_index;
  mapping (address => mapping (uint256 => message)) public messages;
  mapping (address => mapping (uint256 => hashIPFS)) public hashesIPFS;

  // A function for sending a message to the bot. Where the mapping are used to store 
  // the variables from, text and time in a message struct.
  function sendMessage(address _botAddress, string memory _text) public  {
    messages[_botAddress][last_msg_index[_botAddress]].from = msg.sender;
    messages[_botAddress][last_msg_index[_botAddress]].text = _text;
    messages[_botAddress][last_msg_index[_botAddress]].time = now;
    last_msg_index[_botAddress]++;
    emit Message(msg.sender, _botAddress, now, _text);
  }

  // A funtion that returns a true or false. It checks in the messages mapping if there 
  // is a new message for the bot address. 
  function newMessage(address _botAddress, uint256 _index) view public returns (bool) {
    return messages[_botAddress][_index].time  > now;
  }

  // Return the last index of the mapping. This is, the index of the last message received. 
  function lastIndex(address _botAddress) view public returns (uint256) {
    return last_msg_index[_botAddress];
  }

  // This function returns the last message received by the bot addess
  function getLastMessage(address _botAddress) view  public returns (address, string memory, uint256) {
    require(last_msg_index[_botAddress] > 0);
    return (messages[_botAddress][last_msg_index[_botAddress] - 1].from, messages[_botAddress][last_msg_index[_botAddress] - 1].text, messages[_botAddress][last_msg_index[_botAddress] - 1].time);
  }
  // This function returns a message received by the bot addess accesed by an index
  function getMessageByIndex(address _botAddress, uint256 _index) view public returns (address, string memory, uint256) {
    return (messages[_botAddress][_index - 1].from, messages[_botAddress][_index - 1].text, messages[_botAddress][_index - 1].time);
  }

  // Similarly to sendMessage, this function sends a hash string to the bot
  function sendIPFSFile(address _botAddress, string memory _hash) public  {
    hashesIPFS[_botAddress][last_msg_index[_botAddress]].from = msg.sender;
    hashesIPFS[_botAddress][last_msg_index[_botAddress]].hash = _hash;
    hashesIPFS[_botAddress][last_msg_index[_botAddress]].time = now;
    last_hash_index[_botAddress]++;
    emit HashIPFS(msg.sender, _botAddress, now, _hash);
  }

}