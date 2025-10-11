#!/usr/bin/env bash

# Check if we're running as root or if sudo is available
if [ "$EUID" -eq 0 ]; then
    SUDO_CMD=""
elif command -v sudo &>/dev/null; then
    SUDO_CMD="sudo"
else
    SUDO_CMD=""
fi

echo "Installing Node.js and npm..."

# Detect package manager
if command -v pacman &>/dev/null; then
    # Arch Linux
    echo "Installing Node.js from Arch repositories..."
    $SUDO_CMD pacman -S --noconfirm nodejs npm
    
elif command -v apt &>/dev/null; then
    # Debian/Ubuntu
    echo "Installing Node.js from NodeSource..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | $SUDO_CMD bash -
    DEBIAN_FRONTEND=noninteractive $SUDO_CMD apt install -y nodejs
else
    echo "Error: No supported package manager found (pacman or apt)"
    exit 1
fi

echo "Installing npm packages globally..."

# Install global npm packages (non-interactive)
if command -v npm &>/dev/null; then
    npm install -g npm@latest
    npm install -g yarn
    npm install -g pnpm
fi

echo "Installing n (Node.js version manager)..."

# Install n for Node.js version management (non-interactive)
if command -v npm &>/dev/null; then
    npm install -g n
fi

echo "Setting up latest Node.js with n..."

# Use n to install latest Node.js (non-interactive)
if command -v n &>/dev/null; then
    n latest
fi

echo "Node.js installation complete!"
node --version
npm --version
