pragma solidity ^0.4.4;

contract Splitter {
  uint public contractBalance;
  address recipient1;
  address recipient2;
  address public owner;

  mapping(address => uint) public balances;

  

  modifier OnlyByOwner()
    {
        require(owner == msg.sender);
        _;
    }

  function Splitter(address _recipient1, address _recipient2) {
    // constructor
    owner = msg.sender;
    recipient1 = _recipient1;
    recipient2 = _recipient2;
  }
    //split the amount between two recipients
  function split(uint) payable OnlyByOwner returns (uint){
    require(msg.value>1);
  balances[recipient1] += msg.value/2;
  balances[recipient2] += msg.value/2;
  if (msg.value%2>0){
    balances[msg.sender]+=1;
  }}

  function withdraw () payable returns (bool){
    require(balances[msg.sender]>0);
    uint amount = balances[msg.sender];
    balances[msg.sender ]=0;
    if (msg.sender.send(amount)){
      return true;
    } else {
      balances[msg.sender]=amount;
      return false;
    }
  }

  function getBalance(address) public returns (uint){
    contractBalance = this.balance;
  }

  function killContract() OnlyByOwner {
    suicide(owner);
  }

  function()payable{
    
  }
}