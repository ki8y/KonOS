:defenderheh
cls
title Defender Detected
color 9
echo.[?25l
echo.
echo.
echo.
echo.
echo                                  ╭────────────────────────────────╮
echo                                  │ 🛡️ Windows Defender is enabled │
echo                                  ╰────────────────────────────────╯
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
echo Now, disable it for good using a tool called "Defender Control" (or "dControl" for short)
timeout /t 1 >nul
echo 🖥️ Installing dControl...
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
ping -n 1 -w %1 127.0.0.1 >nul
start "" "%SYSTEMDRIVE%\Kon OS\Modules\dControl\dControl.exe"
timeout /t 1 >nul
echo.
echo After dControl opens, click on "Disable Windows Defender". When it turns red, click any key to continue.
pause >nul