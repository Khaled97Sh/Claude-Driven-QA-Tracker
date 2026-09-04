#!/bin/bash
# Assembles a self-contained copy of QA_Tracker_Launcher.app (with both macOS Python
# runtimes bundled in, so it needs zero prerequisites) and packages it into a
# drag-to-Applications .dmg.
#
# Prerequisite: run installer/macos/fetch_python_standalone.sh first (or let
# build_installers.sh at the repo root do it for you).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
RUNTIME_DIR="$SCRIPT_DIR/runtime"
DIST_DIR="$REPO_ROOT/dist"
STAGE_DIR="$REPO_ROOT/.dmg_stage"
APP_NAME="QA_Tracker_Launcher.app"
DMG_NAME="QA-Tracker-Claude-Edition-macOS.dmg"
VOLUME_NAME="QA Tracker — Claude Edition"

if [ ! -x "$RUNTIME_DIR/arm64/bin/python3" ] || [ ! -x "$RUNTIME_DIR/x86_64/bin/python3" ]; then
  echo "ERROR: bundled Python runtimes not found. Run installer/macos/fetch_python_standalone.sh first." >&2
  exit 1
fi

echo "Staging a self-contained copy of $APP_NAME..."
rm -rf "$STAGE_DIR"
mkdir -p "$STAGE_DIR"
cp -R "$REPO_ROOT/$APP_NAME" "$STAGE_DIR/$APP_NAME"

RESOURCES="$STAGE_DIR/$APP_NAME/Contents/Resources"
mkdir -p "$RESOURCES/python-runtime"
cp -R "$RUNTIME_DIR/arm64" "$RESOURCES/python-runtime/arm64"
cp -R "$RUNTIME_DIR/x86_64" "$RESOURCES/python-runtime/x86_64"

echo "Staged app size:"
du -sh "$STAGE_DIR/$APP_NAME"

mkdir -p "$DIST_DIR"
rm -f "$DIST_DIR/$DMG_NAME"

echo "Building $DMG_NAME..."
STAGE_DMG_DIR="$REPO_ROOT/.dmg_root"
rm -rf "$STAGE_DMG_DIR"
mkdir -p "$STAGE_DMG_DIR"
cp -R "$STAGE_DIR/$APP_NAME" "$STAGE_DMG_DIR/$APP_NAME"
ln -s /Applications "$STAGE_DMG_DIR/Applications"

hdiutil create -volname "$VOLUME_NAME" -srcfolder "$STAGE_DMG_DIR" -ov -format UDZO "$DIST_DIR/$DMG_NAME"

rm -rf "$STAGE_DIR" "$STAGE_DMG_DIR"

echo "Done: $DIST_DIR/$DMG_NAME"
ls -la "$DIST_DIR/$DMG_NAME"
