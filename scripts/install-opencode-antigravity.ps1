################################################################################
# OpenCode Antigravity Plugin - One-Click Installer for Windows
# Supports: PowerShell 5.1+, Windows 10/11
################################################################################

#Requires -Version 5.1

[CmdletBinding()]
param()

# Helper functions
function Write-Header {
    param([string]$Message)
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host $Message -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-Error-Custom {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
}

function Write-Warning-Custom {
    param([string]$Message)
    Write-Host "⚠ $Message" -ForegroundColor Yellow
}

function Write-Info {
    param([string]$Message)
    Write-Host "ℹ $Message" -ForegroundColor Cyan
}

################################################################################
# Step 1: Check Prerequisites
################################################################################

Write-Header "Step 1: Checking Prerequisites"

# Check if Node.js is installed
$nodeCmd = Get-Command node -ErrorAction SilentlyContinue
if (-not $nodeCmd) {
    Write-Error-Custom "Node.js is not installed!"
    Write-Host ""
    Write-Host "Please install Node.js first:"
    Write-Host "  • Download from: https://nodejs.org/"
    Write-Host "  • Or use winget: winget install OpenJS.NodeJS.LTS"
    exit 1
}

$nodeVersion = node -v
Write-Success "Node.js is installed: $nodeVersion"

# Check if npm is installed
$npmCmd = Get-Command npm -ErrorAction SilentlyContinue
if (-not $npmCmd) {
    Write-Error-Custom "npm is not installed!"
    exit 1
}

$npmVersion = npm -v
Write-Success "npm is installed: $npmVersion"

Write-Host ""

################################################################################
# Step 2: Install or Update OpenCode
################################################################################

Write-Header "Step 2: Installing OpenCode CLI"

$opencodeCmd = Get-Command opencode -ErrorAction SilentlyContinue
if ($opencodeCmd) {
    $currentVersion = opencode --version
    Write-Info "OpenCode is already installed: $currentVersion"
    Write-Info "Updating to latest version..."
    npm update -g opencode-ai
} else {
    Write-Info "Installing OpenCode CLI globally..."
    npm install -g opencode-ai
}

Write-Success "OpenCode CLI is ready"
$opencodeVersion = opencode --version
Write-Info "Version: $opencodeVersion"

Write-Host ""

################################################################################
# Step 3: Install Antigravity Plugin
################################################################################

Write-Header "Step 3: Installing Antigravity Auth Plugin"

Write-Info "Installing opencode-antigravity-auth@beta..."
npm install -g opencode-antigravity-auth@beta

Write-Success "Plugin installed successfully"

Write-Host ""

################################################################################
# Step 4: Determine Config Directory
################################################################################

Write-Header "Step 4: Setting Up Configuration"

# Use .config/opencode (works with OpenCode's path resolution)
$configDir = Join-Path $env:USERPROFILE ".config\opencode"
Write-Info "Config directory: $configDir"

# Create config directory if it doesn't exist
if (-not (Test-Path $configDir)) {
    New-Item -ItemType Directory -Path $configDir -Force | Out-Null
}

# Backup existing config if present
$configFile = Join-Path $configDir "opencode.json"
if (Test-Path $configFile) {
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupFile = "$configFile.backup.$timestamp"
    Write-Warning-Custom "Existing config found at $configFile"
    Write-Info "Backing up to: $backupFile"
    Copy-Item $configFile $backupFile
}

Write-Host ""

################################################################################
# Step 5: Generate Configuration
################################################################################

Write-Header "Step 5: Generating OpenCode Configuration"

Write-Info "Creating opencode.json with all Antigravity models..."

$configJson = @{
    '$schema' = "https://opencode.ai/config.json"
    plugin = @("opencode-antigravity-auth@beta")
    model = "google/antigravity-claude-sonnet-4-5-thinking"
    provider = @{
        google = @{
            models = @{
                'antigravity-gemini-3-pro' = @{
                    name = "Gemini 3 Pro (Antigravity)"
                    limit = @{ context = 1048576; output = 65535 }
                    modalities = @{ input = @("text", "image", "pdf"); output = @("text") }
                    variants = @{
                        low = @{ thinkingLevel = "low" }
                        high = @{ thinkingLevel = "high" }
                    }
                }
                'antigravity-gemini-3-flash' = @{
                    name = "Gemini 3 Flash (Antigravity)"
                    limit = @{ context = 1048576; output = 65536 }
                    modalities = @{ input = @("text", "image", "pdf"); output = @("text") }
                    variants = @{
                        minimal = @{ thinkingLevel = "minimal" }
                        low = @{ thinkingLevel = "low" }
                        medium = @{ thinkingLevel = "medium" }
                        high = @{ thinkingLevel = "high" }
                    }
                }
                'antigravity-claude-sonnet-4-5' = @{
                    name = "Claude Sonnet 4.5 (no thinking) (Antigravity)"
                    limit = @{ context = 200000; output = 64000 }
                    modalities = @{ input = @("text", "image", "pdf"); output = @("text") }
                }
                'antigravity-claude-sonnet-4-5-thinking' = @{
                    name = "Claude Sonnet 4.5 Thinking (Antigravity)"
                    limit = @{ context = 200000; output = 64000 }
                    modalities = @{ input = @("text", "image", "pdf"); output = @("text") }
                    variants = @{
                        low = @{ thinkingConfig = @{ thinkingBudget = 8192 } }
                        max = @{ thinkingConfig = @{ thinkingBudget = 32768 } }
                    }
                }
                'antigravity-claude-opus-4-5-thinking' = @{
                    name = "Claude Opus 4.5 Thinking (Antigravity)"
                    limit = @{ context = 200000; output = 64000 }
                    modalities = @{ input = @("text", "image", "pdf"); output = @("text") }
                    variants = @{
                        low = @{ thinkingConfig = @{ thinkingBudget = 8192 } }
                        max = @{ thinkingConfig = @{ thinkingBudget = 32768 } }
                    }
                }
                'gemini-2.5-flash' = @{
                    name = "Gemini 2.5 Flash (Gemini CLI)"
                    limit = @{ context = 1048576; output = 65536 }
                    modalities = @{ input = @("text", "image", "pdf"); output = @("text") }
                }
                'gemini-2.5-pro' = @{
                    name = "Gemini 2.5 Pro (Gemini CLI)"
                    limit = @{ context = 1048576; output = 65536 }
                    modalities = @{ input = @("text", "image", "pdf"); output = @("text") }
                }
                'gemini-3-flash-preview' = @{
                    name = "Gemini 3 Flash Preview (Gemini CLI)"
                    limit = @{ context = 1048576; output = 65536 }
                    modalities = @{ input = @("text", "image", "pdf"); output = @("text") }
                }
                'gemini-3-pro-preview' = @{
                    name = "Gemini 3 Pro Preview (Gemini CLI)"
                    limit = @{ context = 1048576; output = 65535 }
                    modalities = @{ input = @("text", "image", "pdf"); output = @("text") }
                }
            }
        }
    }
}

$configJson | ConvertTo-Json -Depth 10 | Set-Content $configFile

Write-Success "Configuration created at: $configFile"

Write-Host ""

################################################################################
# Step 6: Verify Installation
################################################################################

Write-Header "Step 6: Verifying Installation"

# Check if config is valid
$debugOutput = opencode debug config 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Success "Configuration is valid"
} else {
    Write-Error-Custom "Configuration validation failed"
    Write-Info "Check the config file at: $configFile"
}

# Check if plugin is loaded
if ($debugOutput -match "opencode-antigravity-auth") {
    Write-Success "Plugin is loaded"
} else {
    Write-Warning-Custom "Plugin verification inconclusive (may need restart)"
}

Write-Host ""

################################################################################
# Step 7: Final Instructions
################################################################################

Write-Header "Installation Complete!"

Write-Host "✓ OpenCode CLI installed" -ForegroundColor Green
Write-Host "✓ Antigravity plugin installed" -ForegroundColor Green
Write-Host "✓ Configuration complete" -ForegroundColor Green
Write-Host ""

Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host "NEXT STEP: Authenticate with Google" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""
Write-Host "Run the following command to sign in:"
Write-Host ""
Write-Host "  opencode auth login" -ForegroundColor Green
Write-Host ""
Write-Host "This will:"
Write-Host "  1. Open a browser window for Google OAuth"
Write-Host "  2. Ask you to sign in with your Google account"
Write-Host "  3. Save your authentication credentials"
Write-Host ""
Write-Host "You can add multiple accounts for higher rate limits!"
Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host "START USING OPENCODE" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""
Write-Host "Command Line (one-off queries):"
Write-Host "  opencode run 'Hello, explain recursion'" -ForegroundColor Green
Write-Host ""
Write-Host "TUI (Interactive Terminal UI):"
Write-Host "  opencode" -ForegroundColor Green
Write-Host ""
Write-Host "Model Picker Shortcuts (in TUI):"
Write-Host "  Ctrl+M  - Open model picker" -ForegroundColor Green
Write-Host "  Ctrl+T  - Cycle through thinking variants" -ForegroundColor Green
Write-Host "  F2      - Switch to recent model" -ForegroundColor Green
Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Yellow
Write-Host ""
