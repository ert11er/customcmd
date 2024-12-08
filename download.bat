@echo off
call :check_Permissions
cd /d "%~dp0"

IF EXIST ".DOWNLOADED" (
    echo Files already downloaded. Skipping download...
    goto :eof
)

REM DO NOT TOUCH THIS PART THIS IS OLD
REM :: Download essential files individually for robustness.
REM echo Downloading .DOWNLOADED...
REM curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/.DOWNLOADED" -o ".DOWNLOADED" || (
REM     echo Error downloading .DOWNLOADED.  Aborting.
REM     exit /b 1
REM )
REM 
REM echo Downloading menu.bat...
REM curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/menu.bat" -o "menu.bat" || (
REM     echo Error downloading menu.bat. Aborting.
REM     exit /b 1
REM )
REM 
REM :: Create Devmode directory and download Devmode files individually.
REM mkdir Devmode
REM if errorlevel 1 (
REM     echo Error creating Devmode directory. Aborting.
REM     exit /b 1
REM )
REM pushd Devmode
REM set "devmodefilepath=%cd%"
REM 
REM echo Downloading Devmode files...
REM curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ddos_-t.bat" -o "ddos_-t.bat" || goto :download_error
REM curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ddos.bat" -o "ddos.bat" || goto :download_error
REM curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ip_gen.py" -o "ip_gen.py" || goto :download_error
REM curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/ip_list.txt" -o "ip_list.txt" || goto :download_error
REM curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/scanip.bat" -o "scanip.bat" || goto :download_error
REM curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/succeded.py" -o "succeded.py" || goto :download_error
REM curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/Devmode/succeeded_ips.txt" -o "succeeded_ips.txt" || goto :download_error
REM 
REM popd
REM 
REM echo "" > "%devmodefilepath%\ip_list.txt" >nul
REM echo "" > "%devmodefilepath%\succeeded_ips.txt" >nul
REM 
REM 
REM :: Create Mode directories and symbolic links. Improved error handling.
REM :create_directories
REM mkdir Normal
REM if errorlevel 1 (
REM     echo Error creating Normal directory. Aborting.
REM     exit /b 1
REM )
REM cd /d Normal
REM 
REM if not exist "%devmodefilepath%" (
REM     echo Error: Devmode directory not found. Aborting.
REM     exit /b 1
REM )
REM 
REM mklink /D Devmode "%devmodefilepath%" 2>&1 | findstr /i "ERROR" >nul
REM if %errorlevel% neq 0 (
REM     echo Error creating symbolic link in Normal directory.  Error code: %errorlevel%. Aborting.
REM     exit /b 1
REM )
REM 
REM cd /d ..
REM 
REM mkdir GUI
REM if errorlevel 1 (
REM     echo Error creating GUI directory. Aborting.
REM     exit /b 1
REM )
REM cd /d GUI
REM 
REM mklink /D Devmode "%devmodefilepath%" 2>&1 | findstr /i "ERROR" >nul
REM if %errorlevel% neq 0 (
REM     echo Error creating symbolic link in GUI directory. Error code: %errorlevel%. Aborting.
REM     exit /b 1
REM )
REM 
REM cd /d ..
REM 
REM mkdir NOUI
REM if errorlevel 1 (
REM     echo Error creating NOUI directory. Aborting.
REM     exit /b 1
REM )
REM cd /d NOUI
REM mkdir customcmd-cli
REM if errorlevel 1 (
REM     echo Error creating customcmd-cli directory. Aborting.
REM     exit /b 1
REM )
REM cd /d customcmd-cli
REM 
REM echo Downloading noui.bat...
REM curl -L "https://raw.githubusercontent.com/ert11er/customcmd/refs/heads/main/NOUI/customcmd-cli/customcmd-cli.bat" -o "customcmd-cli.bat" || (
REM     echo Error downloading customcmd-cli.bat. Aborting.
REM     exit /b 1
REM )
REM 
REM cd /d ..\..\
REM 
REM start main.bat
REM start /b "" cmd /c del "%~f0"
REM exit
REM 
REM :download_error
REM echo Error downloading Devmode files. Aborting.
REM exit /b 1
REM 
REM :check_Permissions
REM net session >nul 2>&1 & if %errorlevel% == 0 (
REM     cls
REM ) else (
REM     powershell -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
REM     exit /b
REM )





@echo off
call :check_Permissions
cd /d "%~dp0"

IF EXIST ".DOWNLOADED" (
    echo Files already downloaded. Skipping download...
    goto :eof
)

set "destination=%cd%"
set "zipfile=main.zip"
set "extractedFolder=customcmd-main"

curl -L -f "https://github.com/ert11er/customcmd/archive/refs/heads/main.zip" -o "%zipfile%"
if %errorlevel% neq 0 (
    echo Error downloading %zipfile%. Please check your internet connection and try again. Aborting.
    exit /b 1
)

powershell -Command "Expand-Archive -Path '%zipfile%' -DestinationPath '%destination%' -Force"
if %errorlevel% neq 0 (
  echo Error extracting %zipfile%. Aborting.
  del "%zipfile%"
  exit /b 1
)

del "%zipfile%"

REM Use Robocopy to move all contents, including subdirectories and hidden files
robocopy "%destination%\%extractedFolder%" "%destination%" /e /move /xj

if %errorlevel% leq 7 (  REM Robocopy exit codes <= 7 generally indicate success.
    echo Files moved successfully.
    rmdir /s /q "%destination%\%extractedFolder%"
    if %errorlevel% neq 0 (
        echo Error deleting directory. This might not be a critical error.
    )

) else (
    echo Error moving files.  Robocopy Exit Code: %errorlevel% . Aborting.
    exit /b 1
)


echo Download and extraction complete.
>".DOWNLOADED" echo.  REM Create an empty .DOWNLOADED marker file

goto :eof

:check_Permissions
net session >nul 2>&1 & if %errorlevel% == 0 (
    cls
) else (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
    exit /b
)
