# QA Tracker — Claude Edition

A single-file, no-backend QA test-case tracker built for Arabic-speaking (and English-speaking) QA teams. Import test cases from a JSON file, or let Claude generate them for you directly from an SRS document — then execute, track, and export them as polished PDF or CSV reports.

No build step, no server, no database. Everything runs from one HTML file, opened directly in a browser or served by a one-line local web server.

> **Note:** This is primarily a **manual testing** tool — you execute each test case yourself and record the result (pass/fail/blocked/skip). The one exception is API test cases generated from a real API collection, which can optionally be auto-executed and auto-verified (see [Live API test execution](#-live-api-test-execution) below) — everything else still requires you to test it yourself.

---

## ✨ Features

- **Bilingual UI (Arabic / English)** — full interface, generated content, and PDF exports all switch language and layout direction (RTL ⇄ LTR) with one click. Arabic is the default.
- **Two ways to get test cases in:**
  - **Manual JSON import** — copy a ready-made prompt into Claude.ai (or any AI assistant), paste in your SRS, save the JSON it returns, and drop it in. Works completely offline once loaded, no API key required.
  - **Automated generation** — sign in with your own Anthropic API key and upload an SRS document (`.txt`, `.md`, `.pdf`, or `.docx`) directly. The app calls the Claude API and builds your test-case tracker for you, no manual copy-paste needed.
- **Platform-aware filtering** — tag a project with the platforms it covers (Front-end, Back-end, API, CMS, Dashboard, Android, iOS, Security, Accessibility) and get matching filter tabs automatically.
- **Optional API collection input** — alongside the SRS, feed in an OpenAPI/Swagger JSON export or a Postman collection to generate precise, endpoint-accurate API test cases (real methods, paths, required fields, and status codes), tagged under their own dedicated **API** tab so they're easy to review separately from general backend cases. Works in both the manual-prompt and automated-generation flows, and is fully optional — everything still works from the SRS alone without one.
- **Full execution tracking per test case** — status (pending / pass / fail / blocked / skip), device/OS, environment, notes, and an "Actual Result" field that only appears once a case is marked failed.
- **Save & resume progress** — never lose a testing session. The tracker autosaves your progress (statuses, notes, actual results, attachments) to your browser as you work, and offers to resume it next time you open the app. For backup or moving to another machine, hit **💾 Save Project** any time to export everything as a `.qaproject.json` file, and drop it back into the **📁 Resume a Saved Project** box on the home screen to pick up exactly where you left off.
- **Search, bulk actions & spot-checks** — a search box filters cases instantly by ID/title/steps; "☑️ Select multiple" lets you mark a batch of cases Pass/Skip at once; "🎲 Spot-check" opens a dialog where you choose how many already-Passed cases to randomly re-verify (never automatic — you always pick the count).
- **Google Drive attachments** — optionally sign in with Google to attach documentation/evidence files to individual test cases.
- **File a bug straight from a failed case** — **📋 Copy as Bug Report** formats a failed case (steps, expected/actual result, environment) as clean Markdown, ready to paste anywhere. Optionally connect ClickUp (**🔌 Connect ClickUp**, off by default) to file it as a real task with one click instead — see [ClickUp integration](#-clickup-integration) below.
- **Live API test execution** — cases generated from a real API collection can carry the exact request to send and what a pass looks like, and can be run for real with a single click — see [below](#-live-api-test-execution).
- **Manual case authoring** — add ad-hoc test cases straight from the tracker screen, without touching the source JSON.
- **Polished exports:**
  - **PDF** — a cover page with progress stats, grouped by section, styled and paginated, rendered client-side (no server round-trip).
  - **CSV** — full data dump including attachment links, ready for spreadsheets or other tools.
- **Modern "Glass & Depth" UI** — frosted-glass cards, soft shadows, gradient accents, with a light/dark theme toggle that remembers your preference.

---

## 🐛 ClickUp integration

Fully optional and off by default — nothing about it happens automatically.

1. On the tracker screen, click **🔌 Connect ClickUp (optional)** in the top bar. This opens a dialog asking for your ClickUp **personal API token** ([get one here](https://app.clickup.com/settings/apps)) — sign-in is never automatic, so a shared computer never silently reuses someone else's connection. The token is kept only in `sessionStorage` (cleared when the tab/browser closes), never in `localStorage` and never written into a saved `.qaproject.json` file.
2. Right after connecting, pick which ClickUp **list** new bugs should go into — browse your real spaces/folders/lists, or create a new list on the spot. The chosen list travels with the saved project; the token/session never does, so reopening a project later just asks you to reconnect.
3. Once connected, every **failed** case shows a **🐛 Send to ClickUp** button plus an **assignee dropdown** — populated from the real members of that list, chosen independently per case (assign different bugs to different people). Filing a bug also auto-forwards any Google Drive attachments already on that case (screenshots/evidence) onto the new ClickUp task, and swaps the button for a **🔗 View in ClickUp** link so you can't accidentally file the same bug twice.
4. Bug descriptions sent to ClickUp (and the plain "Copy as Bug Report" text) render correctly right-to-left when the tracker is in Arabic mode.

If ClickUp's API ever blocks a direct browser connection (a CORS restriction on their side, outside this app's control), you'll see a clear error either way — **Copy as Bug Report** always works as a manual fallback.

---

## ▶ Live API test execution

When you generate test cases with a real API collection attached (see Option A/B below), Claude also fills in the exact request a collection-derived case needs and what counts as a pass — enabling that case to be run for real, not just described.

1. Open **⚙️ API Settings** in the tracker top bar and set the **Base URL** of the environment you want to actually test (never auto-filled or guessed — you always choose deliberately) and, if needed, a **Bearer Token**. The Base URL travels with the saved project; the token stays session-only, same privacy model as the ClickUp token.
2. Any case with a real request attached shows its own **▶ Run** button (strictly per-case — there's no "run everything at once"). Clicking it fires the real HTTP request and compares the live response's status code (and optionally its content) against what the case expects, automatically setting Pass/Fail and filling "Actual Result" with the real response.
3. **Safety guard, on by default:** GET requests run freely. Anything that could change data (POST/PUT/PATCH/DELETE) is locked — shown with a 🔒 icon instead of a Run button — until you explicitly tick "Allow data-changing requests" in API Settings and confirm a warning dialog.

Like ClickUp, this depends on your API sending proper CORS headers for direct browser requests — test one case first to confirm before relying on it broadly.

---

## 🚀 Quick Start

### One-click installers (recommended — no prerequisites needed)

Download the latest installer for your platform from the [**Releases**](../../releases/latest) page:

- **macOS** — download `QA-Tracker-Claude-Edition-macOS-AppleSilicon.dmg` (M1/M2/M3/M4 Macs) or `-Intel.dmg` (older Intel Macs — check via  → About This Mac), open it, drag **QA Tracker** into **Applications**, then double-click it there.
  - Includes its own bundled Python runtime, so it works even on a completely clean Mac.
  - First launch: Gatekeeper will say the app is from an unidentified developer — right-click the app → **Open** → **Open Anyway** (only needed once).
- **Windows** — download `QA-Tracker-Claude-Edition-Setup.exe` and run it. It installs to your user folder (no admin rights needed), adds Start Menu + Desktop shortcuts, and launches the app automatically when setup finishes.
  - Includes its own bundled Python runtime — no separate Python install needed.
  - First launch: Windows SmartScreen may say "Windows protected your PC" — click **More info** → **Run anyway** (only needed once, since this isn't a code-signed release).

Either way, the app opens automatically in your browser at `http://localhost:8080/qa_tracker.html` once installed.

### Prefer not to install anything? Run it in place instead

<details>
<summary>macOS — <code>QA_Tracker_Launcher.app</code></summary>

1. Double-click **`QA_Tracker_Launcher.app`**.
2. If macOS blocks it: right-click → **Open** → **Open Anyway**.
3. Your browser opens automatically at `http://localhost:8080/qa_tracker.html`.
4. To stop the app, close the Terminal window that opened.

Requires **Python 3** on your system (the installer above bundles its own, but this in-place launcher doesn't).
</details>

<details>
<summary>Windows — <code>.bat</code> / <code>.vbs</code></summary>

- **With a console window:** double-click **`QA_Tracker_Windows.bat`**.
- **Silently (no window):** double-click **`QA_Tracker_Windows.vbs`**. To stop it, open Task Manager and end the `python.exe` process.

Requires **Python 3** on your `PATH` ([download here](https://www.python.org) — check "Add Python to PATH" during install).
</details>

<details>
<summary>Just open the HTML file directly</summary>

`qa_tracker.html` is a normal static HTML file — you can open it directly in any modern browser (double-click it, or drag it into a browser window) without any launcher or server at all. Note: Google Sign-In and the Claude API calls require an `http://` origin to work correctly, so this route only fully works for the manual JSON-import flow without those two features.
</details>

### Building the installers yourself

The installers aren't committed to this repo (they're built artifacts, not source) — they're published on the [Releases](../../releases) page. To rebuild them yourself:

```bash
brew install makensis   # one-time, macOS only — lets you build the Windows installer too
./build_installers.sh
```

This downloads the bundled Python runtimes for each platform and produces both installers in `dist/`. See `installer/windows/` and `installer/macos/` for the individual build scripts.

---

## 📖 Usage

### Option A — Manual JSON import (no API key needed)
1. On the home screen, check the platforms this project covers.
2. Copy the **Claude Prompt** shown on screen, paste it into Claude.ai (or another AI chat) along with your SRS/feature spec. The prompt also has an optional slot for an API collection (OpenAPI/Swagger JSON or Postman export) — paste one in if you have it for more precise API test cases, or delete that section if you don't.
3. Save the JSON it returns as `test_cases.json`.
4. Drag the file onto the drop zone (or click to browse) and hit **Load Test Cases**.

### Option B — Automated generation (your own Anthropic API key)
1. Click **Sign in with Claude**, paste an Anthropic API key ([get one here](https://console.anthropic.com/settings/keys)), and save.
2. Check the platforms this project covers.
3. Upload your SRS document (`.txt`, `.md`, `.pdf`, or `.docx`).
4. Optionally, also upload an **API collection** — an OpenAPI/Swagger JSON export or a Postman collection — so Claude can generate precise API test cases from your real endpoints, methods, and fields instead of guessing them from prose. Fully optional; generation works the same without it.
5. Click **Generate Test Cases** — Claude builds the tracker for you directly, no manual file handling.

From there, both paths land on the same tracker screen: expand a case, set its status, fill in execution details, attach files, and export a PDF or CSV whenever you like.

---

## ⚙️ Configuration & Privacy

- **Anthropic API key** (only needed for automated generation) is stored **only in your own browser's `localStorage`** — it is never sent anywhere except directly to `api.anthropic.com`, and the app itself has no backend to intercept it.
- **Google sign-in** (only needed for Drive file attachments) uses Google's own OAuth token flow; the token is kept in `sessionStorage` and cleared when the tab session ends.
- **ClickUp personal API token** and the **API test-runner Bearer token** follow the same session-only model — kept in `sessionStorage`, never in `localStorage`, and never included in an exported `.qaproject.json` file. Both require reconnecting/re-entering after a browser restart.
- **Project autosave** also lives only in your browser's `localStorage` — tied to this browser on this machine, cleared if you clear site data. Export a `.qaproject.json` file (**💾 Save Project**) whenever you want a durable backup or need to continue on a different machine/browser.
- There is no server, no database, no analytics, and no data ever leaves your machine except the API calls above (Anthropic, Google Drive, ClickUp, and — only if you set one up — your own API under test), all of which you explicitly trigger.

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
QA_Tracker_Launcher.app/   macOS double-click launcher (run in place)
QA_Tracker_Windows.bat     Windows launcher (visible console, run in place)
QA_Tracker_Windows.vbs     Windows launcher (silent, run in place)
installer/                Sources for the one-click installers (see Releases for the built files)
  windows/                 NSIS installer script + Windows launcher + Python-fetch script
  macos/                   .dmg build script + Python-fetch script
build_installers.sh        Builds both installers in one command
README.md                  This file
```

---

## 🤝 Contributing

Issues and pull requests are welcome. Since this is a single-file app, most changes will touch `qa_tracker.html` directly — please keep the "no build step, no framework" philosophy intact. `main` is protected — changes go through a pull request rather than a direct push.

---

## 📄 License

Released under the [MIT License](LICENSE).
