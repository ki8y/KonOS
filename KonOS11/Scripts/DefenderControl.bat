cls
title Defender Detected
color 9
echo.[?25l
echo.
echo.
echo.
echo.
echo                               ╭──────────────────────────────────────╮
echo                               │ 🛡️ Windows Defender is enabled (1/2) │
echo                               ╰──────────────────────────────────────╯
echo.
timeout /t 1 >nul
echo         Windows Defender needs to be disabled to allow Kon OS to make system modifications.
echo.
echo  In the following popup, click Virus and threat protection ^> Manage Settings ^> Turn everything off.
timeout /t 2 >nul
start "" "windowsdefender://"
echo.
echo                             When you're done, press any key to continue.
pause >nul
cls
echo.
echo.
echo.
echo.
echo                               ╭──────────────────────────────────────╮
echo                               │ 🛡️ Windows Defender is enabled (2/2) │
echo                               ╰──────────────────────────────────────╯
echo.
echo            Now, we need to fully eradicate Windows Defender via Sordum's Defender Control.
timeout /t 1 >nul
chcp 437 >nul
powershell -Command Add-MpPreference -ExclusionPath "'%SYSTEMDRIVE%\Kon OS\'" >nul
chcp 65001 >nul
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/Modules/DefenderControl.exe"
set "name=dControl.exe"
mkdir "%SYSTEMDRIVE%\Kon OS\Modules\dControl"
set "location=%SYSTEMDRIVE%\Kon OS\Modules\dControl"
curl -s -L "%file%" -o "%location%\%name%"
chcp 437 >nul
powershell -Command "Add-MpPreference -ExclusionProcess 'dControl.exe'"
chcp 65001 >nul
timeout /t 1 >nul /nobreak
start "" "%SYSTEMDRIVE%\Kon OS\Modules\dControl\dControl.exe"
echo.
echo                     In the following popup, click on "Disable Windows Defender".
echo.
echo                   When it turns red, minimize dControl press any key to continue.
pause >nul
