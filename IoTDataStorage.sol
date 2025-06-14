// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SmartLogisticsIoTStorage {
    address public owner;

    // --- IoT Data Storage ---
    struct IoTData {
        uint256 timestamp;
        string packageId;
        string temperature;
        string latitude;
        string longitude;
        string status;
        string rfidTag;
        string humidity;
    }

    uint256 public constant MAX_ENTRIES = 100;
    IoTData[] public dataRecords;

    event RowDataStored(
        uint256 timestamp,
        string packageId,
        string temperature,
        string latitude,
        string longitude,
        string status,
        string rfidTag,
        string humidity
    );

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    // --- Constructor ---
    constructor() {
        owner = msg.sender;
    }

    // --- IoT Data Functions ---
    function storeRowData(
        string memory packageId,
        string memory temperature,
        string memory latitude,
        string memory longitude,
        string memory status,
        string memory rfidTag,
        string memory humidity
    ) public onlyOwner {
        require(dataRecords.length < MAX_ENTRIES, "Storage limit reached");

        IoTData memory newData = IoTData({
            timestamp: block.timestamp,
            packageId: packageId,
            temperature: temperature,
            latitude: latitude,
            longitude: longitude,
            status: status,
            rfidTag: rfidTag,
            humidity: humidity
        });

        dataRecords.push(newData);
        emit RowDataStored(block.timestamp, packageId, temperature, latitude, longitude, status, rfidTag, humidity);
    }

    // Get total IoT data records count
    function getDataCount() public view returns (uint256) {
        return dataRecords.length;
    }

    // Get IoT data record by index
    function getData(uint256 index) public view returns (
        uint256 timestamp,
        string memory packageId,
        string memory temperature,
        string memory latitude,
        string memory longitude,
        string memory status,
        string memory rfidTag,
        string memory humidity
    ) {
        require(index < dataRecords.length, "Invalid index");
        IoTData memory record = dataRecords[index];
        return (
            record.timestamp,
            record.packageId,
            record.temperature,
            record.latitude,
            record.longitude,
            record.status,
            record.rfidTag,
            record.humidity
        );
    }
}