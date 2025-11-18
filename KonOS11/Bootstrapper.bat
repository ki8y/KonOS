@echo off
:: Download code here
:: Change this to C:\Kon OS\Initialization later on.

if exist "%systemdrive\Kon OS\Setup\Dependencies" (
  goto startscript
  pause
) else (
  curl %putdependenciesfilehere%
  call "%~dp0Install Dependencies.bat"
)

:startscript
pwsh -Command "Unblock-File -Path '%~dp0KonOS.ps1'; Unblock-File -Path '%~f0'"
pwsh -ExecutionPolicy Unrestricted -NoProfile -File "%~dp0KonOS.ps1"
rmdir /s /q "%systemDrive%\Kon OS\KonOS.ps1"
