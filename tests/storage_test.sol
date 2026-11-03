// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "hardhat/console.sol";
import "../contracts/1_Storage.sol";
contract StorageTest {
Storage storageToTest;
function beforeAll () public {
storageToTest = new Storage();
}
function checkWriteRead () public {
console.log("Running checkWriteRead");
storageToTest.store(42);
Assert.equal(storageToTest.retrieve(), uint(42), "proposal retreive should be 42");
}
}
