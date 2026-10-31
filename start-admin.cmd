@echo off
setlocal
cd /d "%~dp0"
where pwsh.exe >nul 2>nul
if errorlevel 1 (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0start-admin.ps1" %*
) else (
    pwsh.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0start-admin.ps1" %*
)
set "ADMIN_EXIT=%errorlevel%"
if not "%ADMIN_EXIT%"=="0" (
    echo Admin console failed to start. Review the error above.
    pause
)
exit /b %ADMIN_EXIT%
