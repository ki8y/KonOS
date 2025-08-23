@echo off
setlocal

:: Replace "ucpd" with the actual service name if different
set "ServiceName=ucpd"

:: Check if the service is running
for /f "tokens=3 delims=: " %%A in ('sc query "%ServiceName%" ^| findstr "STATE"') do (
    if /I "%%A" NEQ "RUNNING" (
        echo [%ServiceName%] Service is not running.
        timeout /t 3 >nul
        exit /b
    )
)

:: Service is running, continue with script
echo [%ServiceName%] Service is running.
pause