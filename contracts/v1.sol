pragma solidity ^0.4.4;

contract Decision{


  address public owner;
  function user(){
    owner =msg.sender;
  }
  struct loan_cons{
    uint amt;
    address reqr;
    uint yes;
    uint no;
    mapping(address=>bool) resp;
  }

  mapping (address=>loan_cons) requests;

modifier _onlyRequester{
  if(msg.sender==requests[msg.sender].reqr){
    _;
  }
  else{
    throw;
  }
}
modifier _exceptReqr{
  if(msg.sender!=requests[msg.sender].reqr){
    _;
  }
  else{
    throw;
  }
}

  loan_cons[] public loans;

  function make_req(uint amt){
   loan_cons memory NewL;
   NewL.amt=amt;
   NewL.reqr=msg.sender;
   NewL.yes=0;
   NewL.no=0;
   loans.push(NewL);
   requests[msg.sender]=NewL;

  }




  function des(address req,bool resp) _exceptReqr {
   if(!requests[req].resp[msg.sender])
   {requests[req].resp[msg.sender]=true;}
   else{
     throw ;
   }

    if(resp==true){
      requests[req].yes+=1;
    }
    else{
      requests[req].no+=1;
    }

  }

  function decide(address _reqr) payable _onlyRequester returns(bool){

    uint t=requests[_reqr].yes + requests[_reqr].no;

    if(requests[_reqr].yes> 60*t/100 ){
     (requests[_reqr].reqr).send(requests[_reqr].amt);
     return true;

      }
      else {
        return false;
      }

  }



}
