#!/bin/bash
set -e

# SyncTabs Safari Extension Build Script

WORK_DIR=$(pwd)
SAFARI_DIR="$WORK_DIR/safari/SyncTabs"
BUILD_DIR="$SAFARI_DIR/build"
ARCHIVE_PATH="$BUILD_DIR/SyncTabs.xcarchive"
APP_BUNDLE="$ARCHIVE_PATH/Products/Applications/SyncTabs.app"
DIST_DIR="$WORK_DIR/dist"

echo "Building Safari Web Extension wrapper for SyncTabs..."

# Clean previous builds
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
mkdir -p "$DIST_DIR"

# Build archive using xcodebuild
echo "Running xcodebuild archive..."
xcodebuild -project "$SAFARI_DIR/SyncTabs.xcodeproj" \
           -scheme "SyncTabs" \
           -configuration Release \
           -archivePath "$ARCHIVE_PATH" \
           archive

if [ ! -d "$APP_BUNDLE" ]; then
    echo "Error: App bundle not found at $APP_BUNDLE"
    exit 1
fi

# Package into a zip for distribution
echo "Packaging into zip..."
cd "$ARCHIVE_PATH/Products/Applications"
zip -qry "$DIST_DIR/SyncTabs-Safari.zip" "SyncTabs.app"

echo "Done! Safari application zip available at dist/SyncTabs-Safari.zip"
