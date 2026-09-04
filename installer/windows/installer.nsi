; QA Tracker — Claude Edition — Windows installer
; Builds a one-click installer: per-user install (no admin/UAC prompt needed),
; Start Menu + Desktop shortcuts, bundled Python runtime (zero prerequisites),
; and an optional auto-launch on finish.
;
; Build with: makensis installer/windows/installer.nsi
; Requires installer/windows/python/ to exist first — run fetch_python_embed.sh,
; or just run build_installers.sh at the repo root, which does both steps.

!include "MUI2.nsh"

Name "QA Tracker — Claude Edition"
OutFile "..\..\dist\QA-Tracker-Claude-Edition-Setup.exe"
InstallDir "$LOCALAPPDATA\QATrackerClaudeEdition"
InstallDirRegKey HKCU "Software\QATrackerClaudeEdition" "InstallDir"
RequestExecutionLevel user
SetCompressor /SOLID lzma

; ── UI pages ──────────────────────────────────────────────────────────────────
!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_RUN "$INSTDIR\launcher.vbs"
!define MUI_FINISHPAGE_RUN_TEXT "Launch QA Tracker now"
!define MUI_FINISHPAGE_RUN_FUNCTION "LaunchApp"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"

; ── Install section ───────────────────────────────────────────────────────────
Section "Install"
  SetOutPath "$INSTDIR"

  File "..\..\qa_tracker.html"
  File "launcher.vbs"

  SetOutPath "$INSTDIR\python"
  File /r "python\*.*"

  SetOutPath "$INSTDIR"
  WriteRegStr HKCU "Software\QATrackerClaudeEdition" "InstallDir" "$INSTDIR"
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  CreateDirectory "$SMPROGRAMS\QA Tracker — Claude Edition"
  CreateShortcut "$SMPROGRAMS\QA Tracker — Claude Edition\QA Tracker.lnk" "wscript.exe" '"$INSTDIR\launcher.vbs"'
  CreateShortcut "$SMPROGRAMS\QA Tracker — Claude Edition\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
  CreateShortcut "$DESKTOP\QA Tracker.lnk" "wscript.exe" '"$INSTDIR\launcher.vbs"'
SectionEnd

; ── Uninstall section ─────────────────────────────────────────────────────────
Section "Uninstall"
  Delete "$INSTDIR\qa_tracker.html"
  Delete "$INSTDIR\launcher.vbs"
  RMDir /r "$INSTDIR\python"
  Delete "$INSTDIR\Uninstall.exe"
  RMDir "$INSTDIR"

  Delete "$DESKTOP\QA Tracker.lnk"
  Delete "$SMPROGRAMS\QA Tracker — Claude Edition\QA Tracker.lnk"
  Delete "$SMPROGRAMS\QA Tracker — Claude Edition\Uninstall.lnk"
  RMDir "$SMPROGRAMS\QA Tracker — Claude Edition"

  DeleteRegKey HKCU "Software\QATrackerClaudeEdition"
SectionEnd

; ── Finish-page "launch now" runs the launcher via wscript so no console flashes
Function LaunchApp
  Exec 'wscript.exe "$INSTDIR\launcher.vbs"'
FunctionEnd
