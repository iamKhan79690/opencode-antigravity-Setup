# 🚀 OpenCode Antigravity Setup: One-Click Installation Guide

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OpenCode](https://img.shields.io/badge/OpenCode-1.1.13+-blue.svg)](https://opencode.ai)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](https://github.com/iamKhan79690/opencode-antigravity-Setup)
[![Plugin](https://img.shields.io/badge/plugin-antigravity--auth%40beta-green.svg)](https://github.com/NoeFabris/opencode-antigravity-auth)

> **Simplify OpenCode with Google Antigravity OAuth Authentication**
> Access powerful models like Claude Sonnet 4.5, Claude Opus 4.5 Thinking, and Gemini 3 Pro with your Google credentials - no API keys needed!

[**▶ Quick Install (One-Liner)**](#-quick-install-one-liner---no-download-required) • [**📖 Documentation**](#-documentation) • [**🛠 Troubleshooting**](#-troubleshooting)

---

## 📺 What This Does

This repository provides **automated one-click installation scripts** that set up OpenCode AI with the Antigravity auth plugin. Perfect for students and beginners who want to skip manual configuration errors.

### ✨ Features

- ✅ **Zero Configuration** - Scripts handle everything automatically
- ✅ **Multi-Platform** - Works on Windows, macOS, and Linux
- ✅ **Google OAuth** - Authenticate with your Google account (no API keys!)
- ✅ **9 AI Models** - Claude Opus/Sonnet with thinking, Gemini 3 Pro/Flash, and more
- ✅ **Multi-Account Support** - Add multiple Google accounts for higher rate limits
- ✅ **Auto-Updates** - Plugin keeps itself updated

### 🎯 Available Models

| Model | Description | Best For |
|-------|-------------|----------|
| `antigravity-claude-sonnet-4-5-thinking` | Claude Sonnet 4.5 with extended thinking | **Default** - Balanced coding & reasoning |
| `antigravity-claude-opus-4-5-thinking` | Claude Opus 4.5 with extended thinking | Most capable complex tasks |
| `antigravity-gemini-3-pro` | Google Gemini 3 Pro | Advanced reasoning |
| `antigravity-gemini-3-flash` | Google Gemini 3 Flash | Quick responses |
| `antigravity-claude-sonnet-4-5` | Claude Sonnet 4.5 (no thinking) | Fast code generation |

---

## 🛠 Prerequisites

Before running the installer, make sure you have:

### Required

1. **Node.js** (v18 or higher)
   - Download from: https://nodejs.org/
   - Or use: `winget install OpenJS.NodeJS.LTS` (Windows)
   - Verify: `node --version`

2. **npm** (comes with Node.js)
   - Verify: `npm --version`

### Optional but Recommended

- **Git** - For cloning this repository
- **A Google Account** - For OAuth authentication

---

## ⚡ Installation (Recommended Method)

### 🚀 Quick Install (One-Liner) - No Download Required!

**Just copy and paste this command into your terminal - it will download and run everything automatically:**

#### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/iamKhan79690/opencode-antigravity-Setup/Opencode-antigravity-Setup/scripts/install-opencode-antigravity.ps1 | iex
```

> **Note:** If you get script execution errors, first run:
> ```powershell
> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

#### macOS / Linux / WSL / Git Bash

```bash
curl -sSL https://raw.githubusercontent.com/iamKhan79690/opencode-antigravity-Setup/Opencode-antigravity-Setup/scripts/install-opencode-antigravity.sh | bash
```

---

### 📥 Alternative: Manual Download

If you prefer to download the script first and inspect it:

1. **Clone or download this repository:**
   ```bash
   git clone https://github.com/iamKhan79690/opencode-antigravity-Setup.git
   cd opencode-antigravity-Setup
   ```

2. **Run the installer:**
   - **Windows:** `.\scripts\install-opencode-antigravity.ps1`
   - **Mac/Linux:** `./scripts/install-opencode-antigravity.sh`

---

## 📋 What the Script Does

The installer automatically:

1. ✅ Checks if Node.js and npm are installed
2. ✅ Installs OpenCode CLI globally (or updates if present)
3. ✅ Installs `opencode-antigravity-auth@beta` plugin
4. ✅ Creates configuration directory at `~/.config/opencode`
5. ✅ Generates `opencode.json` with all 9 Antigravity models
6. ✅ Sets default model to `antigravity-claude-sonnet-4-5-thinking`
7. ✅ Backs up any existing config before overwriting
8. ✅ Verifies installation and shows success message

**Installation Time:** ~2-3 minutes (depending on internet speed)

---

## 🔐 Step 2: Authenticate with Google

After the installer completes, you need to authenticate:

### Run the Authentication Command

```bash
opencode auth login
```

### What Happens

1. A browser window will open automatically
2. Sign in with your Google account
3. Grant permissions to access Antigravity
4. Your credentials are saved securely

### Adding Multiple Accounts (Optional)

For higher rate limits, you can add multiple Google accounts:

```bash
# Run auth login again
opencode auth login

# When prompted, select "(a)dd new account(s)"
# Sign in with another Google account
```

> **Tip:** The plugin automatically rotates between accounts when one hits rate limits!

---

## 🚀 Step 3: Start Using OpenCode

### Option A: TUI Mode (Interactive)

```bash
opencode
```

**TUI Shortcuts:**
- `Ctrl+M` - Open model picker
- `Ctrl+T` - Cycle through thinking variants (low/max)
- `F2` - Switch to recent model
- `Ctrl+C` - Exit

### Option B: CLI Mode (One-off Queries)

```bash
# Basic usage
opencode run "Explain quantum computing"

# With specific model
opencode run "Debug this code" --model=google/antigravity-claude-opus-4-5-thinking --variant=max

# Continue last session
opencode run --continue
```

---

## ⚙️ Configuration & Customization

### View Your Configuration

```bash
opencode debug config
```

### Change Default Model

Edit `~/.config/opencode/opencode.json`:

```json
{
  "model": "google/antigravity-claude-opus-4-5-thinking",
  ...
}
```

### Adjust Thinking Budget

Models support thinking variants:

| Variant | Budget | Best For |
|---------|--------|----------|
| `low` | 8,192 tokens | Quick tasks |
| `max` | 32,768 tokens | Complex reasoning |

**Usage:**
```bash
opencode run "Solve this step by step" --variant=max
```

### List Available Models

```bash
# List all Google models
opencode models google

# List all providers
opencode models
```

---

## 🎓 Understanding the Models

### Claude Models (via Antigravity)

| Model | Context | Output | Features |
|-------|---------|--------|----------|
| `claude-sonnet-4-5-thinking` | 200K | 64K | Balanced coding & reasoning |
| `claude-opus-4-5-thinking` | 200K | 64K | Most capable for complex tasks |
| `claude-sonnet-4-5` | 200K | 64K | Fast (no thinking) |

### Gemini Models (Antigravity + Gemini CLI)

| Model | Context | Output | Quota Source |
|-------|---------|--------|--------------|
| `gemini-3-pro` | 1M+ | 65K | Antigravity |
| `gemini-3-flash` | 1M+ | 65K | Antigravity |
| `gemini-2.5-pro` | 1M+ | 65K | Gemini CLI |
| `gemini-2.5-flash` | 1M+ | 65K | Gemini CLI |

> **Note:** Antigravity models (`antigravity-*`) use Antigravity quota. Gemini CLI models (`*-preview`) use Gemini CLI quota. The plugin automatically falls back between them!

---

## 🧪 Testing Your Installation

### Test 1: Verify Plugin Loaded

```bash
opencode debug config | grep antigravity
```

Should show:
```
"plugin": [
  "opencode-antigravity-auth@beta"
]
```

### Test 2: Verify Models Available

```bash
opencode models google
```

Should list all 9 models.

### Test 3: Run a Simple Query

```bash
opencode run "Say hello and tell me you're working!"
```

Should respond with confirmation.

---

## 📚 Advanced Configuration

### Create Optional Antigravity Config

For advanced settings, create `~/.config/opencode/antigravity.json`:

```json
{
  "$schema": "https://raw.githubusercontent.com/NoeFabris/opencode-antigravity-auth/main/assets/antigravity.schema.json",
  "quiet_mode": false,
  "debug": false,
  "auto_update": true,
  "session_recovery": true,
  "auto_resume": true,
  "max_rate_limit_wait_seconds": 300,
  "account_selection_strategy": "sticky"
}
```

### Environment Variables

Override settings with environment variables:

```bash
# Enable debug logging
export OPENCODE_ANTIGRAVITY_DEBUG=1

# Set account strategy
export OPENCODE_ANTIGRAVITY_ACCOUNT_SELECTION_STRATEGY=round-robin

# Suppress notifications
export OPENCODE_ANTIGRAVITY_QUIET=1
```

---

## 🛠 Troubleshooting

### Problem: "Computer unable to access URL"

**Solution:** You're likely missing the default model configuration. The installer fixes this, but if you see this error:

1. Check your config:
   ```bash
   opencode debug config
   ```

2. Verify `"model"` key exists:
   ```json
   {
     "model": "google/antigravity-claude-sonnet-4-5-thinking",
     ...
   }
   ```

### Problem: "Provider not found: google"

**Solution:** The config is in the wrong location.

1. Check where OpenCode looks for config:
   ```bash
   opencode debug paths
   ```

2. Config should be at: `~/.config/opencode/opencode.json`
   - macOS/Linux: `~/.config/opencode/opencode.json`
   - Windows: `C:\Users\YOUR_USER\.config\opencode\opencode.json`

### Problem: Plugin not loading

**Solution:** Verify plugin is installed globally:

```bash
npm list -g | grep antigravity
```

Should show: `opencode-antigravity-auth@1.x.x-beta.x`

If not, reinstall:
```bash
npm install -g opencode-antigravity-auth@beta
```

### Problem: Authentication fails

**Solution:** Clear existing credentials and try again:

```bash
# Remove account file
rm ~/.config/opencode/antigravity-accounts.json

# Re-authenticate
opencode auth login
```

### Problem: Rate limit errors

**Solution:** Add more Google accounts:

```bash
opencode auth login
# Choose "(a)dd new account(s)"
# Sign in with another account
```

The plugin automatically rotates between accounts!

---

## 📖 Learning Resources

### OpenCode Documentation

- Official Docs: https://opencode.ai/docs/
- Troubleshooting: https://opencode.ai/docs/troubleshooting/
- GitHub: https://github.com/opencode-ai/opencode

### Antigravity Plugin

- Repository: https://github.com/NoeFabris/opencode-antigravity-auth
- Issues: https://github.com/NoeFabris/opencode-antigravity-auth/issues

---

## 🎯 Common Use Cases

### 1. Daily Coding Assistant

```bash
opencode
# Default model: claude-sonnet-4-5-thinking
# Perfect balance of speed and capability
```

### 2. Complex Problem Solving

```bash
opencode run "Analyze this architecture and suggest improvements" --model=google/antigravity-claude-opus-4-5-thinking --variant=max
```

### 3. Quick Code Review

```bash
opencode run "Review this file for bugs" --model=google/antigravity-gemini-3-flash
```

### 4. Long-Context Projects

```bash
opencode run "Explain how this entire codebase works" --model=google/antigravity-claude-sonnet-4-5-thinking
# Supports 200K tokens!
```

---

## ⚡ Performance Tips

1. **Use Flash for speed** - Gemini 3 Flash is fastest for simple tasks
2. **Use Sonnet for balance** - Claude Sonnet 4.5 is great for most coding
3. **Use Opus for complexity** - Claude Opus 4.5 for challenging problems
4. **Use max variant** - For complex reasoning, use `--variant=max`
5. **Add multiple accounts** - Avoid rate limits with 2+ Google accounts

---

## 🔒 Privacy & Security

- **OAuth Tokens** stored in: `~/.config/opencode/antigravity-accounts.json`
- **Treat as passwords** - Don't share this file
- **Auto-refresh** - Tokens refresh automatically before expiry
- **Encrypted** - Credentials stored securely

---

## 📝 What's Included

```
opencode-antigravity-setup/
├── README.md                              # This file
└── scripts/
    ├── install-opencode-antigravity.ps1   # Windows PowerShell installer
    └── install-opencode-antigravity.sh    # Bash installer (macOS/Linux/WSL)
```

---

## 🤝 Contributing

Found a bug or have a suggestion?

1. Open an issue on GitHub
2. Submit a pull request
3. Share your feedback!

---

## 📜 License

This setup guide is provided as-is for educational and personal development use.

**Plugin License:** MIT (see [opencode-antigravity-auth](https://github.com/NoeFabris/opencode-antigravity-auth))

**OpenCode License:** See [OpenCode repository](https://github.com/opencode-ai/opencode)

---

## 🙏 Acknowledgments

- **OpenCode** - The amazing AI coding agent
- **NoeFabris** - For creating the Antigravity auth plugin
- **Google** - For Antigravity and Gemini models
- **Anthropic** - For Claude models

---

## 📞 Support

- **OpenCode Discord:** https://opencode.ai/discord
- **GitHub Issues:** https://github.com/NoeFabris/opencode-antigravity-auth/issues

---

**Last Updated:** January 2026
**Plugin Version:** 1.2.9-beta.1
**OpenCode Version:** 1.1.13+

---

## 📋 About This Repository

**Maintainer:** [@iamKhan79690](https://github.com/iamKhan79690)

### Purpose

This repository was created to solve a common problem: **setting up OpenCode with the Antigravity auth plugin was too complicated for beginners and students**.

The journey started when I encountered multiple configuration errors:
- Wrong config directory paths (APPDATA vs .config)
- Missing default model causing TUI errors
- Plugin installation confusion
- Manual JSON editing mistakes

I created this automated installer to eliminate all those headaches and let anyone get started with OpenCode + Antigravity in **under 5 minutes** with just **one command**.

### Why This Matters

- **Education:** Helps students access powerful AI tools without configuration struggles
- **Accessibility:** Removes technical barriers for non-developers
- **Productivity:** Developers can focus on coding, not setup

### Technology Stack

- **Shell Scripting:** Bash (Unix/Linux/macOS) & PowerShell (Windows)
- **Node.js Package Management:** npm for global package installation
- **Configuration Management:** JSON-based OpenCode config
- **Authentication:** OAuth 2.0 flow via Antigravity

### Project Stats

- **Lines of Code:** ~1,800+ (documentation + automation)
- **Platforms Supported:** 3 (Windows, macOS, Linux)
- **AI Models Configured:** 9
- **Installation Time:** ~2-3 minutes

### Star History

If you find this project helpful, please consider giving it a ⭐ star on GitHub!

### Roadmap

- [ ] Add automated testing
- [ ] Support for more providers
- [ ] Docker container setup
- [ ] Video tutorial
- [ ] Multi-language documentation

---

<div align="center">

### 🎉 You're All Set!

Run `opencode auth login` and start coding with AI!

**⭐ Star this repo if it helped you!**

</div>
