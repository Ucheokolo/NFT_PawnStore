// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/PawnShop.sol";

contract CounterTest is Test {
    Aitch5Store public pawnStore;
    address owner = mkaddr("owner");
    address firstBuyer = mkaddr("firstBuyer");
    string uri =
        "https://ipfs.filebase.io/ipfs/QmT7n7uhNABHRSXW5MTDgpokp7Upwq9DhWsrg486wSkCoe";

    function setUp() public {
        // counter = new Counter();
        vm.prank(owner);
        pawnStore = new Aitch5Store();
    }

    function purchaseItem() public {
        vm.startPrank(firstBuyer);
        pawnStore.getUsdtEth();
        pawnStore.purchaseItem(_contractAddr, _uri);
    }

    // function testIncrement() public {
    //     counter.increment();
    //     assertEq(counter.number(), 1);
    // }

    // function testSetNumber(uint256 x) public {
    //     counter.setNumber(x);
    //     assertEq(counter.number(), x);
    // }

    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }
}
