// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "./UnicERC1155.sol";
import "../interfaces/IUnicFactory.sol";

contract UnicFactory is IUnicFactory, Ownable, Pausable {
    function deployERC1155(
        string memory _uri,
        uint _royalties
    ) external override whenNotPaused returns (address newERC1155) {
        newERC1155 = address(new UnicERC1155(_uri, _royalties, msg.sender));
        Ownable(newERC1155).transferOwnership(msg.sender);
        emit ERC1155Deployed(newERC1155, msg.sender, _uri, _royalties);
    }
}