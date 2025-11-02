@echo off
title Kon OS Bootstrapper
echo Loading...
set setup="%SystemDrive%\Kon OS\Setup"
set "url=https://raw.githubusercontent.com/ki8y/KonOS/main/Kon_OS.bat"
set "name=Kon OS.bat"
set "location=%SystemDrive%\Kon OS\Setup"
curl -L -s "%url%" -o "%location%\%name%"
cls
call "%~dp0\Kon OS.bat" >nul
rmdir /s /q %setup%
