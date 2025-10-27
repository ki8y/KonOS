@echo off
chcp 65001 >nul 2>&1
cls
title UCPD test!
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                                              ╭───────────────────────────╮
echo                                              │  [33m⚠️   [0mUCPD Detected   [33m⚠️[0m  │
echo                                              ╰───────────────────────────╯
echo.
echo                     The user choice protection driver prevents Kon OS from properly applying tweaks.
echo          It's already been disabled, but you'll need to restart your computer for these changes to take effect.
echo                                              Sorry, blame Microsoft; not me.
echo.[0m
echo                                                      Restart this PC?
echo.
echo.[92m                                         ╭────────────╮[91m          ╭────────────╮
echo.[92m                                         │   ✅ [Y]   │[91m          │   ❎ [N]   │
echo.[92m                                         ╰────────────╯[91m          ╰────────────╯
echo.
echo.
echo.
echo.
echo.
echo.
choice /c YN /n
    title WARNING^: Hudson Valley 2 Detected^!
    cls
    color F
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo                                              ╭───────────────────────────╮
    echo                                              │ Windows 11 [33m25H2[0m detected^! │
    echo                                              ╰───────────────────────────╯
    echo.
    echo               Windows 11 25H2 is an untested version of Windows 11. It should be similar enough to 24H2 to
    echo                                run with minimal issues, but I haven't tested this myself. 
    echo                   If you encounter any bugs during or after applying these tweaks, please let me know!
    echo.
    echo                                                Press any key to continue...
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    pause >nul

    cls
    title WARNING^: Sun Valley 2 or older Detected^!
    color F
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo                                              ╭───────────────────────────╮
    echo                                              │ Windows 11 [91m22H2[0m detected^! │
    echo                                              ╰───────────────────────────╯
    echo.
    echo                                     Windows 11 22H2 is an older version of Windows.
    echo                This version of Windows is unsupported by Microsoft, missing features, and is half broken.
    echo              Unless you absolutely NEED 22H2, it's highly recommended to switch to 23H2 ^(or newer^) instead.
    echo.
    echo                                                Press any key to continue...
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    pause >nul

    cls
    title Critical Error
    color 4
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo                                              ╭───────────────────────────╮
    echo                                              │    Windows 10 detected    │
    echo                                              ╰───────────────────────────╯
    echo.
    echo       Kon OS is designed for Windows 11. Windows 10 support will be added soon as a standalone version of Kon OS.
    echo     In the meantime, attempting to use Kon OS on Windows 10 guarantees bugs and potentially system-breaking errors.
    echo                          Please upgrade to Windows 11 23H2 or higher to use Kon OS as intended.
    echo.
    echo                                               Press any key to continue...
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    pause >nul