// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ControlStructures {
    // -----------------------------
    // Custom Error
    // -----------------------------
    error AfterHours(uint256 time);

    // -----------------------------
    // FizzBuzz Function
    // -----------------------------
    function fizzBuzz(uint256 _number) external pure returns (string memory) {
        if (_number % 3 == 0 && _number % 5 == 0) {
            return "FizzBuzz";
        } else if (_number % 3 == 0) {
            return "Fizz";
        } else if (_number % 5 == 0) {
            return "Buzz";
        } else {
            return "Splat";
        }
    }

    // -----------------------------
    // Do Not Disturb Function
    // -----------------------------
    function doNotDisturb(uint256 _time) external pure returns (string memory) {
        // 1️⃣ Panic if time >= 2400
        if (_time >= 2400) {
            // Panic uses built-in Solidity assert failure
            assert(_time < 2400);
        }

        // 2️⃣ Custom error if time > 2200 or < 800
        if (_time > 2200 || _time < 800) {
            revert AfterHours(_time);
        }

        // 3️⃣ Revert with string if at lunch
        if (_time >= 1200 && _time <= 1259) {
            revert("At lunch!");
        }

        // 4️⃣ Return greetings based on time ranges
        if (_time >= 800 && _time <= 1199) {
            return "Morning!";
        } else if (_time >= 1300 && _time <= 1799) {
            return "Afternoon!";
        } else if (_time >= 1800 && _time <= 2200) {
            return "Evening!";
        }

        // Should never reach here due to earlier conditions
        return "Invalid time";
    }
}
