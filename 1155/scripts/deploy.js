const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  const Items = await ethers.getContractFactory("Items");
  const item = await Items.deploy("1155 Collectable", "C15", "https://gateway.pinata.cloud/ipfs/QmP3L9ooY56QNczqCRSX5YgwbQ16UizSLFb8H2zyePNwNa/");
  await item.deployed();

  console.log("Items contract address : ", item.address);
  await item.mintItem(3);

  console.log("Oke!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
