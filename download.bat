@echo off
call :check_Permissions
cd /d "%~dp0"

IF EXIST ".DOWNLOADED" (
    echo Files already downloaded. Skipping download...
    goto :eof
)

:: Download essential files individually for robustness.
echo Downloading .DOWNLOADED...
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/.DOWNLOADED" -o ".DOWNLOADED"

echo Downloading menu.bat...
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/menu.bat" -o "menu.bat"

:: Create Devmode directory and download Devmode files individually.
mkdir Devmode
pushd Devmode
set "devmodefilepath=%cd%"

echo Downloading Devmode files...
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ddos_-t.bat" -o "ddos_-t.bat"
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ddos.bat" -o "ddos.bat"
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ip_gen.py" -o "ip_gen.py"
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ip_list.txt" -o "ip_list.txt"
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/scanip.bat" -o "scanip.bat"
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/succeded.py" -o "succeded.py"
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/succeeded_ips.txt" -o "succeeded_ips.txt"

popd

echo "" > "%devmodefilepath%\ip_list.txt" >nul
echo "" > "%devmodefilepath%\succeeded_ips.txt"

:: Create Mode directories and symbolic links.  Error handling added.
mkdir Normal & cd /d Normal
if not exist "%devmodefilepath%" (
    echo Error: Devmode directory not found.
    goto :eof
)
if errorlevel 1 (
    echo Error creating symbolic link in Normal directory.
    goto :eof
)

mklink /D Devmode "%devmodefilepath%" 2>&1 | findstr /i "ERROR" >nul
if %errorlevel% neq 0 (
    echo Error creating symbolic link in Normal directory.
    goto :eof
)

cd /d ..
mkdir GUI & cd /d GUI

mklink /D Devmode "%devmodefilepath%" 2>&1 | findstr /i "ERROR" >nul
if %errorlevel% neq 0 (
    echo Error creating symbolic link in GUI directory.
    goto :eof
)

cd /d ..
mkdir NOUI & cd /d NOUI
mkdir customcmd-cli & cd /d customcmd-cli

echo Downloading noui.bat...
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/NOUI/customcmd-cli/customcmd-cli.bat" -o "customcmd-cli.bat"

mklink /D Devmode "%devmodefilepath%" 2>&1 | findstr /i "ERROR" >nul
if %errorlevel% neq 0 (
    echo Error creating symbolic link in NOUI directory.
    goto :eof
)

cd /d ..\..\

start main.bat
start /b "" cmd /c del "%~f0"
exit

:check_Permissions
net session >nul 2>&1 & if %errorlevel% == 0 (
    cls
) else (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
    exit /b
)
