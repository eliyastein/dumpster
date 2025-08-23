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
        string memory script = string(
            abi.encodePacked(
                "let svg=document.documentElement;",
                "for(let i=0;i<", tokenId.toString(), ";i++){",
                    "let c=document.createElementNS(\"http://www.w3.org/2000/svg\",\"circle\");",
                    "let r=10+i*2;",
                    "c.setAttribute(\"cx\",\"50\");",
                    "c.setAttribute(\"cy\",\"50\");",
                    "c.setAttribute(\"r\",r);",
                    "c.setAttribute(\"stroke\",\"black\");",
                    "c.setAttribute(\"stroke-width\",\"1\");",
                    "c.setAttribute(\"fill\",\"none\");",
                    "let anim=document.createElementNS(\"http://www.w3.org/2000/svg\",\"animate\");",
                    "anim.setAttribute(\"attributeName\",\"r\");",
                    "anim.setAttribute(\"values\",r+\";\"+(r+2)+\";\"+r);",
                    "anim.setAttribute(\"dur\",\"5s\");",
                    "anim.setAttribute(\"repeatCount\",\"indefinite\");",
                    "c.appendChild(anim);",
                    "svg.appendChild(c);",
                "}"
            )
        );
        return string(
            abi.encodePacked(
                '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">',
                '<script><![CDATA[',
                script,
                ']]></script>',
                '</svg>'
            )
        );
    }
}
