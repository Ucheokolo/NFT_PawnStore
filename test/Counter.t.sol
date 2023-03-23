// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/PawnShop.sol";

contract CounterTest is Test {
    Aitch5Store public pawnStore;
    address owner = mkaddr("owner");
    // address usdtHolder = "0x29131A0c8DFeD19DDe84D36104800caCA7b73B98";
    address firstBuyer = mkaddr("firstBuyer");
    string nftUri =
        "https://ipfs.filebase.io/ipfs/QmT7n7uhNABHRSXW5MTDgpokp7Upwq9DhWsrg486wSkCoe";
    IERC20 purchaseToken = IERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);

    function setUp() public {
        // counter = new Counter();
        vm.prank(owner);
        pawnStore = new Aitch5Store();
    }

    function testpurchaseItem() public {
        vm.startPrank(0x29131A0c8DFeD19DDe84D36104800caCA7b73B98);
        pawnStore.getUsdtEth();
        console.log(
            purchaseToken.balanceOf(0x29131A0c8DFeD19DDe84D36104800caCA7b73B98)
        );
        // purchaseToken.approve(address(pawnStore), 5 ether);
        // pawnStore.purchaseItem(address(pawnStore), nftUri);
    }

    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }
}
