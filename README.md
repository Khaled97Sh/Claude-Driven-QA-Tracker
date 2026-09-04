# QA Tracker — Claude Edition

A single-file, no-backend QA test-case tracker built for Arabic-speaking (and English-speaking) QA teams. Import test cases from a JSON file, or let Claude generate them for you directly from an SRS document — then execute, track, and export them as polished PDF or CSV reports.

No build step, no server, no database. Everything runs from one HTML file, opened directly in a browser or served by a one-line local web server.

---

## ✨ Features

- **Bilingual UI (Arabic / English)** — full interface, generated content, and PDF exports all switch language and layout direction (RTL ⇄ LTR) with one click. Arabic is the default.
- **Two ways to get test cases in:**
  - **Manual JSON import** — copy a ready-made prompt into Claude.ai (or any AI assistant), paste in your SRS, save the JSON it returns, and drop it in. Works completely offline once loaded, no API key required.
  - **Automated generation** — sign in with your own Anthropic API key and upload an SRS document (`.txt`, `.md`, `.pdf`, or `.docx`) directly. The app calls the Claude API and builds your test-case tracker for you, no manual copy-paste needed.
- **Platform-aware filtering** — tag a project with the platforms it covers (Front-end, Back-end, CMS, Dashboard, Android, iOS, Security, Accessibility) and get matching filter tabs automatically.
- **Full execution tracking per test case** — status (pending / pass / fail / blocked / skip), device/OS, environment, notes, and an "Actual Result" field that only appears once a case is marked failed.
- **Google Drive attachments** — optionally sign in with Google to attach documentation/evidence files to individual test cases.
- **Manual case authoring** — add ad-hoc test cases straight from the tracker screen, without touching the source JSON.
- **Polished exports:**
  - **PDF** — a cover page with progress stats, grouped by section, styled and paginated, rendered client-side (no server round-trip).
  - **CSV** — full data dump including attachment links, ready for spreadsheets or other tools.
- **Modern "Glass & Depth" UI** — frosted-glass cards, soft shadows, gradient accents, with a light/dark theme toggle that remembers your preference.

---

## 🚀 Quick Start

### macOS
1. Double-click **`QA_Tracker_Launcher.app`**.
2. If macOS blocks it: right-click → **Open** → **Open Anyway**.
3. Your browser opens automatically at `http://localhost:8080/qa_tracker.html`.
4. To stop the app, close the Terminal window that opened.

### Windows
- **With a console window:** double-click **`QA_Tracker_Windows.bat`**.
- **Silently (no window):** double-click **`QA_Tracker_Windows.vbs`**. To stop it, open Task Manager and end the `python.exe` process.

Both require **Python 3** on your `PATH` ([download here](https://www.python.org) — check "Add Python to PATH" during install on Windows).

### Just open the file
`qa_tracker.html` is a normal static HTML file — you can also open it directly in any modern browser (double-click it, or drag it into a browser window) without any launcher or server at all.

---

## 📖 Usage

### Option A — Manual JSON import (no API key needed)
1. On the home screen, check the platforms this project covers.
2. Copy the **Claude Prompt** shown on screen, paste it into Claude.ai (or another AI chat) along with your SRS/feature spec.
3. Save the JSON it returns as `test_cases.json`.
4. Drag the file onto the drop zone (or click to browse) and hit **Load Test Cases**.

### Option B — Automated generation (your own Anthropic API key)
1. Click **Sign in with Claude**, paste an Anthropic API key ([get one here](https://console.anthropic.com/settings/keys)), and save.
2. Check the platforms this project covers.
3. Upload your SRS document (`.txt`, `.md`, `.pdf`, or `.docx`).
4. Click **Generate Test Cases** — Claude builds the tracker for you directly, no manual file handling.

From there, both paths land on the same tracker screen: expand a case, set its status, fill in execution details, attach files, and export a PDF or CSV whenever you like.

---

## ⚙️ Configuration & Privacy

- **Anthropic API key** (only needed for automated generation) is stored **only in your own browser's `localStorage`** — it is never sent anywhere except directly to `api.anthropic.com`, and the app itself has no backend to intercept it.
- **Google sign-in** (only needed for Drive file attachments) uses Google's own OAuth token flow; the token is kept in `sessionStorage` and cleared when the tab session ends.
- There is no server, no database, no analytics, and no data ever leaves your machine except the two API calls above, which you explicitly trigger.

---

## 🧱 How it works

This is intentionally a **single static HTML file** (`qa_tracker.html`) — all HTML, CSS, and JavaScript live in one place, with no build step or framework. External libraries are loaded from CDN at runtime:

| Library | Version | Purpose |
|---|---|---|
| [jsPDF](https://github.com/parallax/jsPDF) | 2.5.1 | PDF generation |
| [html2canvas](https://github.com/niklasvh/html2canvas) | 1.4.1 | Rendering the report to an image for the PDF |
| [pdf.js](https://mozilla.github.io/pdf.js/) | 2.16.105 | Extracting text from uploaded PDF specs |
| [Mammoth.js](https://github.com/mwilliamson/mammoth.js) | 1.7.0 | Extracting text from uploaded `.docx` specs |
| [Google Identity Services](https://developers.google.com/identity/gsi/web) | — | Optional Google sign-in for Drive attachments |

The included launchers (`QA_Tracker_Launcher.app`, `QA_Tracker_Windows.bat/.vbs`) just start Python's built-in `http.server` and open the file in your browser — nothing custom runs server-side.

---

## 📂 Project structure

```
qa_tracker.html            The entire app — open this directly
QA_Tracker_Launcher.app/   macOS double-click launcher
QA_Tracker_Windows.bat     Windows launcher (visible console)
QA_Tracker_Windows.vbs     Windows launcher (silent)
README.md                  This file
```

---

## 🤝 Contributing

Issues and pull requests are welcome. Since this is a single-file app, most changes will touch `qa_tracker.html` directly — please keep the "no build step, no framework" philosophy intact.

---

## 📄 License

Released under the [MIT License](LICENSE).
