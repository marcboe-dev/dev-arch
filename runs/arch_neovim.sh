#!/usr/bin/env bash

echo "Installing Neovim..."

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
    # Arch Linux - install from official repos (usually quite recent)
    echo "Installing Neovim from Arch repositories..."
    $SUDO_CMD pacman -S --noconfirm neovim
    
    echo "Installing additional packages for Neovim development"
    $SUDO_CMD pacman -S --noconfirm lua luarocks
    
    # Install luacheck via luarocks
    if command -v luarocks &>/dev/null; then
        $SUDO_CMD luarocks install luacheck
    fi
    
elif command -v apt &>/dev/null; then
    # Debian/Ubuntu - use AppImage method as before
    if command -v modprobe &>/dev/null && modprobe fuse 2>/dev/null; then
        # Regular system with working FUSE - use AppImage directly
        echo "downloading neovim v0.11.4 AppImage"
        curl -Lo nvim https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.appimage
        chmod +x nvim
        mkdir -p $HOME/.local/bin
        mv nvim $HOME/.local/bin/
    else
        # Container environment or FUSE not working - extract AppImage
        echo "downloading and extracting neovim v0.11.4 (container mode)"
        curl -Lo nvim.appimage https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.appimage
        chmod +x nvim.appimage
        ./nvim.appimage --appimage-extract

        # Install the extracted contents properly
        mkdir -p $HOME/.local/bin
        mkdir -p $HOME/.local/share
        mkdir -p $HOME/.local/lib

        # Copy binary
        cp squashfs-root/usr/bin/nvim $HOME/.local/bin/

        # Copy runtime files (critical for nvim to work)
        cp -r squashfs-root/usr/share/nvim $HOME/.local/share/

        # Copy lib files if they exist
        if [ -d squashfs-root/usr/lib/nvim ]; then
            cp -r squashfs-root/usr/lib/nvim $HOME/.local/lib/
        fi

        chmod +x $HOME/.local/bin/nvim
        rm -rf squashfs-root nvim.appimage
    fi

    echo "Installing additional packages for Neovim development"
    $SUDO_CMD apt install -y lua5.1 luarocks
    $SUDO_CMD luarocks install luacheck
else
    echo "Error: No supported package manager found (pacman or apt)"
    exit 1
fi

echo "Neovim installation complete!"
nvim --version
