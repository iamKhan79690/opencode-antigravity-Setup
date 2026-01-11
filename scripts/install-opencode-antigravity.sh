#!/bin/bash

################################################################################
# OpenCode Antigravity Plugin - One-Click Installer
# Supports: Linux, macOS, WSL, Git Bash on Windows
################################################################################

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

################################################################################
# Helper Functions
################################################################################

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

################################################################################
# Step 1: Check Prerequisites
################################################################################

print_header "Step 1: Checking Prerequisites"

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed!"
    echo ""
    echo "Please install Node.js first:"
    echo "  • Download from: https://nodejs.org/"
    echo "  • Or use your package manager (apt, brew, etc.)"
    exit 1
fi

NODE_VERSION=$(node -v)
print_success "Node.js is installed: $NODE_VERSION"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    print_error "npm is not installed!"
    exit 1
fi

NPM_VERSION=$(npm -v)
print_success "npm is installed: $NPM_VERSION"

echo ""

################################################################################
# Step 2: Install or Update OpenCode
################################################################################

print_header "Step 2: Installing OpenCode CLI"

if command -v opencode &> /dev/null; then
    OPENCODE_CURRENT=$(opencode --version)
    print_info "OpenCode is already installed: $OPENCODE_CURRENT"
    print_info "Updating to latest version..."
    npm update -g opencode-ai
else
    print_info "Installing OpenCode CLI globally..."
    npm install -g opencode-ai
fi

print_success "OpenCode CLI is ready"
OPENCODE_VERSION=$(opencode --version)
print_info "Version: $OPENCODE_VERSION"

echo ""

################################################################################
# Step 3: Install Antigravity Plugin
################################################################################

print_header "Step 3: Installing Antigravity Auth Plugin"

print_info "Installing opencode-antigravity-auth@beta..."
npm install -g opencode-antigravity-auth@beta

print_success "Plugin installed successfully"

echo ""

################################################################################
# Step 4: Determine Config Directory
################################################################################

print_header "Step 4: Setting Up Configuration"

# Determine config directory - use .config for all platforms
CONFIG_DIR="$HOME/.config/opencode"
print_info "Config directory: $CONFIG_DIR"

# Create config directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Backup existing config if present
CONFIG_FILE="$CONFIG_DIR/opencode.json"
if [ -f "$CONFIG_FILE" ]; then
    BACKUP_FILE="$CONFIG_DIR/opencode.json.backup.$(date +%Y%m%d_%H%M%S)"
    print_warning "Existing config found at $CONFIG_FILE"
    print_info "Backing up to: $BACKUP_FILE"
    cp "$CONFIG_FILE" "$BACKUP_FILE"
fi

echo ""

################################################################################
# Step 5: Generate Configuration
################################################################################

print_header "Step 5: Generating OpenCode Configuration"

print_info "Creating opencode.json with all Antigravity models..."

# Create the JSON config
cat > "$CONFIG_FILE" << 'JSONEOF'
{
  "$schema": "https://opencode.ai/config.json",
  "plugin": ["opencode-antigravity-auth@beta"],
  "model": "google/antigravity-claude-sonnet-4-5-thinking",
  "provider": {
    "google": {
      "models": {
        "antigravity-gemini-3-pro": {
          "name": "Gemini 3 Pro (Antigravity)",
          "limit": { "context": 1048576, "output": 65535 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
          "variants": {
            "low": { "thinkingLevel": "low" },
            "high": { "thinkingLevel": "high" }
          }
        },
        "antigravity-gemini-3-flash": {
          "name": "Gemini 3 Flash (Antigravity)",
          "limit": { "context": 1048576, "output": 65536 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
          "variants": {
            "minimal": { "thinkingLevel": "minimal" },
            "low": { "thinkingLevel": "low" },
            "medium": { "thinkingLevel": "medium" },
            "high": { "thinkingLevel": "high" }
          }
        },
        "antigravity-claude-sonnet-4-5": {
          "name": "Claude Sonnet 4.5 (no thinking) (Antigravity)",
          "limit": { "context": 200000, "output": 64000 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "antigravity-claude-sonnet-4-5-thinking": {
          "name": "Claude Sonnet 4.5 Thinking (Antigravity)",
          "limit": { "context": 200000, "output": 64000 },
          "modalities": { " "input": ["text", "image", "pdf"], "output": ["text"] },
          "variants": {
            "low": { "thinkingConfig": { "thinkingBudget": 8192 } },
            "max": { "thinkingConfig": { "thinkingBudget": 32768 } }
          }
        },
        "antigravity-claude-opus-4-5-thinking": {
          "name": "Claude Opus 4.5 Thinking (Antigravity)",
          "limit": { "context": 200000, "output": 64000 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] },
          "variants": {
            "low": { "thinkingConfig": { "thinkingBudget": 8192 } },
            "max": { "thinkingConfig": { "thinkingBudget": 32768 } }
          }
        },
        "gemini-2.5-flash": {
          "name": "Gemini 2.5 Flash (Gemini CLI)",
          "limit": { "context": 1048576, "output": 65536 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "gemini-2.5-pro": {
          "name": "Gemini 2.5 Pro (Gemini CLI)",
          "limit": { "context": 1048576, "output": 65536 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "gemini-3-flash-preview": {
          "name": "Gemini 3 Flash Preview (Gemini CLI)",
          "limit": { "context": 1048576, "output": 65536 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        },
        "gemini-3-pro-preview": {
          "name": "Gemini 3 Pro Preview (Gemini CLI)",
          "limit": { "context": 1048576, "output": 65535 },
          "modalities": { "input": ["text", "image", "pdf"], "output": ["text"] }
        }
      }
    }
  }
}
JSONEOF

print_success "Configuration created at: $CONFIG_FILE"

echo ""

################################################################################
# Step 6: Verify Installation
################################################################################

print_header "Step 6: Verifying Installation"

# Check if config is valid
if opencode debug config &> /dev/null; then
    print_success "Configuration is valid"
else
    print_error "Configuration validation failed"
    print_info "Check the config file at: $CONFIG_FILE"
fi

# Check if plugin is loaded
if opencode debug config 2>/dev/null | grep -q "opencode-antigravity-auth"; then
    print_success "Plugin is loaded"
else
    print_warning "Plugin verification inconclusive (may need restart)"
fi

echo ""

################################################################################
# Step 7: Final Instructions
################################################################################

print_header "Installation Complete!"

echo -e "${GREEN}✓ OpenCode CLI installed${NC}"
echo -e "${GREEN}✓ Antigravity plugin installed${NC}"
echo -e "${GREEN}✓ Configuration complete${NC}"
echo ""

echo -e "${YELLOW}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}NEXT STEP: Authenticate with Google${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo "Run the following command to sign in:"
echo ""
echo -e "${GREEN}  opencode auth login${NC}"
echo ""
echo "This will:"
echo "  1. Open a browser window for Google OAuth"
echo "  2. Ask you to sign in with your Google account"
echo "  3. Save your authentication credentials"
echo ""
echo "You can add multiple accounts for higher rate limits!"
echo ""
echo -e "${YELLOW}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}START USING OPENCODE${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo "Command Line (one-off queries):"
echo -e "  ${GREEN}opencode run \"Hello, explain recursion\"${NC}"
echo ""
echo "TUI (Interactive Terminal UI):"
echo -e "  ${GREEN}opencode${NC}"
echo ""
echo "Model Picker Shortcuts (in TUI):"
echo "  ${GREEN}Ctrl+M${NC}  - Open model picker"
echo "  ${GREEN}Ctrl+T${NC}  - Cycle through thinking variants"
echo "  ${GREEN}F2${NC}      - Switch to recent model"
echo ""
echo -e "${YELLOW}═══════════════════════════════════════════════════════════════${NC}"
echo ""
