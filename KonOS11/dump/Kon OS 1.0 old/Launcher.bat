@echo off
set ESC=[
cls
title Welcome To Kon OS.
echo.
echo                                              ╭──────────────────────────╮
echo                                              │    Welcome To Kon OS.    │
echo                                              ╰──────────────────────────╯
echo.
echo Ready to install?
choice /c YN7 /n /m "[Y] Yes  [N] No"
if %errorlevel%==1 goto AdminCheck
if %errorlevel%==2 exit

:: Administrator check
:AdminCheck
cls
fltmc >nul 2>&1

if not %errorlevel% == 0 (
    title Please run this as admin!
    echo.
    echo                                              ╭──────────────────────────╮
    echo                                              │    Missing Privileges    │
    echo                                              ╰──────────────────────────╯
    echo.
    echo [⚠ ] To install Kon OS, you'll need %ESC%4m%ESC%31m administrator %ESC%0m privileges.
    timeout /t 3 >nul 
    chcp 437 >nul 2>&1
    PowerShell -Command "Start-Process -FilePath '%~f0' -Verb RunAs" >nul
    exit /b
    exit
)



:: ============Restore point============
:RestorePoint
chcp 65001 >nul
title Restore points!
color 9
echo. %esc%97m
echo                                             ╭──────────────────────────╮
echo                                             │      Restore Points      │
echo                                             ╰──────────────────────────╯%esc%0m
echo.
echo [i] Creating a restore point is **highly recommended** to avoid potential damage to your system.
echo.
echo Create a restore point?
choice /c YN7 /n /m "[Y] Yes  [N] No: "
if %errorlevel%==1 goto CreateRestorePoint
if %errorlevel%==2 goto SkipRestorePointCHECK
if %errorlevel%==3 goto SkipRestorePointCONFIRM

:CreateRestorePoint
cls
echo Enabling restore point if it isn't already enabled...
chcp 437 >nul 2>&1
powershell -Command "Enable-ComputerRestore -Drive \"C:\\\""
chcp 65001 >nul
echo %ESC%92m✓ Done.
timeout /t 1 >nul
cls && echo Creating your restore point...
:: gets rid of restore point cooldown
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul
:: make da restore point 
chcp 437 >nul 2>&1
powershell -Command "Checkpoint-Computer -Description 'Pre-Kon OS Restore Point'"
chcp 65001 >nul
echo Restore point created!
echo It's name is: "Pre-Kon OS Restore Point".
timeout /t 3 >nul
goto defendercheck

:SkipRestorePointCHECK
chcp 437 >nul 2>&1
color c
cls && echo %ESC%31m(^^!) Are you sure?%ESC%97m
timeout /t 1 >nul /nobreak
echo %ESC%97mIf you don't create a restore point, you %ESC%4m%ESC%31mCAN'T GO BACK%ESC%0m to your old Windows instance without reinstalling.%esc%0m
echo It's strongly advised to create a restore point before tweaking your Windows instance, in case something goes wrong.
timeout /t 2 >nul /nobreak
echo.
echo Ignore risks?
timeout /t 1 >nul /nobreak
echo %ESC%31m(Y) Yes, I'm sure...
timeout /t 1 >nul /nobreak
echo %ESC%32m(N) No, create the restore point.%ESC%97m
echo.
choice /c YN /n /m ":"
if %errorlevel%==1 goto SkipRestorePointCONFIRM
if %errorlevel%==2 goto CreateRestorePoint

:SkipRestorePointCONFIRM
color 4
cls && echo (^^!) Not creating a restore point.
echo **Use at your own risk!!! I am not responsible for any harm done to your computer!**
timeout /t 3 >nul
goto defendercheck


:: check if defender is enabled
:defendercheck
sc query "WinDefend" | find "STATE" | find "RUNNING" >nul
if not errorlevel 1 (
    goto :defenderheh
) else ( 
    goto :driverTweaks
)

:defenderheh
cls
title Defender Detected
color 9
echo.
echo                                          ╭─────────────────────────────╮
echo                                          │ Windows Defender is enabled │
echo                                          ╰─────────────────────────────╯
echo.
timeout /t 1 >nul
echo To disable Windows defender, click on "Virus and threat protection". Then click "Manage settings".
echo Then disable all the settings.
timeout /t 2 >nul
start "" "windowsdefender://"
echo When step 1 is complete, press any key to continue.
pause >nul
echo.
echo Now, disable it for good using a tool called "Defender Control" (or "dcontrol" for short)
timeout /t 1 >nul
echo Installing dcontrol...
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/Modules/DefenderControl.exe"
set "name=dControl.exe"
mkdir "c:\Kon OS\Modules\dcontrol"
set "location=C:\Kon OS\Modules\Dcontrol"
curl -s -L "%file%" -o "%location%\%name%"
:: buffer so it doesnt try to open nothing. prob shouldnt happen but batch never works the way i want
start "" "C:\Kon OS\Modules\Dcontrol\dControl.exe"
timeout /t 1 >nul
echo.
echo After dcontrol opens, click on "Disable Windows Defender". When it turns red, click any key to continue.
pause >nul


:: Disable modern standby (i think)
reg add "HKLM\System\CurrentControlSet\Control\Power" /v PlatformAoAcOverride /t REG_DWORD /d 0 /f

:: UCPD check.. ass pain of doom 🙄
echo Making sure the User Choice Protection Driver is not running...
timeout /t 1 >nul
setlocal
set "ServiceName=ucpd"
for /f "tokens=3 delims=: " %%A in ('sc query "%ServiceName%" ^| findstr "STATE"') do (
    if /I "%%A" NEQ "RUNNING" (
        cls
        echo UPCD is disabled. Continuing...
        timeout /t 1 >nul
        goto :Restart
    )
)
echo UCPD Detected! Disabling it now...
schtasks /Change /TN "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity" /Disable >nul 2>&1 
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UCPD" /v Start /t REG_DWORD /d 4 /f >nul 2>&1  
sc config UCPD start= disabled >nul 2>&1

:: ADD KON OS SETUP 2 HERE.
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "KonOS" /t REG_SZ /d "C:\Kon OS\Tools\Timer Resolution\SetTimerResolution.exe" /f

mode con: cols=43 lines=20
cls
echo.
echo       ╭─────────────────────────────╮
echo       │  Setup Phase 1/3 Complete!  │
echo       ╰─────────────────────────────╯           
echo.     
echo %esc%38;5;46m[ ⚠️ ] %esc%97mRestarting your PC in 5 seconds...
timeout /t 1 /nobreak >nul
echo %esc%38;5;190m[ ⚠️ ] %esc%97mRestarting your PC in 4 seconds...
timeout /t 1 /nobreak >nul
echo %esc%38;5;220m[ ⚠️ ] %esc%97mRestarting your PC in 3 seconds...
timeout /t 1 /nobreak >nul
echo %esc%38;5;202m[ ⚠️ ] %esc%97mRestarting your PC in 2 seconds...
timeout /t 1 /nobreak >nul
echo %esc%38;5;196m[ ⚠️ ] %esc%97mRestarting your PC in 1 second...
timeout /t 1 /nobreak >nul
:: shutdown -r /t 0
pause >nul