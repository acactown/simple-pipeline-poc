#!/bin/bash

# Unit tests for subtraction module

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${SCRIPT_DIR}/../../src/modules"

# Source the subtraction module
# shellcheck disable=SC1090,SC1091
source "${SOURCE_DIR}/subtraction.sh"

# Test counter
TEST_COUNT=0
PASSED_COUNT=0

# Helper function to run tests
run_test() {
    local test_name=$1
    local expected=$2
    local actual=$3

    ((TEST_COUNT++))

    if [[ "${actual}" == "${expected}" ]]; then
        echo "  ✅ ${test_name} => PASSED 🎉"
        ((PASSED_COUNT++))
        return 0
    else
        echo "  ❌ ${test_name} => FAILED 🔥"
        echo "    📝 Expected: ${expected}"
        echo "    📝 Got: ${actual}"
        return 1
    fi
}

echo "Testing subtraction module..."

# Test 1: Positive numbers
result=$(subtraction 5 3)
run_test "5 - 3 = 2" "2" "${result}"

# Test 2: Negative result
result=$(subtraction 3 5)
run_test "3 - 5 = -2" "-2" "${result}"

# Test 3: Zero
result=$(subtraction 5 5)
run_test "5 - 5 = 0" "0" "${result}"

# Test 4: Decimal numbers
result=$(subtraction 5.5 2.5)
run_test "5.5 - 2.5 = 3.0" "3.0" "${result}"

# Test 5: Large numbers
result=$(subtraction 5000 2000)
run_test "5000 - 2000 = 3000" "3000" "${result}"

# Summary
echo "✅ Passed ${PASSED_COUNT}/${TEST_COUNT} tests"

if [[ ${PASSED_COUNT} -eq ${TEST_COUNT} ]]; then
    exit 0
else
    exit 1
fi
