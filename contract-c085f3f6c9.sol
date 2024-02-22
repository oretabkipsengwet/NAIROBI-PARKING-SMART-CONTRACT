// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NairobiParkingSmartContract {
    address public nairobiCounty;
    mapping(address => uint256) public parkingBalances;

    event ParkingPayment(address indexed payer, uint256 amount, string vehicleLicense, string parkingZone);
    event PenaltyPayment(address indexed payer, uint256 amount, string vehicleLicense, string parkingZone);
    event VehicleClamped(string vehicleLicense, string parkingZone);
    event VehicleImpounded(string vehicleLicense, string impoundYard);

    modifier onlyNairobiCounty() {
        require(msg.sender == nairobiCounty, "Only Nairobi County can call this function");
        _;
    }

    constructor() {
        nairobiCounty = msg.sender;
    }

    function payForOnStreetParking(string memory vehicleLicense, string memory parkingZone) external payable {
        require(msg.value > 0, "Payment amount must be greater than zero");

        // Additional checks for valid parking zone, vehicle license, and other conditions can be added here.

        parkingBalances[msg.sender] += msg.value;
        emit ParkingPayment(msg.sender, msg.value, vehicleLicense, parkingZone);
    }

    function payPenalty(string memory vehicleLicense, string memory parkingZone) external payable {
        require(msg.value > 0, "Payment amount must be greater than zero");

        // Additional checks for valid penalty, vehicle license, and other conditions can be added here.

        parkingBalances[msg.sender] += msg.value;
        emit PenaltyPayment(msg.sender, msg.value, vehicleLicense, parkingZone);
    }

    function requestVehicleClamp(string memory vehicleLicense, string memory parkingZone) external onlyNairobiCounty {
        // Additional checks for valid parking zone, vehicle license, and other conditions can be added here.

        emit VehicleClamped(vehicleLicense, parkingZone);
    }

    function impoundVehicle(string memory vehicleLicense, string memory impoundYard) external onlyNairobiCounty {
        // Additional checks for valid impound yard, vehicle license, and other conditions can be added here.

        emit VehicleImpounded(vehicleLicense, impoundYard);
    }

    function withdrawFunds() external onlyNairobiCounty {
        payable(nairobiCounty).transfer(address(this).balance);
    }
}
