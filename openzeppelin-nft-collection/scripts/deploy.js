const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  const Tree = await ethers.getContractFactory("TreeCollection");
  const tree = await Tree.deploy("Tree Collection", "TCL");

  await tree.deployed();
  console.log("Deployed contract address : ", tree.address);

  await tree.mint(
    "https://ipfs.io/ipfs/Qmey5MTLNmhmz8PRbUDZtXzRNYdZsi4nQgkM2Akzf4NmQC"
  );

  console.log("Oke !");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
