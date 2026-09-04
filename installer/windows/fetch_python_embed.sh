#!/bin/bash
# Downloads the official Windows "embeddable" Python distribution (designed by
# python.org specifically for bundling into other applications — no installation
# step, no registry entries) and unpacks it into installer/windows/python/.
#
# Build-time only — not committed to git (see .gitignore), regenerated whenever
# installers are built.
set -euo pipefail

PY_VERSION="3.12.7"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="$SCRIPT_DIR/python"
ZIP_URL="https://www.python.org/ftp/python/${PY_VERSION}/python-${PY_VERSION}-embed-amd64.zip"
TMP_ZIP="$SCRIPT_DIR/.tmp-python-embed.zip"

echo "Downloading Python ${PY_VERSION} embeddable distribution for Windows..."
curl -sL --fail "$ZIP_URL" -o "$TMP_ZIP"

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"
unzip -q "$TMP_ZIP" -d "$OUT_DIR"
rm -f "$TMP_ZIP"

if [ ! -f "$OUT_DIR/python.exe" ]; then
  echo "ERROR: expected $OUT_DIR/python.exe not found after extraction" >&2
  exit 1
fi

echo "Done. Size:"
du -sh "$OUT_DIR"
echo "Contents:"
ls "$OUT_DIR"
