// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import { PNLSettings } from '../../modules/PNL/PNLStorage.sol';

interface IPNLConnector {
    struct PNLState {
        uint256 priceOfBorrowToken;
        uint256 priceOfSupplyToken;
        uint256 supplyBalance;
        uint256 borrowBalance;
        address platform;
        address borrowToken;
        address supplyToken;
        PNLSimulations[] simulations;
    }

    struct PNLSimulations {
        bool canBeTriggered;
        string reason;
        PNLSettings settings;
    }

    function configurePNL(
        uint256 priceTarget,
        uint256 fixedReward,
        uint256 percentageReward,
        uint256 unwindFactor,
        bool isTakeProfit
    ) external;

    function removePNLSetting(uint256 index) external;

    function removeAllPNLSettings() external;

    function executePNL(uint256 index, bool withApproval) external returns (uint256);

    function getAllPNLSettings() external returns (PNLSettings[] memory);

    function getPNLSettingsAt(uint256 index) external returns (PNLSettings memory);

    function getPNLState() external returns (PNLState memory);
}
