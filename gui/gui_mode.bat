@echo off

:: Set initial variables
set "script_dir=%~dp0"
set "dev_mode=0"

:main
    :: Reset to script directory
    cd "%script_dir%"
    
    :: Set console encoding
    chcp 65001 >nul
    
    :: Get user input
    set "input=%cd%"
    set "cmd="
    if "%dev_mode%" == "0" (
        powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('%input%>', 'Command Prompt')}" > "%temp%\out.tmp"
    ) else (
        powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('Devmode>', 'Command Prompt')}" > "%temp%\out.tmp"
    )
    set /p "cmd=" < "%temp%\out.tmp"
    
    :: Process commands  
    if "%cmd%" == "stop" (
        exit
    )
    
    if "%cmd%" == "devmode /on" (
        set "dev_mode=1"
        cd "%script_dir%\Devmode"
        goto success
    )
    
    if "%cmd%" == "devmode /off" (
        if "%dev_mode%" == "1" (
            cd "%script_dir%"
            set "dev_mode=0"
            goto success  
        ) else (
            call :invalid_command
            goto success
        )
    )
    
    if "%cmd%" == "help" (
        call :show_help  
        goto success
    )
    
    if "%cmd%" == "rmdir bin" (
        if "%dev_mode%" == "0" (
            call :invalid_command
            goto success
        )
        call :rmdir_bin
        goto success
    )
    
    if "%cmd%" == "cd devmode" (
        if "%dev_mode%" == "0" (
            cd ısejıofjerıofjsepo
            goto success
        )
    )
    
    if "%cmd%" == "cd Devmode" (
        if "%dev_mode%" == "0" (
            cd ısejıofjerıofjsepo 
            goto success
        )
    )
    
    :: Execute user command
    %cmd%
    goto success
    
:: Functions
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
        
:success
    powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Customcmd', 'Success.', [System.Windows.Forms.ToolTipIcon]::None)}"
    goto main
