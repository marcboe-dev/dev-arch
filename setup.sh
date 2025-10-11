#!/usr/bin/env bash

# Check if we're running as root or if sudo is available
if [ "$EUID" -eq 0 ]; then
    SUDO_CMD=""
elif command -v sudo &>/dev/null; then
    SUDO_CMD="sudo"
else
    SUDO_CMD=""
fi

# Detect package manager and install system dependencies
echo "Installing system dependencies..."

if command -v pacman &>/dev/null; then
    # Arch Linux
    echo "Detected Arch Linux (pacman)"
    $SUDO_CMD pacman -Sy --noconfirm
    $SUDO_CMD pacman -S --noconfirm \
        curl \
        wget \
        git \
        base-devel \
        ca-certificates \
        gnupg \
        zsh \
        unzip \
        tar \
        gzip \
        make \
        gcc \
        python \
        python-pip
        
elif command -v apt &>/dev/null; then
    # Debian/Ubuntu
    echo "Detected Debian/Ubuntu (apt)"
    $SUDO_CMD apt update && $SUDO_CMD apt install -y \
        curl \
        wget \
        git \
        build-essential \
        software-properties-common \
        ca-certificates \
        gnupg \
        lsb-release \
        zsh \
        unzip \
        tar \
        gzip \
        make \
        gcc \
        g++ \
        python3 \
        python3-pip
else
    echo "Error: No supported package manager found (pacman or apt)"
    exit 1
fi

# Add error handling and verbose output
set -e # Exit on any error
set -x # Print commands as they execute

echo "Starting installation process..."

# Set DEV_ENV as required by the run script
export DEV_ENV=$(pwd)

# Run with verbose output to see what's happening
echo "Running installation scripts..."
./run 2>&1 | tee install.log

echo "Installation completed!"

# Turn off verbose mode
set +x
set +e

echo "Setup script completed!"
echo "To use zsh, run: exec zsh"
