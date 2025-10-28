// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArraysExercise {
    // ----- Base Arrays -----
    uint[] public numbers = [1,2,3,4,5,6,7,8,9,10];

    // New arrays for timestamp tracking
    address[] public senders;
    uint[] public timestamps;

    // ----- Return the full numbers array -----
    function getNumbers() external view returns (uint[] memory) {
        return numbers;
    }

    // ----- Reset numbers to 1–10 -----
    function resetNumbers() public {
        // Instead of .push(), directly reassigning saves gas
        delete numbers; // Clear the array
        numbers = [1,2,3,4,5,6,7,8,9,10];
    }

    // ----- Append another array to `numbers` -----
    function appendToNumbers(uint[] calldata _toAppend) public {
        uint len = _toAppend.length;
        for (uint i = 0; i < len; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    // ----- Save caller and timestamp -----
    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    // ----- Return all timestamps/senders after Y2K -----
    function afterY2K() public view returns (uint[] memory, address[] memory) {
        uint count = 0;
        uint len = timestamps.length;

        // Count valid timestamps first (for memory sizing)
        for (uint i = 0; i < len; i++) {
            if (timestamps[i] > 946702800) {
                count++;
            }
        }

        // Allocate arrays in memory
        uint[] memory recentTimestamps = new uint[](count);
        address[] memory recentSenders = new address[](count);

        uint index = 0;
        for (uint i = 0; i < len; i++) {
            if (timestamps[i] > 946702800) {
                recentTimestamps[index] = timestamps[i];
                recentSenders[index] = senders[i];
                index++;
            }
        }

        return (recentTimestamps, recentSenders);
    }

    // ----- Reset senders -----
    function resetSenders() public {
        delete senders;
    }

    // ----- Reset timestamps -----
    function resetTimestamps() public {
        delete timestamps;
    }
}
