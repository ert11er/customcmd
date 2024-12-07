@echo off
if "%~1" == "" (
    echo usage: customcmd-cli.bat COMMAND
    pause
    goto end
)
set "devmode=1"
cd %~dp0
:reset
cd %~dp0
set "scriptdir=%cd%"
chcp 65001 >nul
set "cmd=%~1"

if "%cmd%" == "help" (
    help
    echo Spatial Commands:
    if "%devmode%" == "0" (
        echo devmode /on    Opens Developer Mode
    )
    if "%devmode%" == "1" (
        echo Devmode Only Commands:
        echo ddos           Self explanatory, ddoses an IP address
        echo ddos_-t        same as ddos but it is slow and efficient
        echo scanip         Self explanatory, Scans IPs around your network
        echo devmode /off   Closes Developer Mode
    )
goto end
)

if "%cmd%" == "rmdir bin" (
    if "%devmode%" == "0" (
        echo '%cmd%' is not recognized as an internal or external command,
        echo operable program or batch file.
    )
    set /p confirm="Are you sure you want to delete this? [Y/N]: "
    if /I "%confirm%" == "N" (
        goto end
    )
    :rmdirbinbinloop
    echo BIN INSIDE OF BIN
    goto rmdirbinbinloop
)


%cmd%
if "%devmode%" == "0" (
    cd %scriptdir%
)
if "%devmode%" == "1" (
    cd %scriptdir%/Devmode
)

:end
