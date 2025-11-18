@echo off
mkdir "%systemDrive%\Kon OS\Setup" >nul 2&>1"

if exist "%systemDrive%\Kon OS\Dependencies" (
  goto startscript
  pause
) else (
  curl -s -L "https://raw.githubusercontent.com/ki8y/KonOS/experimental/KonOS11/CheckForDependencies.bat" -o "%systemDrive%\Kon OS\Setup\CheckForDependencies.bat"
  call "%systemDrive%\Kon OS\Setup\CheckForDependencies.bat"
)

:startscript
curl -s -L "https://raw.githubusercontent.com/ki8y/KonOS/experimental/KonOS11/KonOS.ps1" -o "%systemDrive%\Kon OS\Setup\KonOS.ps1"
pwsh -Command "Unblock-File -Path '%systemDrive%\Kon OS\Setup\KonOS.ps1'; Unblock-File -Path '%~f0'"
pwsh -ExecutionPolicy Unrestricted -NoProfile -File "%systemDrive%\Kon OS\Setup\KonOS.ps1"
rmdir /s /q "%systemDrive%\Kon OS\temp"



