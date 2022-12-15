// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "ds-test/test.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Receiver.sol";
import {console, CheatCodes, SetupEnvironment} from "./utils/utils.sol";
import {UnicFactory} from "../contracts/UnicFactory.sol";
import {UnicERC1155} from "../contracts/UnicERC1155.sol";

contract UnicERC1155Test is DSTest, SetupEnvironment, ERC1155Receiver {
    UnicFactory private unicFactory;
    string public uri = "testurl.com/{id}.json";

    function setUp() public {
        setupEnvironment();
        (
            ,
            unicFactory
        ) = setupContracts();
    }

    function testRoyaltyInfo() public {
        UnicERC1155 erc1155 = UnicERC1155(unicFactory.deployERC1155(uri, 100));
        (address _receiver, uint256 _royaltyAmount) = erc1155.royaltyInfo(0, 100);
        assertEq(_receiver, address(this));
        assertEq(_royaltyAmount, 1);
    }

    function testMint() public {
        UnicERC1155 erc1155 = UnicERC1155(unicFactory.deployERC1155(uri, 100));
        erc1155.mint(address(this), 0, 100);
        assertEq(100, erc1155.balanceOf(address(this), 0));
    }

    function testFailMint() public {
        vm.prank(address(1));
        UnicERC1155 erc1155 = UnicERC1155(unicFactory.deployERC1155(uri, 100));
        vm.stopPrank();
        erc1155.mint(address(this), 0, 100);
    }

    function testBurn() public {
        UnicERC1155 erc1155 = UnicERC1155(unicFactory.deployERC1155(uri, 100));
        erc1155.mint(address(this), 0, 100);
        erc1155.burn(address(this), 0, 50);
        assertEq(50, erc1155.balanceOf(address(this), 0));
    }

    function testFailBurnNotOwner() public {
        UnicERC1155 erc1155 = UnicERC1155(unicFactory.deployERC1155(uri, 100));
        erc1155.mint(address(this), 0, 100);
        erc1155.mint(address(1), 1, 100);
        erc1155.burn(address(1), 1, 100);
    }


    function onERC1155Received(
        address,address,uint256,uint256,bytes calldata
    ) external pure returns (bytes4) {
        return bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"));
    }

    function onERC1155BatchReceived(
        address,address,uint256[] calldata,uint256[] calldata,bytes calldata
    ) external pure returns (bytes4) {
        return bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"));
    }
}