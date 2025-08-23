@echo off
fltmc >nul 2>&1
chcp 65001 >nul 2>&1
if not %errorlevel% == 0 (
echo [97;101mError: Not running as admin.
    PowerShell Start -Verb RunAs '%0'
    exit /b 0
)

mode con: cols=69 lines=3
title Kon OS EZ-Config
cls
setlocal EnableDelayedExpansion
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

    <nul set /p=[G!line!
)
endlocal

cls
mode con: cols=160 lines=22
echo.[38;5;99m
echo.
echo.                                                        ██╗  ██╗ ██████╗ ███╗   ██╗     ██████╗ ███████╗
echo.                                                        ██║ ██╔╝██╔═══██╗████╗  ██║    ██╔═══██╗██╔════╝
echo.                                                        █████╔╝ ██║   ██║██╔██╗ ██║    ██║   ██║███████╗
echo.                                                        ██╔═██╗ ██║   ██║██║╚██╗██║    ██║   ██║╚════██║
echo.                                                        ██║  ██╗╚██████╔╝██║ ╚████║    ╚██████╔╝███████║
echo.                                                        ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚══════╝
echo.
echo                                                             [97m╔══════════════════════════════════════╗   
echo                                                             ║            [38;5;99mEZ-Config Mode[97m            ║
echo                                                             ╚══════════════════════════════════════╝
echo. 
echo.[0m
echo.
echo.
echo                                                      [1] Wifi Control                    [2] Alt Tab Config                                                    
echo.
echo                                        [3] Bluetooth Control                                        [4] Service control
echo.
echo                                                      [5] Power Plans                     [6] Timer Resolution                                                   
pause >nul

::╭───────── Advanced ─────────╮
::│╭────────╮╭─────────╮       │
::││Sampling││Dithering│       │ stole this lol
::││        └┴─────────┴──────┐│
::││                          ││
::││ Select Method            ││
::││   Nearest Neighbor       ││
::││   Bicubic                ││
::││   Bilinear               ││
::││   Lanczos2               ││
::││   Lanczos3               ││
::││   MitchellNetravali      ││
::││                          ││
::│└──────────────────────────┘│
::╰────────────────────────────╯