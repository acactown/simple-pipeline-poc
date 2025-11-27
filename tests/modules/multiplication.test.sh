#!/bin/bash

# Unit tests for multiplication module

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${SCRIPT_DIR}/../../src/modules"

# Source the multiplication module
# shellcheck disable=SC1090
source "${SOURCE_DIR}/multiplication.sh"

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

echo "Testing multiplication module..."

# Test 1: Positive numbers
result=$(multiplication 2 3)
run_test "2 * 3 = 6" "6" "${result}"

# Test 2: Negative numbers
result=$(multiplication -5 3)
run_test "-5 * 3 = -15" "-15" "${result}"

# Test 3: Zero
result=$(multiplication 0 5)
run_test "0 * 5 = 0" "0" "${result}"

# Test 4: Decimal numbers
result=$(multiplication 2.5 4)
run_test "2.5 * 4 = 10.0" "10.0" "${result}"

# Test 5: Large numbers
result=$(multiplication 100 200)
run_test "100 * 200 = 20000" "20000" "${result}"

# Summary
echo "✅ Passed ${PASSED_COUNT}/${TEST_COUNT} tests"

if [[ ${PASSED_COUNT} -eq ${TEST_COUNT} ]]; then
    exit 0
else
    exit 1
fi
