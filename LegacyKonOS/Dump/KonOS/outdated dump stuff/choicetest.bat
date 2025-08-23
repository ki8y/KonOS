@echo off
echo Choose wisely.
echo [1] [2] [3] [4]
choice /c 1234 /n
if %errorlevel%==1 (
    echo Erorr level 1!
    pause >nul
)
if %errorlevel%==2 (
    echo Erorr level 2!
    pause >nul
)
if %errorlevel%==3 (
    echo Erorr level 3!
    pause >nul
)
if %errorlevel%==4 (
    echo Erorr level 4!
    pause >nul
)

:Exit 
echo I hope you had fun. :)
pause >nul