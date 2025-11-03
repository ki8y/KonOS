chcp 65001 >nul
mode con: cols=110 lines=20
@echo off
cls
title Defender Detected
color 9
echo.[?25l
echo.
echo.
echo.
echo.
echo                                    ╭──────────────────────────────────────╮
echo                                    │ 🛡️ Windows Defender is enabled (1/2) │
echo                                    ╰──────────────────────────────────────╯
echo.
timeout /t 1 >nul
echo                      Windows Defender is running. It needs to be disabled to make sure it
echo                             doesn't interfere with Kon OS's system modifications.
timeout /t 1 >nul
echo.
echo       In the following popup, click Virus and threat protection ^> Manage Settings ^> Turn everything off.
timeout /t 1 >nul
start "" "windowsdefender://"
echo.
echo                                  When you're done, press any key to continue.
pause >nul

mode con: cols=110 lines=21
cls
echo.
echo.
echo.
echo.
echo                                    ╭──────────────────────────────────────╮
echo                                    │ 🛡️ Windows Defender is enabled (2/2) │
echo                                    ╰──────────────────────────────────────╯
echo.
echo           Now that Windows Defender is off, we can disable it forever with Sordum's Defender Control
timeout /t 1 >nul
chcp 437 >nul
powershell -Command "Add-MpPreference -ExclusionPath "'%SYSTEMDRIVE%\Kon OS\Setup'" >nul
powershell -Command "Add-MpPreference -ExclusionProcess 'dControl.exe'" >nul
chcp 65001 >nul
timeout /t 1 >nul /nobreak
start "" "%SYSTEMDRIVE%\Kon OS\Modules\dControl\dControl.exe"
echo.
echo                       Once defender control opens, click on "Disable Windows Defender".
echo.
echo           When it turns red and says "Windows Defender is turned off", you can minimize the window.
echo.
echo                                           Press any key to continue.
pause >nul

powerShell -ExecutionPolicy Unrestricted -NoProfile -Command ^
"& {
    Rename-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend\Parameters' -NewName 'ParametersDISABLED'; ^
    Rename-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend' -Name ImagePath -NewName 'ImagePathDISABLED'; ^
    Rename-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\WinDefend' -Name ServiceDll -NewName 'ServiceDllDISABLED' }"
exit /b
