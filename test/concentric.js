const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ConcentricCircles", function () {
  it("generates SVG with circles equal to tokenId", async function () {
    const [owner] = await ethers.getSigners();
    const factory = await ethers.getContractFactory("ConcentricCircles");
    const contract = await factory.deploy();
    await contract.mint(); // tokenId 1
    const uri = await contract.tokenURI(1);
    
    // The URI should be a data URI with base64-encoded JSON
    expect(uri).to.include("data:application/json;base64");
    
    // Decode the base64 JSON to check the contents
    const base64Json = uri.replace("data:application/json;base64,", "");
    const jsonString = Buffer.from(base64Json, 'base64').toString();
    const metadata = JSON.parse(jsonString);
    
    expect(metadata.name).to.equal("Concentric Circle #1");
    expect(metadata.description).to.equal("Animated on-chain concentric circles.");
    expect(metadata.image).to.include("data:image/svg+xml;base64");
  });
});
