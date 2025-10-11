#!/usr/bin/env bash

echo "Installing tmux..."

# Check if we're running as root or if sudo is available
if [ "$EUID" -eq 0 ]; then
    SUDO_CMD=""
elif command -v sudo &>/dev/null; then
    SUDO_CMD="sudo"
else
    SUDO_CMD=""
fi

# Detect package manager
if command -v pacman &>/dev/null; then
    # Arch Linux
    echo "Installing tmux from Arch repositories..."
    $SUDO_CMD pacman -S --noconfirm tmux
    
elif command -v apt &>/dev/null; then
    # Debian/Ubuntu
    echo "Installing tmux from apt repositories..."
    $SUDO_CMD apt update
    DEBIAN_FRONTEND=noninteractive $SUDO_CMD apt install -y tmux
else
    echo "Error: No supported package manager found (pacman or apt)"
    exit 1
fi

echo "tmux installation complete!"
tmux -V
