@echo off
call :check_Permissions
cd %~dp0
if NOT exist .DOWNLOADED (
    if NOT exist download.bat (
        curl https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/download.bat -o download.bat
        if errorlevel 1 (
            echo Error downloading download.bat
            exit /b 1
        )
    )
    start download.bat
)
echo 1. normal mode
echo 2. gui mode
set /p input="Select your menu:"
if "%input%" == "1" (
    if exist normal (
        cd normal
        start normal_mode.bat
    ) else (
        echo Error: normal directory not found
        exit /b 1
    )
)
if "%input%" == "2" (
    if exist gui (
        cd gui
        start gui_mode.bat
    ) else (
        echo Error: gui directory not found
        exit /b 1
    )
)

:check_Permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    cls
) else (
    powershell.exe -Command "Start-Process -Verb RunAs -FilePath \"%~f0\""
    exit
)