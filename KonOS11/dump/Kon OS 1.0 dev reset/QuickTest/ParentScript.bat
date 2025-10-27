@echo off
echo Calling script 1 with exit /b
call "%~dp0CallThingOne.bat"
pause >nul
echo Calling script 2 with exit
call "%~dp0CallThingTwoEXIT.bat"
echo If you're seeing this, it didnt work.
pause