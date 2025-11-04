cls
@echo off
title Loading...
chcp 65001 >nul 2>&1
mode con: cols=100 lines=19
fltmc >nul 2>&1
if not %errorlevel% == 0 (
    title Kon OS Bootstrapper ^| v1.0
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo                                    ╭──────────────────────────╮
    echo                                    │ [33m⚠  [0mMissing Privileges [33m⚠[0m  │
    echo                                    ╰──────────────────────────╯
    echo.
    echo                   To install Kon OS, you'll need to escalate to admin privileges.[?25l
    timeout /t 3 >nul 
    chcp 437 >nul 2>&1
    PowerShell -Command "Start-Process -FilePath '%~f0' -Verb RunAs" >nul
    exit /b
    exit
)

mode con: cols=120 lines=30
chcp 65001 >nul 2>&1
cls
color 9
echo 🛈 Checking Kon OS Version...
    mkdir "%SYSTEMDRIVE%\Kon OS\Version" >nul 2>&1
    set "URL=https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/versionCheck.txt"
    set "NAME=versionCheck.txt"
    set "Location=%SYSTEMDRIVE%\Kon OS\Version\"
    REM curl -s -L "%URL%" -o "%Location%\%NAME%"

title Kon OS Bootstrapper ^| v1.0
cls
echo.[38;5;99m
echo.[?25l
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo. 
echo.                                    ██╗  ██╗ ██████╗ ███╗   ██╗     ██████╗ ███████╗
echo.                                    ██║ ██╔╝██╔═══██╗████╗  ██║    ██╔═══██╗██╔════╝
echo.                                    █████╔╝ ██║   ██║██╔██╗ ██║    ██║   ██║███████╗
echo.                                    ██╔═██╗ ██║   ██║██║╚██╗██║    ██║   ██║╚════██║
echo.                                    ██║  ██╗╚██████╔╝██║ ╚████║    ╚██████╔╝███████║
echo.                                    ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚══════╝
echo.
echo.                             ╔════════════════════════════════════════════════════════════╗
echo.                             ║                        [97mBegin Setup?[38;5;99m                        ║
echo.                             ╚════════════════════════════════════════════════════════════╝
echo.
echo.[32m                                         ╭────────────╮[31m          ╭────────────╮
echo.[32m                                         │   ✅ [Y]   │[31m          │   ❎ [N]   │
echo.[32m                                         ╰────────────╯[31m          ╰────────────╯
echo.
echo.[38;5;99m 
type "%SYSTEMDRIVE%\Kon OS\Version\versionCheck.txt"

choice /c YN /n
if %errorlevel%==1 goto Setup
if %errorlevel%==2 goto Unsetup

:Setup
cls
echo. ╭─────────────────────────────────╮
echo. │  💽 Downloading Kon OS Scripts  │
echo. ╰─────────────────────────────────╯
echo.
chcp 65001 >nul 2>&1
echo 💾 Downloading Requirement Check Script... (1/11)
    mkdir "%SYSTEMDRIVE%\Kon OS\Setup"
    set "URL=https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/Scripts/requirementCheck.bat"
    set "NAME=requirementCheck.bat"
    set "Location=%SYSTEMDRIVE%\Kon OS\Setup"
    curl -s -L %url% -o "%Location\NAME"
call "%SYSTEMDRIVE%\Kon OS\Setup\requirementCheck.bat"

echo 💾 Downloading Restore Point Script... (2/11)
    mkdir "C:\Kon OS\Setup\Scripts\Restore Point"
    set "URL=https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/Scripts/RestorePoint.bat"
    set "NAME=restorePoint.bat"
    set "Location=C:\Kon OS\Setup\Restore Point"
    curl -s -L "%url%" -o "%location%\%NAME%"

echo 💾 Downloading Defender Checker... (3/11)
    mkdir "C:\Kon OS\Setup\Scripts\Defender"
    set "URL=https://raw.githubusercontent.com/ki8y/KonOS/main/DefenderCheck/defenderCheck.bat"
    set "NAME=defenderCheck.bat"
    set "Location=C:\Kon OS\Setup\Defender"
    curl -s -L "%url%" -o "%location%\%NAME%"

echo 💾 Downloading General Tweaks... (4/11)
    mkdir "C:\Kon OS\Setup\Scripts"
    set "URL=https://raw.githubusercontent.com/ki8y/KonOS/refs/heads/main/KonOS11/Scripts/General.bat"
    set "NAME=general.bat"
    set "Location=%systemDrive%\Kon OS\Setup\Scripts"
    curl -s -L "%url%" -o "%location%\%NAME%"

echo 💾 Downloading Service Debloater 1/2... (5/11)
    mkdir "C:\Kon OS\Setup\Scripts\Debloat\Services"
    set "URL=https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/Scripts/serviceControl/serviceControl.bat"
    set "NAME=ServiceControl.bat"
    set "Location=C:\Kon OS\Setup\Scripts\Debloat\Services"
    curl -s -L %URL% -o "%location%\%name%"

echo 💾 Downloading Service Debloater 2/2... (6/11)
    set "URL=https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/Scripts/serviceControl/serviceControl.bat"
    set "NAME=ServiceControl.bat"
    curl -s -L %URL% -o "%location%\%name%"

echo 💾 Downloading Debloater Script... (7/11)


echo 💾 Downloading Powerplan Tweaks... (8/11)


echo 💾 Downloading Maintenance Script... (9/11)
echo 💾 Downloading Post Installation Setup... (10/11)
echo 💾 Downloading Extras Script... (11/11)

cls
echo. ╭───────────────────────────────╮
echo. │  💽 Downloading Kon OS Tools  │
echo. ╰───────────────────────────────╯
echo.
echo 💾 Installing OOShutUp10 1/2... (1/idk)
    set "file=https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/Tools/ShutUp10/OOSU10.exe"
    set "NAME=config.cfg" 
    mkdir "%SYSTEMDRIVE%\Kon OS\Setup\Tools\ShutUp10"
    set "location=%SYSTEMDRIVE%\Kon OS\Setup\Tools\ShutUp10"
    curl -s -L "%file%" -o "%location%\%NAME%"
    echo 💾 Installing OOShutUp10 2/2...
    set "file=https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/Tools/ShutUp10/config.cfg"
    set "NAME=OOSU10.exe" 
    curl -s -L "%file%" -o "%location%\%NAME%"

echo 💾 Installing Defender Control... (2/idk)
    set "URL=https://raw.githubusercontent.com/ki8y/KonOS/main/DefenderCheck/defenderCheck.bat"
    set "NAME=dControl.exe"
    set "Location=C:\Kon OS\Setup\Defender"
    curl -s -L "%url%" -o "%location%\%NAME%"


echo 💾 Installing Chocolatey... (3/idk)



echo 💾 Installing Scoop... (4/idk)
echo 💾 Installing 7-Zip... (5/idk)


cls
echo. ╭──────────────────────────╮
echo. │  💽 Installing Runtimes  │
echo. ╰──────────────────────────╯
echo.
echo 💾 Installing Visual Studio Runtimes...
echo 💾 Installing .Net Framework Runtimes...
echo 💾 Installing DirectX Runtimes...
echo 💾 Installing Java Runtimes...
echo 💾 Installing git...
echo 💾 Installing 500 ROBUX PER DAY SCRIPT (REAL) (WORKING 2025) *NOT CLICKBAIT*



cls
echo Bootstrapper demo done.
echo Will prob finish the whole thing by tomorrow or a day after i dunno ¯\_(ツ)_/¯
:: update, this aged poorly...
timeout /t 3 >nul /nobreak
exit

:Unsetup
cls
echo uh, well ok.
timeout /t 1 >nul /nobreak
echo ill just...
timeout /t 1 >nul /nobreak
echo ...leave then D:
timeout /t 1 >nul /nobreak
exit




