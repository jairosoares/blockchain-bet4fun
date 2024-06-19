// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

struct ResultFixture {
    uint256 fixture_index;
    uint256 fixture_id;
    string winner;
    string goals;
    bool finalized;
}

struct Winner {
    address winnerAddress;
    uint256 tokenId;
}

struct Prediction {
    address predictionAddress;
    uint256 homeScore;
    uint256 awayScore;
}

struct Fixture {
    uint256 fixtureId;
    uint256 teamHomeId;
    uint256 teamAwayId;
    uint256 dateTime;
    uint256 homeScore;
    uint256 awayScore;
    address charitableAddress;
    mapping(address => Prediction) predictions;
    Prediction[] participants;
    Winner[] winners;
}
