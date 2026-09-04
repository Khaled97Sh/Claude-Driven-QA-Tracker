QA Tracker v3 — Launch Instructions
=====================================

MAC:
  1. Extract QA_Tracker_v3.zip
  2. Double-click QA_Tracker_Launcher.app
  3. If macOS blocks the app: right-click → Open → Open anyway
  4. Browser opens at http://localhost:8080/qa_tracker.html
  5. To stop: close the Terminal window that opened

WINDOWS:
  Option A — Double-click QA_Tracker_Windows.bat
    A Command Prompt window opens and the browser launches.
    Closing the Command Prompt stops the server.

  Option B — Double-click QA_Tracker_Windows.vbs
    Runs silently (no window). Browser launches automatically.
    To stop: open Task Manager → find python.exe → End Task.

REQUIREMENTS:
  Python 3 must be installed and on PATH.
  Download from: https://www.python.org
  Windows: check "Add Python to PATH" during installation.

WHAT'S NEW IN v3:
  • Platform filters updated: Frontend / CMS / Backend-API / Web (All)
  • Platform badges on every test card: 🖥️ Frontend  ⚙️ CMS  🔌 API  🌐 All
  • PDF export rewritten — pure text-based, proper Arabic RTL, no blank pages
  • JSON auto-repair: literal newline errors in Claude output are fixed automatically
  • CLAUDE PROMPT updated to new Frontend/CMS/API format

FILES:
  qa_tracker.html          — the app (open this directly too)
  QA_Tracker_Launcher.app  — Mac double-click launcher
  QA_Tracker_Windows.bat   — Windows launcher (shows window)
  QA_Tracker_Windows.vbs   — Windows launcher (silent)
  README.txt               — this file
