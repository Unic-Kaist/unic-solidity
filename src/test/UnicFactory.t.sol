// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "ds-test/test.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/IERC1155MetadataURI.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {console, CheatCodes, SetupEnvironment} from "./utils/utils.sol";
import {UnicFactory} from "../contracts/UnicFactory.sol";

contract UnicFactoryTest is DSTest, SetupEnvironment {
    UnicFactory private unicFactory;

    function setUp() public {
        setupEnvironment();
        (
            ,
            unicFactory
        ) = setupContracts();
    }

    function testDeployERC1155() public {
        IERC1155MetadataURI erc721 = IERC1155MetadataURI(unicFactory.deployERC1155("testurl.com/{id}.json", 100));
        assertEq(erc721.uri(1), "testurl.com/{id}.json");
        assertEq(Ownable(address(erc721)).owner(), address(this));
    }
}