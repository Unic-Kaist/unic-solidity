// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "ds-test/test.sol";
import {CheatCodes} from "./cheatcodes.sol";
import {console} from "./console.sol";
import {UnicMapper} from "../../contracts/UnicMapper.sol";
import {UnicFactory} from "../../contracts/UnicFactory.sol";

contract SetupEnvironment {
    CheatCodes public vm;

    function setupUnicMapper() public returns (UnicMapper) {
        return new UnicMapper();
    }

    function setupUnicFactory() public returns (UnicFactory) {
        return new UnicFactory();
    }

    function setupEnvironment() public {
        vm = CheatCodes(address(bytes20(uint160(uint256(keccak256("hevm cheat code"))))));
    }

    function setupContracts()
        public
        returns (
            UnicMapper unicMapper,
            UnicFactory unicFactory
        )
    {
        unicMapper = setupUnicMapper();
        unicFactory = setupUnicFactory();
    }
}