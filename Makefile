.PHONY: run test clean help permissions setup-commitlint check-commit check-editorconfig

# Default target
help:
	@echo "======================================"
	@echo "BASH Calculator - Available Commands"
	@echo "======================================"
	@echo ""
	@echo "  make run                 - Run the calculator with operation.json"
	@echo "  make test                - Run all unit tests"
	@echo "  make permissions         - Set executable permissions on scripts"
	@echo "  make check-editorconfig  - Check EditorConfig compliance"
	@echo "  make setup-commitlint    - Install commitlint and setup git hooks"
	@echo "  make check-commit        - Check the last commit message"
	@echo "  make clean               - Clean up temporary files"
	@echo "  make help                - Show this help message"
	@echo ""

# Set executable permissions on all scripts
permissions:
	@echo "Setting executable permissions..."
	@chmod +x src/main.sh
	@chmod +x src/modules/*.sh
	@chmod +x tests/main.sh
	@chmod +x tests/modules/*.test.sh
	@echo "Permissions set successfully!"

# Run the calculator
run: permissions
	@echo "Running calculator..."
	@echo ""
	@bash src/main.sh

# Run all tests
test: permissions
	@bash tests/main.sh

# Check EditorConfig compliance
check-editorconfig:
	@echo "Checking EditorConfig compliance..."
	@editorconfig-checker
	@echo "✅ EditorConfig check complete!"

# Setup commitlint and husky
setup-commitlint:
	@echo "Setting up commitlint..."
	@if ! command -v npm &> /dev/null; then \
		echo "❌ Error: npm is not installed. Please install Node.js and npm first."; \
		exit 1; \
	fi
	@npm install
	@npx husky install
	@chmod +x .husky/commit-msg
	@echo "✅ Commitlint setup complete!"
	@echo ""
	@echo "Commit message format:"
	@echo "  <type>: [task-id] <description>"
	@echo ""
	@echo "Valid types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert"
	@echo ""
	@echo "Example: feat: [DMPINV-101] add multiplication operation"

# Check commit message format
check-commit:
	@echo "Checking last commit message..."
	@git log -1 --pretty=%B | npx commitlint

# Clean up temporary files
clean:
	@echo "Cleaning up..."
	@find . -name "*.tmp" -type f -delete
	@find . -name "*.log" -type f -delete
	@echo "Clean complete!"
