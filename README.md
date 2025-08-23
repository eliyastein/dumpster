# Concentric Circles NFT

This repository contains a simple Hardhat project that implements an on-chain animated ERC721 token. Each token renders a set of SVG circles that grow and shrink, creating a concentric animation generated completely on-chain.

## Project Structure

- **contracts/ConcentricCircles.sol** – ERC721 contract built on top of OpenZeppelin. The `mint` function allows anyone to mint a token until the `MAX_SUPPLY` of 1000 is reached. `tokenURI` returns base64-encoded JSON that includes a base64-encoded SVG image.
- **test/concentric.js** – Hardhat test suite validating core functionality.
- **hardhat.config.js** – Project configuration specifying the Solidity compiler version.

## Requirements

- [Node.js](https://nodejs.org/) (v16 or later is recommended)
- npm (installed with Node.js)

## Install

```bash
npm install
```

## Compile

```bash
npm run compile
```

## Run Tests

```bash
npm test
```

## Local Development

To experiment with the contract locally, start a Hardhat network in one terminal:

```bash
npx hardhat node
```

In another terminal you can deploy and interact with the contract using the Hardhat console:

```bash
npx hardhat console --network localhost
```

Inside the console:

```javascript
const factory = await ethers.getContractFactory("ConcentricCircles");
const cc = await factory.deploy();
await cc.mint();           // mint token #1
await cc.tokenURI(1);      // view the generated metadata
```

## License

Released under the [MIT License](https://opensource.org/licenses/MIT).
