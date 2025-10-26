chcp 437 >nul 2>&1
mode con: cols=120 lines=30

color F
for /f %%i in ('powershell -Command "[System.Environment]::OSVersion.Version.Build"') do set build=%%i
chcp 65001 >nul 2>&1
if %build% GEQ 26200 (
    title WARNING^: Hudson Valley 2 Detected^!
    cls
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
    goto UCPD
) else if %build% GEQ 22631 (
    goto UCPD
) else if %build% GEQ 22621 (
    cls
    title WARNING^: Sun Valley 2 or older Detected^!
    color 6
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
    echo                                              │ Windows 11 [31m22H2[0m detected^! │
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
    goto UCPD
) else if %build% LSS 22000 (
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
    exit
) else (
    goto UCPD
)
endlocal
goto :UCPD

:UCPD
cls
echo Checking if the User Choice Protection Driver is running...
timeout /t 1 >nul
setlocal
set "ServiceName=ucpd"
for /f "tokens=3 delims=: " %%A in ('sc query "%ServiceName%" ^| findstr "STATE"') do (
    if /I "%%A" NEQ "RUNNING" (
        cls
        echo UCPD is disabled. Continuing...
        timeout /t 1 >nul
        exit /b
    )
)
schtasks /Change /TN "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity" /Disable
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UCPD" /v Start /t REG_DWORD /d 4 /f
sc config UCPD start= disabled
cls
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
if %errorlevel%==1 shutdown /r -t 0 && pause >nul
if %errorlevel%==2 exit
endlocal
