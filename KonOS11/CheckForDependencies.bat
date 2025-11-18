@echo off
mkdir "%systemdrive\Kon OS\Setup\Dependencies" >nul 2>&1
fltmc >nul 2>&1
if not %errorlevel% == 0 (
    curl -s -L "https://raw.githubusercontent.com/ki8y/KonOS/experimental/KonOS11/CheckForDependencies.ps1" -o "%systemDrive%\Kon OS\Setup\Dependencies\CheckForDependencies.ps1"
    PowerShell -Command "Start-Process -FilePath '%~f0' -Verb RunAs" >nul
    exit
)
PowerShell -ExecutionPolicy Bypass -NoProfile -File "%systemDrive\Kon OS\Setup\Dependencies\CheckForDependencies.ps1"
