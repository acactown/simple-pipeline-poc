#!/bin/bash

# Main test runner
# Executes all unit tests in the modules directory

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="${SCRIPT_DIR}/modules"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

echo "======================================"
echo "Running Calculator Unit Tests"
echo "======================================"
echo ""

# Find all test files
TEST_FILES=$(find "${MODULES_DIR}" -name "*.test.sh" | sort)

if [[ -z "${TEST_FILES}" ]]; then
    echo -e "${YELLOW}⚠️ No test files found in ${MODULES_DIR}${NC}"
    exit 0
fi

# Run each test file
for test_file in ${TEST_FILES}; do
    test_name=$(basename "${test_file}")
    echo "Running: ${test_name}"

    if bash "${test_file}"; then
        echo -e "${GREEN}✅ ${test_name} => PASSED 🎉${NC}"
        ((PASSED_TESTS++))
    else
        echo -e "${RED}❌ ${test_name} => FAILED 🔥${NC}"
        ((FAILED_TESTS++))
    fi
    ((TOTAL_TESTS++))
    echo ""
done

# Print summary
echo "======================================"
echo "Test Summary"
echo "======================================"
echo "Total Tests: ${TOTAL_TESTS}"
echo ""
echo -e "${GREEN}✅ Passed: ${PASSED_TESTS}${NC}"
if [[ ${FAILED_TESTS} -gt 0 ]]; then
    echo -e "${RED}❌ Failed: ${FAILED_TESTS}${NC}"
fi
echo ""

# Exit with appropriate code
if [[ ${FAILED_TESTS} -eq 0 ]]; then
    echo -e "${GREEN}✅ All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}❌ Some tests failed!${NC}"
    exit 1
fi

