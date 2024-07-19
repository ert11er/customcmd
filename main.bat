@echo off
cd %~dp0
call :check_Permissions
call :download
:reset
cd %~dp0
cls
set "scriptdir=%cd%"
chcp 65001 >nul
echo Microsoft Windows [Version 10.0.19045.4598]
echo (c) Microsoft Corporation. Tüm hakları saklıdır.
echo.
set "devmode=0"
title Komut İstemi
:input
set "input=%cd%"
set "cmd="
if "%devmode%" == "0" (
cd %scriptdir%
)
if "%devmode%" == "1" (
cd %scriptdir%/Devmode
)
set /p cmd="%input%>"
if "%cmd%" == "devmode /on" (
color 2
set "devmode=1"
cd %scriptdir%/Devmode
goto input
)
if "%cmd%" == "devmode /off" (
if "%devmode%" == "1" (
color 7
cd..
set "devmode=0"
goto input
)
echo '%cmd%' is not recognized as an internal or external command,
echo operable program or batch file.
goto input
)
if "%cmd%" == "help" (
help
echo Spatial Commands:
if "%devmode%" == "0" (
echo devmode /on    Opens Developer Mode
)
if "%devmode%" == "1" (
echo Devmode Only Commands:
echo ddos           Self explanatory, ddoses a ip address
echo ddos_-t        same as ddos but it is slow and efficient
echo scanip         Self explanatory, Scans ips around your network
echo devmode /off   Closes Developer Mode
)
goto input
)
if "%cmd%" == "rmdir bin" (
if "%devmode%" == "0" (
echo '%cmd%' is not recognized as an internal or external command,
echo operable program or batch file.
goto input
)
set /p cmd="Are you sure you want to delete this?[Y/N]:"
if "%cmd%" == "N" (
goto input
)
:rmdirbinbinloop
echo BIN INSIDE OF BIN
goto rmdirbinbinloop
)
if "%cmd%" == "cd devmode" (
if "%devmode%" == "0" (
cd ısejıofjerıofjsepo
goto input
)
)
if "%cmd%" == "cd Devmode" (
if "%devmode%" == "0" (
cd ısejıofjerıofjsepo
goto input
)
)
%cmd%
if "%devmode%" == "0" (
cd %scriptdir%
)
if "%devmode%" == "1" (
cd %scriptdir%/Devmode
)
goto input
:check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    goto reset
) else (
    powershell.exe -Command "Start-Process -Verb RunAs -FilePath \"%~f0\""
    exit
)


:download
REM Check if ".DOWNLOADED" file exists
if exist ".DOWNLOADED" (
    goto reset
) else (
    curl https://raw.githubusercontent.com/ert11er/customcmd/main/download.bat -o download.bat >nul
    start download.bat
    goto reset
)
