chcp 437 >nul 2>&1
mode con: cols=120 lines=30


for /f %%i in ('powershell -Command "[System.Environment]::OSVersion.Version.Build"') do set build=%%i
chcp 65001 >nul 2>&1
if %build% GEQ 26200 (
    title WARNING^: Hudson Valley 2 Detected^!
    cls
    echo                                             ╭───────────────────────────╮
    echo                                             │ Windows 11 [33m25H2[0m detected^! │
    echo                                             ╰───────────────────────────╯
    echo.
    echo Windows 11 25H2 is an untested version of Windows 11. It should be similar enough to 24H2 to
    echo allow the script to function just as normally as intended, but I can't confirm this without testing
    echo it myself or getting other people to try it.
    echo.
    echo Press any key to continue.
    pause >nul
    goto UCPD
) else if %build% GEQ 22631 (
    goto UCPD
) else if %build% GEQ 22621 (
    cls
    title WARNING^: Sun Valley 2 or older Detected^!
    color 6
    echo                                             ╭───────────────────────────╮
    echo                                             │ Windows 11 [31m22H2[0m detected^! │
    echo                                             ╰───────────────────────────╯
    echo.
    echo Windows 11 22H2 is an older version of Windows.
    echo This version of Windows is unsupported by Microsoft, missing features, and is half broken.
    echo Unless you absolutely NEED 22H2, it's highly recommended to switch to 23H2 ^(or newer^) instead.
    echo.
    echo [33mPress any key to proceed anyway.[0m
    pause >nul
    color F
) else if %build% LSS 22000 (
    cls
    title Critical Error
    color 4
    echo                                             ╭───────────────────────────╮
    echo                                             │    Windows 10 detected    │
    echo                                             ╰───────────────────────────╯
    echo.
    echo Kon OS is designed for Windows 11. Windows 10 support will be added soon as a standalone version of Kon OS.
    echo Please upgrade to Windows 11 23H2 or higher to use Kon OS as intended.
    echo.
    echo [33mPress any key to exit.[0m
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
echo                                             ╭───────────────────────────╮
echo                                             │ ⚠️     UCPD Detected      │
echo                                             ╰───────────────────────────╯
echo.
echo Unfortunately, the UCPD service is running. It must be disabled.
echo Good news is, this has already been done for you. The bad news is, this service
echo is super stubborn, and disabling it requires a PC restart.
echo.
echo Restart now?
choice /c YN /n /m "[Y] Yes  [N] No: "
if %errorlevel%==1 shutdown /r -t 0 && pause >nul
if %errorlevel%==2 exit
endlocal
