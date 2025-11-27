# BASH Calculator

A simple yet comprehensive calculator application written in BASH, featuring modular design and comprehensive unit testing.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Testing](#testing)
- [Supported Operations](#supported-operations)
- [Examples](#examples)
- [Code Quality and CI/CD](#code-quality-and-cicd)

## Overview

This calculator application demonstrates best practices in BASH scripting, including:

- Modular architecture with separate operation modules
- JSON-based configuration
- Comprehensive unit testing
- Make-based build system
- Error handling and input validation

## Features

- ✅ Four basic arithmetic operations (addition, subtraction, multiplication, division)
- ✅ JSON configuration file for operation definition
- ✅ Modular design for easy extension
- ✅ Comprehensive unit tests for all operations
- ✅ Support for integer and floating-point numbers
- ✅ Division by zero protection
- ✅ Clean Makefile for easy execution

## Prerequisites

Before using this calculator, ensure you have the following installed:

- **BASH** (version 4.0 or higher)
- **jq** - Command-line JSON processor
- **bc** - Basic calculator for arithmetic operations
- **make** - Build automation tool

### Optional (for development)

- **Node.js** (version 14.x or higher) - For commitlint and markdownlint
- **npm** (version 6.x or higher) - For package management
- **shellcheck** - Shell script linting tool
- **markdownlint-cli** - Markdown linting tool

### Installing Prerequisites

**On macOS:**

```bash
brew install jq bc make shellcheck
```

**On Ubuntu/Debian:**

```bash
sudo apt-get update
sudo apt-get install jq bc make shellcheck
```

**On CentOS/RHEL:**

```bash
sudo yum install jq bc make
# ShellCheck may require EPEL repository
sudo yum install epel-release
sudo yum install ShellCheck
```

## Project Structure

```text
simple-pipeline-poc/
├── src/
│   ├── main.sh                    # Main entry point
│   └── modules/
│       ├── addition.sh            # Addition operation
│       ├── subtraction.sh         # Subtraction operation
│       ├── multiplication.sh      # Multiplication operation
│       └── division.sh            # Division operation
├── tests/
│   ├── main.sh                    # Test runner
│   └── modules/
│       ├── addition.test.sh       # Addition tests
│       ├── subtraction.test.sh    # Subtraction tests
│       ├── multiplication.test.sh # Multiplication tests
│       └── division.test.sh       # Division tests
├── operation.json                 # Configuration file
├── Makefile                       # Build automation
└── README.md                      # This file
```

## Installation

1. **Clone or download the repository:**

  ```bash
  cd /path/to/simple-pipeline-poc.git
  ```

2. **Set executable permissions:**

  ```bash
  make permissions
  ```

  This command automatically sets executable permissions on all scripts.

## Usage

### Quick Start

1. **Edit the configuration file** (`operation.json`) to specify the operation:

  ```json
  {
    "operation": "addition",
    "first_number": 10,
    "second_number": 5
  }
  ```

2. **Run the calculator:**

  ```bash
  make run
  ```

### Available Make Commands

- `make help` - Display available commands
- `make run` - Execute the calculator with current configuration
- `make test` - Run all unit tests
- `make permissions` - Set executable permissions on scripts
- `make setup-commitlint` - Install commitlint and setup git hooks
- `make check-commit` - Check the last commit message
- `make check-editorconfig` - Check EditorConfig compliance
- `make check-shellcheck` - Check shell scripts with ShellCheck
- `make check-markdownlint` - Check Markdown files with markdownlint
- `make lint` - Run all linters (editorconfig + shellcheck + markdownlint)
- `make clean` - Remove temporary files

## Configuration

The calculator reads its configuration from `operation.json` in the root directory.

### Configuration Format

```json
{
  "operation": "operation_name",
  "first_number": number_or_string,
  "second_number": number_or_string
}
```

### Configuration Fields

- **operation** (string, required): The operation to perform
  - Valid values: `"addition"`, `"subtraction"`, `"multiplication"`, `"division"`
- **first_number** (number/string, required): The first operand
- **second_number** (number/string, required): The second operand

### Configuration Examples

**Addition:**

```json
{
  "operation": "addition",
  "first_number": 2,
  "second_number": 2
}
```

**Division with decimals:**

```json
{
  "operation": "division",
  "first_number": 10.5,
  "second_number": 2.5
}
```

## Testing

The project includes comprehensive unit tests for all operations.

### Running All Tests

```bash
make test
```

### Running Individual Test Files

```bash
# Addition tests
bash tests/modules/addition.test.sh

# Subtraction tests
bash tests/modules/subtraction.test.sh

# Multiplication tests
bash tests/modules/multiplication.test.sh

# Division tests
bash tests/modules/division.test.sh
```

## Supported Operations

### 1. Addition

Adds two numbers together.

**Configuration:**

```json
{"operation": "addition", "first_number": 5, "second_number": 3}
```

**Result:** `8`

### 2. Subtraction

Subtracts the second number from the first.

**Configuration:**

```json
{"operation": "subtraction", "first_number": 10, "second_number": 4}
```

**Result:** `6`

### 3. Multiplication

Multiplies two numbers.

**Configuration:**

```json
{"operation": "multiplication", "first_number": 6, "second_number": 7}
```

**Result:** `42`

### 4. Division

Divides the first number by the second (with 2 decimal precision).

**Configuration:**

```json
{"operation": "division", "first_number": 15, "second_number": 4}
```

**Result:** `3.75`

## Examples

### Example 1: Simple Addition

```bash
# Edit operation.json
cat > operation.json << EOF
{
  "operation": "addition",
  "first_number": 100,
  "second_number": 250
}
EOF

# Run calculator
make run
```

**Output:**

```text
📝 Operation: addition
    🔢  First Number: 100
    🔢 Second Number: 250
  ------------------------
    ✅ Result: 350
```

### Example 2: Division with Decimals

```bash
# Edit operation.json
cat > operation.json << EOF
{
  "operation": "division",
  "first_number": 22,
  "second_number": 7
}
EOF

# Run calculator
make run
```

**Output:**

```text
📝 Operation: division
    🔢  First Number: 22
    🔢 Second Number: 7
  ------------------------
    ✅ Result: 3.14
```

### Example 3: Running Tests

```bash
make test
```

**Output:**

```text
======================================
Running Calculator Unit Tests
======================================

Running: addition.test.sh
Testing addition module...
  ✅ 2 + 3 = 5 => PASSED 🎉
  ✅ -5 + 3 = -2 => PASSED 🎉
  ✅ 0 + 5 = 5 => PASSED 🎉
  ✅ 2.5 + 3.5 = 6.0 => PASSED 🎉
  ✅ 1000 + 2000 = 3000 => PASSED 🎉
✅ Passed 5/5 tests
✅ addition.test.sh => PASSED 🎉

[... more tests ...]

======================================
Test Summary
======================================
Total Tests: 4

✅ Passed: 4
✅ Failed: 0

✅ All tests passed!
```

## Code Quality and CI/CD

This project includes comprehensive code quality checks and continuous integration:

### Continuous Integration

The project uses GitHub Actions for automated CI on all pull requests to the `main` branch. The CI pipeline (`.github/workflows/ci.yml`) includes:

1. **Super-Linter Job**: Runs [super-linter](https://github.com/super-linter/super-linter) to validate code quality

- **EditorConfig**: Validates code formatting consistency
- **ShellCheck**: Analyzes shell scripts for errors and best practices
- **Markdownlint**: Checks Markdown files for style consistency

2. **Commitlint Job**: Validates commit messages follow Conventional Commits specification

3. **Test Job**: Runs the full test suite (`make test`)

### Local Development Quality Checks

Before submitting a pull request, run these checks locally:

```bash
# Run all linters
make lint

# Check individual linters
make check-editorconfig
make check-shellcheck
make check-markdownlint
make check-commit

# Run tests
make test
```

### Code Style Guidelines

- **Shell Scripts**: Follow [ShellCheck](https://github.com/koalaman/shellcheck) recommendations (`.shellcheckrc`)
- **Formatting**: Follow [EditorConfig](https://editorconfig.org/) rules (`.editorconfig`)
- **Markdown**: Follow Markdownlint rules (`.markdown-lint.yml`)
- **Commits**: Follow [Conventional Commits](https://www.conventionalcommits.org/) (`.commitlintrc.json`)

### Commit Message Format

```text
<type>: [optional task-id] <description>
```

**Valid types**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

**Examples:**

```text
feat: [DMPINV-101] add multiplication operation
fix: [DMPINV-202] correct division by zero handling
docs: update README with CI/CD information
```
