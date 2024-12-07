@echo off
call :check_Permissions & cd /d "%~dp0"
curl -L https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/.DOWNLOADED -o .DOWNLOADED
curl -L https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/menu.bat -o menu.bat
mkdir devmode & cd /d devmode
set "devmodefilepath=%cd%"
curl -L https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ddos.bat -o ddos.bat
curl -L https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ddos_-t.bat -o ddos_-t.bat
curl -L https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ip_gen.py -o ip_gen.py
echo. > ip_list.txt
curl -L https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/scanip.bat -o scanip.bat
curl -L https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/succeded.py -o succeded.py
echo. > succeded_ips.txt
cd /d .. & mkdir normal & cd /d normal
mklink /D Devmode "%devmodefilepath%"
curl -L https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/normal/normal_mode.bat -o normal_mode.bat
cd /d .. & mkdir gui & cd /d gui
curl -L https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/gui/gui_mode.bat -o gui_mode.bat
mklink /D Devmode "%devmodefilepath%"
cd /d .. & mkdir NOUI & cd /d NOUI & mkdir customcmd-cli & cd /d customcmd-cli


:check_Permissions
net session >nul 2>&1 & if %errorlevel% == 0 (
    cls
) else (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
    exit /b
)






