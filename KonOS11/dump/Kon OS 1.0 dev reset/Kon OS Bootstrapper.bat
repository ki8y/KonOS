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
color f
mkdir "%~dp0Scripts\Version" >nul 2>&1
set "URL=https://raw.githubusercontent.com/ki8y/KonOS/main/General/versionCheck.txt"
set "Name=versionCheck.txt"
set "Location=%~dp0Scripts\Version"
color 9
curl -s -L "%URL%" -o "%Location%\%Name%"
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
type "%~dp0Scripts\Version\versionCheck.txt"

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
echo 💾 Downloading Restore Point Script... (1/many)
mkdir "C:\Kon OS\Setup\Restore Point"
set URL="https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/Scripts/RestorePoint.bat"
set Name="restorePoint.bat"
set Location="C:\Kon OS\Setup\Restore Point"
curl -s -L "%file%" -o "%location%\%name%"

echo 💾 Downloading Defender Control... (2/many)
mkdir "C:\Kon OS\Setup\Defender"
set URL="https://raw.githubusercontent.com/ki8y/KonOS/main/DefenderCheck/defenderCheck.bat"
set Name="defenderCheck.bat"
set Location="C:\Kon OS\Setup\Defender"
curl -s -L "%file%" -o "%location%\%name%"



echo 💾 Downloading General Tweaks... (3/many)
echo 💾 Installing Service Control...
echo 💾 Installing blank...
echo 💾 Installing blank...
echo 💾 Installing blank...
echo 💾 Installing blank...
echo 💾 Installing blank...

cls
echo. ╭───────────────────────────────╮
echo. │  💽 Downloading Kon OS Tools  │
echo. ╰───────────────────────────────╯
echo.
echo 💾 Installing OOShutUp10... (1/many)
set "file=https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/Tools/ShutUp10/OOSU10.exe"
set "name=config.cfg" 
mkdir "%SYSTEMDRIVE%\Kon OS\Setup\Tools\ShutUp10"
set "location=%SYSTEMDRIVE%\Kon OS\Setup\Tools\ShutUp10"
curl -s -L "%file%" -o "%location%\%name%"
set "file=https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/Tools/ShutUp10/config.cfg"
set "name=OOSU10.exe" 
curl -s -L "%file%" -o "%location%\%name%"



cls
echo Bootstrapper demo done.
echo Will prob finish the whole thing by tomorrow or a day after i dunno ¯\_(ツ)_/¯
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

