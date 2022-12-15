// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "ds-test/test.sol";
import {console, CheatCodes, SetupEnvironment} from "./utils/utils.sol";
import {UnicMapper} from "../contracts/UnicMapper.sol";
import {UnicFactory} from "../contracts/UnicFactory.sol";

contract UnicMapperTest is DSTest, SetupEnvironment {
    UnicMapper private unicMapper;
    UnicFactory private unicFactory;

    function setUp() public {
        setupEnvironment();
        (
            unicMapper,
            unicFactory
        ) = setupContracts();
    }

    function testSetIdToAsset() public {
        bytes32 _id = bytes32(bytes("id1"));
        bytes32 _chain = bytes32(bytes("ethereum"));
        address _assetAddress = address(1);
        uint _tokenId = 1;
        unicMapper.setIdToAsset(_id, _chain, _assetAddress, _tokenId);

        bytes32 chain;
        address assetAddress;
        uint tokenId;
        (chain, assetAddress, tokenId) = unicMapper.idToAsset(_id);
        assertEq(chain, _chain);
        assertEq(assetAddress, _assetAddress);
        assertEq(tokenId, _tokenId);
    }

    function testSetIdsToCollection() public {
        bytes32 _chain = bytes32(bytes("ethereum"));
        address _assetAddress = address(1);
        bytes32[] memory _ids = new bytes32[](2);
        _ids[0] = bytes32(bytes("id1"));
        _ids[1] = bytes32(bytes("id2"));
        uint[] memory _tokenIds = new uint[](2);
        _tokenIds[0] = 1;
        _tokenIds[1] = 2;

        unicMapper.setIdsToCollection(_chain, _assetAddress, _ids, _tokenIds);

        bytes32 chain;
        address assetAddress;
        uint tokenId;
        (chain, assetAddress, tokenId) = unicMapper.idToAsset(_ids[0]);
        assertEq(chain, _chain);
        assertEq(assetAddress, _assetAddress);
        assertEq(tokenId, _tokenIds[0]);

        (chain, assetAddress, tokenId) = unicMapper.idToAsset(_ids[1]);
        assertEq(chain, _chain);
        assertEq(assetAddress, _assetAddress);
        assertEq(tokenId, _tokenIds[1]);
    }

    function testSetIdsToAssets() public {
        bytes32[] memory _ids = new bytes32[](2);
        _ids[0] = bytes32(bytes("id1"));
        _ids[1] = bytes32(bytes("id2"));
        bytes32[] memory _chains = new bytes32[](2);
        _chains[0] = bytes32(bytes("ethereum"));
        _chains[1] = bytes32(bytes("fuel"));
        address[] memory _assetAddresses = new address[](2);
        _assetAddresses[0] = address(1);
        _assetAddresses[1] = address(2);
        uint[] memory _tokenIds = new uint[](2);
        _tokenIds[0] = 1;
        _tokenIds[1] = 2;

        unicMapper.setIdsToAssets(_ids, _chains, _assetAddresses, _tokenIds);

        bytes32 chain;
        address assetAddress;
        uint tokenId;
        (chain, assetAddress, tokenId) = unicMapper.idToAsset(_ids[0]);
        assertEq(chain, _chains[0]);
        assertEq(assetAddress, _assetAddresses[0]);
        assertEq(tokenId, _tokenIds[0]);

        (chain, assetAddress, tokenId) = unicMapper.idToAsset(_ids[1]);
        assertEq(chain, _chains[1]);
        assertEq(assetAddress, _assetAddresses[1]);
        assertEq(tokenId, _tokenIds[1]);
    }
}