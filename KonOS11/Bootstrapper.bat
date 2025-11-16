@echo off
:: Download code here

:: Change this to C:\Kon OS\Initialization later on.
pwsh -ExecutionPolicy Unrestricted -NoProfile -File "%~dp0KonOS.ps1"
rmdir /s /q "%systemDrive%\Kon OS\KonOS.ps1"