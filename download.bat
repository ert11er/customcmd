@echo off
call :check_Permissions
cd /d "%~dp0"

IF EXIST ".DOWNLOADED" (
    echo Files already downloaded. Skipping download...
    goto :eof
)

:: Download essential files individually for robustness.
echo Downloading .DOWNLOADED...
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/.DOWNLOADED" -o ".DOWNLOADED" || (
    echo Error downloading .DOWNLOADED.  Aborting.
    exit /b 1
)

echo Downloading menu.bat...
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/menu.bat" -o "menu.bat" || (
    echo Error downloading menu.bat. Aborting.
    exit /b 1
)

:: Create Devmode directory and download Devmode files individually.
mkdir Devmode
if errorlevel 1 (
    echo Error creating Devmode directory. Aborting.
    exit /b 1
)
pushd Devmode
set "devmodefilepath=%cd%"

echo Downloading Devmode files...
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ddos_-t.bat" -o "ddos_-t.bat" || goto :download_error
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ddos.bat" -o "ddos.bat" || goto :download_error
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ip_gen.py" -o "ip_gen.py" || goto :download_error
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ip_list.txt" -o "ip_list.txt" || goto :download_error
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/scanip.bat" -o "scanip.bat" || goto :download_error
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/succeded.py" -o "succeded.py" || goto :download_error
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/succeeded_ips.txt" -o "succeeded_ips.txt" || goto :download_error

popd

echo "" > "%devmodefilepath%\ip_list.txt" >nul
echo "" > "%devmodefilepath%\succeeded_ips.txt" >nul


:: Create Mode directories and symbolic links. Improved error handling.
:create_directories
mkdir Normal
if errorlevel 1 (
    echo Error creating Normal directory. Aborting.
    exit /b 1
)
cd /d Normal

if not exist "%devmodefilepath%" (
    echo Error: Devmode directory not found. Aborting.
    exit /b 1
)

mklink /D Devmode "%devmodefilepath%" 2>&1 | findstr /i "ERROR" >nul
if %errorlevel% neq 0 (
    echo Error creating symbolic link in Normal directory.  Error code: %errorlevel%. Aborting.
    exit /b 1
)

cd /d ..

mkdir GUI
if errorlevel 1 (
    echo Error creating GUI directory. Aborting.
    exit /b 1
)
cd /d GUI

mklink /D Devmode "%devmodefilepath%" 2>&1 | findstr /i "ERROR" >nul
if %errorlevel% neq 0 (
    echo Error creating symbolic link in GUI directory. Error code: %errorlevel%. Aborting.
    exit /b 1
)

cd /d ..

mkdir NOUI
if errorlevel 1 (
    echo Error creating NOUI directory. Aborting.
    exit /b 1
)
cd /d NOUI
mkdir customcmd-cli
if errorlevel 1 (
    echo Error creating customcmd-cli directory. Aborting.
    exit /b 1
)
cd /d customcmd-cli

echo Downloading noui.bat...
curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/NOUI/customcmd-cli/customcmd-cli.bat" -o "customcmd-cli.bat" || (
    echo Error downloading customcmd-cli.bat. Aborting.
    exit /b 1
)

cd /d ..\..\

start main.bat
start /b "" cmd /c del "%~f0"
exit

:download_error
echo Error downloading Devmode files. Aborting.
exit /b 1

:check_Permissions
net session >nul 2>&1 & if %errorlevel% == 0 (
    cls
) else (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
    exit /b
)
