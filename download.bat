@echo off
call :check_Permissions
cd /d "%~dp0"

IF EXIST ".DOWNLOADED" (
    echo Files already downloaded. Skipping download...
    goto :eof
)

:: Download main files
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/.DOWNLOADED" -o ".DOWNLOADED" >nul 2>&1
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/menu.bat" -o "menu.bat" >nul 2>&1

:: Create Devmode directory and download files
mkdir Devmode
pushd Devmode
set "devmodefilepath=%cd%"
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/*" -o @ - >nul 2>&1
echo "" > ip_list.txt 

echo "" > succeeded_ips.txt
cd /d ..
mkdir Normal & cd /d Normal
mklink /D Devmode "%devmodefilepath%"
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Normal/normal_mode.bat" -o "normal_mode.bat" >nul 2>&1
cd /d ..
mkdir GUI & cd /d GUI
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/GUI/gui.bat" -o "gui.bat" >nul 2>&1
cd /d ..
mkdir NOUI & cd /d NOUI
mkdir customcmd-cli & cd /d customcmd-cli
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/NOUI/noui.bat" -o "noui.bat" >nul 2>&1




:check_Permissions
net session >nul 2>&1 & if %errorlevel% == 0 (
    cls
) else (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
    exit /b
)






