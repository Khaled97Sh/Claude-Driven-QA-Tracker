@echo off
title QA Tracker
cd /d "%~dp0"

REM ── Find Python ──────────────────────────────────────────────
set PYTHON=
for %%i in (python3 python py) do (
    %%i --version >nul 2>&1
    if not errorlevel 1 (
        set PYTHON=%%i
        goto :found
    )
)
echo.
echo  Python غير مثبت على هذا الجهاز.
echo  يرجى تحميل وتثبيت Python 3 من: https://python.org
echo  تأكد من تفعيل خيار "Add Python to PATH" أثناء التثبيت.
echo.
pause
exit /b 1

:found
REM ── Kill any previous server on port 8080 ────────────────────
for /f "tokens=5" %%a in ('netstat -aon 2^>nul ^| find ":8080 "') do (
    taskkill /F /PID %%a >nul 2>&1
)

REM ── Start server ─────────────────────────────────────────────
echo  QA Tracker يعمل على http://localhost:8080/qa_tracker.html
echo  اغلق هذه النافذة لإيقاف السيرفر.
echo.
start "" "http://localhost:8080/qa_tracker.html"
%PYTHON% -m http.server 8080
