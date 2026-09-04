#!/bin/bash
# Assembles a self-contained copy of QA_Tracker_Launcher.app for each Mac
# architecture (Apple Silicon and Intel), each with only its own matching
# Python runtime bundled in (so it needs zero prerequisites), and packages
# each into its own drag-to-Applications .dmg. Shipping two smaller,
# arch-specific images instead of one universal one keeps each download
# roughly half the size, since nobody needs both runtimes at once.
#
# Prerequisite: run installer/macos/fetch_python_standalone.sh first (or let
# build_installers.sh at the repo root do it for you).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
RUNTIME_DIR="$SCRIPT_DIR/runtime"
DIST_DIR="$REPO_ROOT/dist"
APP_NAME="QA_Tracker_Launcher.app"
VOLUME_NAME="QA Tracker — Claude Edition"

if [ ! -x "$RUNTIME_DIR/arm64/bin/python3" ] || [ ! -x "$RUNTIME_DIR/x86_64/bin/python3" ]; then
  echo "ERROR: bundled Python runtimes not found. Run installer/macos/fetch_python_standalone.sh first." >&2
  exit 1
fi

mkdir -p "$DIST_DIR"

build_one() {
  local arch="$1"        # arm64 | x86_64
  local dmg_name="$2"
  local stage_dir="$REPO_ROOT/.dmg_stage_$arch"
  local dmg_root="$REPO_ROOT/.dmg_root_$arch"

  echo "── Building for $arch ─────────────────────────────"
  rm -rf "$stage_dir" "$dmg_root"
  mkdir -p "$stage_dir"
  cp -R "$REPO_ROOT/$APP_NAME" "$stage_dir/$APP_NAME"

  local resources="$stage_dir/$APP_NAME/Contents/Resources"
  mkdir -p "$resources/python-runtime"
  cp -R "$RUNTIME_DIR/$arch" "$resources/python-runtime/$arch"

  echo "Staged app size ($arch):"
  du -sh "$stage_dir/$APP_NAME"

  mkdir -p "$dmg_root"
  cp -R "$stage_dir/$APP_NAME" "$dmg_root/$APP_NAME"
  ln -s /Applications "$dmg_root/Applications"

  rm -f "$DIST_DIR/$dmg_name"
  hdiutil create -volname "$VOLUME_NAME" -srcfolder "$dmg_root" -ov -format UDZO "$DIST_DIR/$dmg_name"

  rm -rf "$stage_dir" "$dmg_root"
  echo "Done: $DIST_DIR/$dmg_name"
  ls -la "$DIST_DIR/$dmg_name"
}

build_one "arm64" "QA-Tracker-Claude-Edition-macOS-AppleSilicon.dmg"
build_one "x86_64" "QA-Tracker-Claude-Edition-macOS-Intel.dmg"
