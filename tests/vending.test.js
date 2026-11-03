import { expect } from "chai";
import { ethers } from "hardhat";

describe("VendingMachine", function () {
  it("test payable method", async function () {
    const VendingMachine = await ethers.getContractFactory("VendingMachine");
    const vending = await VendingMachine.deploy("VirtualCupcakes");
    await vending.deployed();
    console.log("VendingMachine deployed at: " + vending.address);

    const [owner, acc_1] = await ethers.getSigners();

    // Используем .toNumber()
    expect((await vending.getVendingMachineBalance()).toNumber()).to.equal(100);

    // Покупаем 1 пирожное
    await vending.connect(acc_1).purchase(1, { value: 1e9 });

    // Проверяем, что стало 99
    expect((await vending.getVendingMachineBalance()).toNumber()).to.equal(99);
  });

  it("test refill", async function () {
    const VendingMachine = await ethers.getContractFactory("VendingMachine");
    // Исправлена опечатка в deploy
    const vending = await VendingMachine.deploy("VirtualCupcakes");
    await vending.deployed();
    console.log("VendingMachine deployed at: " + vending.address);

    const [owner, acc_1] = await ethers.getSigners();

    expect((await vending.getVendingMachineBalance()).toNumber()).to.equal(100);

    await vending.connect(acc_1).purchase(1, { value: 1e9 });
    expect((await vending.getVendingMachineBalance()).toNumber()).to.equal(99);

    // Пополняем на 1
    await vending.refill(1);
    expect((await vending.getVendingMachineBalance()).toNumber()).to.equal(100);
  });
});