//var ConvertLib = artifacts.require("./ConvertLib.sol");
var v1 = artifacts.require("./v1.sol");

module.exports = function(deployer) {
  //deployer.deploy(ConvertLib);
  ///deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(v1);
};
