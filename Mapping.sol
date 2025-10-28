// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FavoriteRecords {
    // ----- State Variables -----

    // Mapping of approved record names -> true/false
    mapping(string => bool) public approvedRecords;

    // Nested mapping: user address => (album name => true/false)
    mapping(address => mapping(string => bool)) private userFavorites;

    // Store approved record names for iteration (since mappings aren’t iterable)
    string[] private approvedRecordNames;

    // Custom error for invalid album submissions
    error NotApproved(string albumName);

    // ----- Constructor -----
    constructor() {
        // Preload the approved records
        approvedRecordNames = [
            "Thriller",
            "Back in Black",
            "The Bodyguard",
            "The Dark Side of the Moon",
            "Their Greatest Hits (1971-1975)",
            "Hotel California",
            "Come On Over",
            "Rumours",
            "Saturday Night Fever"
        ];

        // Mark each as approved in mapping
        for (uint i = 0; i < approvedRecordNames.length; i++) {
            approvedRecords[approvedRecordNames[i]] = true;
        }
    }

    // ----- View: Return all approved records -----
    function getApprovedRecords() external view returns (string[] memory) {
        return approvedRecordNames;
    }

    // ----- Add a record to sender’s favorites -----
    function addRecord(string calldata albumName) external {
        // Verify that the record is approved
        if (!approvedRecords[albumName]) {
            revert NotApproved(albumName);
        }

        // Mark the record as favorite for msg.sender
        userFavorites[msg.sender][albumName] = true;
    }

    // ----- Get all favorites for a given user -----
    function getUserFavorites(address user)
        external
        view
        returns (string[] memory)
    {
        // Count favorites first
        uint count = 0;
        for (uint i = 0; i < approvedRecordNames.length; i++) {
            if (userFavorites[user][approvedRecordNames[i]]) {
                count++;
            }
        }

        // Create memory array of the right size
        string[] memory favorites = new string[](count);
        uint index = 0;

        // Fill favorites
        for (uint i = 0; i < approvedRecordNames.length; i++) {
            string memory name = approvedRecordNames[i];
            if (userFavorites[user][name]) {
                favorites[index] = name;
                index++;
            }
        }

        return favorites;
    }

    // ----- Reset favorites for sender -----
    function resetUserFavorites() external {
        for (uint i = 0; i < approvedRecordNames.length; i++) {
            string memory name = approvedRecordNames[i];
            userFavorites[msg.sender][name] = false;
        }
    }
}
