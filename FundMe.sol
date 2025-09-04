// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConvertor.sol";

error NotOwner();

contract FundMe{
    using PriceConvertor for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    address public owner;
    uint256 public min_USD;

    constructor(uint256 _min_USD){
        owner = msg.sender;
        min_USD = _min_USD * 1e18;
    }

    function fund() external payable{
        // if(msg.value.getConversionRate() < min_USD){
        //     revert("You need to spend more ETH!");
        // }

        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function withdraw() public {
        if(msg.sender != owner){
            revert NotOwner();
        }

        payable(msg.sender).transfer(address(this).balance);

        for(uint256 i=0;i<funders.length;i++){
            delete addressToAmountFunded[funders[i]];
        }

        delete funders;
    }

    function getUserBalance()public view returns(uint256){
        return addressToAmountFunded[msg.sender];
    }

}
