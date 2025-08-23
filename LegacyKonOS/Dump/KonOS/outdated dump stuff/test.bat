@echo off
setlocal

:: Check if Windows is activated using PowerShell (LicenseStatus = 1 means activated)
for /f %%A in ('powershell -NoProfile -Command "(Get-CimInstance -Query \"SELECT * FROM SoftwareLicensingProduct WHERE PartialProductKey IS NOT NULL\").LicenseStatus -contains 1"') do set "activated=%%A"

if /i "%activated%"=="True" (
    echo Windows is activated. Hurray!
	pause
    goto :eof
) else (
    echo Windows is NOT activated.
    echo Opening Activation Settings...
    start ms-settings:activation
)
pause >nul