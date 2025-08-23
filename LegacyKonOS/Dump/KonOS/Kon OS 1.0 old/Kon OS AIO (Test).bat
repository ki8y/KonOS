:: Administrator check
cls
@echo off
title Loading...
PowerShell -Command "chcp 65001 > $null 2>&1"
fltmc >nul 2>&1
if not %errorlevel% == 0 (
    title Please run this as admin!
    echo. [33m [0m 
    echo                                              ╭──────────────────────────╮
    echo                                              │ ⚠  Missing Privileges ⚠  │
    echo                                              ╰──────────────────────────╯
    echo.
    echo To install Kon OS, you'll need [4madministrator[0m privileges.
    timeout /t 3 >nul 
    chcp 437 >nul 2>&1
    PowerShell -Command "Start-Process -FilePath '%~f0' -Verb RunAs" >nul
    exit /b
    exit
)

mode con: cols=69 lines=3
cls
chcp 65001 >nul 2>&1
setlocal EnableDelayedExpansion
echo.
set "bar=[                    ]"
set /a i=1
set "barWidth=50"
set "total=100"
set "pad=                                                  "  :: 50+ spaces
for /L %%i in (1,1,%total%) do (
    set /a percent=%%i
    set /a filled=percent * barWidth / 100

    set "bar=      [[38;5;99m"
    for /L %%b in (1,1,!filled!) do set "bar=!bar!█"
    set /a next=filled + 1
    for /L %%b in (!next!,1,%barWidth%) do set "bar=!bar!·"

    set "bar=!bar![97m] !percent!%%"

    set "line=!bar!!pad!"
    set "line=!line:~0,80!"

    call :sleep
    <nul set /p=[G!line!
)
chcp 437 >nul 2>&1
endlocal

:: find windows version
setlocal enabledelayedexpansion
for /f %%i in ('powershell -Command "[System.Environment]::OSVersion.Version.Build"') do set build=%%i


chcp 65001 >nul 2>&1
mode con: cols=120 lines=30

if %build% GEQ 26100 (
    cls
    title Hudson Valley Detected! [%build%]
    echo.
    echo                                             ╭───────────────────────────╮
    echo                                             │ Windows 11 [33m24H2[0m detected^^! │
    echo                                             ╰───────────────────────────╯
    echo.
    echo I'm still experimenting with 24H2, so expect this version of Windows to be
    echo buggier, slower, and generally more of a pain in the ass.
    echo.
    echo It'll PROBABLY be okay, but I don't wanna disappoint you just in case.
    echo.
    echo [33mPress any key to proceed anyway.[0m
    pause >nul
) else if %build% GEQ 22621 (
    goto KonOS
) else if %build% GEQ 22000 (
    chcp 65001 >nul 2>&1
    cls
    title Redstone 5 Detected
    color 9
    echo                                             ╭───────────────────────────╮
    echo                                             │ Windows 11 [31m21H2[0m detected^^! │
    echo                                             ╰───────────────────────────╯
    echo.
    echo Windows 11 21H2 is an older version of Windows.
    echo This version of Windows is unsupported by Microsoft, missing features, and is half broken.
    echo Unless you absolutely NEED 21H2, it's highly recommended to switch to 22H2 instead.
    echo.
    echo [33mPress any key to proceed anyway.[0m
    pause >nul
    color F
) else if %build% GEQ 19042 (
    goto KonOS
) else if %build% GEQ 17763 (
    cls
    title Redstone 5 Detected
    echo                                             ╭───────────────────────────╮
    echo                                             │ Windows 10 [33m1809[0m detected^^! │
    echo                                             ╰───────────────────────────╯
    echo.
    echo Windows 10 1809 is an older version of Windows.
    echo It may not be optimized for newer games, or missing newer features.
    echo.
    echo [33mPress any key to proceed anyway.[0m
    pause >nul
) else (
    goto KonOS
)
endlocal
goto KonOS

:: UCPD check.. ass pain of doom 🙄
echo Double checking to make sure the User Choice Protection Driver is not running...
timeout /t 1 >nul
setlocal
set "ServiceName=ucpd"
for /f "tokens=3 delims=: " %%A in ('sc query "%ServiceName%" ^| findstr "STATE"') do (
    if /I "%%A" NEQ "RUNNING" (
        cls
        echo UPCD is disabled. Continuing...
        timeout /t 1 >nul
        goto :KonOS
    )
)
schtasks /Change /TN "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity" /Disable
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UCPD" /v Start /t REG_DWORD /d 4 /f
sc config UCPD start= disabled
cls
echo.
echo                                             ╭───────────────────────────╮
echo                                             │ !     UCPD Detected     ! │
echo                                             ╰───────────────────────────╯
echo.
echo User Choice Protection Driver is running. It needs to be disabled for Kon OS to continue.
echo Good news is, this has already been done for you. The bad news is, this service
echo is super stubborn, and disabling it requires a PC restart.
echo.
echo Restart now?
choice /c YN /n /m "[Y] Yes  [N] No: "
if %errorlevel%==1 shutdown /r -t 0 && pause >nul
if %errorlevel%==2 exit


endlocal

:KonOS
chcp 65001 >nul 2>&1
cls
color f
Title Kon OS
echo.[38;5;99m
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.                                      ██╗  ██╗ ██████╗ ███╗   ██╗     ██████╗ ███████╗
echo.                                      ██║ ██╔╝██╔═══██╗████╗  ██║    ██╔═══██╗██╔════╝
echo.                                      █████╔╝ ██║   ██║██╔██╗ ██║    ██║   ██║███████╗
echo.                                      ██╔═██╗ ██║   ██║██║╚██╗██║    ██║   ██║╚════██║
echo.                                      ██║  ██╗╚██████╔╝██║ ╚████║    ╚██████╔╝███████║
echo.                                      ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚══════╝
echo.                           
echo.                                ╔══════════════════════════════════════════════════════════╗
echo.                                ║             [97mAll-In-One Windows Modding Tool.[38;5;99m             ║
echo.                                ╚══════════════════════════════════════════════════════════╝
echo.
echo.
echo.
echo.
echo.
echo.
echo   ╭─────────────╮
echo   │  [97mv0.95 AIO[38;5;99m  │
echo   ╰─────────────╯ 
timeout /t 3 >nul
cls

:: ============Restore point============
:RestorePoint
title Restore points!
color 9
echo.
echo                                             ╭───────────────────────────╮
echo                                             │ 🛈     Restore Points      │
echo                                             ╰───────────────────────────╯
echo.
echo Creating a restore point is **highly recommended** to avoid potential damage to your system.
echo.
echo Create a restore point?
choice /c YN7 /n /m "[Y] Yes  [N] No: "
if %errorlevel%==1 goto CreateRestorePoint
if %errorlevel%==2 goto SkipRestorePointCHECK
if %errorlevel%==3 goto SkipRestorePointCONFIRM

:CreateRestorePoint
cls
chcp 437 >nul 2>&1
echo Enabling restore point if it isn't already enabled...
powershell -Command "Enable-ComputerRestore -Drive \"%SYSTEMDRIVE%\\\""
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul
timeout /t 1 >nul
cls && echo Creating your restore point...
:: gets rid of restore point cooldown
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul
:: make da restore point 
powershell -Command "Checkpoint-Computer -Description 'Pre Kon OS Restore Point'"
echo Restore point created!
echo If needed, it's named: "Pre Kon OS Restore Point".
timeout /t 3 >nul
goto defendercheck

:SkipRestorePointCHECK
chcp 437 >nul 2>&1
color c
cls && echo [31m(^^!) Are you sure?[97m
timeout /t 1 >nul /nobreak
echo [97;41m**Creating a system restore point is highly recommended to avoid further complications if anything goes wrong!!**[0m
timeout /t 2 >nul /nobreak
echo.
echo Ignore risks?
timeout /t 1 >nul /nobreak
echo [31m(Y) Yes, I'm sure...
timeout /t 1 >nul /nobreak
echo [32m(N) No, create the restore point.[97m
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
mkdir "%SYSTEMDRIVE%\Kon OS\Modules\dcontrol"
set "location=%SYSTEMDRIVE%\Kon OS\Modules\Dcontrol"
curl -s -L "%file%" -o "%location%\%name%"
:: buffer so it doesnt try to open nothing. prob shouldnt happen but batch never works the way i want
start "" "%SYSTEMDRIVE%\Kon OS\Modules\Dcontrol\dControl.exe"
timeout /t 1 >nul
echo.
echo After dcontrol opens, click on "Disable Windows Defender". When it turns red, click any key to continue.
pause >nul

:: scare the user a bit.. lol
taskkill /f /im explorer.exe >nul 2>&1

:: fix windows update so it doesnt include drivers
:driverTweaks
cls
color 6
title Kon OS
echo Disabling driver updates from Windows Update...
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate" /v value /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v DontSearchWindowsUpdate /t REG_DWORD /d 1 /f
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul
timeout /t 1 >nul

:: ============Installs general stuff.============
chcp 437 >nul
REM Wifi Enabler
cls
color f
echo Just installing some stuff...
REM OOShutUp10
echo.
echo OOShutUp10 (and the config)...
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/Modules/OOShutUp10/config.cfg"
set "name=config.cfg" 
mkdir "%SYSTEMDRIVE%\Kon OS\Modules\OOShutUp10"
set "location=%SYSTEMDRIVE%\Kon OS\Modules\OOShutUp10"
curl -s -L "%file%" -o "%location%\%name%"
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/Modules/OOShutUp10/OOSU10.exe"
set "name=OOSU10.exe" 
curl -s -L "%file%" -o "%location%\%name%"
:: FIXES
REM GameDVR Fixer

REM Alt+Tab toggler thing
echo.
echo Intalling ALT+TAB scripts...
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/Windows-Settings/AltTab/DefaultAltTab.bat"
set "name=Default Alt+Tab Switcher.cmd" 
mkdir "%SYSTEMDRIVE%\Kon OS\Windows Settings\Alt-Tab Switcher"
set "location=%SYSTEMDRIVE%\Kon OSWindows Settings\Alt-Tab Switcher"
curl -s -L "%file%" -o "%location%\%name%"
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/Windows-Settings/AltTab/LegacyAltTab.bat"
set "name=Legacy Alt+Tab Switcher (Kon OS Default).cmd"
curl -s -L "%file%" -o "%location%\%name%"
REM Bluetooth Toggler
echo.
echo Installing Bluetooth scripts...
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/Windows-Settings/Bluetooth/DisableBluetooth.bat"
set "name=Disable Bluetooth (Kon OS Default).cmd" 
mkdir "%SYSTEMDRIVE%\Kon OS\Windows Settings\Bluetooth"
set "location=%SYSTEMDRIVE%\Kon OS\Windows Settings\Bluetooth"
curl -s -L "%file%" -o "%location%\%name%"
set "file=ttps://raw.githubusercontent.com/ki8y/Tweaks/main/Windows-Settings/Bluetooth/EnableBluetooth.bat"
set "name=Enable Bluetooth.cmd" 
curl -s -L "%file%" -o "%location%\%name%"
REM Wifi Control
echo.
echo Installing Wi-fi Control...
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/Windows-Settings/Wifi/EnableWifi.bat"
set "name=Enable Wi-Fi.cmd"
mkdir "%SYSTEMDRIVE%\Kon OS\Windows Settings\Wi-fi"
set "location=%SYSTEMDRIVE%\Kon OS\Windows Settings\Wi-fi"
curl -s -L "%file%" -o "%location%\%name%"
REM Wifi Disabler
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/Windows-Settings/Wifi/DisableWifi.bat"
set "name=Disable Wi-Fi (Kon OS Default).cmd"
curl -s -L "%file%" -o "%location%\%name%"
:: PACKAGE MANAGERS (and packages)
PowerShell -ExecutionPolicy Unrestricted -NoProfile -File "%~dp0Modules\Scripts\pacMan.ps1"
REM GPU STUFF
:: DDU

echo.
echo Installing DDU...
call "%~dp0Modules\Scripts\dduInstaller.bat"
:: NVCleanInstall
echo.
echo Installing NVCleanInstall...
set "file=https://github.com/ki8y/Tweaks/raw/refs/heads/main/GPU/Nvidia/1_NVCleanInstall/NVCleanstall_1.19.0.exe"
set "name=NVCleanInstall (v1.19.0).exe"
mkdir "C:\Kon OS\Display Drivers\NVIDIA\1) NVCleanInstall"
set "location=C:\Kon OS\Display Drivers\NVIDIA\1) NVCleanInstall"
curl -s -L "%file%" -o "%location%\%name%"
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/Nvidia/NVCleanstall_1.19.0.exe"
:: Nvidia profile inspector (and the required profiles)
echo.
echo Installing NVIDIA Profile Inspector...
call "%~dp0Modules\Scripts\nvProfileInspectorInstaller.bat"
:: AMD
echo.
echo Downloading AMD web shortcut...
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/AMD/AMD.url"
set "name=AMD.url"
mkdir "C:\Kon OS\Display Drivers\AMD\1) Drivers"
set "location=C:\Kon OS\Display Drivers\AMD\1) Drivers"
curl -s -L "%file%" -o "%location%\%name%"
echo.
echo Downloading RadeonSoftwareSlimmer shortcut...

::===========================                                              ===========================
::===========================REMINDER TO DO THIS STUFF... god i hate it all===========================
::===========================              i hate it i hate it             ===========================
::===========================                                              ===========================


:: TOOLS/TIMER RESOLUTION
echo.
echo Installing Timer Resolution...
set "file=https://github.com/valleyofdoom/TimerResolution/releases/download/SetTimerResolution-v1.0.0/SetTimerResolution.exe"
set "name=SetTimerResolution.exe"
mkdir "C:\Kon OS\Modules\Timer Resolution"
set "location=C:\Kon OS\Modules\Timer Resolution"
curl -s -L "%file%" -o "%location%\%name%"
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/Tools/TimerResolution/MeasureSleep.exe"
set "name=MeasureSleep.exe"
curl -s -L "%file%" -o "%location%\%name%"
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/Tools/TimerResolution/Benchmark/benchmark.ps1"
set "name=bench.ps1"
mkdir "C:\Kon OS\Modules\Timer Resolution\Benchmark"
set "location=C:\Kon OS\Modules\Timer Resolution\Benchmark"
curl -s -L "%file%" -o "%location%\%name%"

:: ============General  tweaks============
:gtweaks
color 9
cls && echo [Kon OS] Applying general quality of life tweaks...
timeout /t 1 >nul 
:: Shutdown tweaks
echo [Kon OS] Shutdown Tweaks
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f  
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "1000" /f
reg add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "1000" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f
powercfg -h off
:: Taskbar tweaks
cls && echo [Kon OS] Taskbar Tweaks
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD 0 /f

:: Settings display mode to performance
cls && echo [Kon OS] Disabling visual effects...
chcp 65001 >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f >nul 2>&1 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Desktop" /v VisualFXSetting /t REG_DWORD /d 3 /f >nul 2>&1 
echo 🛈 Disabling window animations...
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v MinAnimate /t REG_SZ /d 0 /f
echo 🛈 Disabling TaskBar animations...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul 2>&1 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul 2>&1 
echo 🛈 Disabling Aero Peek...
reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f
echo 🛈 Disabling menu animations...
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v EnableToolTips /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListBoxSmoothScrolling /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "MenuAnimations" /t REG_DWORD /d 0 /f >nul 2>&1
echo 🛈 Disabling pointer shadow...
powershell -Command "Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'UserPreferencesMask' -Type Binary -Value ([byte[]](144,18,3,128,16,0,0,0))" >nul 2>&1


echo 🛈 Enabling font smoothing...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v FontSmoothing /t REG_DWORD /d 2 /f >nul 2>&1 
reg add "HKCU\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 2 /f

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d 0 /f >nul 2>&1 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ThumbnailCacheSize" /t REG_DWORD /d 0 /f >nul 2>&1  
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "TaskbarAnimations" /t REG_DWORD /d 0 /f >nul 2>&1 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "WindowAnimations" /t REG_DWORD /d 0 /f >nul 2>&1 
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters ,1 ,True
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters 1, True
echo this HOPEFULLY worked, pls test now :3
pause >nul


:: Enables old right click menu (better i dont care lol)
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f
:: Disables copilot
cls && echo Disabling copilot...
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f
:: Enabling full quality wallpaper jpegs
cls && echo Fixing wallpaper quality
reg add "HKCU\Control Panel\Desktop" /v JPEGImportQuality /t REG_DWORD /d 100 /f
:: Enabling hidden files and extensions. (and compact mode idc it looks better lol)
cls && echo Enabling hidden files and showing file extensions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v UseCompactMode /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL" /v CheckedValue /t REG_DWORD /d 1 /f
:: Enabling dark mode, because you're probably psychotic if you think light mode is better. Sorry light mode users, you're really weird...
cls && echo Enabling dark mode...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f
:: Disabling transparency
cls && echo Disabling transparency...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f
:: Disable sticky keys
cls && echo Disabling sticky keys...
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d 506 /f
:: Disable notifications
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableNotificationCenter /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f
:: Disabling location services.
cls && echo Disabling location services...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "deny" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t  REG_DWORD /d "0" /f
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul
cls

:: Add verbose logon UI
echo Making Windows more verbose...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v VerboseStatus /t REG_DWORD /d 1 /f
::Add verbose bluescreens
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v DisplayParameters /t REG_DWORD /d 1 /f
:: Disable background processes
cls && echo Disabling background processes...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f
:: Disabling activity history
cls && echo Disabling activity history...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f
:: Disabling UAC
echo Disabling UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
:: Disable login blur
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v DisableAcrylicBackgroundOnLogon /t REG_DWORD /d 1 /f
:: Enable "End task" button in taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" /v TaskbarEndTask /t REG_DWORD /d 1 /f
:: Disabling telemetry (CHRIS TITUS :D)
cls && echo Disabling location services...
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Application Experience\MareBackup" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable >nul 2>&1 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v ContentDeliveryAllowed /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEverEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338387Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353698Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v EnthusiastMode /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v AutoEndTasks /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v Start /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Mouse" /v MouseHoverTime /t REG_SZ /d 400 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v IRPStackSize /t REG_DWORD /d 30 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d 0 /f
:: Disabling Teredo
cls && echo Disabling Teredo...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 1 /f
:: Disabling IPv6
cls && echo Disabling IPv6
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" /t REG_DWORD /d 255 /f
powershell -Command "Disable-NetAdapterBinding -Name '*' -ComponentID ms_tcpip6"
:: Disabling Mouse Acceleration
cls && echo Disabling mouse acceleration...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f
:: Disabling Homegroup
cls && echo Disabling Homegroup...
sc config HomeGroupListener start=demand
sc config HomeGroupProvider start=demand
:: Disabling GameDVR (sora nooooooo FARKKK...)
cls && echo Disabling GameDVR...
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehavior /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 1 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d 1 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_EFSEFeatureFlags /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f
:: Disabling Core Isolation
cls && echo Disabling Core Isolation...
reg add "HKLM\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f
:: Disable modern standby (i think)
reg add "HKLM\System\CurrentControlSet\Control\Power" /v PlatformAoAcOverride /t REG_DWORD /d 0 /f
:: Disables live tiles, smooth scrolling, folder templates, fast user switching, and ink related features. Also essentially flushes explorer
cls && echo Some more general tweaks.
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v NoTileApplicationNotification /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v SmoothScroll /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v FolderType /t REG_SZ /d "NotSpecified" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v HideFastUserSwitching /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v AllowWindowsInkWorkspace /t REG_DWORD /d 0 /f
:: Optimizes power latency settings and stuff.. heh.
cls && echo Doing some latency stuff.
:: Power settings
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "Latency" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "TransitionLatency" /t REG_DWORD /d 1 /f
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul

:: bcdedit stuff
cls
color 9
echo Editing boot options...
echo.
echo 🛈 Setting boot menu to legacy...
bcdedit /set {current} bootmenupolicy Legacy >nul 2>&1

echo 🛈 Deleting "useplatformclock" value...
bcdedit /deletevalue useplatformclock >nul 2>&1 

echo 🛈 Disabling useplatformtick value...
bcdedit /set useplatformtick no >nul 2>&1 

echo 🛈 Enabling disabledynamictick value...
bcdedit /set disabledynamictick yes >nul 2>&1

echo 🛈 Disabling Boot UI...
bcdedit /set bootux disabled >nul 2>&1 

echo 🛈 Setting Time-Stamp Counter Synchronization Policy to enhanced...
bcdedit /set tscsyncpolicy enhanced >nul 2>&1  

echo 🛈 Enabling x2APIC...
bcdedit /set x2apicpolicy Enable >nul 2>&1 

echo 🛈 Disabling Legacy APIC Mode...
bcdedit /set uselegacyapicmode No >nul 2>&1 

:: disables adaptive refresh rate. i hate it
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ModernSleep" /v "AdaptiveRefreshRate" /t REG_DWORD /d 0 /f

:: Disabling intel bloat (thanks sora!)
color 9
cls && echo Disabling Intel Services...

for %%D in (
    dptftcs
    igccservice
    IntelDisplayUMService
    ipfsvc
    WMIRegistrationService
) do (
    echo 🛈 Disabling %%D...
    sc config %%D start= disabled >nul 2>&1
)
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul
pause

:: Disabling HP Services (thanks again sora!)

cls && echo Disabling HP Services...
echo.
echo 🛈 Disabling HPNetworkCap...
sc config HPNetworkCap start=disabled >nul 2>&1
echo 🛈 Disabling HPOmenCap...
sc config HPOmenCap start=disabled >nul 2>&1
echo 🛈 Disabling HPSysInfoCap...
sc config HPSysInfoCap start=disabled >nul 2>&1
echo 🛈 Disabling HpTouchpointAnalyticsService...
sc config HpTouchpointAnalyticsService start=disabled >nul 2>&1
echo 🛈 Disabling HPAppHelperCap...
sc config HPAppHelperCap start=disabled >nul 2>&1
echo 🛈 Disabling HPAudioAnalytics...
sc config HPAudioAnalytics start=disabled >nul 2>&1
echo 🛈 Disabling HPDiagsCap...
sc config HPDiagsCap start=disabled >nul 2>&1
echo 🛈 Disabling HotKeyServiceUWP...
sc config HotKeyServiceUWP start=disabled >nul 2>&1
echo 🛈 Disabling LanWlanWwanSwitchingServiceUWP...
sc config LanWlanWwanSwitchingServiceUWP start=disabled >nul 2>&1
echo 🛈 Disabling hpsvcsscan...
sc config hpsvcsscan start=disabled >nul 2>&1
echo 🛈 Disabling SFUService...
sc config SFUService start=disabled >nul 2>&1
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul

for %%D in (

) do (
    echo 🛈 Disabling %%D...
    sc config %%D start= disabled >nul 2>&1
)
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul
pause

:: Configure ShutUp10
echo Configuring OOShutUp10...
"C:\Kon OS\Modules\OOShutUp10\OOSU10.exe" "C:\Kon OS\Modules\OOShutUp10\config.cfg" /quiet
timeout /t 2 >nul
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul
timeout /t 1 >nul

:: Enabling the old alt tab menu, might increase performance? I dunno.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AltTabSettings" /t REG_DWORD /d 1 /f

setlocal enabledelayedexpansion
PowerShell -ExecutionPolicy Unrestricted -NoProfile -File "%~dp0Modules\Scripts\peskyServices.ps1"
endlocal

:: ============Privacy is freedom's service control============
:: Credits (YouTube): https://www.youtube.com/@PrivacyisFreedom
:: Credits (Github): https://github.com/PrivacyIsFreedom
reg add "HKLM\System\CurrentControlSet\Services\PimIndexMaintenanceSvc" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\WinHttpAutoProxySvc" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\BcastDVRUserService" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKLM\System\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d "4" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "MicrophoneCaptureEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "2" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "2" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
reg add "HKLM\Software\Policies\Microsoft\Windows\GameDVR" /v "AllowgameDVR" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d "4" /f
schtasks /DELETE /TN "AMDInstallLauncher" /f
schtasks /DELETE /TN "AMDLinkUpdate" /f
schtasks /DELETE /TN "AMDRyzenMasterSDKTask" /f
schtasks /DELETE /TN "Driver Easy Scheduled Scan" /f
schtasks /DELETE /TN "ModifyLinkUpdate" /f
schtasks /DELETE /TN "SoftMakerUpdater" /f
schtasks /DELETE /TN "StartCN" /f
schtasks /DELETE /TN "StartDVR" /f
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
schtasks /Change /TN "Microsoft\Windows\Defrag\ScheduledDefrag" /Disable
schtasks /Change /TN "Microsoft\Windows\Device Information\Device" /Disable
schtasks /Change /TN "Microsoft\Windows\Device Information\Device User" /Disable
schtasks /Change /TN "Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner" /Disable
schtasks /Change /TN "Microsoft\Windows\Diagnosis\Scheduled" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskCleanup\SilentCleanup" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskFootprint\StorageSense" /Disable
schtasks /Change /TN "Microsoft\Windows\DUSM\dusmtask" /Disable
schtasks /Change /TN "Microsoft\Windows\EnterpriseMgmt\MDMMaintenenceTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\Flighting\OneSettings\RefreshCache" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\LocalUserSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\MouseSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\PenSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\Input\TouchpadSyncDataAvailable" /Disable
schtasks /Change /TN "Microsoft\Windows\International\Synchronize Language Settings" /Disable
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\Installation" /Disable
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources" /Disable
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /Disable
schtasks /Change /TN "Microsoft\Windows\License Manager\TempSignedLicenseExchange" /Disable
schtasks /Change /TN "Microsoft\Windows\Management\Provisioning\Cellular" /Disable
schtasks /Change /TN "Microsoft\Windows\Management\Provisioning\Logon" /Disable
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsToastTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser" /Disable
schtasks /Change /TN "Microsoft\Windows\MUI\LPRemove" /Disable
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable
schtasks /Change /TN "Microsoft\Windows\PushToInstall\Registration" /Disable
schtasks /Change /TN "Microsoft\Windows\Ras\MobilityManager" /Disable
schtasks /Change /TN "Microsoft\Windows\RecoveryEnvironment\VerifyWinRE" /Disable
schtasks /Change /TN "Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /Disable
schtasks /Change /TN "Microsoft\Windows\RetailDemo\CleanupOfflineContent" /Disable
schtasks /Change /TN "Microsoft\Windows\Servicing\StartComponentCleanup" /Disable
schtasks /Change /TN "Microsoft\Windows\SettingSync\NetworkStateChangeTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Setup\SetupCleanupTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Setup\SnapshotCleanupTask" /Disable
schtasks /Change /TN "Microsoft\Windows\SpacePort\SpaceAgentTask" /Disable
schtasks /Change /TN "Microsoft\Windows\SpacePort\SpaceManagerTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Speech\SpeechModelDownloadTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Storage Tiers Management\Storage Tiers Management Initialization" /Disable
schtasks /Change /TN "Microsoft\Windows\Sysmain\ResPriStaticDbSync" /Disable
schtasks /Change /TN "Microsoft\Windows\Sysmain\WsSwapAssessmentTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Task Manager\Interactive" /Disable
schtasks /Change /TN "Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Disable
schtasks /Change /TN "Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable
schtasks /Change /TN "Microsoft\Windows\Time Zone\SynchronizeTimeZone" /Disable
schtasks /Change /TN "Microsoft\Windows\TPM\Tpm-HASCertRetr" /Disable
schtasks /Change /TN "Microsoft\Windows\TPM\Tpm-Maintenance" /Disable
schtasks /Change /TN "Microsoft\Windows\UPnP\UPnPHostConfig" /Disable
schtasks /Change /TN "Microsoft\Windows\User Profile Service\HiveUploadTask" /Disable
schtasks /Change /TN "Microsoft\Windows\WDI\ResolutionHost" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Filtering Platform\BfeOnServiceStartTypeChange" /Disable
schtasks /Change /TN "Microsoft\Windows\WOF\WIM-Hash-Management" /Disable
schtasks /Change /TN "Microsoft\Windows\WOF\WIM-Hash-Validation" /Disable
schtasks /Change /TN "Microsoft\Windows\Work Folders\Work Folders Logon Synchronization" /Disable
schtasks /Change /TN "Microsoft\Windows\Work Folders\Work Folders Maintenance Work" /Disable
schtasks /Change /TN "Microsoft\Windows\Workplace Join\Automatic-Device-Join" /Disable
schtasks /Change /TN "Microsoft\Windows\WwanSvc\NotificationTask" /Disable
schtasks /Change /TN "Microsoft\Windows\WwanSvc\OobeDiscovery" /Disable
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /Disable

cls && echo 
color 6
timeout /t 1 >nul
for %%D in (
    BcastDVRUserService
    wlidsvc   
    wcncsvc
    DisplayEnhancementService 
    DiagTrack 
    DusmSvc 
    TabletInputService 
    Fax 
    lfsvc 
    AJRouter
    ALG
    Netlogon
    CertPropSvc
    Themes
    DPS
    AssignedAccessManagerSvc
    DialogBlockingService
    NetTcpPortSharing
    PimIndexMaintenanceSvc
    RemoteAccess
    UevAgentService
    WSearch
    VSS
    MapsBroker
    shpamsvc
    ssh-agent
    tzautoupdate
    uhssvc
    MSDTC
    SecurityHealthService
    SysMain
    WdiServiceHost
    WinDefend
    seclogon
    wscsvc
    wisvc
    StorSvc
    NcbService
    WdiSystemHost
    AppReadiness
    XblAuthManager
    PNRPAutoReg
    XblGameSave
    XboxGipSvc
    XboxNetApiSvc
    SCardSvr
    CscService
    WalletService
    icssvc
    fhsvc
    FrameServer
    FrameServerMonitor
    EntAppSvc
    DmEnrollmentSvc
    AxInstSV
    DeviceAssociationService
    TieringEngineService
    TextInputManagementService
    CDPSvc
    DevQueryBroker
    EFS
    FDResPub
    :: Hyper-V
    HvHost
    vmicguestinterface
    vmicheartbeat
    vmickvpexchange
    vmicrdv
    vmicshutdown
    vmictimesync
    vmicvmsession
    vmicvss
    :: Done
    IKEEXT
    InstallService
    MixedRealityOpenXRSvc
    MsKeyboardFilter
    PrintNotify
    RasMan
    RmSvc
    SensorDataService
    SensorService
    SensrSvc
    SessionEnv
    SharedAccess
    StiSvc
    TokenBroker
    UsoSvc
    W32Time
    WebClient
    Wecsvc
    WinRM
    autotimesvc
    dmwappushservice
    edgeupdate
    edgeupdatem
    fdPHost
    smphost
    wercplsupport
    wuauserv
    DispBrokerDesktopSvc
    FontCache
    LanmanServer
    ShellHWDetection
    TermService
    Wcmsvc
    cbdhsvc 
    WpcMonSvc 
    MicrosoftEdgeElevationService 
    edgeupdate 
    edgeupdatem 
    autotimesvc
    diagnosticshub.standardcollector.service 
    PhoneSvc 
    TapiSrv 
    WbioSrvc 
    SEMgrSvc 
    iphlpsvc 
    BthAvctpSvc 
    BDESVC 
    CDPUserSvc 
    DevicesFlowUserSvc 
    TrkWks 
    dLauncherLoopback 
    NPSMSvc 
    WPDBusEnum 
    PcaSvc 
    RetailDemo
    SSDPSRV 
    OneSyncSvc 
    UserDataSvc 
    UnistoreSvc 
    DsSvc 
    AppVClient 
    SstpSvc 
    WMPNetworkSvc 
    WerSvc  
    WinHttpAutoProxySvc 
    DsmSvc 
) do (
    echo Setting %%D to disabled...
    sc config %%D start= disabled >nul 2>&1 && echo [32m%%D disabled successfully[39m || echo [33m[WARNING] Failed to change %%D![39m
)

for %%M in (
    BFE
    AppIDSvc
    AppMgmt
    AppXSvc
    Appinfo
    Browser
    COMSysApp
    ClipSVC
    DcpSvc
    DeviceInstall
    EapHost
    GraphicsPerfSvc
    HomeGroupListener
    HomeGroupProvider
    IEEtwCollectorService
    InventorySvc
    IpxlatCfgSvc
    KtmRm
    LanmanWorkstation
    LicenseManager
    LxpSvc
    McpManagementService
    MSiSCSI 
    NaturalAuthentication
    NcaSvc
    NcdAutoSetup
    NetSetupSvc
    Netman
    NgcCtnrSvc
    NgcSvc
    NlaSvc
    PNRPsvc 
    PeerDistSvc
    PerfHost
    PlugPlay
    PolicyAgent
    PushToInstall
    QWAVE
    RasAuto
    RpcLocator
    SCPolicySvc
    SDRSVC
    Sense
    SharedRealitySvc
    SmsRouter
    StateRepository
    TimeBroker
    TimeBrokerSvc
    TroubleshootingSvc
    TrustedInstaller
    UI0Detect
    UdkUserSvc
    webthreatdefusersvc
    UmRdpService
    VacSvc  
    WEPHOSTSVC
    WFDSConMgrSvc
    WManSvc
    WSService   
    WaaSMedicSvc
    WarpJITSvc  
    WcsPlugInService
    WdNisSvc
    WiaRpc
    WpnService
    camsvc
    cloudidsvc
    dcsvc
    defragsvc
    dot3svc
    embeddedmode
    hidserv
    lltdsvc
    msiserver
    netprofm
    p2pimsvc
    p2psvc
    perceptionsimulation
    pla
    spectrum
    svsvc
    swprv
    upnphost
    vds
    vm3dservice
    vmvss
    wbengine
    webthreatdefsvc
    wlpasvc
    wmiApSrv
    workfolderssvc
    wudfsvc
) do (
    echo Setting %%M to manual...
    sc config %%M start= demand >nul 2>&1 && echo [32m%%M set to manual successfully[39m || echo [33m[WARNING] Failed to change %%M![39m
)

for %%Q in (
    DoSvc
    sppsvc
) do (
    echo Setting %%Q to automatic [delayed]...
    sc config %%Q start= delayed-auto >nul 2>&1 && echo [32m%%Q changed successfully[39m || echo [33m[WARNING] Failed to change %%Q![39m
)



for %%A in (
    AudioEndpointBuilder
    AudioSrv
    Audiosrv
    BrokerInfrastructure
    CoreMessagingRegistrar
    CryptSvc
    DcomLaunch
    Dhcp
    Dnscache
    EventLog
    EventSystem
    gpsvc
    KeyIso
    LSM
    MpsSvc
    Power
    ProfSvc
    RpcEptMapper
    RpcSs
    SamSs
    Schedule
    SENS
    SgrmBroker
    SystemEventsBroker
    UserManager
    VGAuthService
    VMTools
    VaultSvc
    tiledatamodelsvc
    Winmgmt
) do (
    echo Setting %%A to automatic...
    sc config %%A start= auto >nul 2>&1 && echo [32m%%A changed successfully[39m || echo [33m[WARNING] Failed to change %%A![39m
)

cls
echo Reinforcing service settings... Please wait.
for %%D in (
    BcastDVRUserService
    wlidsvc   
    wcncsvc
    DisplayEnhancementService 
    DiagTrack 
    DusmSvc 
    TabletInputService 
    Fax 
    lfsvc 
    AJRouter
    ALG
    Netlogon
    CertPropSvc
    Themes
    DPS
    AssignedAccessManagerSvc
    DialogBlockingService
    NetTcpPortSharing
    PimIndexMaintenanceSvc
    RemoteAccess
    UevAgentService
    WSearch
    VSS
    MapsBroker
    shpamsvc
    ssh-agent
    tzautoupdate
    uhssvc
    MSDTC
    SecurityHealthService
    SysMain
    WdiServiceHost
    WinDefend
    seclogon
    wscsvc
    wisvc
    StorSvc
    NcbService
    WdiSystemHost
    AppReadiness
    XblAuthManager
    PNRPAutoReg
    XblGameSave
    XboxGipSvc
    XboxNetApiSvc
    SCardSvr
    CscService
    WalletService
    icssvc
    fhsvc
    FrameServer
    FrameServerMonitor
    EntAppSvc
    DmEnrollmentSvc
    AxInstSV
    DeviceAssociationService
    TieringEngineService
    TextInputManagementService
    CDPSvc
    DevQueryBroker
    EFS
    FDResPub
    :: Hyper-V
    HvHost
    vmicguestinterface
    vmicheartbeat
    vmickvpexchange
    vmicrdv
    vmicshutdown
    vmictimesync
    vmicvmsession
    vmicvss
    :: Done
    IKEEXT
    InstallService
    MixedRealityOpenXRSvc
    MsKeyboardFilter
    PrintNotify
    RasMan
    RmSvc
    SensorDataService
    SensorService
    SensrSvc
    SessionEnv
    SharedAccess
    StiSvc
    TokenBroker
    UsoSvc
    W32Time
    WebClient
    Wecsvc
    WinRM
    autotimesvc
    dmwappushservice
    edgeupdate
    edgeupdatem
    fdPHost
    smphost
    wercplsupport
    wuauserv
    DispBrokerDesktopSvc
    FontCache
    LanmanServer
    TermService
    Wcmsvc
    cbdhsvc 
    WpcMonSvc 
    MicrosoftEdgeElevationService 
    edgeupdate 
    edgeupdatem 
    autotimesvc
    diagnosticshub.standardcollector.service 
    PhoneSvc 
    TapiSrv 
    WbioSrvc 
    SEMgrSvc 
    iphlpsvc 
    BthAvctpSvc 
    BDESVC 
    CDPUserSvc 
    DevicesFlowUserSvc 
    TrkWks 
    dLauncherLoopback 
    NPSMSvc 
    WPDBusEnum 
    PcaSvc 
    RetailDemo
    SSDPSRV 
    OneSyncSvc 
    UserDataSvc 
    UnistoreSvc 
    DsSvc 
    AppVClient 
    SstpSvc 
    WMPNetworkSvc 
    WerSvc  
    WinHttpAutoProxySvc 
    DsmSvc 
) do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%D" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

for %%M in (
    BFE
    AppIDSvc
    AppMgmt
    AppXSvc
    Appinfo
    Browser
    COMSysApp
    ClipSVC
    DcpSvc
    DeviceInstall
    EapHost
    GraphicsPerfSvc
    HomeGroupListener
    HomeGroupProvider
    IEEtwCollectorService
    InventorySvc
    IpxlatCfgSvc
    KtmRm
    LanmanWorkstation
    LicenseManager
    LxpSvc
    McpManagementService
    MSiSCSI 
    NaturalAuthentication
    NcaSvc
    NcdAutoSetup
    NetSetupSvc
    Netman
    NgcCtnrSvc
    NgcSvc
    NlaSvc
    PNRPsvc 
    PeerDistSvc
    PerfHost
    PlugPlay
    PolicyAgent
    PushToInstall
    QWAVE
    RasAuto
    RpcLocator
    SCPolicySvc
    SDRSVC
    Sense
    SharedRealitySvc
    SmsRouter
    StateRepository
    TimeBroker
    TimeBrokerSvc
    TroubleshootingSvc
    TrustedInstaller
    UI0Detect
    UdkUserSvc
    webthreatdefusersvc
    UmRdpService
    VacSvc  
    WEPHOSTSVC
    WFDSConMgrSvc
    WManSvc
    WSService   
    WaaSMedicSvc
    WarpJITSvc  
    WcsPlugInService
    WdNisSvc
    WiaRpc
    WpnService
    camsvc
    cloudidsvc
    dcsvc
    defragsvc
    dot3svc
    embeddedmode
    hidserv
    lltdsvc
    msiserver
    netprofm
    p2pimsvc
    p2psvc
    perceptionsimulation
    pla
    spectrum
    svsvc
    swprv
    upnphost
    vds
    vm3dservice
    vmvss
    wbengine
    webthreatdefsvc
    wlpasvc
    wmiApSrv
    workfolderssvc
    wudfsvc
) do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%M" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
)
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul

:: Disable bluetooth services
cls && echo Disabling bluetooth...
for %%D in (
    BTAGService
    bthserv
) do (
    echo Setting %%D to disabled...
    sc config %%D start= disabled >nul 2>&1 && echo [32m%%D disabled successfully[39m || echo [33m[WARNING] Failed to change %%D![39m
)
:: (PIF) Disabling windows update and store services
cls && echo Disabling Windows Update and Store services
chcp 437 >nul

for %%S in (
    ClipSVC
    uhssvc
    upfc
    PushToInstall
    BITS
    InstallService
    uhssvc
    UsoSvc
    wuauserv
    LanmanServer
) do (
    sc stop %%S >nul 2>&1 && echo [32m%%S killed successfully[39m || echo [33m[WARNING] Failed to stop %%S![39m
)

chcp 437 >nul

for %%D in (
    ClipSVC 
    BITS 
    InstallService 
    uhssvc 
    UsoSvc 
    wuauserv 
    LanmanServer 
) do (
    echo Setting %%D to disabled...
    sc config %%D start= disabled >nul 2>&1 && echo [32m%%D disabled successfully[39m || echo [33m[WARNING] Failed to change %%D![39m
)

reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v Start /t reg_dword /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\InstallService" /v Start /t reg_dword /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v Start /t reg_dword /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v Start /t reg_dword /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v Start /t reg_dword /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v Start /t reg_dword /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\upfc" /v Start /t reg_dword /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\uhssvc" /v Start /t reg_dword /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ossrs" /v Start /t reg_dword /d 4 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpdatePeriod" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpgrade" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpgradePeriod" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d "1" /f
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdates" /Disable
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /Disable
schtasks /Change /TN "Microsoft\Windows\InstallService\SmartRetry" /Disable
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndContinueUpdates" /Disable
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndScanForUpdates" /Disable
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Report policies" /Disable
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Disable
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /Disable
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /Disable
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Disable
schtasks /Change /TN "Microsoft\Windows\WaaSMedic\PerformRemediation" /Disable
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Scheduled Start" /Disable
:: (PIF) Remote services
cls && echo Disabling remote services...
sc config RemoteRegistry start= disabled
sc config RemoteAccess start= disabled
sc config WinRM start= disabled
sc config RmSvc start= disabled
:: (PIF) Disable printer services
cls && echo Disabling printer...
sc config PrintNotify start= disabled
sc config Spooler start= disabled
schtasks /Change /TN "Microsoft\Windows\Printing\EduPrintProv" /Disable
schtasks /Change /TN "Microsoft\Windows\Printing\PrinterCleanupTask" /Disable

:: Tries to fully disable SecurityHealthService
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "4" /f

:: Deleting internet explorer
echo Deleting internet explorer...
:: deleting directories
rd /s /q "C:\Program Files\Internet Explorer"
rd /s /q C:\Program Files (x86)\Internet Explorer
:: disabling internet explorer
dism /online /Disable-Feature /FeatureName:Internet-Explorer-Optional-amd64 /NoRestart
:: Deleting shortcuts
del "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Internet Explorer.lnk" /f
del "%Public%\Desktop\Internet Explorer.lnk" /f

:: ============EDGE REMOVER============
:Edge
cls && color 2 && echo Would you like to remove Microsoft Edge? (Recommended. There are better options.)
echo [97;43mPerformance impact: Medium[32;40m
choice /c YN /n /m "[Y] Yes  [N] No: "
if %errorlevel%==1 goto RemoveEdge
if %errorlevel%==2 goto DoNotRemoveEdge

:RemoveEdge
cls
echo Removing Microsoft Edge...
:: Kill Edge processes
taskkill /f /im msedge.exe >nul 2>&1
taskkill /f /im msedgewebview2.exe >nul 2>&1
:: Delete Edge Scheduled Tasks to prevent reinstallation
schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineCore" /f >nul 2>&1
schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineUA" /f >nul 2>&1
:: Remove Edge-related directories
echo Deleting Edge folders...
rd /s /q "C:\Program Files (x86)\Microsoft\Edge" >nul 2>&1
rd /s /q "C:\Program Files (x86)\Microsoft\EdgeCore" >nul 2>&1
rd /s /q "C:\Program Files (x86)\Microsoft\EdgeUpdate" >nul 2>&1
rd /s /q "C:\Program Files (x86)\Microsoft\EdgeWebView" >nul 2>&1
rd /s /q "C:\Program Files (x86)\Microsoft\Temp" >nul 2>&1
:: Remove desktop shortcuts (user + public)
echo Deleting Edge shortcuts...
del "C:\Users\Public\Desktop\Microsoft Edge.lnk" /f >nul 2>&1
:: Loop through all user profiles to clean their desktops and pinned items
for /d %%U in ("C:\Users\*") do (
    del "%%U\Desktop\Microsoft Edge.lnk" /f >nul 2>&1
    del "%%U\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk" /f >nul 2>&1
)
:: Blocks EdgeUpdate.exe via Firewall
echo Blocking EdgeUpdate via Firewall...
netsh advfirewall firewall add rule name="Block_EdgeUpdate" dir=out action=block program="C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="Block_EdgeUpdate_Inbound" dir=in action=block program="C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" enable=yes >nul 2>&1
:: Blocks msedge.exe just in case all else fails
netsh advfirewall firewall add rule name="Block_msedge" dir=out action=block program="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="Block_msedge_Inbound" dir=in action=block program="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" enable=yes >nul 2>&1
echo Edge removed.
timeout /t 1 >nul
goto :WifiChoice

:: Does not remove edge
:DoNotRemoveEdge
cls && echo Okay, not removing Edge.
timeout /t 1 >nul
goto :DebloatEdge

:: Debloats edge
:DebloatEdge
cls && echo Debloating Edge...
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "CreateDesktopShortcutDefault" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "ShowRecommendationsEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HideFirstRunExperience" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserFeedbackAllowed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "ConfigureDoNotTrack" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "AlternateErrorPagesEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeCollectionsEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeShoppingAssistantEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "MicrosoftEdgeInsiderPromotionEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "ShowMicrosoftRewards" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeAssetDeliveryServiceEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeCollectionsEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "CryptoWalletEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "WalletDonationEnabled" /t REG_DWORD /d 0 /f
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul
goto :WiFiChoice

:: ============WI-FI CONTROL============
:WiFiChoice
color f
cls && echo Disable wifi services? Can reduce latency, but breaks wifi. (..duh!)
echo.
echo [97;42mPerformance impact: Low[0m
choice /c YN /n /m "[Y] Yes  [N] No: "
if %errorlevel%==1 goto WiFiOFF
if %errorlevel%==2 goto WiFiON

:WiFiON
color a
cls && echo Okay, keeping Wi-Fi enabled.
timeout /t 1 >nul
goto SSRemover

:WiFiOFF
:: Disabling wifi (PiF involved)
color c
cls && echo Disabling wifi services...
sc config NlaSvc start= disabled
sc config LanmanWorkstation start= disabled
schtasks /Change /TN "Microsoft\Windows\WlanSvc\CDSSync" /Disable
schtasks /Change /TN "Microsoft\Windows\WCM\WiFiTask" /Disable
schtasks /Change /TN "Microsoft\Windows\NlaSvc\WiFiTask" /Disable
schtasks /Change /TN "Microsoft\Windows\DUSM\dusmtask" /Disable
reg add "HKLM\Software\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /v "NoActiveProbe" /t REG_DWORD /d "1" /f
reg add "HKLM\System\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "EnableActiveProbing" /t REG_DWORD /d "0" /f
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "Value" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "Value" /t REG_DWORD /d 0 /f
sc config BFE start= demand
sc config Dnscache start= demand
sc config Dhcp start= auto
sc config lmhosts start= disabled
sc config nsi start= auto
sc config Wcmsvc start= disabled
sc config Winmgmt start= auto
sc config WlanSvc start= demand
for /f "tokens=1,* delims=:" %%A in ('netsh interface show interface ^| findstr /i "Wireless"') do (
    set "wifiName=%%B"
)
setlocal EnableDelayedExpansion
set "wifiName=!wifiName:~1!"
netsh interface set interface name="!wifiName!" admin=disabled
echo Wifi services disabled.
timeout /t 1 >nul
echo *Can be re-enabled later!*
timeout /t 1 >nul
endlocal
goto SSRemover

:SSRemover
cls && echo Removing smartscreen...
color c
set "smartscreen1=C:\Windows\System32\smartscreen.exe"
set "smartscreen2=C:\Windows\SystemApps\Microsoft.Windows.AppRep.ChxApp_cw5n1h2txyewy\CHXSmartScreen.exe"
if exist "%smartscreen1%" (
    takeown /F "%smartscreen1%" >nul 2>&1
    icacls "%smartscreen1%" /grant administrators:F >nul 2>&1
    echo Removing Smartscreen [Phase 1]
    taskkill /f /im smartscreen.exe
    del "%smartscreen1%" /f /q

    chcp 65001 >nul
    echo [92m✓ Done.
chcp 437 >nul
) else (
    echo File not found: %smartscreen1%. Is it already deleted?
)
if exist "%smartscreen2%" (
    takeown /F "%smartscreen2%" >nul 2>&1
    icacls "%smartscreen2%" /grant administrators:F >nul 2>&1
    echo Removing Smartscreen [Phase 2]
    taskkill /f /im CHXSmartScreen.exe
    del "%smartscreen2%" /f /q
    chcp 65001 >nul
    echo [92m✓ Done.
chcp 437 >nul
) else (
    echo File not found: %smartscreen2%. Is it already deleted?
)

:: ============REMOVING APPS============
color f
cls && echo Removing some extra Microsoft apps...
PowerShell -ExecutionPolicy Unrestricted -NoProfile -File "%~dp0Modules\Scripts\msDebloat.ps1"
echo Removing Microsoft Store...
timeout /t 3 >nul
PowerShell -ExecutionPolicy Unrestricted -NoProfile -File "%~dp0Modules\Scripts\storeRemover.ps1"
setlocal enabledelayedexpansion

set processes=Teams.exe msteams.exe msteams_autostarter.exe msteamsupdate.exe
for %%p in (%processes%) do (
    taskkill /F /IM %%p >nul 2>&1
)
PowerShell -ExecutionPolicy Unrestricted -Command "Get-AppxPackage -Name *Teams* | ForEach-Object { Remove-AppxPackage -Package $_.PackageFullName }"
rd /s /q "%LocalAppData%\Microsoft\Teams"
rd /s /q "%AppData%\Microsoft\Teams"
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul
endlocal

:: ============Open Shell============
cls
echo Replacing the start menu with Open-Shell...

:: Killing default shell processes so they don’t interfere
taskkill /f /im StartMenuExperienceHost.exe >nul 2>&1
taskkill /f /im ShellExperienceHost.exe >nul 2>&1

:: Taking ownership of system start menu executables
takeown /f "%SystemRoot%\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe" /a >nul
icacls "%SystemRoot%\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe" /grant administrators:F >nul
takeown /f "%SystemRoot%\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe" /a >nul
icacls "%SystemRoot%\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe" /grant administrators:F >nul

:: Disabling default start menu executables
ren "%SystemRoot%\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\StartMenuExperienceHost.exe" StartMenuExperienceHost_disabled.exe >nul
ren "%SystemRoot%\SystemApps\ShellExperienceHost_cw5n1h2txyewy\ShellExperienceHost.exe" ShellExperienceHost_disabled.exe >nul

:: Download Open-Shell installer
set "file=https://github.com/Open-Shell/Open-Shell-Menu/releases/download/v4.4.195/OpenShellSetup_4_4_195.exe"
set "name=OpenShellSetup_4_4_195.exe"
set "location=C:\Kon OS\temp"
mkdir "%location%" >nul 2>&1
curl -s -L "%file%" -o "%location%\%name%"

:: Download Open-Shell registry config (you already have this part)
:: Assume it's saved at C:\Kon OS\Modules\OpenShell\KON.reg

:: Install Open-Shell
echo Installing Open-Shell...
start "" "%location%\%name%" /quiet ADDLOCAL=StartMenu
timeout /t 8 >nul
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul
cls
echo Importing Open-Shell config...
reg import "%~dp0Modules\OpenShellConfig\config.reg"
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul

:skipImport
color f
:: ============HAGS============
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f

:: ============COOL POWERPLAN STUFF!============
:: Set file association (khorvie stuff)
assoc .pow=PowerPlanFile
:: Define how .pow files are handled (even more khorvie stuff, seriously that dude is smart)
reg add "HKEY_CLASSES_ROOT\PowerPlanFile\shell\open\command" /ve /d "\"%SystemRoot%\System32\cmd.exe\" /c powercfg -import \"%%1\"" /f
:: Now actually trying to get the powerplan to work.
cls
PowerShell -ExecutionPolicy Bypass -NoProfile -File "%~dp0Modules\Scripts\powerImport.ps1"
echo Do they match?
choice /c YN /n /m "[Y] Yes  [N] No: "
if %errorlevel%==1 goto TimerResCheck
if %errorlevel%==2 goto PowerCorrector

:PowerCorrector
echo To correct your power plan, a control panel applet will open. && timeout /t 2 >nul
start powercfg.cpl
echo Click "Endgame Performance" to get the most optimal power plan.
echo After you're done, press any key to continue. && pause >nul
goto TimerResCheck

:: ============TIMER RESOLUTION============
:: Get OS build number
:TimerResCheck
cls
for /f %%i in ('powershell -Command "[System.Environment]::OSVersion.Version.Build"') do set build=%%i

if %build% GEQ 22000 (
    reg add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\kernel" /v "GlobalTimerResolutionRequests" /t REG_DWORD /d "1" /f
    goto TimerResolution
) else if %build% GEQ 19041 (
    goto TimerResolution
) else if %build% GEQ 17763 (
    goto TimerResolution
) else (
    cls
    color F
    title The Khorvie Workaround.
    echo Windows 10 20H2 and up requires a weird workaround for timer resolution to work properly
    echo.
    echo To make timer resolution work, you need to have DPC checker minimized in your taskbar at all times.
    echo.
    echo Proceed with timer resolution? [97;42m**Recommended!**[0m
    choice /c YN /n /m "[Y] Yes  [N] No: "
    if %errorlevel%==1 goto KhorvieWorkaround
    if %errorlevel%==2 goto SkipTimerResolution
)

:TimerResolution
color F
cls
echo Timer Resolution.
echo. 
echo It's good to benchmark and see what really fits you, but if
echo you dont feel like doing all that, just input "5060" (0.506ms).
echo (Hopefully, I can automate the benchmark process in the future!)
echo.
echo Please input a resolution (Minimum: 5000)
set /p resolution=": "
echo.
echo Setting timer resolution to %resolution% (0.%resolution%ms)...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TimerResolution" /t REG_SZ /d "C:\Kon OS\Tools\Timer Resolution\SetTimerResolution.exe --resolution %resolution% --no-console" /f
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul
timeout /t 1 >nul 
goto :Wallpaper

:SkipTimerResolution
Color f
cls
echo Skipping timer resolution... :(
timeout /t 1 >nul


:: ============KON OS THEMES============
:Wallpaper
cls && echo Adding and applying wallpaper...
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/Themes/Wallpapers/KonOSDark.jpg"
set "name=konosdark.jpg"
mkdir "c:\Kon OS\Modules\Themes\Wallpapers"
set "location=C:\Kon OS\Modules\Themes\Wallpapers"
curl -s -L "%file%" -o "%location%\%name%"
:: Applying wallpaper
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "C:\Kon OS\Modules\Themes\Wallpapers\konosdark.jpg" /f
:: Lock Screen
set "file=https://i.imgur.com/hpcJ55a.jpeg"
set "name=konLS.jpg"
mkdir "C:\Kon OS\Modules\Themes\Wallpapers\Lock Screen\"
set "location=C:\Kon OS\Modules\Themes\Wallpapers\Lock Screen"
curl -s -L "%file%" -o "%location%\%name%"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v LockScreenImage /t REG_SZ /d "C:\Kon OS\Modules\Themes\Wallpapers\Lock Screen\konLS.jpg" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 0 /f
:: RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters 1, True <--- Command I used to use. I think its cooler when you startup and reveal "Kon OS" though.
:: Accent colors || Format: 0xAABBGGRR (AA=Alpha, BB=Blue, GG=Green, RR=Red)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AutoColorization /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v ColorPrevalence /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v ColorPrevalence /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v AccentColor /t REG_DWORD /d 0xff5c5c5c /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Accent" /v AccentColor /t REG_DWORD /d 0xff5c5c5c /f



:: Extra Themes
cls
echo Installing extra themes...
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/Themes/Wallpapers/KonOSLight.jpg"
set "name=konoslight.jpg"
mkdir "c:\Kon OS\Modules\Themes\Wallpapers"
set "location=C:\Kon OS\Modules\Themes\Wallpapers"
curl -s -L "%file%" -o "%location%\%name%"
set "file=https://github.com/ki8y/Tweaks/raw/main/Themes/KonOSDark.deskthemepack"
set "name=Kon OS Dark Theme.deskthemepack"
set "location=C:\Kon OS\Modules\Themes"
curl -s -L "%file%" -o "%location%\%name%"
set "file=https://github.com/ki8y/Tweaks/raw/main/Themes/KonOSLight.deskthemepack"
set "name=Kon OS Light Theme.deskthemepack"
curl -s -L "%file%" -o "%location%\%name%"

timeout /t 1 >nul

:: ============OEM EDITING============
cls && echo Adding cool OEM info.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Manufacturer /t REG_SZ /d "Kon OS" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportURL /t REG_SZ /d "https://discord.gg/KbdbsVMppN" /f
set "file=https://github.com/ki8y/Tweaks/raw/main/OEM.bmp"
set "name=OEM.bmp"
mkdir "c:\Kon OS\Modules\Other"
set "location=C:\Kon OS\Modules\Other"
curl -s -L "%file%" -o "%location%\%name%"
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Logo /t REG_SZ /d "C:\Kon OS\Modules\Other\OEM.bmp" /f

cls && echo Adding shortcuts...
PowerShell -ExecutionPolicy Bypass -NoProfile -File "%~dp0Modules\Scripts\createShortcuts.ps1"
echo Kon OS added to desktop.
timeout /t 1 >nul 

:: ============CLEANUP (Kon + PiF)============
cls && echo.
color 9
echo                                              ╭────────────────────────────╮
echo                                              │       Cleaning Up...       │
echo                                              ╰────────────────────────────╯
echo.
echo 🛈 Clearing Kon OS temporary files...
rd /s /q "C:\Kon OS\temp" >nul 2>&1
echo 🛈 Flushing DNS...
ipconfig /flushdns >nul 2>&1
echo 🛈 Clearing %temp%... >nul 2>&1
del "%temp%" /s /f /q >nul 2>&1
rmdir /S /Q "%AppData%\Local\Temp\" >nul 2>&1
rd /s /q %LocalAppData%\Temp >nul 2>&1
rd /s /q %LocalAppData%\Temp\mozilla-temp-files >nul 2>&1
rd "%SystemDrive%\OneDriveTemp" /s /q >nul 2>&1
echo 🛈 Clearing Discord cache...
del "%AppData%\Discord\Cache\." /s /f /q >nul 2>&1
del "%AppData%\Discord\Code Cache\." /s /f /q >nul 2>&1
rd "%AppData%\Discord\Cache" /s /q >nul 2>&1
rd "%AppData%\Discord\Code Cache" /s /q >nul 2>&1
echo 🛈 Clearing Logs...
del "%ProgramData%\USOPrivate\UpdateStore" /s /f /q >nul 2>&1
del "%ProgramData%\USOShared\Logs" /s /f /q >nul 2>&1
del "%WINDIR%\Logs" /s /f /q >nul 2>&1
echo 🛈 Clearing extra files...
del "C:\Windows\System32\SleepStudy" /s /f /q >nul 2>&1
rd "%SystemDrive%\$GetCurrent" /s /q >nul 2>&1
rd "%SystemDrive%\$SysReset" /s /q >nul 2>&1
rd "%SystemDrive%\$Windows.~BT" /s /q >nul 2>&1
rd "%SystemDrive%\$Windows.~WS" /s /q >nul 2>&1
rd "%SystemDrive%\$WinREAgent" /s /q >nul 2>&1
del "%WINDIR%\Installer\$PatchCache$" /s /f /q >nul 2>&1
rmdir /s /q "%SystemRoot%\System32\SleepStudy" >nul 2>&1
rmdir /s /q "%SystemRoot%\System32\SleepStudy >nul 2>&1" >nul 2>&1
chcp 65001 >nul
echo [92m✓ Done.
chcp 437 >nul
timeout /t 1 >nul

cls
color f
mode con: cols=129 lines=30
echo.[38;5;49m
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.      ██████╗███████╗████████╗██╗   ██╗██████╗      ██████╗ ██████╗ ███╗   ███╗██████╗ ██╗     ███████╗████████╗███████╗██╗
echo.      ██╔═══╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗    ██╔════╝██╔═══██╗████╗ ████║██╔══██╗██║     ██╔════╝╚══██╔══╝██╔════╝██║
echo.      ██████╗█████╗     ██║   ██║   ██║██████╔╝    ██║     ██║   ██║██╔████╔██║██████╔╝██║     █████╗     ██║   █████╗  ██║
echo.      ╚═══██║██╔══╝     ██║   ██║   ██║██╔═══╝     ██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║     ██╔══╝     ██║   ██╔══╝  ╚═╝
echo.      ██████║███████╗   ██║   ╚██████╔╝██║         ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ███████╗███████╗   ██║   ███████╗██╗
echo.      ╚═════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝          ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝
echo.
echo.                              ╭─────────────────────────────────────────────────────────────╮                               
echo.                              │[97m 🗘         Press Any Key To Restart Your Computer...       🗘[38;5;49m │
echo.                              ╰─────────────────────────────────────────────────────────────╯
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo. [?25l
pause >nul
shutdown /r -t 0
exit

:sleep
:: Usage: call :sleep 30
ping -n 1 -w %1 127.0.0.1 >nul
exit /b

:Unused 
REM Browser Installer
echo.
echo Browser installer...
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/BrowserInstaller.bat"
set "name=Browser Installer.bat"
mkdir "c:\Kon OS\Tools\Browser Installer"
set "location=C:\Kon OS\Tools\Browser Installer"
curl -s -L "%file%" -o "%location%\%name%"