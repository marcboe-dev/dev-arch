#!/usr/bin/env bash

echo "Installing system libraries and tools..."

# Check if we're running as root or if sudo is available
if [ "$EUID" -eq 0 ]; then
    SUDO_CMD=""
elif command -v sudo &>/dev/null; then
    SUDO_CMD="sudo"
else
    SUDO_CMD=""
fi

# Detect package manager and distribution
if command -v pacman &>/dev/null; then
    # Arch Linux
    echo "Detected Arch Linux (pacman)"
    
    # Update package database
    $SUDO_CMD pacman -Sy --noconfirm
    
    # Install packages
    $SUDO_CMD pacman -S --noconfirm \
        git \
        ripgrep \
        xclip \
        jq \
        tldr \
        python-pip \
        base-devel
    
    # Note: pavucontrol and shutter might need AUR on Arch
    # Installing if available in official repos
    $SUDO_CMD pacman -S --noconfirm pavucontrol 2>/dev/null || echo "pavucontrol not found in repos"
    
elif command -v apt &>/dev/null; then
    # Debian/Ubuntu
    echo "Detected Debian/Ubuntu (apt)"
    
    # Update package lists
    $SUDO_CMD apt update
    
    # Install packages
    DEBIAN_FRONTEND=noninteractive $SUDO_CMD apt install -y \
        git \
        ripgrep \
        pavucontrol \
        xclip \
        jq \
        tldr \
        shutter \
        python3-pip
else
    echo "Error: No supported package manager found (pacman or apt)"
    exit 1
fi

echo "Installing fzf..."

# Create directory if it doesn't exist
mkdir -p $HOME/personal

# Clone fzf repository
if [ -d "$HOME/personal/fzf" ]; then
    echo "fzf directory already exists, pulling latest changes..."
    cd $HOME/personal/fzf && git pull
else
    git clone https://github.com/junegunn/fzf.git $HOME/personal/fzf
fi

# Install fzf non-interactively with all features enabled
$HOME/personal/fzf/install --all --key-bindings --completion --update-rc

echo "Libraries and tools installation complete!"

# Verify installations
echo "Verifying installations:"
git --version 2>/dev/null && echo "✓ git installed" || echo "✗ git failed"
rg --version 2>/dev/null && echo "✓ ripgrep installed" || echo "✗ ripgrep failed"
jq --version 2>/dev/null && echo "✓ jq installed" || echo "✗ jq failed"
$HOME/personal/fzf/bin/fzf --version 2>/dev/null && echo "✓ fzf installed" || echo "✗ fzf failed"
