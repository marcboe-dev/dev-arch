#!/usr/bin/env bash

echo "Installing Zsh and Oh My Zsh..."

# Check if we're running as root or if sudo is available
if [ "$EUID" -eq 0 ]; then
    SUDO_CMD=""
elif command -v sudo &>/dev/null; then
    SUDO_CMD="sudo"
else
    SUDO_CMD=""
fi

# Install zsh if not already installed
if ! command -v zsh &>/dev/null; then
    echo "Installing zsh..."
    
    if command -v pacman &>/dev/null; then
        # Arch Linux
        $SUDO_CMD pacman -S --noconfirm zsh
    elif command -v apt &>/dev/null; then
        # Debian/Ubuntu
        $SUDO_CMD apt update
        $SUDO_CMD DEBIAN_FRONTEND=noninteractive apt install -y zsh zsh-common
    else
        echo "Error: No supported package manager found (pacman or apt)"
        exit 1
    fi
fi

# Change shell without prompting (only if not root)
if [ "$EUID" -ne 0 ]; then
    chsh -s $(which zsh)
else
    echo "Running as root - skipping shell change"
fi

echo "Installing oh-my-zsh non-interactively"

# Use environment variables to skip prompts - only for this command
RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Zsh and Oh My Zsh installation complete!"
echo "To switch to zsh, run: exec zsh"
