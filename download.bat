@echo off
call :check_Permissions
cd %~dp0
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/.DOWNLOADED -o .DOWNLOADED
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/menu.bat -o menu.bat
mkdir normal
cd normal
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/normal/normal_mode.bat -o normal_mode.bat
cd ..
mkdir gui
cd gui
mkdir Devmode
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/gui/gui_mode.bat -o gui_mode.bat
cd Devmode


:check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    cls
) else (
    powershell.exe -Command "Start-Process -Verb RunAs -FilePath \"%~f0\""
    exit
)