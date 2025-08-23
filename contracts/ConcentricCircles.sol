// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ConcentricCircles is ERC721 {
    using Counters for Counters.Counter;
    using Strings for uint256;

    uint256 public constant MAX_SUPPLY = 1000;
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("ConcentricCircles", "CIRC") {}

    function mint() public {
        uint256 tokenId = _tokenIdCounter.current() + 1;
        require(tokenId <= MAX_SUPPLY, "Max supply reached");
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        string memory svg = _generateSVG(tokenId);
        string memory json = Base64.encode(bytes(string(abi.encodePacked(
            '{',
                '"name":"Concentric Circle #', tokenId.toString(), '",',
                '"description":"Animated on-chain concentric circles.",',
                '"image":"data:image/svg+xml;base64,', Base64.encode(bytes(svg)), '"',
            '}'
        ))));
        return string(abi.encodePacked("data:application/json;base64,", json));
    }

    function _generateSVG(uint256 tokenId) internal pure returns (string memory) {
        string memory circles;
        for (uint256 i = 0; i < tokenId; i++) {
            circles = string(abi.encodePacked(
                circles,
                '<circle cx="50" cy="50" r="',
                (10 + i * 2).toString(),
                '" stroke="black" stroke-width="1" fill="none">',
                '<animate attributeName="r" values="',
                (10 + i * 2).toString(), ';', (12 + i * 2).toString(), ';', (10 + i * 2).toString(),
                '" dur="5s" repeatCount="indefinite" />',
                '</circle>'
            ));
        }
        return string(abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">',
            circles,
            '</svg>'
        ));
    }
}
