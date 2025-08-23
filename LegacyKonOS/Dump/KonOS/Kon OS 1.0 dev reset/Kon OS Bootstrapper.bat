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
if %errorlevel%==1 goto RestorePoint
if %errorlevel%==2 goto Unsetup


:: Restore Point.
:RestorePoint
mode con: cols=100 lines=19
cls
color 9
echo.
echo.
echo.
echo.
echo                                    ╭────────────────────────────╮
echo                                    │ [97m💾 Create A Restore Point[94m  │
echo                                    ╰────────────────────────────╯
echo.
echo            Creating a restore point can save you from a huge headache if things go wrong.
echo.
echo                                       Create a restore point?
echo.
echo.[32m                               ╭────────────╮[31m          ╭────────────╮
echo.[32m                               │   ✅ [Y]   │[31m          │   ❎ [N]   │
echo.[32m                               ╰────────────╯[31m          ╰────────────╯
choice /c YN7 /n
if %errorlevel%==1 goto CreateRestorePoint
if %errorlevel%==2 goto SkipRestorePointCHECK
if %errorlevel%==3 goto SkipRestorePointCONFIRM

:: Weed out people being a pain in the ass hopefully...
:SkipRestorePointCHECK
cls
color c
echo.
echo.
echo                                    ╭────────────────────────────╮
echo                                    │ [97m💾 Create A Restore Point[91m  │
echo                                    ╰────────────────────────────╯
echo.
echo                                           ...Are you sure?
echo.
echo             Not creating a restore point when applying system modifications can lead to
echo                            irreparable harm to your Windows installation.
echo.
echo.
echo                                  Continue without a restore point?
echo.
echo.[32m                               ╭────────────╮[31m          ╭────────────╮
echo.[32m                               │   ✅ [Y]   │[31m          │   ❎ [N]   │
echo.[32m                               ╰────────────╯[31m          ╰────────────╯
choice /c YN /n
if %errorlevel%==1 goto SkipRestorePointCONFIRM
if %errorlevel%==2 goto CreateRestorePoint

:: I love you
:CreateRestorePoint
cls
echo.[94m
echo.
echo                                    ╭────────────────────────────╮
echo                                    │ [97m💾 Creating Restore Point[94m  │
echo                                    ╰────────────────────────────╯
echo.
echo Enabling restore point if it isn't already enabled... (1/3)
chcp 437 >nul
powershell -Command "Enable-ComputerRestore -Drive \"%SYSTEMDRIVE%\\\""
echo Creating restore point... (2/3)
:: gets rid of restore point cooldown
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul
:: make da restore point 
REM powershell -Command "Checkpoint-Computer -Description 'Pre-KonOS Restore Point'"
echo Restore point created! (3/3)
echo If needed, it's named: "Pre-Kon OS Restore Point".
timeout /t 3 >nul
goto Setup

:Setup
cls
chcp 65001 >nul 2>&1
echo 💾 Downloading Defender Control... (1/many)
mkdir "C:\Kon OS\Initial Setup\Defender"
set URL="https://raw.githubusercontent.com/ki8y/KonOS/main/DefenderCheck/defenderCheck.bat"
set Name="defenderCheck.bat"
set Location="C:\Kon OS\Initial Setup\Defender"
curl -s -L "%file%" -o "%location%\%name%"
echo 💾 Downloading General Tweaks... (2/many)
echo 💾 Installing Service Control...
echo 💾 Installing blank...
echo 💾 Installing blank...
echo 💾 Installing blank...
echo 💾 Installing blank...
echo 💾 Installing blank...
echo                                  ╭─────────────────────────────────────╮
echo                                  │ 🛡️ Windows Defender is enabled (1/2) │
echo                                  ╰─────────────────────────────────────╯
echo 💾 Installing blank...

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

