@echo off
cd %~dp0
REM call :download
:reset
cd %~dp0
set "scriptdir=%cd%"
chcp 65001 >nul
set "devmode=0"
:input
set "input=%cd%"
set "cmd="
if "%devmode%" == "0" (
cd %scriptdir%
)
if "%devmode%" == "1" (
cd %scriptdir%/Devmode
)
if "%devmode%" == "0" (
powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('%input%>', 'Command Prompt')}" > %TEMP%\out.tmp
)
if "%devmode%" == "1" (
powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('Devmode>', 'Command Prompt')}" > %TEMP%\out.tmp
)
set /p cmd=<%TEMP%\out.tmp
if "%cmd%" == "stop" (
exit
)
if "%cmd%" == "devmode /on" (
set "devmode=1"
cd %scriptdir%/Devmode
goto succ
)
if "%cmd%" == "devmode /off" (
if "%devmode%" == "1" (
cd..
set "devmode=0"
goto succ
)
echo '%cmd%' is not recognized as an internal or external command,
echo operable program or batch file.
goto succ
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
goto succ
)
if "%cmd%" == te"rmdir bin" (
if "%devmode%" == "0" (
echo '%cmd%' is not recognized as an internal or external command,
echo operable program or batch file.
goto succ
)
set /p cmd="Are you sure you want to delete this?[Y/N]:"
if "%cmd%" == "N" (
goto succ
)
:rmdirbinbinloop
echo BIN INSIDE OF BIN
goto rmdirbinbinloop
)
if "%cmd%" == "cd devmode" (
if "%devmode%" == "0" (
cd ısejıofjerıofjsepo
goto succ
)
)
if "%cmd%" == "cd Devmode" (
if "%devmode%" == "0" (
cd ısejıofjerıofjsepo
goto succ
)
)
%cmd%
if "%devmode%" == "0" (
cd %scriptdir%
)
if "%devmode%" == "1" (
cd %scriptdir%/Devmode
)
goto succ
:succ
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Customcmd', 'Success.', [System.Windows.Forms.ToolTipIcon]::None)}"
goto input

:download
REM the new files should be uploaded
REM Check if ".DOWNLOADED" file exists
REM if exist ".DOWNLOADED" (
REM    goto reset
REM ) else (
REM     curl https://raw.githubusercontent.com/ert11er/customcmd/main/download.bat -o download.bat >nul
REM     start download.bat
REM     exit
REM )
