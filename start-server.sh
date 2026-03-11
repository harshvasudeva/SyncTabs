#!/bin/bash
echo "================================================"
echo "  SyncTabs Server - Setup & Start"
echo "================================================"
echo ""

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "[ERROR] Node.js is not installed or not in PATH."
    echo "Please install Node.js from https://nodejs.org"
    exit 1
fi

echo "[OK] Node.js found: $(node --version)"

NODE_MAJOR="$(node -p "process.versions.node.split('.')[0]")"
if [ "$NODE_MAJOR" -lt 24 ]; then
    echo "[ERROR] SyncTabs dev server requires Node.js 24 LTS."
    echo "Install Node.js 24 and try again."
    exit 1
fi

if [ "$NODE_MAJOR" -ge 25 ]; then
    echo "[ERROR] SyncTabs dev server is pinned to Node.js 24 LTS."
    echo "Switch to Node.js 24 for a supported development environment."
    exit 1
fi

# Install dependencies
echo ""
echo "[*] Installing server dependencies..."
cd "$(dirname "$0")/server"
npm install

if [ $? -ne 0 ]; then
    echo "[ERROR] Failed to install dependencies."
    exit 1
fi

echo ""
echo "[OK] Dependencies installed."
echo ""
echo "================================================"
echo "  Starting SyncTabs Server..."
echo "  Press Ctrl+C to stop."
echo "================================================"
echo ""

node server.js
