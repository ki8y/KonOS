:: Administrator check
cls
@echo off
chcp 65001 >nul 2>&1
fltmc >nul 2>&1
if not %errorlevel% == 0 (
    PowerShell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

cls
@echo off
echo Disabling user protection service...
schtasks.exe /Change /TN "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity" /Disable
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UCPD" /v Start /t REG_DWORD /d 4 /f
sc config UCPD start= disabled
cls
mode con: cols=50 lines=30
echo [97;42mUCPD disbaled successfully.[0m
echo Your computer will need to be restarted 
echo to fully apply these changes.
echo.
echo Restart now?
echo [Y] Yes  [N] No
choice /c YN /n /m ":"
if %errorlevel%==1 goto shutdown /r -t 0
if %errorlevel%==2 goto exit