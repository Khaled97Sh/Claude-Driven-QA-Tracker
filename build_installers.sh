#!/bin/bash
# Builds both one-click installers (Windows .exe + macOS .dmg) in one command.
# Requires: `makensis` (brew install makensis), curl, unzip, tar, hdiutil (macOS only).
# Output lands in dist/ (not committed to git — see .gitignore).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$REPO_ROOT/dist"

echo "══════════════════════════════════════════"
echo " 1/4  Fetching bundled Python for Windows"
echo "══════════════════════════════════════════"
"$REPO_ROOT/installer/windows/fetch_python_embed.sh"

echo
echo "══════════════════════════════════════════"
echo " 2/4  Building Windows installer (.exe)"
echo "══════════════════════════════════════════"
if ! command -v makensis >/dev/null 2>&1; then
  echo "ERROR: makensis not found. Install with: brew install makensis" >&2
  exit 1
fi
(cd "$REPO_ROOT" && makensis installer/windows/installer.nsi)

echo
echo "══════════════════════════════════════════"
echo " 3/4  Fetching bundled Python for macOS"
echo "══════════════════════════════════════════"
"$REPO_ROOT/installer/macos/fetch_python_standalone.sh"

echo
echo "══════════════════════════════════════════"
echo " 4/4  Building macOS installer (.dmg)"
echo "══════════════════════════════════════════"
"$REPO_ROOT/installer/macos/build_dmg.sh"

echo
echo "══════════════════════════════════════════"
echo " Done — installers are in dist/:"
echo "══════════════════════════════════════════"
ls -la "$REPO_ROOT/dist"
