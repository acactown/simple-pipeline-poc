.PHONY: run test clean help permissions setup-commitlint check-commit check-editorconfig check-shellcheck check-markdownlint lint pkg

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
	@echo "  make check-shellcheck    - Check shell scripts with ShellCheck"
	@echo "  make check-markdownlint  - Check Markdown files with markdownlint"
	@echo "  make lint                - Run all linters (editorconfig + shellcheck + markdownlint)"
	@echo "  make setup-commitlint    - Install commitlint and setup git hooks"
	@echo "  make check-commit        - Check the last commit message"
	@echo "  make pkg                 - Create macOS PKG installer package"
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
	@echo "✅ Commit message format check complete!"

# Check shell scripts with ShellCheck
check-shellcheck:
	@echo "Checking shell scripts with ShellCheck..."
	@shellcheck src/main.sh src/modules/*.sh tests/main.sh tests/modules/*.test.sh
	@echo "✅ ShellCheck complete!"

# Check Markdown files with markdownlint
check-markdownlint:
	@echo "Checking Markdown files with markdownlint..."
	@npx markdownlint '**/*.md' --ignore node_modules --ignore CHANGELOG.md --config .markdown-lint.yml
	@echo "✅ markdownlint complete!"

# Run all linters
lint: check-commit check-editorconfig check-shellcheck check-markdownlint
	@echo "✅ All linting checks passed!"

# Create macOS PKG installer package
pkg: permissions clean
	@echo "======================================"
	@echo "Creating macOS PKG installer..."
	@echo "======================================"
	@# Extract version from package.json
	$(eval VERSION := $(shell node -p "require('./package.json').version"))
	$(eval PKG_NAME := simple-pipeline-poc-$(VERSION).pkg)
	$(eval IDENTIFIER := com.acactown.simple-pipeline-poc)
	$(eval INSTALL_LOCATION := /usr/local/share/simple-pipeline-poc)
	@echo "Package Name: $(PKG_NAME)"
	@echo "Version: $(VERSION)"
	@echo "Identifier: $(IDENTIFIER)"
	@echo "Install Location: $(INSTALL_LOCATION)"
	@echo ""
	@# Create staging directory structure
	@echo "📁 Creating staging directory..."
	@mkdir -p build/pkg/payload$(INSTALL_LOCATION)
	@mkdir -p build/pkg/scripts
	@# Copy source files to staging area
	@echo "📦 Copying source files..."
	@cp -R src/* build/pkg/payload$(INSTALL_LOCATION)/
	@# Create postinstall script to set permissions
	@echo "📝 Creating installation scripts..."
	@echo '#!/bin/bash' > build/pkg/scripts/postinstall
	@echo 'chmod +x $(INSTALL_LOCATION)/main.sh' >> build/pkg/scripts/postinstall
	@echo 'chmod +x $(INSTALL_LOCATION)/modules/*.sh' >> build/pkg/scripts/postinstall
	@echo 'ln -sf $(INSTALL_LOCATION)/main.sh /usr/local/bin/simple-calculator 2>/dev/null || true' >> build/pkg/scripts/postinstall
	@echo 'echo "✅ Simple Calculator installed successfully!"' >> build/pkg/scripts/postinstall
	@echo 'echo "Run: simple-calculator"' >> build/pkg/scripts/postinstall
	@echo 'exit 0' >> build/pkg/scripts/postinstall
	@chmod +x build/pkg/scripts/postinstall
	@# Create the PKG file
	@echo ""
	@echo "🔨 Building PKG file..."
	@pkgbuild --root build/pkg/payload \
		--identifier $(IDENTIFIER) \
		--version $(VERSION) \
		--scripts build/pkg/scripts \
		--install-location / \
		build/$(PKG_NAME)
	@echo ""
	@echo "======================================"
	@echo "✅ PKG created successfully!"
	@echo "======================================"
	@echo "📦 Package: build/$(PKG_NAME)"
	@echo ""
	@echo "To install:"
	@echo "  sudo installer -pkg build/$(PKG_NAME) -target /"
	@echo ""
	@echo "After installation, run:"
	@echo "  simple-calculator"
	@echo ""

# Clean up temporary files
clean:
	@echo "Cleaning up..."
	@find . -name "*.tmp" -type f -delete
	@find . -name "*.log" -type f -delete
	@rm -rf build/
	@echo "✅ Clean complete!"
