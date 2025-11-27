#!/bin/bash

# Unit tests for division module

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${SCRIPT_DIR}/../../src/modules"

# Source the division module
# shellcheck disable=SC1090,SC1091
source "${SOURCE_DIR}/division.sh"

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

echo "Testing division module..."

# Test 1: Positive numbers
result=$(division 6 3)
run_test "6 / 3 = 2.00" "2.00" "${result}"

# Test 2: Negative numbers
result=$(division -10 5)
run_test "-10 / 5 = -2.00" "-2.00" "${result}"

# Test 3: Decimal result
result=$(division 5 2)
run_test "5 / 2 = 2.50" "2.50" "${result}"

# Test 4: Decimal numbers
result=$(division 7.5 2.5)
run_test "7.5 / 2.5 = 3.00" "3.00" "${result}"

# Test 5: Division by zero (should fail)
if division 5 0 2>/dev/null; then
    echo "  ❌ Division by zero should fail"
    ((TEST_COUNT++))
else
    echo "  ✅ Division by zero correctly returns error"
    ((TEST_COUNT++))
    ((PASSED_COUNT++))
fi

# Summary
echo "✅ Passed ${PASSED_COUNT}/${TEST_COUNT} tests"

if [[ ${PASSED_COUNT} -eq ${TEST_COUNT} ]]; then
    exit 0
else
    exit 1
fi
