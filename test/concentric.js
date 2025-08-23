const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ConcentricCircles", function () {
  it("generates compact SVG using on-chain loops", async function () {
    const factory = await ethers.getContractFactory("ConcentricCircles");
    const contract = await factory.deploy();

    // Mint token #1 and check the basic metadata
    await contract.mint();
    const uri1 = await contract.tokenURI(1);
    expect(uri1).to.include("data:application/json;base64");

    const base64Json1 = uri1.replace("data:application/json;base64,", "");
    const jsonString1 = Buffer.from(base64Json1, 'base64').toString();
    const metadata1 = JSON.parse(jsonString1);
    expect(metadata1.name).to.equal("Concentric Circle #1");
    expect(metadata1.description).to.equal("Animated on-chain concentric circles.");
    expect(metadata1.image).to.include("data:image/svg+xml;base64");

    // Decode SVG to ensure it uses a script tag
    const svgBase641 = metadata1.image.replace("data:image/svg+xml;base64,", "");
    const svg1 = Buffer.from(svgBase641, 'base64').toString();
    expect(svg1).to.include("<script><![CDATA[");

    // Mint up to token #10 and compare URI lengths to ensure it stays compact
    for (let i = 0; i < 9; i++) {
      await contract.mint();
    }
    const uri10 = await contract.tokenURI(10);
    expect(uri10.length - uri1.length).to.be.lessThan(200);
  });
});
