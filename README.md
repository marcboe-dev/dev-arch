# Development Environment Setup

A complete development environment setup for Ubuntu containers/systems with automated installation of essential development tools.

## Quick Start

### 1. Start Ubuntu Container

```bash
docker run -it --network host ubuntu bash
```

### 2. Clean Up Previous Containers (Optional)

```bash
docker rm -f $(docker ps -aq)  # Delete all containers
```

### 3. Install Basic Dependencies

```bash
apt update
apt install -y git vim xclip
```

### 4. Setup SSH Key for GitHub

Generate SSH key

Copy public key to GitHub

Go to **GitHub’ Settings’ SSH and GPG keys’ New SSH key** and paste the public key.

### 5. Clone Repository

```bash
cd ~
git clone git@github.com:marc-is-coding/personal.git
```

### 6. Run Setup Scripts

#### First: Copy configuration files

```bash
cd personal/dev
./dev-env
```

#### Second: Install all development tools

```bash
./setup
```

### 7. Switch to Zsh

```bash
exec zsh
source .zsh_profile
```

## What Gets Installed

The setup script automatically installs:

### System Tools

- **Git** - Version control
- **Zsh + Oh My Zsh** - Enhanced shell with themes and plugins
- **Tmux** - Terminal multiplexer
- **fzf** - Fuzzy finder with key bindings

### Development Tools

- **Neovim** - Modern text editor with LSP support
- **Node.js + npm + pnpm** - JavaScript runtime and package managers
- **Rust + Cargo** - Rust programming language and tools
- **Starship** - Cross-shell prompt

### Utilities

- **ripgrep** - Fast text search
- **jq** - JSON processor
- **tldr** - Simplified man pages
- **xclip** - Clipboard utility
- **Stylua** - Lua formatter

## Configuration

The `./dev-env` script copies pre-configured dotfiles for:

- **Neovim** - Full IDE setup with LSP, plugins, and key bindings
- **Tmux** - Custom configuration
- **Zsh** - Shell configuration with aliases and functions
- **Starship** - Custom prompt theme

## Workflow

This setup provides a seamless terminal-driven workflow for navigating projects and files:

### Starting a Session

Press `Ctrl+F` to launch the **tmux-sessionizer**, which:
1. Opens an fzf fuzzy finder to search for directories
2. Creates a new tmux session or switches to an existing one
3. Drops you directly into Neovim with Neo-tree (file explorer) open

### Navigating Projects

From Neo-tree, you can:
- **Search files** - Use Telescope (`<leader>sf`) to fuzzy find files across the project
- **Scratch window** - Switch to the scratch window to make new searches or run commands
- **Navigate splits** - Use `Ctrl+h/j/k/l` to move between Neovim and tmux splits

### Tmux Session Management

- `Ctrl+B + s` - Show all available tmux sessions
- `tmux kill-server` - Kill all tmux sessions and start fresh
- `Ctrl+B + n` / `Ctrl+B + p` - Navigate between tmux windows

### Custom Session Commands

Additional keybinds for quick project switching:
- `Alt+H` - Open session 0
- `Alt+T` - Open session 1
- `Alt+N` - Open session 2
- `Alt+S` - Open session 3

## Manual Installation

You can also run individual installers:

```bash
DEV_ENV=$(pwd) ./run <installer_name>
```

Available installers: `libs`, `rust`, `tmux`, `node`, `starship`, `neovim`, `zsh`

## Notes

- Designed for Ubuntu/Debian systems
- Works in Docker containers (handles sudo availability automatically)
- All installations are non-interactive
- Configuration files are backed up before modification

### First Time Neovim Setup

Before starting nvim, clear treesitter cache:

```bash
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

## Acknowledgments

This development environment setup is built upon and inspired by excellent work from the community:

### Workflow & Architecture

- **[ThePrimeAgen](https://github.com/ThePrimeAgen)** - The overall workflow, repository structure, installation automation, and the `tmux-sessionizer` concept are adapted from his development environment. His approach to terminal-driven development heavily influenced this configuration.

### Neovim & Tmux Configuration

- **[hendrikmi](https://github.com/hendrikmi)** - The Neovim plugin configuration patterns, tmux integration strategies, and UI/color design are based on their dotfiles setup.
