const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  const Collection = await ethers.getContractFactory("Collection");
  const collection = await Collection.deploy("Quoc Collection", "QCL");
  await collection.deployed();

  console.log("Collection contract address : ", collection.address);

  await collection.mint(
    "https://ipfs.io/ipfs/Qmey5MTLNmhmz8PRbUDZtXzRNYdZsi4nQgkM2Akzf4NmQC"
  );

  console.log("Mint NFT successfully !");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
