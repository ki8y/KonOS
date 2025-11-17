@echo off
:: Download code here
:: Change this to C:\Kon OS\Initialization later on.
pwsh -Command "Unblock-File -Path '%~dp0KonOS.ps1'; Unblock-File -Path '%~f0'"
pwsh -ExecutionPolicy Unrestricted -NoProfile -File "%~dp0KonOS.ps1"
rmdir /s /q "%systemDrive%\Kon OS\KonOS.ps1"
