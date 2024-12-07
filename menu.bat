@echo off
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