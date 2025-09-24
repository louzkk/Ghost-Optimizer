@echo off

:: Check for Admin Privileges
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    goto:UACPrompt
) else (
    goto:GotAdmin
)

:UACPrompt
    > "%temp%\getadmin.vbs" echo Set UAC = CreateObject^("Shell.Application"^)
    >> "%temp%\getadmin.vbs" echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %*", "", "runas", 1
    cscript //nologo "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:GotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

:: Properties
mode 135,30
setlocal enabledelayedexpansion
powershell "Set-ExecutionPolicy Unrestricted" >nul 2>&1
reg add "HKCU\CONSOLE" /v "VirtualTerminalLevel" /t REG_DWORD /d 1 /f >nul 2>&1
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")
(for /f %%a in ('echo prompt $E^| cmd') do set "esc=%%a")

:: Variables
set version=4.8.5.2 beta
set script=Ghost Optimizer
set reboot=- System Restart required

:: Colors
set red=[38;2;255;0;0m
set purple=[38;5;93m
set yellow=[33m
set orange=[38;5;202m
set green=[38;2;0;255;0m
set verde=[38;5;42m
set nvidia=[38;5;51m
set blue=[97;44m
set msi=[30;47m
set reset=[0m
set white=[0m
set underline=[4m
set roxo=[38;5;129m
set cinza=[38;5;8m
set highlight=[97;48;5;93m

:: Gradient
set "colorBaseR=128"
set "colorBaseG=0"
set "colorBaseB=255"
set "variationR=-96"
set "variationG=0"
set "variationB=0"
for /L %%j in (0,1,129) do (
    set /a "mid=80"
    set /a "pos=%%j"
    if %%j LEQ !mid! (
        set /a "t=pos * 100 / mid"
        set /a "colorR=40 + (88 * t / 100)"
        set /a "colorG=0"
        set /a "colorB=255"
    ) else (
        set /a "t=(pos - mid) * 100 / (82 - mid)"
        set /a "colorR=128 - (128 * t / 100)"
        set /a "colorG=0"
        set /a "colorB=255"
    )
    if !colorR! LSS 0 set colorR=0
    set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
)

:: Welcome Page
:disclaimer
title %script% %version%
chcp 65001 >nul 2>&1
cls 
echo.
echo.
set "W=130"
set /a "LAST=W-2"
set /a "MID=(W-2)/2"

for /L %%j in (0,1,!LAST!) do (
    if %%j LEQ !MID! (
        set /a "colorR=40 + (88 * %%j / !MID!)"
    ) else (
        set /a "colorR=128 - (128 * (%%j-!MID!) / (!LAST!-!MID!))"
    )
    set /a "colorG=0", "colorB=255"
    set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
)

set "lines[0]=                                    ██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗  "
set "lines[1]=                                    ██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝"
set "lines[2]=                                    ██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗"
set "lines[3]=                                    ██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝"
set "lines[4]=                                    ╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗"
set "lines[5]=                                     ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝"

for /L %%i in (0,1,5) do (
    set "text=!lines[%%i]!"
    set "textGradient="
    for /L %%j in (0,1,!LAST!) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m
)

set "lineGradient="
set /a "BeforeSpace=(135 - 109) / 2"
for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
for /L %%j in (0,1,108) do (
    set /a "colorR=colorBaseR + (variationR * %%j / 108)"
    set /a "colorG=colorBaseG + (variationG * %%j / 108)"
    set /a "colorB=colorBaseB + (variationB * %%j / 108)"
    set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
)
for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
echo !lineGradient!!esc![0m

echo.
echo                                      %roxo%%underline%%script%%reset% is a lightweight open source tweaker/optimizer
echo                               made to improve system performance, network, latency and fix system integrity.
echo.
echo                           The revert tweaks option may not work as expected; create a restore point for safety.
echo                   Use this script at your own risk. The author takes no responsibility for any damage or data loss.
echo                                        You can report issues or submit suggetions at Github.
echo.
echo.
echo                                 %purple%[ %roxo%%underline%Y%reset% %purple%]%white% Create a restore point                %purple%[ %roxo%%underline%N%reset% %purple%]%white% Skip restore point
echo.
echo.

set /p answer="%white% >:%roxo%"

:: Options
if "%answer%"=="y" goto:restore
if "%answer%"=="Y" goto:restore
if "%answer%"=="n" goto:loading
if "%answer%"=="N" goto:loading

:: Invalid Input
goto:disclaimer

:: Restore Point
:restore
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v "DisableSR" /t REG_DWORD /d 0 /f >nul 2>&1

chcp 437 >nul 2>&1
powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description '%script% %version% | Restore Point' -RestorePointType 'MODIFY_SETTINGS'" >nul 2>&1
chcp 65001 >nul 2>&1

cls
echo.
echo   %purple%[ %roxo%•%purple% %purple%]%white% Restore Point created %green%successfully%white%.
timeout /t 2 /nobreak >> "%logfile%" 2>&1
goto:loading

:: Loading Page
:loading
cls
echo !esc![?25l
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set "lines[0]=                                                                 ██████          "
set "lines[1]=                                                              ████████████       "
set "lines[2]=                                                           ██████████████████    "
set "lines[3]=                                                           █████   ██   █████    "
set "lines[4]=                                                          ██████   ██   ██████    "
set "lines[5]=                                                         ██████████████████████    "
set "lines[6]=                                                        █████   ███  ███   █████     "
set "lines[7]=                                                        ███  ███   ██   ███  ███     "
set "lines[8]=                                                        ████████████████████████     "
set "lines[9]=                                                        ████    ███  ███    ████     "
set "lines[10]=                                                                                      "
set "lines[11]=                                                                                       "
set "lines[12]=                                                                Loading...             "

for /L %%i in (0,1,12) do (
    set "text=!lines[%%i]!"
    set "textGradient="
    for /L %%j in (0,1,129) do (
        set "char=!text:~%%j,1!"
        if "!char!" == "" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m
)

:: Create Folders
if not exist "C:\Ghost Optimizer" md "C:\Ghost Optimizer"
if not exist "C:\Ghost Optimizer\Logs" md "C:\Ghost Optimizer\Logs"
if not exist "C:\Ghost Optimizer\NVIDIA" md "C:\Ghost Optimizer\NVIDIA"
if not exist "C:\Ghost Optimizer\OOSU10++" md "C:\Ghost Optimizer\OOSU10++"
if not exist "C:\Ghost Optimizer\GhostOPX" md "C:\Ghost Optimizer\GhostOPX"
if not exist "C:\Ghost Optimizer\GhostAHK" md "C:\Ghost Optimizer\GhostAHK"

:: Setting Logs
set "d=%date:/=-%"
set "t=%time::=-%"
set "t=%t:.=-%"
set "t=%t: =0%"

set "logfile=C:\Ghost Optimizer\Logs\%d%_%t%.log"

echo Ghost Optimizer > "%logfile%"
echo Created by: @louzkk >> "%logfile%" 2>&1
echo. >> "%logfile%" 2>&1

:: Setting Url
set "LinkFile=C:\Ghost Optimizer\GitHub.url"
(
echo [InternetShortcut]
echo URL=https://github.com/louzkk/Ghost-Optimizer
) > "%LinkFile%"

:: Get GPU Info
chcp 437 >> "%logfile%" 2>&1
for /f "delims=" %%G in ('powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"') do (
    set "GPUName=%%G"
    goto:gotGPU
)
:gotGPU

:: Get CPU Info
for /f "delims=" %%A in ('powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"') do (
    set "CPUName=%%A"
    goto:gotCPU
)
:gotCPU
chcp 65001 >> "%logfile%" 2>&1

:: Main Menu
:menu
cls
echo.
echo.

set "W=130"
set /a "LAST=W-2"
set /a "MID=(W-2)/2"

for /L %%j in (0,1,!LAST!) do (
    if %%j LEQ !MID! (
        set /a "colorR=40 + (88 * %%j / !MID!)"
    ) else (
        set /a "colorR=128 - (128 * (%%j-!MID!) / (!LAST!-!MID!))"
    )
    set /a "colorG=0", "colorB=255"
    set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
)

set "lines[0]=            ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗      ██████╗ ██████╗ ████████╗██╗███╗   ███╗██╗███████╗███████╗██████╗  "
set "lines[1]=           ██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝     ██╔═══██╗██╔══██╗╚══██╔══╝██║████╗ ████║██║╚══███╔╝██╔════╝██╔══██╗"
set "lines[2]=           ██║  ███╗███████║██║   ██║███████╗   ██║        ██║   ██║██████╔╝   ██║   ██║██╔████╔██║██║  ███╔╝ █████╗  ██████╔╝"
set "lines[3]=           ██║   ██║██╔══██║██║   ██║╚════██║   ██║        ██║   ██║██╔═══╝    ██║   ██║██║╚██╔╝██║██║ ███╔╝  ██╔══╝  ██╔══██╗"
set "lines[4]=           ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║        ╚██████╔╝██║        ██║   ██║██║ ╚═╝ ██║██║███████╗███████╗██║  ██║"
set "lines[5]=            ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝         ╚═════╝ ╚═╝        ╚═╝   ╚═╝╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝  ╚═╝"

for /L %%i in (0,1,5) do (
    set "text=!lines[%%i]!"
    set "textGradient="
    for /L %%j in (0,1,!LAST!) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m
)

echo.
echo                             %purple%%underline%GPU%reset%%purple%:%reset% %GPUName%        %purple%%underline%CPU%reset%%purple%:%reset% %CPUName%
echo.

set "lineGradient="
set /a "BeforeSpace=(135 - 109) / 2"
for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
for /L %%j in (0,1,108) do (
    set /a "colorR=colorBaseR + (variationR * %%j / 108)"
    set /a "colorG=colorBaseG + (variationG * %%j / 108)"
    set /a "colorB=colorBaseB + (variationB * %%j / 108)"
    set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
)
for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
echo !lineGradient!!esc![0m

echo.
echo                             %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply all Tweaks/Fixes                %purple%[ %roxo%%underline%R%reset% %purple%]%white% Revert all Tweaks/Fixes
echo.
echo.
echo                   %purple%[ %roxo%%underline%1%reset% %purple%]%white% General Tweaks               %purple%[ %roxo%%underline%2%reset% %purple%]%white% Performance Tweaks             %purple%[ %roxo%%underline%3%reset% %purple%]%white% Network Tweaks 
echo.
echo                   %purple%[ %roxo%%underline%4%reset% %purple%]%white% NVIDIA Profile               %purple%[ %roxo%%underline%5%reset% %purple%]%white% Latency ^& Input-Lag            %purple%[ %roxo%%underline%6%reset% %purple%]%white% Mouse ^& Keyboard       
echo.
echo                   %purple%[ %roxo%%underline%7%reset% %purple%]%white% Windows Cleaner              %purple%[ %roxo%%underline%8%reset% %purple%]%white% Telemetry ^& Logging            %purple%[ %roxo%%underline%9%reset% %purple%]%white% Unnecessary Services
echo.
echo                   %purple%[ %roxo%%underline%10%reset% %purple%]%white% Ghost Powerplan             %purple%[ %roxo%%underline%11%reset% %purple%]%white% Integrity ^& Health            %purple%[ %roxo%%underline%12%reset% %purple%]%white% Remove Bloatware                        
echo.
set /p answer="%white% >:%roxo%"

:: Options
if %answer% equ 1 call:general
if %answer% equ 2 call:performance
if %answer% equ 3 call:network
if %answer% equ 4 call:nvidia
if %answer% equ 5 call:latency
if %answer% equ 6 call:kbm
if %answer% equ 7 call:clean
if %answer% equ 8 call:telemetry
if %answer% equ 9 call:services
if %answer% equ 10 call:powerplan
if %answer% equ 11 call:health
if %answer% equ 12 call:debloat

if "%answer%"=="A" goto:applyall
if "%answer%"=="a" goto:applyall
if "%answer%"=="R" goto:revertall
if "%answer%"=="r" goto:revertall

if "%answer%"=="Louzkk" start https://github.com/louzkk
if "%answer%"=="louzkk" start https://github.com/louzkk
if "%answer%"=="@louzkk" start https://github.com/louzkk
if "%answer%"=="@Louzkk" start https://github.com/louzkk
if "%answer%"=="ghost" start https://github.com/louzkk/Ghost-Optimizer
if "%answer%"=="Ghost" start https://github.com/louzkk/Ghost-Optimizer
if "%answer%"=="GHOST" start https://github.com/louzkk/Ghost-Optimizer
if "%answer%"=="github" start https://github.com/louzkk/Ghost-Optimizer
if "%answer%"=="Github" start https://github.com/louzkk/Ghost-Optimizer
if "%answer%"=="help" start https://github.com/louzkk/Ghost-Optimizer
if "%answer%"=="restart" goto:restart
if "%answer%"=="exit" exit /B
if "%answer%"=="menu" goto:menu
if "%answer%"=="reboot" goto:reboot
if "%answer%"=="rebootcancel" goto:rebootcancel
if "%answer%"=="cancel" goto:rebootcancel

:: Invalid Input
    goto:menu

:: Apply General Tweaks
    :general
    cls
    echo.
    echo.
    set "W=130"
    set /a "LAST=W-2"
    set /a "MID=(W-2)/2"

    for /L %%j in (0,1,!LAST!) do (
        if %%j LEQ !MID! (
            set /a "colorR=40 + (88 * %%j / !MID!)"
        ) else (
            set /a "colorR=128 - (128 * (%%j-!MID!) / (!LAST!-!MID!))"
        )
        set /a "colorG=0", "colorB=255"
        set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
    )

    set "lines[0]=                                       ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗     "
    set "lines[1]=                                      ██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║     "
    set "lines[2]=                                      ██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║     "
    set "lines[3]=                                      ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║     "
    set "lines[4]=                                      ╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗"
    set "lines[5]=                                       ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝"

    for /L %%i in (0,1,5) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,!LAST!) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lines[0]=                                 Applies basic tweaks to improve responsiveness and windows usability."
    set "lines[1]=                                Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

    for /L %%i in (0,1,1) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,129) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lineGradient="
    set /a "BeforeSpace=(134 - 108) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,108) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m     
    echo.
    echo                               %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply General Tweaks                %purple%[ %roxo%%underline%R%reset% %purple%]%white% Revert General Tweaks
    echo.                 
    echo.
    echo                                                         %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to Menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" goto:generalapply
    if "%answer%"=="r" goto:generalrevert
    if "%answer%"=="A" goto:generalapply
    if "%answer%"=="R" goto:generalrevert
    if "%answer%"=="b" goto:menu
    if "%answer%"=="B" goto:menu

    :: Invalid Input
    goto:general

    :generalapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Applying %roxo%General%white% Tweaks... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying General Tweaks --- >> "%logfile%" 2>&1

    :: Explorer
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >> "%logfile%" 2>&1
    reg delete "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >> "%logfile%" 2>&1
    reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f >> "%logfile%" 2>&1
    reg delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Explorer Tweaks applied.

    :: Taskbar
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" /v "TaskbarEndTask" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" /v "value" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Taskbar Tweaks applied.

    :: Blur Effect
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Transparency disabled.

    :: Time Stamp Interval
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "IoPriority" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "TimeStampInterval" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Time Stamp disabled.

    :: File Extensions
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% File Extensions visible.

    :: Hidden Files
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Hidden Files visible.

    :: Storage Sense
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "01" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Storage Sense disabled.

    :: Background Apps
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Background Apps disabled.

    :: Remote Assist
    reg add "HKLM\System\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Remote Assist disabled.

    :: Driver Search
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Driver Search disabled.

    :: USB Selective Suspend
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% USB Selective Suspend disabled.

    :: Hibernation
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberBootEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SleepReliabilityDetailedDiagnostics" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Hibernation disabled.

    :: Focus Assist
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "FocusAssist" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_AUTOMATIC_RULES_ENABLED" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Focus Assist disabled.

    :: Notifications/Push
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_NOTIFICATION_SOUND" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\QuietHours" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.AutoPlay" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.LowDisk" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.Print.Notification" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.WiFiNetworkManager" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Notifications disabled.

    :: Windows Suggestions
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314559Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280815Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-202914Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Suggestions disabled.

    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% General Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    echo --- Finished General Tweaks --- >> "%logfile%" 2>&1
    goto:general

:: Apply Performance Tweaks
    :performance
    cls
    echo.
    echo.
    set "W=130"
    set /a "LAST=W-2"
    set /a "MID=(W-2)/2"

    for /L %%j in (0,1,!LAST!) do (
        if %%j LEQ !MID! (
            set /a "colorR=40 + (88 * %%j / !MID!)"
        ) else (
            set /a "colorR=128 - (128 * (%%j-!MID!) / (!LAST!-!MID!))"
        )
        set /a "colorG=0", "colorB=255"
        set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
    )

    set "lines[0]=                    ██████╗ ███████╗██████╗ ███████╗ ██████╗ ██████╗ ███╗   ███╗ █████╗ ███╗   ██╗ ██████╗███████╗"
    set "lines[1]=                    ██╔══██╗██╔════╝██╔══██╗██╔════╝██╔═══██╗██╔══██╗████╗ ████║██╔══██╗████╗  ██║██╔════╝██╔════╝"
    set "lines[2]=                    ██████╔╝█████╗  ██████╔╝█████╗  ██║   ██║██████╔╝██╔████╔██║███████║██╔██╗ ██║██║     █████╗  "
    set "lines[3]=                    ██╔═══╝ ██╔══╝  ██╔══██╗██╔══╝  ██║   ██║██╔══██╗██║╚██╔╝██║██╔══██║██║╚██╗██║██║     ██╔══╝  "
    set "lines[4]=                    ██║     ███████╗██║  ██║██║     ╚██████╔╝██║  ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║╚██████╗███████╗"
    set "lines[5]=                    ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝"

    for /L %%i in (0,1,5) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,!LAST!) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lines[0]=                         Applies advanced tweaks to boost system performance and latency and responsivness."
    set "lines[1]=                              Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

    for /L %%i in (0,1,1) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,129) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lineGradient="
    set /a "BeforeSpace=(134 - 108) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,108) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m     
    echo.
    echo                              %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply Performance Tweaks                %purple%[ %roxo%%underline%R%reset% %purple%]%white% Revert Performance Tweaks
    echo.                 
    echo.
    echo                                                         %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to Menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" goto:performanceapply
    if "%answer%"=="r" goto:performancerevert
    if "%answer%"=="A" goto:performanceapply
    if "%answer%"=="R" goto:performancerevert
    if "%answer%"=="b" goto:menu
    if "%answer%"=="B" goto:menu

    :: Invalid Input
    goto:performance


    :performanceapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Applying %roxo%Performance%white% Tweaks... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying Performance Tweaks --- >> "%logfile%" 2>&1

    :: Game Mode
    reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Game Mode enabled.

    :: Game Bar & Game DVR
    reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v value /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Game Bar and DVR disabled.

    :: System Profile
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "10" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% System Responsiveness Optimized.

    :: Win32PrioritySeparation
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Priority Separation Optimized.

    :: Game Scheduling
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "AlwaysOn" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d False /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d High /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d True /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Gaming Scheduling Optimized.

    :: Hardware-Accelerated GPU Scheduling
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% GPU Scheduling Optimized.

    :: Memory Management
    sc config SysMain start= disabled >> "%logfile%" 2>&1
    wmic computersystem >> "%logfile%" 2>&1
    wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d 33554432 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Memory Management Optimized.

    :: Large System Cache
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Large System Cache enabled.

    :: Fullscreen Optimization
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Fullscreen Optimizations enabled.

    :: Message Signaled Interrupts
    for /f %%g in ('wmic path win32_videocontroller get PNPDeviceID ^| findstr /L "VEN_"') do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    )
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Message Signaled Interrupts enabled.

    :: Multiple Plane Overlay
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Multiple Plane Overlay disabled.

    :: Virtualization Based Security
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "RequirePlatformSecurityFeatures" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    bcdedit /set hypervisorlaunch off >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Virtualization Based Security disabled.

    :: Spectre/Meltdown
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Spectre ^& Meltdown disabled.

    :: Direct3D/DirectX
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 10 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Direct3D\Drivers" /v "SoftwareOnly" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\DirectInput" /v "EnableBackgroundProcessing" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Direct3D" /v "DisableDebugLayer" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Graphics Drivers Optimized.

    :: Power Management
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergySaverPolicy" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "CoalescingTimerInterval" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CoalescingTimerInterval" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "CoalescingTimerInterval" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ModernSleep" /v "CoalescingTimerInterval" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PlatformAoAcOverride" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Power Management Optimized.

    :: CPU and Timer
    bcdedit /set tscsyncpolicy enhanced >> "%logfile%" 2>&1
    bcdedit /set uselegacyapicmode No >> "%logfile%" 2>&1
    bcdedit /deletevalue useplatformclock >> "%logfile%" 2>&1
    bcdedit /deletevalue useplatformtick >> "%logfile%" 2>&1
    bcdedit /set disabledynamictick No >> "%logfile%" 2>&1
    bcdedit /set x2apicpolicy Enable >> "%logfile%" 2>&1
    bcdedit /set configaccesspolicy Default >> "%logfile%" 2>&1
    bcdedit /set usephysicaldestination No >> "%logfile%" 2>&1
    bcdedit /set usefirmwarepcisettings No >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% BCD Optimizations applied.

    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Performance Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    echo --- Performance Tweaks Applied --- >> "%logfile%" 2>&1
    goto:performance

:: Apply Network Tweaks
    :network
    cls
    echo.
    echo.
    set "W=130"
    set /a "LAST=W-2"
    set /a "MID=(W-2)/2"

    for /L %%j in (0,1,!LAST!) do (
        if %%j LEQ !MID! (
            set /a "colorR=40 + (88 * %%j / !MID!)"
        ) else (
            set /a "colorR=128 - (128 * (%%j-!MID!) / (!LAST!-!MID!))"
        )
        set /a "colorG=0", "colorB=255"
        set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
    )

    set "lines[0]=                                    ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗"
    set "lines[1]=                                    ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝"
    set "lines[2]=                                    ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ "
    set "lines[3]=                                    ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ "
    set "lines[4]=                                    ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗"
    set "lines[5]=                                    ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝"

    for /L %%i in (0,1,5) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,!LAST!) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lines[0]=                      Applies advanced tweaks to improve network latency, stability and speed. Applies a custom DNS"
    set "lines[1]=                              Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

    for /L %%i in (0,1,1) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,129) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lineGradient="
    set /a "BeforeSpace=(134 - 108) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,108) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m     
    echo.
    echo                                  %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply Network Tweaks                %purple%[ %roxo%%underline%R%reset% %purple%]%white% Revert Network Tweaks
    echo.                 
    echo.
    echo                                                          %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to Menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" goto:networkapply
    if "%answer%"=="A" goto:networkapply
    if "%answer%"=="r" goto:networkrevert
    if "%answer%"=="R" goto:networkrevert
    if "%answer%"=="b" goto:menu
    if "%answer%"=="B" goto:menu

    :: Invalid Input
    goto:network

    :networkapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Applying %roxo%Network%white% Tweaks... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying Network Tweaks --- >> "%logfile%" 2>&1

    :: Network Interface Detection
    for /f "tokens=3 delims={}" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" ^| find "{" 2>&1 >> "%logfile%"') do (
        set "InterfaceID=%%A"
    )
    for /f %%n in ('Reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}" /v "*SpeedDuplex" /s ^| findstr  "HKEY" 2>&1 >> "%logfile%"') do (
        echo %%n >> "%logfile%" 2>&1
    )
    chcp 437 >> "%logfile%" 2>&1
    for /f "delims=" %%A in ('powershell -Command "(Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}).Name"') do (
        set "netinterface=%%A"
        chcp 65001 >> "%logfile%" 2>&1
    )

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Network Interface detected.
    timeout /t 1 >> "%logfile%" 2>&1

    :: MSI
    for /f %%l in ('wmic path win32_NetworkAdapter get PNPDeviceID ^| find "PCI\VEN_"') do (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\SYSTEM\CurrentControlSet\Enum\%%l\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\SYSTEM\CurrentControlSet\Enum\%%l\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    )
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Network Adaper MSI enabled.
    timeout /t 1 >> "%logfile%" 2>&1

    :: Priority
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "LocalPriority" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "HostsPriority" /t REG_DWORD /d 5 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "DnsPriority" /t REG_DWORD /d 6 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "NetbtPriority" /t REG_DWORD /d 7 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% General Network Tweaks applied.

    :: Sock Adress
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MinSockAddrLength" /t REG_DWORD /d 16 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MaxSockAddrLength" /t REG_DWORD /d 16 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Increased Sock Adress size.

    :: Autotuning
    netsh int tcp set global autotuninglevel=disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Autotuning Level disabled.

    :: Explicit Congestion
    netsh int tcp set global ecncapability=disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Explicit Congestion disabled.

    :: NETDMA
    netsh int tcp set global netdma=enabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Direct Memory Access enabled.

    :: DCA
    netsh int tcp set global dca=enabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Direct Cache Access enabled.

    :: RSC
    netsh int tcp set global rsc=disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Recieve Side Coalescing disabled.

    :: RSS
    netsh int tcp set global rss=enabled >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Ndis\Parameters" /v "RssBaseCpu" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Recieve Side Scaling disabled.

    :: Chimney
    netsh int tcp set global chimney=enabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Chimney enabled.

    :: Timestamps
    netsh int tcp set global timestamps=disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% TCP Timestamps disabled.

    :: Memory Pressure
    netsh int tcp set security mpp=disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Memory Pressure Protection disabled.

    :: Security Profiles
    netsh int tcp set security profiles=disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Security Profiles disabled.

    :: Heuristics
    netsh int tcp set heuristics disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Scaling Heuristics disabled.

    :: CTCP
    netsh int tcp set supplemental Internet congestionprovider=ctcp >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% CTCP disabled.

    :: Task Offload
    netsh int ip set global taskoffload=disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Task Offloading disabled.

    :: DNS Configuration
    netsh interface ip set dns name="%netinterface%" source=static addr=1.1.1.1 register=PRIMARY >> "%logfile%" 2>&1
    netsh interface ip add dns name="%netinterface%" addr=1.0.0.1 index=2 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% %roxo%Cloudflare DNS%reset% applied.

    :: DNS Cache Tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableBucketSize" /t REG_DWORD /d 384 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableSize" /t REG_DWORD /d 384 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheEntryTtlLimit" /t REG_DWORD /d 64000 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheTtl" /t REG_DWORD /d 64000 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% DNS Cache Optimized.

    :: DNS Cache Clean
    ipconfig /flushdns >> "%logfile%" 2>&1
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% DNS Cache cleared.

    :: Network Throttling
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "DisableBandwidthThrottling" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxCmds" /t REG_DWORD /d 2048 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Network Throttling disabled.

    :: TCP/IP Interface
    reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{%InterfaceID%}" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{%InterfaceID%}" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpDelAckTicks" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Nagle's Algorithm Tweaks applied.

    :: TCP/IP Advanced / Offloads
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableTaskOffload" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableTCPChimney" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableRSS" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableTCPA" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxHalfOpen" /t REG_DWORD /d 100 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxHalfOpenRetried" /t REG_DWORD /d 80 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxPortsExhausted" /t REG_DWORD /d 5 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpNumConnections" /t REG_DWORD /d 500 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableECN" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% TCP/IP ^& Offloads Tweaks applied.

    :: Delivery Optimization
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Delivery Optimization disabled.

    :: AFD / Socket Tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "BufferAlignment" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DefaultReceiveWindow" /t REG_DWORD /d 262144 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DefaultSendWindow" /t REG_DWORD /d 262144 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DisableAddressSharing" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DisableChainedReceive" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "disabledirectAcceptEx" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DoNotHoldNICBuffers" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DynamicSendBufferDisable" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "FastSendDatagramThreshold" /t REG_DWORD /d 1024 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "FastCopyReceiveThreshold" /t REG_DWORD /d 1024 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "IgnoreOrderlyRelease" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "IgnorePushBitOnReceives" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% AFD/Socket Tweaks applied.

    :: NIC Power Saving (from Ancel's Performance Batch)
    reg add "%%n" /v "AutoPowerSaveModeEnabled" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "AutoDisableGigabit" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "AdvancedEEE" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "DisableDelayedPowerUp" /t REG_SZ /d "2" /f >> "%logfile%" 2>&1
    reg add "%%n" /v "*EEE" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "EEE" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "EnablePME" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "EEELinkAdvertisement" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "EnableGreenEthernet" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "EnableSavePowerNow" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "EnablePowerManagement" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "EnableDynamicPowerGating" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "EnableConnectedPowerGating" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "EnableWakeOnLan" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "GigaLite" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "NicAutoPowerSaver" /t REG_SZ /d "2" /f >> "%logfile%" 2>&1
    reg add "%%n" /v "PowerDownPll" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "PowerSavingMode" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "ReduceSpeedOnPowerDown" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "SmartPowerDownEnable" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "S5NicKeepOverrideMacAddrV2" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "S5WakeOnLan" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "ULPMode" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "WakeOnDisconnect" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "*WakeOnMagicPacket" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "*WakeOnPattern" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "WakeOnLink" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "%%n" /v "WolShutdownLinkSpeed" /t REG_SZ /d "2" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% NIC Power Saving disabled.

    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Network Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    echo --- Finished Network Tweaks --- >> "%logfile%" 2>&1
    goto:network

:: Apply Telemetry & Logging Removal
    :telemetry
    cls
    echo.
    echo.
    set "W=130"
    set /a "LAST=W-2"
    set /a "MID=(W-2)/2"

    for /L %%j in (0,1,!LAST!) do (
        if %%j LEQ !MID! (
            set /a "colorR=40 + (88 * %%j / !MID!)"
        ) else (
            set /a "colorR=128 - (128 * (%%j-!MID!) / (!LAST!-!MID!))"
        )
        set /a "colorG=0", "colorB=255"
        set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
    )

    set "lines[0]=                             ████████╗███████╗██╗     ███████╗███╗   ███╗███████╗████████╗██████╗ ██╗   ██╗"
    set "lines[1]=                             ╚══██╔══╝██╔════╝██║     ██╔════╝████╗ ████║██╔════╝╚══██╔══╝██╔══██╗╚██╗ ██╔╝"
    set "lines[2]=                                ██║   █████╗  ██║     █████╗  ██╔████╔██║█████╗     ██║   ██████╔╝ ╚████╔╝ "
    set "lines[3]=                                ██║   ██╔══╝  ██║     ██╔══╝  ██║╚██╔╝██║██╔══╝     ██║   ██╔══██╗  ╚██╔╝   "
    set "lines[4]=                                ██║   ███████╗███████╗███████╗██║ ╚═╝ ██║███████╗   ██║   ██║  ██║   ██║   "
    set "lines[5]=                                ╚═╝   ╚══════╝╚══════╝╚══════╝╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   "

    for /L %%i in (0,1,5) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,!LAST!) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lines[0]=                  Disables data collection, diagnostics, and tracking, enhancing privacy and reducing resource usage."
    set "lines[1]=                              Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

    for /L %%i in (0,1,1) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,129) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lineGradient="
    set /a "BeforeSpace=(134 - 108) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,108) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m     
    echo.
    echo                                 %purple%[ %roxo%%underline%S%reset% %purple%]%white% Stop Telemetry ^& Logging                %purple%[ %roxo%%underline%R%reset% %purple%]%white% Revert Telemetry ^& Logging
    echo.
    echo.
    echo                                                           %purple%[ %roxo%%underline%O%reset% %purple%]%white% Open OOSU10+   
    echo.
    echo.
    echo                                                           %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to Menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="s" goto:telemetryapply
    if "%answer%"=="S" goto:telemetryapply
    if "%answer%"=="r" goto:telemetryrevert
    if "%answer%"=="R" goto:telemetryrevert
    if "%answer%"=="o" goto:oosu10
    if "%answer%"=="O" goto:oosu10
    if "%answer%"=="b" goto:menu
    if "%answer%"=="B" goto:menu

    :: Invalid Input
    goto:telemetry

    :telemetryapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Applying %highlight%OOSU10+%reset% Tweaks...
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying OOSU Tweaks --- >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Checking %highlight%OOSU10+%reset% executable...
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    if not exist "C:\%script%\OOSU10++\OOSU10.exe" (
        echo   %purple%[ %roxo%•%purple% %purple%]%white% Downloading %highlight%OOSU10+%reset% executable...
        chcp 437 >> "%logfile%" 2>&1
        powershell -Command "Invoke-WebRequest 'https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe' -OutFile 'C:\%script%\OOSU10++\OOSU10.exe'" >> "%logfile%" 2>&1
        chcp 65001 >> "%logfile%" 2>&1
        if not exist "C:\%script%\OOSU10++\OOSU10.exe" (
            echo   %red%[ %red%•%red% %red%]%reset% Failed to download OOSU10+ executable!
            echo --- Download failed --- >> "%logfile%" 2>&1
            goto:telemetryend
        )
    ) else (
        echo   %purple%[ %roxo%•%purple% %purple%]%white% %highlight%OOSU10+%reset% already downloaded.
        timeout /t 2 /nobreak >> "%logfile%" 2>&1
    )

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Importing %highlight%OOSU10+%reset% Profile...
    curl -g -k -L -# -o "C:\%script%\OOSU10++\GhostOPX-OOSU.cfg" "https://github.com/louzkk/Ghost-Optimizer/raw/main/bin/GhostOPX-OOSU.cfg" >> "%logfile%" 2>&1
    if errorlevel 1 (
        echo   %red%[ %red%•%red% %red%]%reset% Failed to download OOSU10+ profile!
        echo --- Profile download failed --- >> "%logfile%" 2>&1
        goto:telemetryend
    )
    timeout /t 2 /nobreak >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Applying %highlight%OOSU10+%reset% Profile...
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    if exist "C:\%script%\OOSU10++\OOSU10.exe" (
        start "" /wait "C:\%script%\OOSU10++\OOSU10.exe" "C:\%script%\OOSU10++\GhostOPX-OOSU.cfg" >> "%logfile%" 2>&1
        echo.
        echo   %purple%[ %roxo%•%purple% %purple%]%white% OOSU10++ Tweaks Applied %green%successfully%white%.
        echo --- OOSU Tweaks applied --- >> "%logfile%" 2>&1
    ) else (
        echo   %red%[ %red%•%red% %red%]%reset% OOSU10+ executable not found!
        echo --- Apply failed --- >> "%logfile%" 2>&1
    )

    :telemetryend

    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo --- OOSU10++ tweaks applied --- >> "%logfile%" 2>&1

    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting %roxo%Telemetry %white%^& %roxo%Logging%white% blocking... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Starting Telemetry Blocking --- >> "%logfile%" 2>&1

    :: Privacy Improvements
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Privacy Improvements applied.

    :: DiagTrack
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TroubleshootingSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DsSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DPS" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Telemetry Services disabled.

    :: Telemetry/Data Collection
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowCommercialDataPipeline" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowDeviceNameInTelemetry" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitEnhancedDiagnosticDataWindowsAnalytics" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "MicrosoftEdgeDataOptIn" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    sc config DiagTrack start= disabled >> "%logfile%" 2>&1
    sc config dmwappushservice start= disabled >> "%logfile%" 2>&1
    sc config diagnosticshub.standardcollector.service start= disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Data Collection disabled.

    :: Device Metadata/Input
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Input Metadata disabled.

    :: Error reporting
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "DoReport" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Error Reporting disabled.

    :: Experience Feedback
    reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfNotificationsSent" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoExplicitFeedback" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoActiveHelp" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Reliability" /v "CEIPEnable" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Reliability" /v "SqmLoggerRunning" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v "DisableOptinExperience" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v "SqmLoggerRunning" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\SQMClient\IE" /v "SqmLoggerRunning" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Experience Feedback disabled.

    :: User Activity Upload
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Activity Upload disabled.

    :: Advertising ID
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Advertising ID disabled.

    :: Biometrics
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Biometrics disabled.

    :: Location Sensor
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Geolocation disabled.

    :: Autologgers (from Ancel's Performance Batch)
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogEnable" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogLevel" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "DisableTaggedEnergyLogging" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxApplication" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxTagPerApplication" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Cellcore" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\CloudExperienceHostOobe" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DataMarket" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\HolographicDevice" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsClient" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsProxy" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\LwtNetLog" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Mellanox-Kernel" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-AssignedAccess-Trace" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-Setup" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NBSMBLOGGER" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\PEAuthLog" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\RdrLog" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatform" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatformTel" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SocketHeciServer" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SpoolerLogger" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPLOGGER" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TileStore" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Tpm" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TPMProvisioningService" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WFP-IPsec Trace" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSession" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSessionRepro" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiSession" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WinPhoneCritical" /v "Start" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogEnable" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogLevel" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "HistoryViewEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Credssp" /v "DebugLogLevel" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Autologgers disabled.

    :: Telemetry Task Schedulings (from Ancel's Performance Batch)
    schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Maintenance\WinSAT" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Application Experience\AitAgent" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\FileHistory\File History (maintenance mode)" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\PI\Sqm-Tasks" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\AppID\SmartScreenSpecific" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" /disable >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn" /disable >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Schedulings disabled.

    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Telemetry ^& Logging disabled %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    echo --- Finished Telemetry & Logging --- >> "%logfile%" 2>&1
    goto:telemetry

   :oosu10
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Opening %highlight%OOSU10+%reset% Software...
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Opening OOSU10 --- >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Checking %highlight%OOSU10+%reset% executable...
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    if not exist "C:\%script%\OOSU10++\OOSU10.exe" (
        echo   %purple%[ %roxo%•%purple% %purple%]%white% Downloading %highlight%OOSU10+%reset% executable...
        chcp 437 >> "%logfile%" 2>&1
        powershell -Command "Invoke-WebRequest 'https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe' -OutFile 'C:\%script%\OOSU10++\OOSU10.exe'" >> "%logfile%" 2>&1
        chcp 65001 >> "%logfile%" 2>&1
    ) else (
        echo   %purple%[ %roxo%•%purple% %purple%]%white% %highlight%OOSU10+%reset% already downloaded.
        timeout /t 2 /nobreak >> "%logfile%" 2>&1
    )

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Opening %highlight%OOSU10+%reset% software...
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    start /wait "" "C:\%script%\OOSU10++\OOSU10.exe" >> "%logfile%" 2>&1

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% OOSU10+ Software closed.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    echo --- Closing OOSU10 --- >> "%logfile%" 2>&1
    goto:telemetry

:: Apply Mouse & Keyboard Tweaks
    :kbm
    cls
    echo.
    echo.
    set "W=130"
    set /a "LAST=W-2"
    set /a "MID=(W-2)/2"

    for /L %%j in (0,1,!LAST!) do (
        if %%j LEQ !MID! (
            set /a "colorR=40 + (88 * %%j / !MID!)"
        ) else (
            set /a "colorR=128 - (128 * (%%j-!MID!) / (!LAST!-!MID!))"
        )
        set /a "colorG=0", "colorB=255"
        set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
    )

    set "lines[0]=                                                     ██╗  ██╗██████╗ ███╗   ███╗"
    set "lines[1]=                                                     ██║ ██╔╝██╔══██╗████╗ ████║"
    set "lines[2]=                                                     █████╔╝ ██████╔╝██╔████╔██║"
    set "lines[3]=                                                     ██╔═██╗ ██╔══██╗██║╚██╔╝██║"
    set "lines[4]=                                                     ██║  ██╗██████╔╝██║ ╚═╝ ██║"
    set "lines[5]=                                                     ╚═╝  ╚═╝╚═════╝ ╚═╝     ╚═╝"

    for /L %%i in (0,1,5) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,!LAST!) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lines[0]=                     Tweaks mouse and keyboard for minimal input lag, maximum responsiveness, and precise control."
    set "lines[1]=                              Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

    for /L %%i in (0,1,1) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,129) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lineGradient="
    set /a "BeforeSpace=(134 - 108) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,108) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m     
    echo.
    echo                         %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply Mouse ^& Keyboard Tweaks                %purple%[ %roxo%%underline%R%reset% %purple%]%white% Revert Mouse ^& Keyboard Tweaks
    echo.                 
    echo.
    echo                                                         %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to Menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" goto:kbmapply
    if "%answer%"=="r" goto:kbmrevert
    if "%answer%"=="A" goto:kbmapply
    if "%answer%"=="R" goto:kbmrevert
    if "%answer%"=="b" goto:menu
    if "%answer%"=="B" goto:menu

    :: Invalid Input
    goto:kbm


    :kbmapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Applying %roxo%Mouse %white%^& %roxo%Keyboard%white% Tweaks... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying KBM Tweaks --- >> "%logfile%" 2>&1

    :: Mouse Precision
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Mouse Precision Optimized.

    :: Trackpad Precision
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v "EnablePrecision" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Trackpad Precision Optimized.

    :: Mouse DQS
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d 32 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Mouse Data Queue Size Optimized.

    :: Keyboard DQS
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d 32 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Keyboard Data Queue Size Optimized.

    :: Double Click
    reg add "HKCU\Control Panel\Mouse" /v "DoubleClickSpeed" /t REG_SZ /d 300 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Click Speed Optimized.

    :: Repeat Delay
    reg add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Key Delay Optimized.

    :: Repeat Rate
    reg add "HKCU\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d 31 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Key Speed Optimized.

    :: Sticky Keys
    reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d 506 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Sticky Keys disabled.

    :: Filter Keys
    reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d 122 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Filter Keys disabled.

    :: Toggle Keys
    reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d 58 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Toggle Keys disabled.

    echo.
    echo   %yellow%[ %yellow%•%yellow% %yellow%]%reset% Set the highest polling rate value for your mouse/keyboard.

    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Mouse ^& Keyboard Tweaks applied %green%successfully%white%.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    echo --- KBM Tweaks Applied --- >> "%logfile%" 2>&1
    goto:kbm

:: Apply Bloatware Removal
    :debloat
    cls
    echo.
    echo.
    set "W=130"
    set /a "LAST=W-2"
    set /a "MID=(W-2)/2"

    for /L %%j in (0,1,!LAST!) do (
        if %%j LEQ !MID! (
            set /a "colorR=40 + (88 * %%j / !MID!)"
        ) else (
            set /a "colorR=128 - (128 * (%%j-!MID!) / (!LAST!-!MID!))"
        )
        set /a "colorG=0", "colorB=255"
        set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
    )

    set "lines[0]=                                      ██████╗ ███████╗██████╗ ██╗      ██████╗  █████╗ ████████╗ "
    set "lines[1]=                                      ██╔══██╗██╔════╝██╔══██╗██║     ██╔═══██╗██╔══██╗╚══██╔══╝"
    set "lines[2]=                                      ██║  ██║█████╗  ██████╔╝██║     ██║   ██║███████║   ██║   "
    set "lines[3]=                                      ██║  ██║██╔══╝  ██╔══██╗██║     ██║   ██║██╔══██║   ██║   "
    set "lines[4]=                                      ██████╔╝███████╗██████╔╝███████╗╚██████╔╝██║  ██║   ██║   "
    set "lines[5]=                                      ╚═════╝ ╚══════╝╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   "

    for /L %%i in (0,1,5) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,!LAST!) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lines[0]=                   Uninstall pre-installed apps and Paid services to free up storage and reduce resource usage."
    set "lines[1]=                              Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

    for /L %%i in (0,1,1) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,129) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lineGradient="
    set /a "BeforeSpace=(134 - 108) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,108) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m     
    echo.
    echo                              %purple%[ %roxo%%underline%U%reset% %purple%]%white% Uninstall Bloatware Apps                %purple%[ %roxo%%underline%R%reset% %purple%]%white% Reinstall Bloatware Apps
    echo.                 
    echo.
    echo                                                         %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to Menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="u" goto:debloatapply
    if "%answer%"=="U" goto:debloatapply
    if "%answer%"=="r" goto:debloatrevert
    if "%answer%"=="R" goto:debloatrevert
    if "%answer%"=="b" goto:menu
    if "%answer%"=="B" goto:menu

    :: Invalid Input
    goto:debloat

    :debloatapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Disabling %roxo%Bloatware%white% Features... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Uninstalling Bloatware Apps --- >> "%logfile%" 2>&1

    :: Advertising Info
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Advertising Info disabled.

    :: OneDrive
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% OneDrive Notifications disabled.

    :: Start Menu Ads
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "HideRecommendedSection" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v "HideRecommendedSection" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Education" /v "IsEducationEnvironment" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_Layout" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Start Menu Ads disabled.

    :: News and Widgets
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Widgets ^& News disabled.

    :: Copilot AI
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Copilot AI disabled.

    :: Edge Policies
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "CopilotCDPPageContext" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "CopilotPageContext" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeEntraCopilotPageContext" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeHistoryAISearchEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "ComposeInlineEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "GenAILocalFoundationalModelSettings" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageBingChatEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Browser AI disabled.

    :: Notepad Policies
    reg add "HKLM\SOFTWARE\Policies\WindowsNotepad" /v "DisableAIFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Notepad AI disabled.

    :: Paint Policies
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableCocreator" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeFill" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableImageCreator" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeErase" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableRemoveBackground" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Paint AI disabled.

    :: App preinstall
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Apps reinstalation disabled.

    :: App Suggestions
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314559Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280815Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-202914Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Content suggestion disabled.

    :: Lockscreen Tooltips
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Lockscreen tooltips disabled.

    :: Lockscreen Spotlight
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableSpotlightCollectionOnDesktop" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Lockscreen Spotlight disabled.

    timeout /t 2 /nobreak >> "%logfile%" 2>&1

    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Uninstalling %roxo%Bloatware%white% Apps... 
    echo.

    :: 3D Apps
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *3DBuilder* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Print3D* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Microsoft3DViewer* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% 3D Apps uninstalled.

    :: Bing
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *bing* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *bingfinance* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *BingNews* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *bingsports* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *BingWeather* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *News* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Bing Apps uninstalled.

    :: Phone
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *WindowsPhone* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *YourPhone* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *CommsPhone* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Phone Apps uninstalled.

    :: PDF
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Drawboard PDF* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *DrawboardPDF* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Drawboard PDF uninstalled.

    :: Facebook
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Facebook* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Facebook uninstalled.

    :: Get Started/Help
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Getstarted* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *GetHelp* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Get Start/Help uninstalled.

    :: Messaging
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Microsoft.Messaging* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Messaging uninstalled.

    :: Office Hub
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *MicrosoftOfficeHub* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Office Hub uninstalled.

    :: OneNote
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *OneNote* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Office.OneNote* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% OneNote uninstalled.

    :: People
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *People* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% People uninstalled.

    :: Skype
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *SkypeApp* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Skype uninstalled.

    :: Solitaire
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *solit* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *MicrosoftSolitaireCollection* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Solitaire uninstalled.

    :: Sway
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Sway* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Sway uninstalled.

    :: Alarms / Clock
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *WindowsAlarms* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Alarms uninstalled.

    :: Maps
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *WindowsMaps* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Maps uninstalled.

    :: Feedback Hub
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *WindowsFeedbackHub* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Feedback Hub uninstalled.

    :: Sound Recorder
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *WindowsSoundRecorder* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Sound Recorder uninstalled.

    :: Communications
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *windowscommunicationsapps* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Communications uninstalled.

    :: Cortana
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Microsoft.549981C3F5F10* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Cortana uninstalled.

    :: Teams
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Teams* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Teams uninstalled.

    :: Sticky Notes
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *MicrosoftStickyNotes* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Sticky Notes uninstalled.

    :: Mixed Reality Portal
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *MixedReality.Portal* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Mixed Reality Portal uninstalled.

    :: LinkedIn
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *LinkedIn* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% LinkedIn uninstalled.

    :: Microsoft 365 Copilot
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Copilot* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% 365 Copilot uninstalled.

    :: Outlook
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Outlook* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *OutlookForWindows* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Outlook uninstalled.

    :: Clipchamp
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Clipchamp* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Clipchamp uninstalled.

    :: Microsoft To Do
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Microsoft.Todos* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% To Do uninstalled.

    :: OneConnect
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *OneConnect* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% OneConnect uninstalled.

    :: Windows Web Experience Pack
    chcp 437 >> "%logfile%" 2>&1
    winget uninstall "Windows Web Experience Pack" --silent >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Widgets uninstalled.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Bloatware apps uninstalled %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    echo --- Finished Debloat --- >> "%logfile%" 2>&1
    goto:debloat

:: Apply Latency & Input-Lag Tweaks
    :latency
    cls
    echo.
    echo.
    set "W=130"
    set /a "LAST=W-2"
    set /a "MID=(W-2)/2"

    for /L %%j in (0,1,!LAST!) do (
        if %%j LEQ !MID! (
            set /a "colorR=40 + (88 * %%j / !MID!)"
        ) else (
            set /a "colorR=128 - (128 * (%%j-!MID!) / (!LAST!-!MID!))"
        )
        set /a "colorG=0", "colorB=255"
        set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
    )

    set "lines[0]=                                      ██╗      █████╗ ████████╗███████╗███╗   ██╗ ██████╗██╗   ██╗"
    set "lines[1]=                                      ██║     ██╔══██╗╚══██╔══╝██╔════╝████╗  ██║██╔════╝╚██╗ ██╔╝"
    set "lines[2]=                                      ██║     ███████║   ██║   █████╗  ██╔██╗ ██║██║      ╚████╔╝ "
    set "lines[3]=                                      ██║     ██╔══██║   ██║   ██╔══╝  ██║╚██╗██║██║       ╚██╔╝  "
    set "lines[4]=                                      ███████╗██║  ██║   ██║   ███████╗██║ ╚████║╚██████╗   ██║   "
    set "lines[5]=                                      ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝ ╚═════╝   ╚═╝   "

    for /L %%i in (0,1,5) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,!LAST!) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lines[0]=                              Applies advanced tweaks to minimize system latency and improve responsivness."
    set "lines[1]=                                 Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

    for /L %%i in (0,1,1) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,129) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lineGradient="
    set /a "BeforeSpace=(134 - 108) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,108) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m     
    echo.
    echo                      %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply Latency ^& Input-Lag Tweaks                %purple%[ %roxo%%underline%R%reset% %purple%]%white% Revert Latency ^& Input-LagTweaks
    echo.                 
    echo.
    echo                                                          %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to Menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" goto:latencyapply
    if "%answer%"=="r" goto:latencyrevert
    if "%answer%"=="A" goto:latencyapply
    if "%answer%"=="R" goto:latencyrevert
    if "%answer%"=="b" goto:menu
    if "%answer%"=="B" goto:menu

    :: Invalid Input
    goto:latency


    :latencyapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Applying %roxo%Latency %white%^& %roxo%Input-Lag%white% Tweaks... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying Latency and Input-Lag Tweaks --- >> "%logfile%" 2>&1

    :: System Responsivness
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "10" /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "AlwaysOn" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% System Responsivness Optimized.

    :: Desktop time
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "Append Completion" /t REG_SZ /d "yes" /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "AutoSuggest" /t REG_SZ /d "yes" /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ExtendedUIHoverTime" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MouseHoverTime" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d 1000 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d 2000 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d 1000 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d 2000 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% UI Responsiveness Optimized.

    :: Control Power Latency
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% System Latency Optimized.

    :: Graphics Power Latency
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "Latency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "TransitionLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameLatency" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Graphics Latency Optimized.

    :: DXGKrnl/Power Monitor Latency
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorLatencyTolerance" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Monitor Latency Optimized.

    :: Timer Resolution
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm" /v "FlipQueueSize" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "ClockTimerResolution" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "TimerResolution" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Timer Resolution Optimized.

    :: Distribute Timers
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DistributeTimers" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Timer Distribution enabled.

    :: HPET disable
    bcdedit /deletevalue useplatformclock >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% High Precision Timer tweaked.

    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Latency ^& Input-Lag Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    echo --- Latency and Input-Lag Tweaks Applied --- >> "%logfile%" 2>&1
    goto:latency

:: Apply GhostOPX Power Plan
    :powerplan
    cls
    echo.
    echo.
    set "W=130"
    set /a "LAST=W-2"
    set /a "MID=(W-2)/2"

    for /L %%j in (0,1,!LAST!) do (
        if %%j LEQ !MID! (
            set /a "colorR=40 + (88 * %%j / !MID!)"
        ) else (
            set /a "colorR=128 - (128 * (%%j-!MID!) / (!LAST!-!MID!))"
        )
        set /a "colorG=0", "colorB=255"
        set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
    )

    set "lines[0]=                           ██████╗  ██████╗ ██╗    ██╗███████╗██████╗     ██████╗ ██╗      █████╗ ███╗   ██╗"
    set "lines[1]=                           ██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗    ██╔══██╗██║     ██╔══██╗████╗  ██║"
    set "lines[2]=                           ██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝    ██████╔╝██║     ███████║██╔██╗ ██║"
    set "lines[3]=                           ██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗    ██╔═══╝ ██║     ██╔══██║██║╚██╗██║"
    set "lines[4]=                           ██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║    ██║     ███████╗██║  ██║██║ ╚████║"
    set "lines[5]=                           ╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝    ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝"

    for /L %%i in (0,1,5) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,!LAST!) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lines[0]=                            Applies a custom Power Plan focused on highest performance and lowest latency."
    set "lines[1]=                               Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

    for /L %%i in (0,1,1) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,129) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lineGradient="
    set /a "BeforeSpace=(134 - 108) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,108) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m     
    echo.
    echo                             %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply GhostOPX Power Plan                %purple%[ %roxo%%underline%R%reset% %purple%]%white% Apply Balanced Power Plan
    echo.                 
    echo.
    echo                                                         %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to Menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" goto:powerplanapply
    if "%answer%"=="A" goto:powerplanapply
    if "%answer%"=="r" goto:powerplanapply2
    if "%answer%"=="R" goto:powerplanapply2
    if "%answer%"=="b" goto:menu
    if "%answer%"=="B" goto:menu

    :: Invalid Input
    goto:powerplan

    :powerplanapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Applying %highlight%GhostOPX%reset% Power Plan... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying Power Plan --- >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Checking Github repository...

    chcp 437 >> "%logfile%" 2>&1
    powershell (Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods).WmiSetBrightness(8,75)
    chcp 65001 >> "%logfile%" 2>&1

    timeout /t 2 /nobreak >nul

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Downloading %highlight%GhostOPX%reset% Power Plan...
    curl -g -k -L -# -o "C:\%script%\GhostOPX\GhostOPX-POWER.pow" "https://github.com/louzkk/Ghost-Optimizer/raw/main/bin/GhostOPX-POWER.pow" >> "%logfile%" 2>&1
    if not exist "C:\%script%\GhostOPX\GhostOPX-POWER.pow" (
        echo   %red%[ %orange%• %red%]%white% Failed to download GhostOPX power plan.
        timeout /t 2 >nul
        goto:powerplan
    )

    timeout /t 2 /nobreak >nul

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Importing %highlight%GhostOPX%reset% Power Plan...

    powercfg /import "C:\%script%\GhostOPX\GhostOPX-POWER.pow" >> "%logfile%" 2>&1
    if errorlevel 1 (
        echo   %red%[ %orange%• %red%]%white% Failed to import %highlight%GhostOPX%reset% power plan.
        timeout /t 3 >nul
        goto:powerplan
    )

    timeout /t 2 /nobreak >nul

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Applying %highlight%GhostOPX%reset% Power Plan...

    set "GUID="
    for /f "tokens=2 delims=:()" %%i in ('powercfg /list ^| findstr /i "GhostOPX"') do (
        set "GUID=%%i"
        set "GUID=!GUID: =!"
    )

    if not defined GUID (
        echo   %red%[ %orange%• %red%]%white% Could not find %highlight%GhostOPX%reset% power plan GUID.
        timeout /t 3 >nul
        goto:powerplan
    )

    powercfg /setactive !GUID! >> "%logfile%" 2>&1
    if errorlevel 1 (
        echo   %red%[ %orange%• %red%]%white% Failed to set %highlight%GhostOPX%reset% power plan active.
        timeout /t 3 >nul
        goto:powerplan
    )

    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% GhostOPX power plan applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    echo --- Power Plan applied --- >> "%logfile%" 2>&1
    goto:powerplan

:: Apply Integrity & Health Fixes
    :health
    cls
    echo.
    echo.
    set "W=130"
    set /a "LAST=W-2"
    set /a "MID=(W-2)/2"

    for /L %%j in (0,1,!LAST!) do (
        if %%j LEQ !MID! (
            set /a "colorR=40 + (88 * %%j / !MID!)"
        ) else (
            set /a "colorR=128 - (128 * (%%j-!MID!) / (!LAST!-!MID!))"
        )
        set /a "colorG=0", "colorB=255"
        set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
    )

    set "lines[0]=                                   ██╗███╗   ██╗████████╗███████╗ ██████╗ ██████╗ ██╗████████╗██╗   ██╗ "
    set "lines[1]=                                   ██║████╗  ██║╚══██╔══╝██╔════╝██╔════╝ ██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝"
    set "lines[2]=                                   ██║██╔██╗ ██║   ██║   █████╗  ██║  ███╗██████╔╝██║   ██║    ╚████╔╝ "
    set "lines[3]=                                   ██║██║╚██╗██║   ██║   ██╔══╝  ██║   ██║██╔══██╗██║   ██║     ╚██╔╝  "
    set "lines[4]=                                   ██║██║ ╚████║   ██║   ███████╗╚██████╔╝██║  ██║██║   ██║      ██║   "
    set "lines[5]=                                   ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝   "

    for /L %%i in (0,1,5) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,!LAST!) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lines[0]=                        Performs a scan and repairs corrupted files, Windows health, updates, and disk errors."
    set "lines[1]=                                Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

    for /L %%i in (0,1,1) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,129) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lineGradient="
    set /a "BeforeSpace=(134 - 108) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,108) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m     
    echo.
    echo                                          %purple%[ %roxo%%underline%S%reset% %purple%] %white%Fast Health Fix           %purple%[ %roxo%%underline%F%reset% %purple%] %white%Full Health Fix
    echo.                 
    echo.
    echo                                                         %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to Menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="s" goto:healthapply1
    if "%answer%"=="S" goto:healthapply1
    if "%answer%"=="f" goto:healthapply2
    if "%answer%"=="F" goto:healthapply2
    if "%answer%"=="b" goto:menu
    if "%answer%"=="B" goto:menu

    :: Invalid Input
    goto:health


    :healthapply1
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting %roxo%Fast%white% Integrity ^& Health Fix... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Starting Fast Health Fix --- >> "%logfile%" 2>&1

    :: Checking Image
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Checking Windows Image Health...
    DISM /Online /Cleanup-Image /CheckHealth >> "%logfile%" 2>&1

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Scanning Image
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Scanning Windows Image Health...
    DISM /Online /Cleanup-Image /ScanHealth >> "%logfile%" 2>&1

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Restoring Image
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Restoring Windows Image Health...
    DISM /Online /Cleanup-Image /RestoreHealth >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Image Health restored %green%successfully%white%.
    echo.

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Components Reset
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Reseting Windows Components base...
    DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Components repaired %green%successfully%white%.
    echo.

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: SFC SCANNOW
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Repairing System Integrity...
    sfc /scannow >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% System Integrity repaired %green%successfully%white%.
    echo.

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Reapring Microsoft Store Cache
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Repairing Microsoft Store...
    wsreset.exe >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Microsoft Store repaired %green%successfully%white%.
    echo.

    :: Saving Registry Integrity into Log
    reg query HKLM\SOFTWARE >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Registry Integrity saved to Log.

    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Integrity ^& Health fixes applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    echo --- Finished Fast Health Fix --- >> "%logfile%" 2>&1
    goto:health

    :healthapply2
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting %roxo%Full%white% Integrity ^& Health Fix... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Starting Full Health Fix --- >> "%logfile%" 2>&1

    :: Checking Image
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Checking Windows Image Health...
    DISM /Online /Cleanup-Image /CheckHealth >> "%logfile%" 2>&1

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Scanning Image
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Scanning Windows Image Health...
    DISM /Online /Cleanup-Image /ScanHealth >> "%logfile%" 2>&1

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Restoring Image
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Restoring Windows Image Health...
    DISM /Online /Cleanup-Image /RestoreHealth >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Image Health restored %green%successfully%white%.
    echo.

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Checking Components
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Checking Windows Drivers Health...
    DISM /Online /Cleanup-Image /StartComponentCleanup >> "%logfile%" 2>&1

    :: Scanning Components
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Repairing Windows Drivers Health...
    DISM /Online /Cleanup-Image /StartComponentCleanup >> "%logfile%" 2>&1

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Restoring Components
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Reseting Drivers Base Health...
    DISM /Online /Cleanup-Image /AnalyzeComponentStore >> "%logfile%" 2>&1
    DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Drivers restored %green%successfully%white%.
    echo.

    :: SFC SCANNOW
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Repairing System Integrity...
    sfc /scannow >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% System Integrity repaired %green%successfully%white%.
    echo.

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Reapring Microsoft Store Cache
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Repairing Microsoft Store...
    wsreset.exe >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Microsoft Store repaired %green%successfully%white%.
    echo.

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Files System Boot Check
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Repairing Files System...
    echo Y|chkdsk C: /f /r >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% %yellow%Files will be repaired in the next boot%reset%.
    echo.

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Stopping Windows Update
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Stopping Windows Update services...
    net stop wuauserv >> "%logfile%" 2>&1
    net stop cryptSvc >> "%logfile%" 2>&1
    net stop bits >> "%logfile%" 2>&1
    net stop msiserver >> "%logfile%" 2>&1

    :: Repairing Windows Update
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Repairing Windows Update...
    ren C:\Windows\SoftwareDistribution SoftwareDistribution.old >> "%logfile%" 2>&1
    ren C:\Windows\System32\catroot2 catroot2.old >> "%logfile%" 2>&1
    del /q /f /s %windir%\SoftwareDistribution\Download\* >> "%logfile%" 2>&1

    :: Starting Windows Update
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Restarting Windows Update services...
    net start wuauserv >> "%logfile%" 2>&1
    net start cryptSvc >> "%logfile%" 2>&1
    net start bits >> "%logfile%" 2>&1
    net start msiserver >> "%logfile%" 2>&1
    echo.

    :: Saving Registry Integrity into Log
    reg query HKLM\SOFTWARE >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Registry Integrity saved to Log.

    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Integrity ^& Health fixes applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    echo --- Finished Full Health Fix --- >> "%logfile%" 2>&1
    goto:health

:: Start Temporary Files Cleanup
    :clean
    cls
    echo.
    echo.
    set "W=130"
    set /a "LAST=W-2"
    set /a "MID=(W-2)/2"

    for /L %%j in (0,1,!LAST!) do (
        if %%j LEQ !MID! (
            set /a "colorR=40 + (88 * %%j / !MID!)"
        ) else (
            set /a "colorR=128 - (128 * (%%j-!MID!) / (!LAST!-!MID!))"
        )
        set /a "colorG=0", "colorB=255"
        set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
    )

    set "lines[0]=                                            ██████╗██╗     ███████╗ █████╗ ███╗   ██╗ "
    set "lines[1]=                                           ██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║"
    set "lines[2]=                                           ██║     ██║     █████╗  ███████║██╔██╗ ██║"
    set "lines[3]=                                           ██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║"
    set "lines[4]=                                           ╚██████╗███████╗███████╗██║  ██║██║ ╚████║"
    set "lines[5]=                                            ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝"

    for /L %%i in (0,1,5) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,!LAST!) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lines[0]=                     Cleans temporary files, logs, caches, and unnecessary files to free up space and fix issues."
    set "lines[1]=                              Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

    for /L %%i in (0,1,1) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,129) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lineGradient="
    set /a "BeforeSpace=(134 - 108) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,108) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m     
    echo.
    echo                              %purple%[ %roxo%%underline%G%reset% %purple%]%white% Start Ghost Clean-up                %purple%[ %roxo%%underline%W%reset% %purple%]%white% Start Windows Clean-up
    echo.
    echo.
    echo                                                         %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to Menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="g" goto:ghostclean
    if "%answer%"=="G" goto:ghostclean
    if "%answer%"=="w" goto:windowsclean
    if "%answer%"=="W" goto:windowsclean
    if "%answer%"=="b" goto:menu
    if "%answer%"=="B" goto:menu

    :: Invalid Input
    goto:clean


    :ghostclean
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting %roxo%Ghost Optimizer%white% Clean... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Starting Ghost Optimizer Clean --- >> "%logfile%" 2>&1

    :: Temporary files
    rd /s /q "%windir%\Temp" >> "%logfile%" 2>&1
    md "%windir%\Temp" >> "%logfile%" 2>&1
    rd /s /q "%LocalAppData%\Temp" >> "%logfile%" 2>&1
    md "%LocalAppData%\Temp" >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Temporary files cleaned.

    :: Prefetch
    rd /s /q "%windir%\Prefetch" >> "%logfile%" 2>&1
    md "%windir%\Prefetch" >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Prefetch files cleaned.

    :: Recycle Bin
    rd /s /q "%systemdrive%\$Recycle.Bin" >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Recycle Bin cleaned.

    :: Thumbcache
    del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Thumbnail cache cleaned.

    :: System logs
    echo. > "%SystemRoot%\Logs\CBS\CBS.log" >> "%logfile%" 2>&1
    echo. > "%SystemRoot%\Logs\DISM\DISM.log" >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% System logs cleared.

    :: Clean Ghost Optimizer Logs
    if exist "C:\Ghost Optimizer\Logs" (
        del /f /q "C:\Ghost Optimizer\Logs\*.*" >> "%logfile%" 2>&1
        echo   %purple%[ %roxo%•%purple% %purple%]%white% Ghost logs cleared.
    ) else (
        echo   %purple%[ %roxo%•%purple% %purple%]%white% Logs folder not found.
    )

    :: Clean Ghost Optimizer Cache
    if exist "C:\Ghost Optimizer" (
        del /f /q "C:\Ghost Optimizer\*.*" >> "%logfile%" 2>&1
        echo   %purple%[ %roxo%•%purple% %purple%]%white% Ghost cache cleared.
    ) else (
        echo   %purple%[ %roxo%•%purple% %purple%]%white% Cache folder not found.
    )

    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% System cleaned %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    echo --- Finished Ghost Optimizer Clean --- >> "%logfile%" 2>&1
    goto:clean

    :windowsclean
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting %roxo%Windows%white% Clean... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Starting Windows Clean --- >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Click on Temporary Files.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    start ms-settings:storagesense >> "%logfile%" 2>&1

    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% System cleaned %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    echo --- Finished Windows Clean --- >> "%logfile%" 2>&1
    goto:clean

:: Disable Unecessary Services
    :services
    cls
    echo.
    echo.
    set "W=130"
    set /a "LAST=W-2"
    set /a "MID=(W-2)/2"

    for /L %%j in (0,1,!LAST!) do (
        if %%j LEQ !MID! (
            set /a "colorR=40 + (88 * %%j / !MID!)"
        ) else (
            set /a "colorR=128 - (128 * (%%j-!MID!) / (!LAST!-!MID!))"
        )
        set /a "colorG=0", "colorB=255"
        set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
    )

    set "lines[0]=                                     ███████╗███████╗██████╗ ██╗   ██╗██╗ ██████╗███████╗███████╗ "
    set "lines[1]=                                     ██╔════╝██╔════╝██╔══██╗██║   ██║██║██╔════╝██╔════╝██╔════╝"
    set "lines[2]=                                     ███████╗█████╗  ██████╔╝██║   ██║██║██║     █████╗  ███████╗"
    set "lines[3]=                                     ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║     ██╔══╝  ╚════██║"
    set "lines[4]=                                     ███████║███████╗██║  ██║ ╚████╔╝ ██║╚██████╗███████╗███████║"
    set "lines[5]=                                     ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝╚══════╝╚══════╝"

    for /L %%i in (0,1,5) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,!LAST!) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lines[0]=                       Disables unnecessary services to reduce resource usage and improve system performance."
    set "lines[1]=                              Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

    for /L %%i in (0,1,1) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,129) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lineGradient="
    set /a "BeforeSpace=(134 - 108) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,108) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m     
    echo.
    echo                            %purple%[ %roxo%%underline%D%reset% %purple%]%white% Disable Unnecessary Services                %purple%[ %roxo%%underline%R%reset% %purple%]%white% Revert Unecessary Services
    echo.                 
    echo.
    echo                                                          %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to Menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="d" goto:servicesapply
    if "%answer%"=="D" goto:servicesapply
    if "%answer%"=="r" goto:servicesrevert
    if "%answer%"=="R" goto:servicesrevert
    if "%answer%"=="b" goto:menu
    if "%answer%"=="B" goto:menu


    :: Invalid Input
    goto:services

    :servicesapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Disabling %roxo%Unnecessary Services%white%...
    echo.
    timeout /t 2 /nobreak >> "C:\%script%\Ghost_Log.txt" 2>&1
    echo --- Disabling Unnecessary Services --- >> "%logfile%" 2>&1

    :: Telephony API
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PhoneSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Phone Services disabled.

    :: Font Cache 3.0.0.0
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache3.0.0.0" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Font Cache disabled.

    :: Parental Control
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpcMonSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SEMgrSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedRealitySvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Parental Control disabled.

    :: P2P
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PNRPsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\p2psvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\p2pimsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Peer-to-Peer disabled.

    :: Sharing
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Netlogon" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CscService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\svsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% File Sharing disabled.

    :: Windows Update
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "3" /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\InstallService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\sedsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Update disabled.

    :: Sensor / Location
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorDataService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\shpamsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Sensor services disabled.

    :: Mixed Reality Portal
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\perceptionsimulation" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\FrameServer" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Mixed Reality disabled.

    :: OneSync
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\UserDataSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\UnistoreSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DevicesFlowUserSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\ConsentUxUserSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DevicePickerUserSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DeviceAssociationBrokerSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\cbdhsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% OneSync disabled.

    :: DVRU
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BcastDVRUserService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Broadcast disabled.

    :: Edge
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdatem" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdate" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\MicrosoftEdgeElevationService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Edge Update disabled.

    :: Network Protocols
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\ALG" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\QWAVE" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\IpxlatCfgSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\icssvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\MSiSCSI" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\NfsClnt" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lltdsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Connection services disabled.

    :: Time Sync
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DusmSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\autotimesvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\tzautoupdate" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Time Sync disabled.

    :: SysMain
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% SysMain disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\defragsvc" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Auto Defrag enabled.

    :: Tablet Input
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TouchKeyboardAndHandwritingPanelService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Tablet Input disabled.

    :: Tablet
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Themes" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Themes disabled.

    :: Encryption
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SENS" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Encryption services disabled.

    :: Readiness
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppReadiness" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\OSRSS" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Readiness disabled.

    :: Messages
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\MessagingService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Messages disabled.

    :: SSH
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\ssh-agent" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% SSH services disabled.

    :: Cortana
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Cortana disabled.

    :: Print Spooler / Fax
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Fax" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Spooler/Fax services disabled.

    :: Maps Broker
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Maps Broker disabled.

    :: Search Index
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WSearch" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Search Index disabled.

    :: Remote Registry
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Remote Registry disabled.

    :: Biometrics
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WbioSrvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Biometric disabled.

    :: Insider
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Insider disabled.

    :: Wallet
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WalletService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Wallet disabled.

    :: Xbox Services
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Xbox services disabled.

    :: Xbox Services
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\cplspcon" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\cphs" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\jhi_service" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\esifsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\igccservice" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfxCUIService2.0.0.0" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WMIRegistrationService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RstMwService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Intel(R) TPM Provisioning Service" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\IntelAudioService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Intel services disabled.

    echo.
    timeout /t 3 /nobreak >> "C:\%script%\Ghost_Log.txt" 2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Unnecessary Services disabled %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\%script%\Ghost_Log.txt" 2>&1
    title %script% %version% %reboot%
    echo --- Unnecessary Services Disabled --- >> "%logfile%" 2>&1
    goto:services

:: Apply NVIDIA Tweaks/Profile
    :nvidia
    cls
    echo.
    echo.

    set "W=130"
    set /a "LAST=W-2"
    set /a "MID=(W-2)/2"

    for /L %%j in (0,1,!LAST!) do (
        set /a "colorR=0"
        set /a "colorG=255 - (105 * %%j / !LAST!)"
        set /a "colorB=100 + (155 * %%j / !LAST!)"
        set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
    )

    set "lines[0]=                                              ███╗   ██╗██╗   ██╗██╗██████╗ ██╗ █████╗ "
    set "lines[1]=                                              ████╗  ██║██║   ██║██║██╔══██╗██║██╔══██╗"
    set "lines[2]=                                              ██╔██╗ ██║██║   ██║██║██║  ██║██║███████║"
    set "lines[3]=                                              ██║╚██╗██║╚██╗ ██╔╝██║██║  ██║██║██╔══██║"
    set "lines[4]=                                              ██║ ╚████║ ╚████╔╝ ██║██████╔╝██║██║  ██║"
    set "lines[5]=                                              ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═════╝ ╚═╝╚═╝  ╚═╝"

    for /L %%i in (0,1,5) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,!LAST!) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lines[0]=                  Optimizes NVIDIA drivers to improve performance and latency while disabling telemetry/bloatware."
    set "lines[1]=                              Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

    for /L %%i in (0,1,1) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,129) do (
            set "char=!text:~%%j,1!"
            if "!char!"=="" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    echo.
    set "lineGradient="
    set /a "BeforeSpace=(134 - 108) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,108) do (
        set /a "colorR=0"
        set /a "colorG=255 - (105 * %%j / 108)"
        set /a "colorB=100 + (155 * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )

    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m     
    echo.
    echo                                 %nvidia%[ %verde%%underline%A%reset% %nvidia%]%white% Apply NVIDIA Tweaks                %nvidia%[ %verde%%underline%R%reset% %nvidia%]%white% Revert NVIDIA Tweaks
    echo.
    echo.
    echo                                                    %nvidia%[ %verde%%underline%O%reset% %nvidia%]%white% Open Profile Inspector   
    echo.
    echo.
    echo                                                           %nvidia%[ %verde%%underline%B%reset% %nvidia%]%white% Back to Menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" goto:nvidiaapply
    if "%answer%"=="r" goto:nvidiarevert
    if "%answer%"=="A" goto:nvidiaapply
    if "%answer%"=="R" goto:nvidiarevert
    if "%answer%"=="o" goto:inspector
    if "%answer%"=="O" goto:inspector
    if "%answer%"=="b" goto:menu
    if "%answer%"=="B" goto:menu

    :: Invalid Input
    goto:nvidia

    :nvidiaapply
    cls
    echo.
    echo   %verde%[ %green%•%verde% %verde%]%reset% Applying %green%NVIDIA Profile Inspector%reset% Tweaks...
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying NVIDIA Profile --- >> "%logfile%" 2>&1

    echo   %verde%[ %green%•%verde% %verde%]%reset% Checking %green%Profile Inspector%reset% executable...
    timeout /t 2 /nobreak >> "%logfile%" 2>&1

    if not exist "C:\%script%\NVIDIA\nvidiaProfileInspector.zip" (
        echo   %verde%[ %green%•%verde% %verde%]%reset% Downloading %green%Profile Inspector%reset% package...
        curl -g -k -L -# -o "C:\%script%\NVIDIA\nvidiaProfileInspector.zip" "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/download/2.4.0.27/nvidiaProfileInspector.zip" >> "%logfile%" 2>&1
        if errorlevel 1 (
            echo   %red%[ %red%•%red% %red%]%reset% Failed to download NVIDIA Profile Inspector.
            goto :nvidiaend
        )
    ) else (
        echo   %verde%[ %green%•%verde% %verde%]%reset% %green%Profile Inspector%reset% already downloaded.
        timeout /t 2 /nobreak >> "%logfile%" 2>&1
    )

    if not exist "C:\%script%\NVIDIA\NvidiaProfileInspector" (
        echo   %verde%[ %green%•%verde% %verde%]%reset% Extracting %green%Profile Inspector%reset% package...
        chcp 437 >> "%logfile%" 2>&1
        powershell -NoProfile Expand-Archive 'C:\%script%\NVIDIA\nvidiaProfileInspector.zip' -DestinationPath 'C:\%script%\NVIDIA\' >> "%logfile%" 2>&1
        chcp 65001 >> "%logfile%" 2>&1
        del /q "C:\%script%\NVIDIA\nvidiaProfileInspector.zip" >nul 2>&1
        if not exist "C:\%script%\NVIDIA\nvidiaProfileInspector.exe" (
            echo   %red%[ %red%•%red% %red%]%reset% Extraction failed, executable not found.
            goto :nvidiaend
        )
    )

    echo   %verde%[ %green%•%verde% %verde%]%reset% Importing %green%Profile Inspector%reset% profile...
    curl -g -k -L -# -o "C:\%script%\NVIDIA\GhostOPX-NVIDIA.nip" "https://github.com/louzkk/Ghost-Optimizer/raw/main/bin/GhostOPX-NVIDIA.nip" >> "%logfile%" 2>&1
    if errorlevel 1 (
        echo   %red%[ %red%•%red% %red%]%reset% Failed to download NVIDIA profile.
        goto :nvidiaend
    )
    timeout /t 2 /nobreak >> "%logfile%" 2>&1

    echo   %verde%[ %green%•%verde% %verde%]%reset% Applying %green%Profile Inspector%reset% profile...
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    if exist "C:\%script%\NVIDIA\nvidiaProfileInspector.exe" (
        start "" /wait "C:\%script%\NVIDIA\nvidiaProfileInspector.exe" "C:\%script%\NVIDIA\GhostOPX-NVIDIA.nip" >> "%logfile%" 2>&1
        echo.
        echo   %verde%[ %green%•%verde% %verde%]%reset% Profile Inspector Tweaks Applied %green%successfully%white%.
        echo --- NVIDIA Profile applied --- >> "%logfile%" 2>&1
    ) else (
        echo   %red%[ %red%•%red% %red%]%reset% NVIDIA Profile Inspector executable not found.
    )

    :nvidiaend

    cls
    echo.
    echo   %verde%[ %green%•%verde% %verde%]%reset% Applying %green%NVIDIA%reset% Tweaks... 
    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo --- Applying NVIDIA Tweaks --- >> "%logfile%" 2>&1

    :: Latency Tolerance (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "D3PCLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "F1TransitionLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "LOWLATENCY" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Node3DLowLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PciLatencyTimerControl" /t REG_DWORD /d "20" /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMDeepL1EntryLatencyUsec" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmGspcMaxFtuS" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmGspcMinFtuS" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmGspcPerioduS" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMLpwrEiIdleThresholdUs" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMLpwrGrIdleThresholdUs" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMLpwrGrRgIdleThresholdUs" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RMLpwrMsIdleThresholdUs" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "VRDirectFlipDPCDelayUs" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "VRDirectFlipTimingMarginUs" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "VRDirectJITFlipMsHybridFlipDelayUs" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "vrrCursorMarginUs" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "vrrDeflickerMarginUs" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "vrrDeflickerMaxUs" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% %verde%]%reset% Latency Tolerance Optimized.

    :: Power Saving (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% %verde%]%reset% Power Saving disabled.

    :: Driver Telemetry (from Ancel's Performance Batch)
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "NvBackend" /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    schtasks /change /disable /tn "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%logfile%" 2>&1
    schtasks /change /disable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%logfile%" 2>&1
    schtasks /change /disable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%logfile%" 2>&1
    schtasks /change /disable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%logfile%" 2>&1
    schtasks /change /disable /tn "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%logfile%" 2>&1
    schtasks /change /disable /tn "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%logfile%" 2>&1
    schtasks /change /disable /tn "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% %verde%]%reset% Driver Telemetry disabled.

    :: DirectX Event Tracking (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% %verde%]%reset% Event Tracking disabled.

    :: Dedicated Video Memory (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% %verde%]%reset% Increased Dedicated VRAM.

    :: Redraw Acceleration (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% %verde%]%reset% Setting Driver Accelerationss.

    :: Filters (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% %verde%]%reset% Overlay Filter disabled.

    :: Write Combining (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% %verde%]%reset% Write Combining disabled.

    :: Contigous Memory Allocation (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% %verde%]%reset% Forcing Contigous Memory Allocation.

    :: DPC'S (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\NVAPI" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% %verde%]%reset% Core DPC enabled.

    :: NVIDIA WDDM TDR (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLevel" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDebugMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLimitCount" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLimitTime" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrTestMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% %verde%]%reset% Driver TDR disabled.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% %verde%]%reset% NVIDIA Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    echo --- NVIDIA Tweaks applied --- >> "%logfile%" 2>&1
    goto:nvidia

   :inspector
    cls
    echo.
    echo   %verde%[ %green%•%verde% %verde%]%reset% Opening %green%NVIDIA Profile Inspector%reset% Software...
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Opening Profile Inspector --- >> "%logfile%" 2>&1

    echo   %verde%[ %green%•%verde% %verde%]%reset% Checking %green%Profile Inspector%reset% executable...
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    if not exist "C:\%script%\NVIDIA\nvidiaProfileInspector.exe" (
        echo   %verde%[ %green%•%verde% %verde%]%reset% Downloading %green%Profile Inspector%reset% executable...
        curl -g -k -L -# -o "C:\%script%\NVIDIA\nvidiaProfileInspector.zip" "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/download/2.4.0.27/nvidiaProfileInspector.zip" >> "%logfile%" 2>&1
    ) else (
        echo   %verde%[ %green%•%verde% %verde%]%reset% %green%Profile Inspector%reset% already downloaded.
        timeout /t 2 /nobreak >> "%logfile%" 2>&1
    )

    echo   %verde%[ %green%•%verde% %verde%]%reset% Opening %green%Profile Inspector%reset% software...
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    start /wait "" "C:\%script%\NVIDIA\nvidiaProfileInspector.exe" >> "%logfile%" 2>&1

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% %verde%]%reset% %green%Profile Inspector%reset% Software closed.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %reboot%
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    echo --- Closing Profile Inspector --- >> "%logfile%" 2>&1
    goto:nvidia

:: Restarting & Rebooting
    :restart
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Restarting %purple%%underline%%script%%white%... 
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    start "" "%~f0"
    exit

    :reboot
    shutdown /r /t 10
    echo   %yellow%[ %yellow%•%yellow% %yellow%]%reset% Your system will reboot in %purple%10s%reset% to apply optimizations...
    timeout /t 3 /nobreak >nul
    goto:menu

    :rebootcancel
    shutdown /a
    echo   %yellow%[ %yellow%•%yellow% %yellow%]%reset% Scheduled reboot cancelled %green%successfully%white%..
    timeout /t 3 /nobreak >nul
    goto:menu

