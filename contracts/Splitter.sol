pragma solidity ^0.4.17;

contract Splitter {

  address public recipient1;
  address public recipient2;
  address public owner;


  mapping(address => uint) public balances;

  
  event LogSplit(uint value, address from, address recipient1, address recipient2);
  event LogWithdrawal(uint value, address indexed sender);

  

  modifier onlyByOwner()
    {
        require(owner == msg.sender);
        _;
    }

  function Splitter(address _recipient1, address _recipient2) {
    // constructor
    owner = msg.sender;
    assert(_recipient1 != address(0));
    assert(_recipient2 != address(0));
    recipient1 = _recipient1;
    recipient2 = _recipient2;
  }

    //split the amount between two recipients
  function split() payable public onlyByOwner returns(bool) {
    require(msg.value>1);
  balances[recipient1] += msg.value/2;
  balances[recipient2] += msg.value/2;
  uint remainder = msg.value%2;
  if (remainder>0) {
    balances[msg.sender]+= remainder;
    }

  LogSplit(msg.value, msg.sender, recipient1, recipient2);
  return true;
  }

  function withdraw () returns (bool) {
    require(balances[msg.sender]>0);
    uint amount = balances[msg.sender];
    balances[msg.sender] = 0;
    msg.sender.transfer(amount);
    LogWithdrawal(amount, msg.sender);
    return true;
  }

  function killContract() onlyByOwner {
    selfdestruct(owner);
  }

  
}