@echo off
set ESC=[

:: Color List
set DarkRed=[31m

mode con: cols=69 lines=3
title Post Installation Config
chcp 65001 >nul 2>&1
::taskkill /f /im explorer.exe
setlocal EnableDelayedExpansion
::echo Loading...
echo. %ESC%?25l
set "bar=[                    ]"
set /a i=1
set "barWidth=50"
set "total=100"
:: Pad to ensure consistent line length
set "pad=                                                  "  :: 50+ spaces
for /L %%i in (1,1,%total%) do (
    set /a percent=%%i
    set /a filled=percent * barWidth / 100

    set "bar=      [%ESC%38;5;99m"
    for /L %%b in (1,1,!filled!) do set "bar=!bar!█"
    set /a next=filled + 1
    for /L %%b in (!next!,1,%barWidth%) do set "bar=!bar!·"

    set "bar=!bar!%ESC%97m] !percent!%%"

    :: Pad the end with spaces to overwrite leftover characters
    set "line=!bar!!pad!"
    set "line=!line:~0,80!"

    call :sleep
    <nul set /p=%ESC%G!line!
)
endlocal
ping localhost -n 2 >nul 2>&1
REM taskkill /f /im explorer.exe >nul 2>&1
cls
chcp 437 >nul
mode con: cols=45 lines=4
echo.
echo                   Hello!                    
ping localhost -n 2 >nul 2>&1
echo         Thanks for installing %ESC%38;5;99mKon OS.%ESC%97m
ping localhost -n 2 >nul 2>&1

:setup
setlocal
:: Check if Windows is activated using PowerShell (LicenseStatus = 1 means activated)
for /f %%A in ('powershell -NoProfile -Command "(Get-CimInstance -Query \"SELECT * FROM SoftwareLicensingProduct WHERE PartialProductKey IS NOT NULL\").LicenseStatus -contains 1"') do set "activated=%%A"

if /i "%activated%"=="True" (
    echo Windows is activated.
    echo Continuing...
    timeout /t 1 >nul /nobreak
    goto :Manager
) else (
    goto :unactivated
)

:unactivated
cls
chcp 65001 >nul 2>&1
mode con: cols=51 lines=30
cls    
echo.
echo      ╔═══════════════════════════════════════╗
echo      ║     %ESC%38;5;99mKon OS AIO post-install setup%ESC%97m     ║
echo      ╚═══════════════════════════════════════╝
echo.
echo   Windows needs to be activated to properly use
echo           Kon OS. Activate Windows now?
echo.
echo %ESC%4m[Y] Yes │ [N] No%ESC%0m
choice /c YN /n
if %errorlevel%==1 goto :MAS
if %errorlevel%==2 cls && echo Skipping activation... Proceed with caution! && timeout /t 2 >nul && goto :TextEditor

:MAS
cls
echo Installing MassGrave's Microsoft
echo Activation Script...
set "file=https://github.com/massgravel/Microsoft-Activation-Scripts/archive/master.zip"
set "name=MAS.zip"
mkdir "C:\Kon OS\Modules\Activation\MAS" >nul
set "location=C:\Kon OS\Modules\Activation\MAS"
curl -s -L "%file%" -o "%location%\%name%"
echo.
echo Extracting...
7z x "C:\Kon OS\Modules\Activation\MAS\MAS.zip" -o"C:\Kon OS\Modules\Activation\MAS\MASAIO" >nul
echo Launching...
start "" "C:\Kon OS\Modules\Activation\MAS\MASAIO\Microsoft-Activation-Scripts-master\MAS\All-In-One-Version-KL\MAS_AIO.cmd"
cls
mode con: cols=55 lines=25
echo When MAS opens, click %ESC%92m[1]%ESC%97m for HWID activation.
echo (If this fails, you can also try %ESC%93m[3]%ESC%97m!)
echo.
echo After you're finished, press any key to continue.
pause >nul

:TextEditor
cls
mode con: cols=45 lines=12
echo.
echo         ╭────────────────────────╮
echo         │ Choosing a Text Editor │
echo         ╰────────────────────────╯
echo.  
echo            [1] Sublime Text
echo            [2] Notepad++%ESC%33m* %ESC%97m
echo            [3] Visual Studio Code
echo            [4] None (Notepad)
echo.
echo   🛈 if unsure, select [2].
chcp 437 >nul 2>&1
choice /c 1234 /n
if %errorlevel%==1 (
    cls
    echo Installing Sublime Text...
    choco install sublimetext4 -y
)
if %errorlevel%==2 (
    cls
    echo Installing Notepad++...
    choco install notepadplusplus -y
)
if %errorlevel%==3 (
    cls
    echo Installing Visual Studio Code...
    choco install vscode -y
)
if %errorlevel%==4 (
    cls
    echo Skipping...
)
chcp 65001 >nul 2>&1
echo %ESC%92m✓ Done. %ESC%0m
ping localhost -n 2 >nul 2>&1
goto :Browser

:Browser
cls
mode con: cols=70 lines=12
echo.
echo                       ╭────────────────────────╮
echo                       │   Choosing a Browser   │
echo                       ╰────────────────────────╯
echo.  
echo             [1] Brave                      [4] Ungoogled Chromium
echo             [2] Firefox                    [5] Google Chrome*
echo             [3] Librewolf                  [6] Microsoft Edge*
echo.
echo.
echo   🛈 if unsure, select [1].
chcp 437 >nul 2>&1
choice /c 123456 /n
if %errorlevel%==1 (
    cls
    echo Installing Brave...
    choco install brave -y
)
if %errorlevel%==2 (
    cls
    echo Installing Firefox...
    choco install firefox -y
)
if %errorlevel%==3 (
    cls
    echo Installing Librewolf...
    choco install librewolf -y
)
if %errorlevel%==4 (
    cls
    echo Installing Ungoogled Chromium...
    choco install ungoogled-chromium -y
)
if %errorlevel%==5 (
    cls
    goto ChromeWarning
)
if %errorlevel%==6 (
    cls
    goto EdgeWarning
)
chcp 65001 >nul 2>&1
echo %ESC%92m✓ Done. %ESC%0m
ping localhost -n 2 >nul 2>&1
goto :Apps

:: Trash browser warning LMFAO
:ChromeWarning
echo %ESC%91m[!] Warning! %ESC%0m
echo.
echo Google Chrome is not a recommended browser due to
echo heavy telemetry Google has implemented. It is recommended to use
echo something like Brave or Ungoogled Chromium instead.
echo.
echo Proceed anyway?
choice /c YN /n
if %errorlevel%==1 (
    choco install googlechrome
)
if %errorlevel%==2 goto Browser
chcp 65001 >nul 2>&1
echo %ESC%92m✓ Done. %ESC%0m
ping localhost -n 2 >nul 2>&1
goto Apps

:EdgeWarning
echo %ESC%91m[!] Warning! %ESC%0m
echo.
echo Microsoft Edge is not a recommended browser due to
echo heavy telemetry Microsoft has implemented. It is recommended to use
echo something like Brave or Ungoogled Chromium instead.
echo.
echo Proceed anyway?
choice /c YN /n
if %errorlevel%==1 (
    choco install microsoft-edge
)
if %errorlevel%==2 goto Browser
chcp 65001 >nul 2>&1
echo %ESC%92m✓ Done. %ESC%0m
ping localhost -n 2 >nul 2>&1
goto Apps


:: Other extra apps you can install.
:Apps
cls
echo ==========[App Manager]==========
echo [1] Discord
echo [2] Bloxstrap
echo [3] OBS
echo [4] Spotify
echo
echo unfinished gui lolelelelell
pause


:sleep
:: Usage: call :sleep 30
:: ping -n 1 -w %1 127.0.0.1 >nul
exit /b
[██████████████████████████████████████████████████] 100%
C:\Users\Wybie>.........................................................................................................