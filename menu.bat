@echo off
call :check_Permissions
cd %~dp0
echo 1. normal mode
echo 2. gui mode
set /p input="Select your menu:"
if "%input%" == "1" (
cd normal
start normal_mode.bat
)
if "%input%" == "2" (
cd gui
start gui_mode.bat
)




:check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    cls
) else (
    powershell.exe -Command "Start-Process -Verb RunAs -FilePath \"%~f0\""
    exit
)