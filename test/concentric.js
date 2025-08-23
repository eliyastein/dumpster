const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ConcentricCircles", function () {
  it("generates SVG with circles equal to tokenId", async function () {
    const [owner] = await ethers.getSigners();
    const factory = await ethers.getContractFactory("ConcentricCircles");
    const contract = await factory.deploy();
    await contract.mint(); // tokenId 1
    const uri = await contract.tokenURI(1);
    expect(uri).to.include("Concentric Circle #1");
    expect(uri).to.include("data:image/svg+xml;base64");
  });
});
