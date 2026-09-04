#!/bin/bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$DIR/site"
cd "$PROJECT_DIR" || exit 1

if command -v python3 >/dev/null 2>&1; then
  PYTHON=python3
elif command -v python >/dev/null 2>&1; then
  PYTHON=python
else
  osascript -e 'display alert "QA Tracker" message "Python not found. Install from python.org"'
  exit 1
fi

open http://localhost:8080/qa_tracker.html &
"$PYTHON" -m http.server 8080
