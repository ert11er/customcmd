@echo off
call :check_Permissions
cd %~dp0
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/.DOWNLOADED -o .DOWNLOADED
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/menu.bat -o menu.bat
mkdir devmode
cd devmode
set devmodefilepath="%cd%"
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ddos.bat -o ddos.bat
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ddos_-t.bat -o ddos_-t.bat
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ip_gen.py -o ip_gen.py
echo. >> ip_list.txt
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/scanip.bat -o scanip.bat
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/succeded.py -o succeded.py
echo. >> succeded_ips.txt
cd..
mkdir normal
cd normal
mklink /D Devmode "%devmodefilepath%"
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/normal/normal_mode.bat -o normal_mode.bat
cd ..
mkdir gui
cd gui
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/gui/gui_mode.bat -o gui_mode.bat
mklink /D Devmode "%devmodefilepath%"
cd..



:check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    cls
) else (
    powershell.exe -Command "Start-Process -Verb RunAs -FilePath \"%~f0\""
    exit
)