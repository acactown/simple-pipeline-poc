#!/bin/bash

# Main calculator script
# Reads operation.json and executes the appropriate module

set -e

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="${SCRIPT_DIR}/modules"
CONFIG_FILE="${SCRIPT_DIR}/operation.json"

# Check if jq is available for JSON parsing
if ! command -v jq &> /dev/null; then
    echo "❌ Error: jq is required but not installed. Please install jq to continue."
    exit 1
fi

# Check if configuration file exists
if [[ ! -f "${CONFIG_FILE}" ]]; then
    echo "❌ Error: Configuration file not found at ${CONFIG_FILE}"
    exit 1
fi

# Parse the JSON file
OPERATION=$(jq -r '.operation' "${CONFIG_FILE}")
FIRST_NUMBER=$(jq -r '.first_number' "${CONFIG_FILE}")
SECOND_NUMBER=$(jq -r '.second_number' "${CONFIG_FILE}")

# Validate inputs
if [[ "${OPERATION}" == "null" || "${FIRST_NUMBER}" == "null" || "${SECOND_NUMBER}" == "null" ]]; then
    echo "❌ Error: Invalid configuration. Please ensure operation, first_number, and second_number are defined."
    exit 1
fi

# Map operation to module file
MODULE_FILE="${MODULES_DIR}/${OPERATION}.sh"

# Check if the module exists
if [[ ! -f "${MODULE_FILE}" ]]; then
    echo "❌ Error: Operation '${OPERATION}' is not supported. Module not found: ${MODULE_FILE}"
    exit 1
fi

# Source the module and execute the operation
# shellcheck disable=SC1090
source "${MODULE_FILE}"

# Call the operation function
result=$(${OPERATION} "${FIRST_NUMBER}" "${SECOND_NUMBER}")

# Print the result
echo " 📝 Operation: ${OPERATION}"
echo ""
echo "    🔢  First Number: ${FIRST_NUMBER}"
echo "    🔢 Second Number: ${SECOND_NUMBER}"
echo "  --------------------------"
echo "    ✅ Result: ${result}"
echo ""
