// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IoTDataStorage {
    struct IoTData {
        uint256 timestamp;
        string packageId;
        string category;   // e.g., "Location", "Status"
        string value;      // e.g., "New York", "Delivered"
    }

    uint256 public constant MAX_ENTRIES = 100;
    IoTData[] public dataRecords;
    address public owner;

    event DataStored(uint256 timestamp, string packageId, string category, string value);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function storeData(string memory packageId, string memory category, string memory value) public onlyOwner {
        require(dataRecords.length < MAX_ENTRIES, "Storage limit reached");

        IoTData memory newData = IoTData({
            timestamp: block.timestamp,
            packageId: packageId,
            category: category,
            value: value
        });

        dataRecords.push(newData);
        emit DataStored(block.timestamp, packageId, category, value);
    }

    function getDataCount() public view returns (uint256) {
        return dataRecords.length;
    }

    function getData(uint256 index) public view returns (
        uint256 timestamp,
        string memory packageId,
        string memory category,
        string memory value
    ) {
        require(index < dataRecords.length, "Invalid index");
        IoTData memory record = dataRecords[index];
        return (record.timestamp, record.packageId, record.category, record.value);
    }
}
