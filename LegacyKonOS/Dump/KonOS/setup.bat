@echo off
mode con: cols=69 lines=3
title Post Installation Config
chcp 65001 >nul 2>&1
::taskkill /f /im explorer.exe
setlocal EnableDelayedExpansion
::echo Loading...
echo.
set "bar=[                    ]"
set /a i=1
set "barWidth=50"
set "total=100"
:: Pad to ensure consistent line length
set "pad=                                                  "  :: 50+ spaces
for /L %%i in (1,1,%total%) do (
    set /a percent=%%i
    set /a filled=percent * barWidth / 100

    set "bar=      [[38;5;99m"
    for /L %%b in (1,1,!filled!) do set "bar=!bar!█"
    set /a next=filled + 1
    for /L %%b in (!next!,1,%barWidth%) do set "bar=!bar!·"

    set "bar=!bar![97m] !percent!%%"

    :: Pad the end with spaces to overwrite leftover characters
    set "line=!bar!!pad!"
    set "line=!line:~0,80!"

    call :sleep
    <nul set /p=[G!line!
)
endlocal
ping localhost -n 2 >nul 2>&1
cls
chcp 437 >nul
mode con: cols=45 lines=3
echo Hello, %username%!
ping localhost -n 2 >nul 2>&1
echo Thanks for installing [38;5;99mKon OS.[97m
ping localhost -n 2 >nul 2>&1

:setup
chcp 65001 >nul 2>&1
mode con: cols=50 lines=30
cls
echo.  [97m
echo      ╔══════════════════════════════════════╗
echo      ║         [33mChoose a text editor[97m         ║
echo      ╚══════════════════════════════════════╝
echo.
echo [97m[1] Notepad++
echo [97m[2] Sublime Text
echo [97m[3] Visual Studio Code
echo [97m[4] Brackets
echo [97m[5] Neovim
:: echo [97m[1] [92mNotepad++
:: echo [97m[2] [38;5;208mSublime Text
:: echo [97m[3] [38;5;33mVisual Studio Code
:: echo [97m[4] [38;5;75mBrackets
:: echo [97m[5] [38;5;39mNeo[38;5;34mvim
pause >nul

:Apps
cls
echo ==========[App Manager]==========
echo [1] Discord
echo [2] Bloxstrap
echo [3] OBS
echo [4] Spotify

:sleep
:: Usage: call :sleep 30
ping -n 1 -w %1 127.0.0.1 >nul
exit /b
[██████████████████████████████████████████████████] 100%
C:\Users\Wybie>.........................................................................................................
