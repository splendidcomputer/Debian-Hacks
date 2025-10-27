#!/usr/bin/env bash
# ============================================================
# Zoom Installer for Debian (Bookworm, Trixie, etc.)
# Author: Mostafa Razavi Ghods
# ============================================================

set -e

echo "Zoom Installer for Debian"
echo "--------------------------"

# System update
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y wget gpg

# Download Zoom
echo "Downloading the latest Zoom package..."
wget -q https://zoom.us/client/latest/zoom_amd64.deb -O zoom_amd64.deb

# Install Zoom
echo "Installing Zoom..."
sudo apt install -y ./zoom_amd64.deb || sudo apt --fix-broken install -y

# Verify installation
if command -v zoom >/dev/null 2>&1; then
    echo "Zoom installed successfully at: $(which zoom)"
else
    echo "Zoom installation failed. Please check the output for details."
    exit 1
fi

# Register Zoom as protocol handler
echo "Registering Zoom as the handler for zoommtg:// links..."
xdg-mime default Zoom.desktop x-scheme-handler/zoommtg
sudo update-desktop-database >/dev/null 2>&1 || true

# Verify handler registration
HANDLER=$(xdg-mime query default x-scheme-handler/zoommtg)
if [[ "$HANDLER" == "Zoom.desktop" ]]; then
    echo "Zoom protocol handler registered correctly."
else
    echo "Warning: Zoom handler registration may not have succeeded (found: $HANDLER)."
fi

# Test handler
echo "Testing Zoom link handling..."
xdg-open "zoommtg://zoom.us/join?action=join&confno=123456789&pwd=test" >/dev/null 2>&1 || true

# Cleanup
echo "Removing temporary installation file..."
rm -f zoom_amd64.deb