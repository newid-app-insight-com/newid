pragma solidity ^0.4.15;

contract Bifty {
  address public company;
  uint    public faceValue;
  uint    public saleValue;
  bool    public dupDiscount;
  address public user;
  address public prevUser;
  bool    public refund;

  modifier onlyUser() {
    require(msg.sender == user);
    _;
  }

  modifier notRefund() {
    require(refund != true);
    _;
  }

  // This is the constructor which registers the
  // creator and the assigned name.
  function Bifty(
    address _company,
    uint _faceValue,
    uint _saleValue,
    bool _dupDiscount,
    address _user
  ) payable {
    company = _company;
    faceValue = _faceValue;
    saleValue = _saleValue;
    dupDiscount = _dupDiscount;
    user = _user;
  }

  function sendBifty(address _to) onlyUser payable {
    user = _to;
    prevUser = msg.sender;
  }

  function useBifty(address _company) onlyUser payable {
    if(company != _company) return;
    user = _company;
    prevUser = msg.sender;
  }

  function refundBifty() notRefund onlyUser payable {
    refund = true;
  }
}
