@echo off

:: Set initial variables
set "script_dir=%~dp0"
set "dev_mode=0"

:: Request admin privileges
call :check_permissions

:main
    :: Reset to script directory and clear screen
    cd "%script_dir%"
    cls
    
    :: Set console encoding and title 
    chcp 65001 >nul
    title Komut İstemi
    
    :: Display header
    echo Microsoft Windows [Version 10.0.19045.4598]
    echo (c) Microsoft Corporation. Tüm hakları saklıdır.
    echo.
    
    :: Get user input
    set "input=%cd%"
    set "cmd="
    set /p "cmd=%input%>"
    
    :: Process commands
    if "%cmd%" == "devmode /on" (
        color 2
        set "dev_mode=1"
        cd "%script_dir%\Devmode"
        goto main
    )
    
    if "%cmd%" == "devmode /off" (
        if "%dev_mode%" == "1" (
            color 7
            cd "%script_dir%"  
            set "dev_mode=0"
        ) else (
            call :invalid_command
        )
        goto main
    )
    
    if "%cmd%" == "help" (
        call :show_help
        goto main
    )
    
    if "%cmd%" == "rmdir bin" (
        if "%dev_mode%" == "0" (
            call :invalid_command
            goto main
        )
        call :rmdir_bin
        goto main
    )
    
    if "%cmd%" == "cd devmode" (
        if "%dev_mode%" == "0" (
            cd ısejıofjerıofjsepo
        )
        goto main
    )
    
    if "%cmd%" == "cd Devmode" (
        if "%dev_mode%" == "0" (
            cd ısejıofjerıofjsepo
        )
        goto main
    )
    
    :: Execute user command
    %cmd%
    goto main

:: Functions    
:check_permissions
    net session >nul 2>&1
    if %errorLevel% == 0 (
        goto :EOF
    ) else (
        powershell.exe -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
        exit
    )
    
:invalid_command
    echo '%cmd%' is not recognized as an internal or external command,
    echo operable program or batch file.
    goto :EOF
    
:show_help
    help
    echo Spatial Commands:
    if "%dev_mode%" == "0" (
        echo devmode /on    Opens Developer Mode
    ) else (
        echo Devmode Only Commands:
        echo ddos           Self explanatory, ddoses a ip address
        echo ddos_-t        same as ddos but it is slow and efficient
        echo scanip         Self explanatory, Scans ips around your network 
        echo devmode /off   Closes Developer Mode
    )
    goto :EOF
    
:rmdir_bin
    set /p "confirm=Are you sure you want to delete this? [Y/N]: "
    if /i "%confirm%" == "N" goto :EOF
    
    :rmdir_bin_loop
        echo BIN INSIDE OF BIN
        goto rmdir_bin_loop
