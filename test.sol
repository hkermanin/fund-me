// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3 {

    AggregatorV3Interface ppp = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundId */,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = ppp.latestRoundData();
        return answer / 1e8;
    }
}
