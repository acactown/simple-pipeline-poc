.PHONY: run test clean help permissions setup-commitlint check-commit check-editorconfig check-shellcheck check-markdownlint lint pkg-macos pkg-ubuntu

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
	@echo "  make pkg-macos           - Create macOS PKG installer package (on macOS)"
	@echo "  make pkg-ubuntu          - Create macOS PKG installer package (on Ubuntu)"
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
	@npx markdownlint '**/*.md' --config .markdown-lint.yml
	@echo "✅ markdownlint complete!"

# Run all linters
lint: check-commit check-editorconfig check-shellcheck check-markdownlint
	@echo "✅ All linting checks passed!"

# Create macOS PKG installer package
pkg-macos: permissions clean
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

# Create macOS PKG installer package on Ubuntu (cross-platform build)
pkg-ubuntu: permissions clean
	@echo "======================================"
	@echo "Creating macOS PKG installer (on Ubuntu)..."
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
	@mkdir -p build/pkg/flat/base.pkg
	@mkdir -p build/pkg/flat/Resources/en.lproj
	@mkdir -p build/pkg/root$(INSTALL_LOCATION)
	@mkdir -p build/pkg/scripts
	@# Copy source files to staging area
	@echo "📦 Copying source files..."
	@cp -R src/* build/pkg/root$(INSTALL_LOCATION)/
	@# Create postinstall script
	@echo "📝 Creating installation scripts..."
	@echo '#!/bin/bash' > build/pkg/scripts/postinstall
	@echo 'chmod +x $(INSTALL_LOCATION)/main.sh' >> build/pkg/scripts/postinstall
	@echo 'chmod +x $(INSTALL_LOCATION)/modules/*.sh' >> build/pkg/scripts/postinstall
	@echo 'ln -sf $(INSTALL_LOCATION)/main.sh /usr/local/bin/simple-calculator 2>/dev/null || true' >> build/pkg/scripts/postinstall
	@echo 'echo "✅ Simple Calculator installed successfully!"' >> build/pkg/scripts/postinstall
	@echo 'echo "Run: simple-calculator"' >> build/pkg/scripts/postinstall
	@echo 'exit 0' >> build/pkg/scripts/postinstall
	@chmod +x build/pkg/scripts/postinstall
	@# Calculate payload size and file count
	$(eval PAYLOAD_SIZE := $(shell du -sk build/pkg/root | cut -f1))
	$(eval FILE_COUNT := $(shell find build/pkg/root -type f | wc -l | tr -d ' '))
	@# Create PackageInfo XML
	@echo "📝 Creating PackageInfo..."
	@echo '<?xml version="1.0" encoding="utf-8"?>' > build/pkg/flat/base.pkg/PackageInfo
	@echo '<pkg-info format-version="2" identifier="$(IDENTIFIER)" version="$(VERSION)" install-location="/" auth="root">' >> build/pkg/flat/base.pkg/PackageInfo
	@echo '  <payload installKBytes="$(PAYLOAD_SIZE)" numberOfFiles="$(FILE_COUNT)"/>' >> build/pkg/flat/base.pkg/PackageInfo
	@echo '  <scripts>' >> build/pkg/flat/base.pkg/PackageInfo
	@echo '    <postinstall file="./postinstall"/>' >> build/pkg/flat/base.pkg/PackageInfo
	@echo '  </scripts>' >> build/pkg/flat/base.pkg/PackageInfo
	@echo '</pkg-info>' >> build/pkg/flat/base.pkg/PackageInfo
	@# Create Distribution XML
	@echo "📝 Creating Distribution..."
	@echo '<?xml version="1.0" encoding="utf-8"?>' > build/pkg/flat/Distribution
	@echo '<installer-gui-script minSpecVersion="1">' >> build/pkg/flat/Distribution
	@echo '  <title>Simple Calculator</title>' >> build/pkg/flat/Distribution
	@echo '  <organization>$(IDENTIFIER)</organization>' >> build/pkg/flat/Distribution
	@echo '  <domains enable_localSystem="true"/>' >> build/pkg/flat/Distribution
	@echo '  <options customize="never" require-scripts="true" rootVolumeOnly="true"/>' >> build/pkg/flat/Distribution
	@echo '  <pkg-ref id="$(IDENTIFIER)"/>' >> build/pkg/flat/Distribution
	@echo '  <choices-outline>' >> build/pkg/flat/Distribution
	@echo '    <line choice="default">' >> build/pkg/flat/Distribution
	@echo '      <line choice="$(IDENTIFIER)"/>' >> build/pkg/flat/Distribution
	@echo '    </line>' >> build/pkg/flat/Distribution
	@echo '  </choices-outline>' >> build/pkg/flat/Distribution
	@echo '  <choice id="default"/>' >> build/pkg/flat/Distribution
	@echo '  <choice id="$(IDENTIFIER)" visible="false">' >> build/pkg/flat/Distribution
	@echo '    <pkg-ref id="$(IDENTIFIER)"/>' >> build/pkg/flat/Distribution
	@echo '  </choice>' >> build/pkg/flat/Distribution
	@echo '  <pkg-ref id="$(IDENTIFIER)" version="$(VERSION)" onConclusion="none">base.pkg</pkg-ref>' >> build/pkg/flat/Distribution
	@echo '</installer-gui-script>' >> build/pkg/flat/Distribution
	@# Create Payload archive
	@echo ""
	@echo "🔨 Creating Payload archive..."
	@cd build/pkg/root && find . | cpio -o --format odc --owner 0:80 2>/dev/null | gzip -c > ../flat/base.pkg/Payload
	@# Create Scripts archive
	@echo "🔨 Creating Scripts archive..."
	@cd build/pkg/scripts && find . | cpio -o --format odc --owner 0:80 2>/dev/null | gzip -c > ../flat/base.pkg/Scripts
	@# Create BOM file
	@echo "🔨 Creating BOM file..."
	@mkbom -u 0 -g 80 build/pkg/root build/pkg/flat/base.pkg/Bom
	@# Create the final PKG using xar
	@echo "🔨 Building PKG file..."
	@cd build/pkg/flat && xar --compression none -cf "../../$(PKG_NAME)" *
	@echo ""
	@echo "======================================"
	@echo "✅ PKG created successfully!"
	@echo "======================================"
	@echo "📦 Package: build/$(PKG_NAME)"
	@echo ""
	@echo "To install (on macOS):"
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
