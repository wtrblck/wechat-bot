@echo off
setlocal
cd /d "%~dp0"
where pwsh.exe >nul 2>nul
if errorlevel 1 (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0start-bot.ps1" %*
) else (
    pwsh.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0start-bot.ps1" %*
)
set "BOT_START_EXIT=%errorlevel%"
if not "%BOT_START_EXIT%"=="0" echo Startup failed. See agent\data\startup logs.
pause
exit /b %BOT_START_EXIT%
