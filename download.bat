@echo off
call :check_Permissions
cd %~dp0
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/menu.bat -o menu.bat
mkdir normal
cd normal
mkdir Devmode
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/normal/normal_mode.bat -o normal_mode.bat
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/normal/.DOWNLOADED -o normal_mode.bat
cd Devmode
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/normal/Devmode/ddos.bat -o ddos.bat
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/normal/Devmode/ddos_-t.bat -o ddos_-t.bat
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/normal/Devmode/ip_gen.py -o ip_gen.py
echo. >> ip_list.txt
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/normal/Devmode/scanip.bat -o scanip.bat
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/normal/Devmode/succeded.py -o succeded.py
echo. >> succeded_ips.txt
cd ..
cd ..
mkdir gui
cd gui
mkdir Devmode
curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/gui/gui_mode.bat -o gui_mode.bat

:check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    cls
) else (
    powershell.exe -Command "Start-Process -Verb RunAs -FilePath \"%~f0\""
    exit
)