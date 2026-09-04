#!/bin/bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$DIR/site"
cd "$PROJECT_DIR" || exit 1

# Prefer a bundled, self-contained Python runtime (added by the .dmg installer build)
# so the app works with zero prerequisites. Fall back to whatever Python is already
# on the system, preserving the original no-bundle behavior if the bundle is absent.
ARCH="$(uname -m)"
BUNDLED_PYTHON="$DIR/python-runtime/$ARCH/bin/python3"

if [ -x "$BUNDLED_PYTHON" ]; then
  PYTHON="$BUNDLED_PYTHON"
elif command -v python3 >/dev/null 2>&1; then
  PYTHON=python3
elif command -v python >/dev/null 2>&1; then
  PYTHON=python
else
  osascript -e 'display alert "QA Tracker" message "Python not found. Install from python.org"'
  exit 1
fi

open http://localhost:8080/qa_tracker.html &
"$PYTHON" -m http.server 8080
