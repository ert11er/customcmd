@echo off
call :check_Permissions
cd /d "%~dp0"

IF EXIST ".DOWNLOADED" (
    echo Files already downloaded. Skipping download...
    goto :eof
)

:: Download .DOWNLOADED file
echo Downloading .DOWNLOADED...
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/.DOWNLOADED" -o ".DOWNLOADED"

:: Download menu.bat
echo Downloading menu.bat...
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/menu.bat" -o "menu.bat"

:: Create Devmode directory and download Devmode files
mkdir Devmode
pushd Devmode
set "devmodefilepath=%cd%"
echo Downloading Devmode files... 
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/*" -o "%devmodefilepath%\%~nxF" >nul
echo "" > "%devmodefilepath%\ip_list.txt"
echo "" > succeeded_ips.txt
cd /d ..
mkdir Normal & cd /d Normal
mklink /D Devmode "%devmodefilepath%"
:: Download normal_mode.bat
echo Downloading normal_mode.bat...
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/normal/normal_mode.bat" -o "normal_mode.bat" >nul
cd /d ..
mkdir GUI & cd /d GUI
:: Download gui.bat
echo Downloading gui.bat...
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/GUI/gui.bat" -o "gui.bat" >nul
cd /d ..
mkdir NOUI & cd /d NOUI
mkdir customcmd-cli & cd /d customcmd-cli
echo Downloading noui.bat...
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/NOUI/customcmd-cli/customcmd-cli.bat" -o "customcmd-cli.bat" >nul
mklink /D Devmode "%devmodefilepath%"


:check_Permissions
net session >nul 2>&1 & if %errorlevel% == 0 (
    cls
) else (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
    exit /b
)






