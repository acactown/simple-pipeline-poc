# BASH Calculator

A simple yet comprehensive calculator application written in BASH, featuring modular design and comprehensive unit testing.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Node Version Management](#node-version-management)
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Testing](#testing)
- [Supported Operations](#supported-operations)
- [Examples](#examples)
- [Creating Installer Packages](#creating-installer-packages)
- [Linting and Code Quality Tools](#linting-and-code-quality-tools)
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

- **Node.js** (version 24.x or higher) - For commitlint and markdownlint
- **npm** (version 11.x or higher) - For package management
- **shellcheck** - Shell script linting tool
- **editorconfig-checker** - EditorConfig linting tool
- **markdownlint-cli** - Markdown linting tool

### Installing Prerequisites

```bash
brew install jq bc make shellcheck editorconfig-checker
```

## Node Version Management

This project uses **Node.js 24.11.1** for development tooling (`commitlint`, `markdownlint`, etc.). The required Node version is specified in the `.nvmrc` file.

### Using NVM (Recommended)

[NVM (Node Version Manager)](https://github.com/nvm-sh/nvm) allows you to install and switch between multiple Node.js versions easily.

#### Installing NVM

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
```

Or with wget:

```bash
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
```

After installation, restart your terminal or run:

```bash
source ~/.zshrc
```

#### Using the Correct Node Version

Once NVM is installed, navigate to the project directory and run:

```bash
# Install the Node version specified in .nvmrc
nvm install

# Use the Node version specified in .nvmrc
nvm use
```

### Verifying Node Version

To verify you're using the correct Node version:

```bash
node --version
# Should output: v24.11.1
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
- `make pkg-macos` - Create macOS PKG installer package (use on macOS)
- `make pkg-ubuntu` - Create macOS PKG installer package (use on Ubuntu/CI systems)
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

## Creating Installer Packages

The project supports creating macOS PKG installer packages for distribution.

### pkg-macos (Recommended for local builds)

Use this target when building on **macOS**:

```bash
make pkg-macos
```

This uses Apple's native `pkgbuild` command to create a properly formatted PKG file.

**Installation:**

```bash
# Install the package
sudo installer -pkg build/simple-pipeline-poc-<version>.pkg -target /

# After installation, the calculator is available as:
simple-calculator
```

### pkg-ubuntu (For CI/CD builds)

Use this target when building on **Ubuntu** (e.g., GitHub Actions runners):

```bash
make pkg-ubuntu
```

This manually constructs a PKG file using `xar`, `cpio`, and `mkbom` tools.

⚠️ **Note:** Packages built on Ubuntu may have compatibility issues and should primarily be used in automated CI/CD pipelines.

### Installing Unsigned Packages

⚠️ **Both targets create unsigned packages.** macOS Gatekeeper will block installation by default.

**Workaround options:**

1. **Right-click installation** (recommended for end users):

    - Right-click (or Control+click) the `.pkg` file in Finder
    - Select "Open" from the context menu
    - Click "Open" in the warning dialog

2. **Allow in System Settings**:

    - Try to install normally
    - Go to System Settings → Privacy & Security
    - Click "Open Anyway" next to the blocked installer

3. **Command line override**:

    ```bash
    sudo installer -allowUntrusted -pkg build/simple-pipeline-poc-<version>.pkg -target /
    ```

### Code Signing (Optional)

To create properly signed packages that install without warnings, you need an **Apple Developer ID Installer certificate**. Contact your organization's Apple Developer Program admin to obtain the necessary credentials.

## Linting and Code Quality Tools

This project uses multiple linting tools to maintain code quality, consistency, and adherence to best practices. All linters are integrated into the development workflow and CI/CD pipeline.

### Overview of Linting Tools

The project uses four primary linting tools:

| Tool             | Purpose                      | Config File          | Run Command               |
|------------------|------------------------------|----------------------|---------------------------|
| **EditorConfig** | Code formatting consistency  | `.editorconfig`      | `make check-editorconfig` |
| **ShellCheck**   | Shell script static analysis | `.shellcheckrc`      | `make check-shellcheck`   |
| **Markdownlint** | Markdown file linting        | `.markdown-lint.yml` | `make check-markdownlint` |
| **Commitlint**   | Commit message validation    | `.commitlintrc.json` | `make check-commit`       |

### Installation Instructions

**NPM Linting dependencies:**

```bash
npm install
```

**EditorConfig Checker:**

```bash
brew install editorconfig-checker
```

**ShellCheck:**

```bash
brew install shellcheck
```

**Commitlint:**

```bash
# Setup git hooks (required)
make setup-commitlint
```

### Configuration Details

#### 1. EditorConfig (`.editorconfig`)

Enforces consistent coding styles across different editors and IDEs.

**Exclusions (`.editorconfig-checker.json`):**

Edit the `.editorconfig-checker.json` file to exclude the files you want to ignore.

**Check compliance:**

```bash
make check-editorconfig
```

#### 2. ShellCheck (`.shellcheckrc`)

Static analysis tool for shell scripts that detects common errors and bad practices.

**Check scripts:**

```bash
make check-shellcheck
```

#### 3. Markdownlint (`.markdown-lint.yml`)

Validates Markdown files for style and formatting consistency.

**Check Markdown files:**

```bash
make check-markdownlint
```

**Excluded Files (`.markdownlintignore`):**

Edit the `.markdownlintignore` file to exclude the files you want to ignore.

#### 4. Commitlint (`.commitlintrc.json`)

Validates commit messages follow the Conventional Commits specification.

**Commit Message Format:**

```text
<type>: [optional-task-id] <description>

[optional body]

[optional footer(s)]
```

**Valid Types:**

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `build`: Build system changes
- `ci`: CI/CD changes
- `chore`: Maintenance tasks
- `revert`: Revert previous commit

**Check commit:**

```bash
make check-commit
```

### Running All Linters

Run all linters at once before committing:

```bash
make lint
```

This runs:

1. Commitlint (checks last commit message)
2. EditorConfig checker
3. ShellCheck (all shell scripts)
4. Markdownlint (all Markdown files)

### Git Hooks Integration

Commitlint is automatically enforced via Git hooks (Husky) to validate commit messages before they're created.

**Setup hooks:**

```bash
make setup-commitlint
```

This creates `.husky/commit-msg` hook that runs `commitlint` automatically on every commit.

**Hook behavior:**

- ✅ Valid commit message → Commit succeeds
- ❌ Invalid commit message → Commit rejected with error message

### SDLC Integration

The linting tools are integrated throughout the Software Development Lifecycle:

#### 1. Local Development (Pre-commit)

```text
Developer writes code
      ↓
make lint (manual check)
      ↓
git add .
      ↓
git commit -m "..." ← Commitlint hook validates message
      ↓
git push
```

**Best Practice:** Run `make lint` before committing to catch issues early.

#### 2. Continuous Integration (Pull Request)

```text
Developer opens PR to main branch
      ↓
GitHub Actions CI Pipeline runs:
      ↓
┌─────────────────────────────────┐
│ 1. Super-Linter Job (parallel)  │
│    - EditorConfig               │
│    - ShellCheck                 │
│    - Markdownlint               │
├─────────────────────────────────┤
│ 2. Commitlint Job (parallel)    │
│    - Validates all PR commits   │
├─────────────────────────────────┤
│ 3. Test Job (after 1 & 2)       │
│    - Runs unit tests            │
├─────────────────────────────────┤
│ 4. Build Job (after 3)          │
│    - Creates macOS PKG          │
└─────────────────────────────────┘
      ↓
All checks pass → PR can be merged
Any check fails → PR blocked until fixed
```

**CI Configuration:** `.github/workflows/ci.yml`

#### 3. Quality Gates

The SDLC enforces quality at multiple levels:

| Stage      | Gate                  | Tool(s)     | Enforcement              |
|------------|-----------------------|-------------|--------------------------|
| **Commit** | Message format        | Commitlint  | Git hook (local)         |
| **Push**   | Code quality          | All linters | CI pipeline (remote)     |
| **PR**     | All checks pass       | CI pipeline | GitHub branch protection |
| **Merge**  | Approved + CI passing | GitHub      | Required for merge       |

#### 4. Release Process

```text
Code merged to main
      ↓
Release Please bot analyzes commits
      ↓
Creates/updates Release PR
  - Generates CHANGELOG from commits
  - Bumps version (SemVer)
      ↓
Maintainer reviews and merges
      ↓
Tag created → Release published
```

**Version Bumping (based on commit types):**

- `feat:` → Minor version bump (1.0.0 → 1.1.0)
- `fix:` → Patch version bump (1.0.0 → 1.0.1)
- `feat!:` or `BREAKING CHANGE:` → Major version bump (1.0.0 → 2.0.0)

### Best Practices

1. **Run linters before committing:**

  ```bash
  make lint
  ```

2. **Fix issues incrementally:** Don't accumulate linting errors

3. **Use IDE plugins:** Install EditorConfig, ShellCheck, and Markdownlint plugins for real-time feedback

4. **Follow commit conventions:** Makes `CHANGELOG.md` generation and version bumping automatic

5. **Review CI logs:** When CI fails, read the full error messages to understand what needs fixing

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
