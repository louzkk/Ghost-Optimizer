@echo off

:: Check for Admin
    title Checking for Admin Rights...
    if "%processor_architecture%"=="amd64" (
        >nul 2>&1 "%systemroot%\SysWOW64\cacls.exe" "%systemroot%\SysWOW64\config\system"
    ) else (
        >nul 2>&1 "%systemroot%\system32\cacls.exe" "%systemroot%\system32\config\system"
    )

    if %errorlevel% neq 0 (
        goto UACPrompt
    ) else (
        goto GotAdmin
    )

    :UACPrompt
    echo Set UAC = CreateObject("Shell.Application") > "%temp%\getadmin.vbs"
    set params=%*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /b

    :GotAdmin
    pushd "%cd%"
    cd /d "%~dp0"

:: Script Properties
    mode 124,29
    setlocal enabledelayedexpansion
    powershell "Set-ExecutionPolicy Unrestricted" >nul 2>&1
    reg add "HKCU\CONSOLE" /v "VirtualTerminalLevel" /t REG_DWORD /d 1 /f >nul 2>&1
    for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")
    (for /f %%a in ('echo prompt $E^| cmd') do set "esc=%%a")

    :: Variables
    set "version=4.9.7"
    set "space= / "
    set "script=Ghost Optimizer"
    set "reboot=Reboot required"
    set "rebooing=Rebooting"
    set "shuttingdown=Shutting Down"
    set "downloading=Downloading"
    set "louzkk=@louzkk"
    title %script% %version%

:: Colors & Gradient
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

    chcp 65001 >nul 2>&1

:: Welcome & Restore Point
    :welcome
    cls 
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=                                ██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗  "
    set "lines[1]=                                ██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝"
    set "lines[2]=                                ██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗"
    set "lines[3]=                                ██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝"
    set "lines[4]=                                ╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗"
    set "lines[5]=                                 ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝"

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
    set /a "BeforeSpace=(130 - 115) / 2"
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
    echo                          %roxo%%script%%reset% is a lightweight open source tweaker/optimizer that is
    echo                made to improve system performance, network, latency, block telemetry and fix system integrity.
    echo.
    echo                     The revert tweaks option may not work as expected; create a restore point for safety.
    echo               Use this script at your own risk. The author takes no responsibility for any damage or data loss.
    echo                                  You can report issues or submit suggetions at Github.
    echo.
    echo                                                    Made by: %roxo%%louzkk%%reset%
    echo.
    echo.
    echo                         %purple%[ %roxo%%underline%Y%reset% %purple%]%white% Create a restore point                %purple%[ %roxo%%underline%N%reset% %purple%]%white% Skip restore point
    echo.
    echo.

    set /p answer="%white% >:%roxo%"

    :: Options
    if "%answer%"=="y" goto restore
    if "%answer%"=="Y" goto restore
    if "%answer%"=="n" goto loading
    if "%answer%"=="N" goto loading

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >nul 2>&1
    echo.
    goto welcome

    :: Restore Point
    :restore
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Creating a %roxo%Restore Point%white%... 
    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo --- Creating a Restore Point --- >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% ]%white% Starting System Restore services...
    sc config srservice start= auto >nul 2>&1
    sc start srservice >nul 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Tweaking System Protection...
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v "DisableSR" /t REG_DWORD /d 0 /f >nul 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Creating a Restore Point...
    chcp 437 >nul 2>&1
    powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description '%script% %version% - Restore Point' -RestorePointType 'MODIFY_SETTINGS'" >nul 2>&1
    chcp 65001 >nul 2>&1
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Restore Point created %green%successfully%white%.
    echo --- Restore Point created --- >> "%logfile%" 2>&1
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    goto loading

:: Loading & Getting Info
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
    set "lines[0]=                                                           ██████              "
    set "lines[1]=                                                        ████████████           "
    set "lines[2]=                                                     ██████████████████        "
    set "lines[3]=                                                     █████   ██   █████        "
    set "lines[4]=                                                    ██████   ██   ██████       "
    set "lines[5]=                                                   ██████████████████████      "
    set "lines[6]=                                                  █████   ███  ███   █████     "
    set "lines[7]=                                                  ███  ███   ██   ███  ███     "
    set "lines[8]=                                                  ████████████████████████     "
    set "lines[9]=                                                  ████    ███  ███    ████     "
    set "lines[10]=                                                                              "
    set "lines[11]=                                                                              "
    set "lines[12]=                                                          Loading...          "

    for /L %%i in (0,1,12) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,109) do (
            set "char=!text:~%%j,1!"
            if "!char!" == "" set "char= "
            set "textGradient=!textGradient!!esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    :: Creating Folders
        if not exist "C:\Ghost Optimizer" md "C:\Ghost Optimizer"
        if not exist "C:\Ghost Optimizer\Logs" md "C:\Ghost Optimizer\Logs"
        if not exist "C:\Ghost Optimizer\NVIDIA" md "C:\Ghost Optimizer\NVIDIA"
        if not exist "C:\Ghost Optimizer\OOSU10" md "C:\Ghost Optimizer\OOSU10"
        if not exist "C:\Ghost Optimizer\GhostX" md "C:\Ghost Optimizer\GhostX"
        if not exist "C:\Ghost Optimizer\GhostAHK" md "C:\Ghost Optimizer\GhostAHK"

    :: Setting Logs
        set "d=%date:/=-%"
        set "t=%time::=-%"
        set "t=%t:.=-%"
        set "t=%t: =0%"
        set "logfile=C:\Ghost Optimizer\Logs\%d%_%t%.log"
        echo Ghost Optimizer > "%logfile%"
        echo Created by louzkk >> "%logfile%" 2>&1
        echo. >> "%logfile%" 2>&1

    :: Setting Url
        set "LinkFile=C:\Ghost Optimizer\GitHub.url"
        (
        echo [InternetShortcut]
        echo URL=https://github.com/louzkk/Ghost-Optimizer
        ) > "%LinkFile%"

        chcp 437 >> "%logfile%" 2>&1

    :: GPU Info
        for /f "delims=" %%G in ('powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"') do (
            set "GPUName=%%G"
        )

    :: CPU info
        for /f "delims=" %%A in ('powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"') do (
            set "CPUName=%%A"
        )

    :: Winver info
        for /f "tokens=3" %%b in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| findstr /i "CurrentBuild"') do (
            set "BuildNumber=%%b"
        )
        if defined BuildNumber (
            if !BuildNumber! GEQ 22000 (
                set "OSName=11"
            ) else (
                set "OSName=10"
            )
        )
        set Winver=for Windows %OSName%

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    chcp 65001 >> "%logfile%" 2>&1

:: Main Menu & Selection
    :menu
    title %script% %version% %space% %winver%
    cls
    echo.
    echo.

    set "W=120"
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

    set "lines[0]=     ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗      ██████╗ ██████╗ ████████╗██╗███╗   ███╗██╗███████╗███████╗██████╗"
    set "lines[1]=    ██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝     ██╔═══██╗██╔══██╗╚══██╔══╝██║████╗ ████║██║╚══███╔╝██╔════╝██╔══██╗"
    set "lines[2]=    ██║ ███╗ ███████║██║   ██║███████╗   ██║        ██║   ██║██████╔╝   ██║   ██║██╔████╔██║██║  ███╔╝ █████╗  ██████╔╝"
    set "lines[3]=    ██║  ██║ ██╔══██║██║   ██║╚════██║   ██║        ██║   ██║██╔═══╝    ██║   ██║██║╚██╔╝██║██║ ███╔╝  ██╔══╝  ██╔══██╗"
    set "lines[4]=    ╚██████║ ██║  ██║╚██████╔╝███████║   ██║        ╚██████╔╝██║        ██║   ██║██║ ╚═╝ ██║██║███████╗███████╗██║  ██║"
    set "lines[5]=     ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝         ╚═════╝ ╚═╝        ╚═╝   ╚═╝╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝  ╚═╝"

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
    echo                        %purple%%underline%GPU%reset%%purple%:%reset% %GPUName%        %purple%%underline%CPU%reset%%purple%:%reset% %CPUName%
    echo.

    set "lineGradient="
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                       %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply all Tweaks/Fixes%orange%*%reset%                 %purple%[ %roxo%%underline%R%reset% %purple%]%white% Revert all Tweaks/Fixes
    echo.
    echo.
    echo              %purple%[ %roxo%%underline%1%reset% %purple%]%white% General Tweaks               %purple%[ %roxo%%underline%2%reset% %purple%]%white% Performance Tweaks              %purple%[ %roxo%%underline%3%reset% %purple%]%white% Network Tweaks
    echo.
    echo              %purple%[ %roxo%%underline%4%reset% %purple%]%white% NVIDIA Profile               %purple%[ %roxo%%underline%5%reset% %purple%]%white% Latency ^& Input-Lag             %purple%[ %roxo%%underline%6%reset% %purple%]%white% Mouse ^& Keyboard       
    echo.
    echo              %purple%[ %roxo%%underline%7%reset% %purple%]%white% Windows Cleaner              %purple%[ %roxo%%underline%8%reset% %purple%]%white% Telemetry ^& Logging             %purple%[ %roxo%%underline%9%reset% %purple%]%white% Unnecessary Services
    echo.
    echo              %purple%[ %roxo%%underline%10%reset% %purple%]%white% GhostX Powerplan            %purple%[ %roxo%%underline%11%reset% %purple%]%white% Integrity ^& Health             %purple%[ %roxo%%underline%12%reset% %purple%]%white% Uninstall Bloatware                        
    echo.
    echo.
    set /p answer="%white% >:%roxo%"

    :: Options
    if %answer% equ 1 goto general
    if %answer% equ 2 goto performance
    if %answer% equ 3 goto network
    if %answer% equ 4 goto nvidia
    if %answer% equ 5 goto latency
    if %answer% equ 6 goto kbm
    if %answer% equ 7 goto clean
    if %answer% equ 8 goto telemetry
    if %answer% equ 9 goto services
    if %answer% equ 10 goto powerplan
    if %answer% equ 11 goto health
    if %answer% equ 12 goto debloat

    if "%answer%"=="A" goto applyall
    if "%answer%"=="a" goto applyall
    if "%answer%"=="R" goto revertall
    if "%answer%"=="r" goto revertall

    if "%answer%"=="restart" goto restart
    if "%answer%"=="exit" exit
    if "%answer%"=="reboot" goto reboot
    if "%answer%"=="rebootcancel" goto rebootcancel
    if "%answer%"=="cancel" goto rebootcancel
    if "%answer%"=="Restart" goto restart
    if "%answer%"=="Exit" exit
    if "%answer%"=="Reboot" goto reboot
    if "%answer%"=="Rebootcancel" goto rebootcancel
    if "%answer%"=="Cancel" goto rebootcancel
    if "%answer%"=="RESTART" goto restart
    if "%answer%"=="EXIT" exit
    if "%answer%"=="REBOOT" goto reboot
    if "%answer%"=="REBOOTCANCEL" goto rebootcancel
    if "%answer%"=="CANCEL" goto rebootcancel

    if "%answer%"=="socd" goto socd

    if "%answer%"=="Louzkk" start https://github.com/louzkk
    if "%answer%"=="louzkk" start https://github.com/louzkk
    if "%answer%"=="@louzkk" start https://github.com/louzkk
    if "%answer%"=="@Louzkk" start https://github.com/louzkk
    if "%answer%"=="LOUZKK" start https://github.com/louzkk
    if "%answer%"=="@LOUZKK" start https://github.com/louzkk
    if "%answer%"=="ghost" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="Ghost" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="GHOST" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="github" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="Github" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="help" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="Help" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="HELP" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="About" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="about" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="ABOUT" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="?" start https://github.com/louzkk/Ghost-Optimizer

    :: Invalid Input
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    goto menu

:: Apply & Revert All
    :applyall
    cls
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=                               █████╗ ██████╗ ██████╗ ██╗  ██╗   ██╗     █████╗ ██╗     ██╗          "
    set "lines[1]=                              ██╔══██╗██╔══██╗██╔══██╗██║  ╚██╗ ██╔╝    ██╔══██╗██║     ██║          "
    set "lines[2]=                              ███████║██████╔╝██████╔╝██║   ╚████╔╝     ███████║██║     ██║          "
    set "lines[3]=                              ██╔══██║██╔═══╝ ██╔═══╝ ██║    ╚██╔╝      ██╔══██║██║     ██║          "
    set "lines[4]=                              ██║  ██║██║     ██║     ███████╗██║       ██║  ██║███████╗███████╗     "
    set "lines[5]=                              ╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝╚═╝       ╚═╝  ╚═╝╚══════╝╚══════╝     "

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
    set "lines[0]=                   Tweaks: General, Performance, Network, Latency, KBM, Telemetry, Services and Power Plan."
    set "lines[1]=                           Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

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
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                           %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply all Tweaks                      %purple%[ %roxo%%underline%C%reset% %purple%]%white% Check documentation
    echo.                 
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" call :applyallapply
    if "%answer%"=="c" call :documentation
    if "%answer%"=="A" call :applyallapply
    if "%answer%"=="C" call :documentation
    if "%answer%"=="b" call :menu
    if "%answer%"=="B" call :menu

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto applyall

    :applyallapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %roxo%All%white% Tweaks/Fixes... 
    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1

    set mode=none
    call:generalapply
    call:performanceapply
    call:networkapply
    call:latencyapply
    call:kbmapply
    call:telemetryapply
    call:servicesapply
    call:powerplanapply

    echo.
    echo.
    echo   %yellow%[ • ]%reset% Remaining Tweaks: NVIDIA, Cleaner, Health and Debloat 

    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% All Tweaks/Fixes applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    taskkill /f /im explorer.exe >> "%logfile%" 2>&1
    start explorer.exe >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    goto menu

    :documentation
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Opening %roxo%documentation%white% page...
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    start https://github.com/louzkk/Ghost-Optimizer
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    goto menu

    :revertall
    cls
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=                        ██████╗ ███████╗██╗   ██╗███████╗██████╗ ████████╗     █████╗ ██╗     ██╗               "
    set "lines[1]=                        ██╔══██╗██╔════╝██║   ██║██╔════╝██╔══██╗╚══██╔══╝    ██╔══██╗██║     ██║               "
    set "lines[2]=                        ██████╔╝█████╗  ██║   ██║█████╗  ██████╔╝   ██║       ███████║██║     ██║               "
    set "lines[3]=                        ██╔══██╗██╔══╝  ╚██╗ ██╔╝██╔══╝  ██╔══██╗   ██║       ██╔══██║██║     ██║               "
    set "lines[4]=                        ██║  ██║███████╗ ╚████╔╝ ███████╗██║  ██║   ██║       ██║  ██║███████╗███████╗          "
    set "lines[5]=                        ╚═╝  ╚═╝╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝   ╚═╝       ╚═╝  ╚═╝╚══════╝╚══════╝          "

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
    set "lines[0]=                       Revert all Tweaks/Fixes using the restore point that you created (or should have)."
    set "lines[1]=                           Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

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
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                            %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply Restore Point                %purple%[ %roxo%%underline%C%reset% %purple%]%white% Check documentation
    echo.                 
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" goto revertallapply
    if "%answer%"=="c" goto documentation
    if "%answer%"=="A" goto revertallapply
    if "%answer%"=="C" goto documentation
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto revertall

    :revertallapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Reverting %roxo%All%white% Tweaks/Fixes... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying Restore Point --- >> "%logfile%" 2>&1

    :: Start System Restore
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% System Restore open.
    start /wait "" rstrui.exe >> "%logfile%" 2>&1
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% System Restore closed.
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Thank you for using Ghost Optimizer :]
    echo.
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo   %yellow%[ • ]%reset% The next system reboot/restart may take some time.

    echo.
    timeout /t 3 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% All Tweaks/Fixes reverted %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Restore Point reverted --- >> "%logfile%" 2>&1
    goto menu

    :documentation
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Opening %roxo%documentation%white% page...
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    start https://github.com/louzkk/Ghost-Optimizer
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    goto menu

:: General Tweaks
    :general
    set mode=menu
    cls
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=                                  ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗     "
    set "lines[1]=                                 ██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║     "
    set "lines[2]=                                 ██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║     "
    set "lines[3]=                                 ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║     "
    set "lines[4]=                                 ╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗"
    set "lines[5]=                                  ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝"

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
    set "lines[0]=                        Applies essential tweaks to make Windows cleaner, faster to use and less annoying."
    set "lines[1]=                           Check the full documentation at: https://github.com/louzkk/Ghost-Optimizer"

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

    set "lineGradient="
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                                               %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply General Tweaks
    echo.                 
    echo.
    echo                                                   %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" call :generalapply
    if "%answer%"=="r" call :generalrevert
    if "%answer%"=="A" call :generalapply
    if "%answer%"=="R" call :generalrevert
    if "%answer%"=="b" goto :menu
    if "%answer%"=="B" goto :menu

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto general

    :generalapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %roxo%General%white% Tweaks... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying General Tweaks --- >> "%logfile%" 2>&1

    :: SysMain (Prefetcher)
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% SysMain disabled.

    :: Disk Optimization
    reg add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" /v "Enable" /t REG_STR /d "Y" /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\defragsvc" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Optimize" /v "ScheduledDefrag" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" /ri 0 /st 00:00 /du 00:00 /mo MONTHLY /enable >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Defrag enabled.

    :: Bing Search
    reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchHistoryEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Bing search disabled.

    :: Snap Assist
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SnapAssist" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "EnableSnapAssistFlyout" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "EnableSnapAssistFlyoutPreview" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Snap Assist disabled.

    :: Explorer
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Explorer Tweaked.

    :: Taskbar
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" /v "TaskbarEndTask" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" /v "value" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v "DisableTouchKeyboard" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableDesktopModeAutoInvoke" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\TabletTip\1.7" /v "TipbandDesiredVisibility" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "PeopleBand" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" /v "PenWorkspaceButtonDesiredVisibility" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Taskbar Tweaked.

    :: Webview/Indexing
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchHistoryEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowIndexingEncryptedStoresOrItems" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableIndexerBackoff" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "PreventIndexingOutlook" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "PreventIndexingPublicFolders" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "PreventIndexingEmailAttachments" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    sc config WSearch start=disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Searchbar Tweaked.

    :: File Extensions
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% File Extensions visible.

    :: Hidden Files
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Hidden Files visible.

    :: Tablet Mode
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "TabletMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "SignInMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "TabletModeBatteryThreshold" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Tablet Mode disabled.

    :: Storage Sense
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 1 /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Storage Sense disabled.

    :: Background Apps
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Background Apps disabled.

    :: Remote Assist
    reg add "HKLM\System\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowFullControl" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fAllowUnsolicited" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Remote Assist disabled.

    :: Dynamic Light
    reg add "HKCU\Software\Microsoft\Lighting" /v "AmbientLightingEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Dynamic Light disabled.

    :: Stickers
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Stickers" /v "EnableStickers" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Stickers disabled.

    :: USB Selective Suspend
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% USB Idling disabled.

    :: Hibernation
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberBootEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SleepReliabilityDetailedDiagnostics" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Hibernation disabled.

    :: Focus Assist
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "FocusAssist" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Focus Assist disabled.

    :: LockTooltips & Spotlight
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableSpotlightCollectionOnDesktop" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Tooltips ^& Spotlight disabled.

    :: Driver Search
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Driver Search disabled.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% General Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Finished General Tweaks --- >> "%logfile%" 2>&1
    if "%mode%"=="menu" goto menu
    exit /b

:: Performance Tweaks
    :performance
    set mode=menu
    cls
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=               ██████╗ ███████╗██████╗ ███████╗ ██████╗ ██████╗ ███╗   ███╗ █████╗ ███╗   ██╗ ██████╗███████╗"
    set "lines[1]=               ██╔══██╗██╔════╝██╔══██╗██╔════╝██╔═══██╗██╔══██╗████╗ ████║██╔══██╗████╗  ██║██╔════╝██╔════╝"
    set "lines[2]=               ██████╔╝█████╗  ██████╔╝█████╗  ██║   ██║██████╔╝██╔████╔██║███████║██╔██╗ ██║██║     █████╗  "
    set "lines[3]=               ██╔═══╝ ██╔══╝  ██╔══██╗██╔══╝  ██║   ██║██╔══██╗██║╚██╔╝██║██╔══██║██║╚██╗██║██║     ██╔══╝  "
    set "lines[4]=               ██║     ███████╗██║  ██║██║     ╚██████╔╝██║  ██║██║ ╚═╝ ██║██║  ██║██║ ╚████║╚██████╗███████╗"
    set "lines[5]=               ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝"

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
    set "lines[0]=                    Applies advanced tweaks to boost system performance and latency and responsivness."
    set "lines[1]=                         Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

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

    set "lineGradient="
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                                             %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply Performance Tweaks
    echo.                 
    echo.
    echo                                                   %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" call :performanceapply
    if "%answer%"=="r" call :performancerevert
    if "%answer%"=="A" call :performanceapply
    if "%answer%"=="R" call :performancerevert
    if "%answer%"=="b" call :menu
    if "%answer%"=="B" call :menu

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto performance

    :performanceapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %roxo%Performance%white% Tweaks... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying Performance Tweaks --- >> "%logfile%" 2>&1

    :: Game Mode
    reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Game Mode enabled.

    :: Uncomment this line to keep the Game Bar and Game Capture on.
    ::goto keepgamebar

    :: Game Bar & DVR
    reg add "\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v value /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    :keepgamebar
    echo   %purple%[ %roxo%•%purple% ]%white% Game Bar ^& DVR disabled.

    :: Win32PrioritySeparation
    :: You can mannually find the best value for your system: 22 - 26 - 36 - 38 - 40 - 42
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Priority Separation Optimized.

    :: Game Scheduling (MMCSS/Legacy)
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "AlwaysOn" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "AlwaysOn" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d False /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d High /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d High /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d True /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d True /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Gaming Scheduling Optimized.

    :: Memory Management
    chcp 437 >> "%logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /f >> "%logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PagingFiles" /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "AutomaticManagedPagefile" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableExplicitVidMm" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1    
    echo   %purple%[ %roxo%•%purple% ]%white% Memory Management Optimized.

    :: Power Management
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ModernSleep" /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Power Management Optimized.

    :: Modern Standby
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PreferExternalManifest" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Attributes" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PlatformAoAcOverride" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Modern Standby disabled.

    :: Time Stamp Interval & IoPriority
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "TimeStampInterval" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "IoPriority" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% IO Priority Optimized.

    :: Hardware-Accelerated GPU Scheduling
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableReclaim" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% GPU Scheduling Optimized.

    :: Direct3D/DirectX
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 10 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Direct3D\Drivers" /v "SoftwareOnly" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Direct3D" /v "DisableDebugLayer" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\DirectX" /v "ForceGPUPreemption" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\DirectX" /v "MaxShaderCacheSize" /t REG_DWORD /d 4096 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% DirectX/3D Optimized.

    :: Fullscreen Optimization
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD  /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Fullscreen Optimizations enabled.

    :: Windowed Optimization
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm" /v "FlipQueueSize" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DisableFlipModel" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\DirectX\GraphicsSettings" /v "SwapEffectUpgradeEnable" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\DirectX\GraphicsSettings" /v "SwapEffectUpgradeCache" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /t REG_SZ /d "VRROptimizeEnable=0;SwapEffectUpgradeEnable=1;" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Windowed Optimizations enabled.

    :: Message Signaled Interrupts (MSI)
    chcp 437 >> "%logfile%" 2>&1
    for /f "tokens=*" %%g in ('powershell -Command "Get-CimInstance Win32_VideoController | ForEach-Object { $_.PNPDeviceID }"') do (
        reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
        reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    )
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1    
    echo   %purple%[ %roxo%•%purple% ]%white% MSI ^& MPO Mode enabled.

    :: Virtualization Based Security
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "RequirePlatformSecurityFeatures" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\LSA" /v "LsaCfgFlags" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    bcdedit /set hypervisorlaunch off >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% VBS and Hypervisor disabled.

    :: Spectre & Meltdown
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Spectre ^& Meltdown disabled.

    :: CPU & Timer
    bcdedit /set tscsyncpolicy Enhanced >> "%logfile%" 2>&1
    bcdedit /set disabledynamictick No >> "%logfile%" 2>&1
    bcdedit /set x2apicpolicy Enable >> "%logfile%" 2>&1
    bcdedit /set configaccesspolicy Default >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Kernel Optimizations applied.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Performance Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Performance Tweaks Applied --- >> "%logfile%" 2>&1
    if "%mode%"=="menu" goto menu
    exit /b

:: Network & DNS Tweaks
    :network
    set mode=menu
    cls
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=                               ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗"
    set "lines[1]=                               ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝"
    set "lines[2]=                               ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ "
    set "lines[3]=                               ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ "
    set "lines[4]=                               ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗"
    set "lines[5]=                               ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝"

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
    set "lines[0]=                     Applies advanced tweaks to improve network latency, stability, security and speed."
    set "lines[1]=                          Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

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
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                                                %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply Network Tweaks
    echo.                 
    echo.
    echo                                                   %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" call :networkapply
    if "%answer%"=="A" call :networkapply
    if "%answer%"=="r" call :networkrevert
    if "%answer%"=="R" call :networkrevert
    if "%answer%"=="b" call :menu
    if "%answer%"=="B" call :menu

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto network

    :networkapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %roxo%Network%white% ^& %roxo%DNS%white% Tweaks... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying Network Tweaks --- >> "%logfile%" 2>&1

    :: TCP/IP Stack Tweaks
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 0xffffffff /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "DisableBandwidthThrottling" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxCmds" /t REG_DWORD /d 2048 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% TCP/IP Stack Optimized.

    :: TCP Frequency Tweaks
    reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpDelAckTicks" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% TCP/IP Frequency Optimized.

    :: TCP Global Parameters
    netsh int tcp set global timestamps=enabled >> "%logfile%" 2>&1
    netsh int tcp set global chimney=disabled >> "%logfile%" 2>&1
    netsh int tcp set global ecncapability=enabled >> "%logfile%" 2>&1
    netsh int tcp set global autotuninglevel=enabled >> "%logfile%" 2>&1
    netsh int tcp set heuristics disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% TCP/IP Parameters Optimized.

    :: Reinforce SACK safe behavior
    netsh int tcp set global nonsackrttresiliency=disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% SACK Behavior Reinforced.

    :: RSS/RSC configuration
    netsh int tcp set global rss=enabled >> "%logfile%" 2>&1
    netsh int tcp set global rsc=disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% RSS/RSC Optimized.

    :: NETDMA/DCA
    netsh int tcp set global netdma=disabled >> "%logfile%" 2>&1
    netsh int tcp set global dca=disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% NETDMA/DCA Disabled.

    :: CTCP
    netsh int tcp set supplemental internet congestionprovider=ctcp >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% CTCP Enabled.

    :: Reset IP stack
    netsh int ip reset >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% IP Stack Reset.

    :: Network Adapter Tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableTaskOffload" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DynamicSendBufferDisable" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DoNotHoldNICBuffers" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "BufferAlignment" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "FastSendDatagramThreshold" /t REG_DWORD /d 1024 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "FastCopyReceiveThreshold" /t REG_DWORD /d 1024 /f >> "%logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DefaultSendWindow" /f >> "%logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DefaultReceiveWindow" /f >> "%logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "IgnorePushBitOnReceives" /f >> "%logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "IgnoreOrderlyRelease" /f >> "%logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DisableChainedReceive" /f >> "%logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DisableDirectAcceptEx" /f >> "%logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DisableRawSecurity" /f >> "%logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DisableAddressSharing" /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableLargeSendOffload" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% AFD Parameters Optimized.

    :: Power Saving
    chcp 437 >> "%logfile%" 2>&1
    set "NICCLASS=HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}"
    reg add "%NICCLASS%" /v "*InterruptModeration" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "%NICCLASS%" /v "InterruptModeration" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "%NICCLASS%" /v "ITR" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "%NICCLASS%" /v "*PacketCoalescing" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "%NICCLASS%" /v "PacketCoalescing" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "%NICCLASS%" /v "*ArpOffload" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "%NICCLASS%" /v "ArpOffload" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "%NICCLASS%" /v "*EEE" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "%NICCLASS%" /v "EEE" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "%NICCLASS%" /v "AdvancedEEE" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "%NICCLASS%" /v "EnableGreenEthernet" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "%NICCLASS%" /v "EnableSavePowerNow" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "%NICCLASS%" /v "EnablePowerManagement" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Scan" /v "DisablePeriodicScan" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WlanSvc\Parameters" /v "CoalescePackets" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "InitialRto" /t REG_DWORD /d 2000 /f >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Power Saving disabled.

    :: DNS Cloudflare
    chcp 437 >> "%logfile%" 2>&1
    for /f "usebackq tokens=*" %%I in (`powershell -NoProfile -Command "(Get-NetAdapter -Physical | Where-Object {$_.Status -eq 'Up'}).InterfaceIndex"`) do (
        netsh interface ip set dnsservers name=%%I source=static address=1.1.1.1 validate=no >> "%logfile%" 2>&1
        netsh interface ip add dnsservers name=%%I address=1.0.0.1 index=2 validate=no >> "%logfile%" 2>&1
        netsh interface ipv6 add dnsservers interface=%%I address=2606:4700:4700::1111 index=1 >> "%logfile%" 2>&1
        netsh interface ipv6 add dnsservers interface=%%I address=2606:4700:4700::1001 index=2 >> "%logfile%" 2>&1
    )
    ipconfig /flushdns >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% DNS Servers set to %roxo%Cloudflare%reset%.

    :: DNS Cache Tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableBucketSize" /t REG_DWORD /d 384 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableSize" /t REG_DWORD /d 384 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheEntryTtlLimit" /t REG_DWORD /d 64000 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheTtl" /t REG_DWORD /d 64000 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% DNS Cache Optimized.

    :: Winsock Tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MinSockAddrLength" /t REG_DWORD /d 16 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MaxSockAddrLength" /t REG_DWORD /d 16 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Winsock Parameters Optimized.

    :: Firewall Rules
    netsh advfirewall firewall add rule name="Ghost Optimizer LPD TCP" protocol=TCP localport=515 dir=in action=block >> "%logfile%" 2>&1
    netsh advfirewall firewall add rule name="Ghost Optimizer mDNS UDP IN"  protocol=UDP localport=5353 dir=in  action=block >> "%logfile%" 2>&1
    netsh advfirewall firewall add rule name="Ghost Optimizer mDNS UDP OUT" protocol=UDP localport=5353 dir=out action=block >> "%logfile%" 2>&1
    netsh advfirewall firewall add rule name="Ghost Optimizer RDP TCP" protocol=TCP localport=3389 dir=in action=block >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Firewall Rules Applied.

    :: Additional Tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    sc stop RemoteRegistry >> "%logfile%" 2>&1
    sc config RemoteRegistry start= disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Remote Registry disabled.

    :: fdPHost & FDResPub
    sc stop fdPHost >> "%logfile%" 2>&1
    sc config fdPHost start= disabled >> "%logfile%" 2>&1
    sc stop FDResPub >> "%logfile%" 2>&1
    sc config FDResPub start= disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Function Discovery disabled.

    :: SMBv1
    chcp 437 >> "%logfile%" 2>&1
    dism /online /norestart /disable-feature /featurename:SMB1Protocol >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB1" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer" /v "Start" /t REG_DWORD /d 4 /f  >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SMB1" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SMB2" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% SMBv1 Protocol disabled.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Network ^& DNS Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Finished Network Tweaks --- >> "%logfile%" 2>&1
    if "%mode%"=="menu" goto menu
    exit /b

:: Telemetry & OOSU10
    :telemetry
    set mode=menu
    cls
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=                        ████████╗███████╗██╗     ███████╗███╗   ███╗███████╗████████╗██████╗ ██╗   ██╗"
    set "lines[1]=                        ╚══██╔══╝██╔════╝██║     ██╔════╝████╗ ████║██╔════╝╚══██╔══╝██╔══██╗╚██╗ ██╔╝"
    set "lines[2]=                           ██║   █████╗  ██║     █████╗  ██╔████╔██║█████╗     ██║   ██████╔╝ ╚████╔╝ "
    set "lines[3]=                           ██║   ██╔══╝  ██║     ██╔══╝  ██║╚██╔╝██║██╔══╝     ██║   ██╔══██╗  ╚██╔╝   "
    set "lines[4]=                           ██║   ███████╗███████╗███████╗██║ ╚═╝ ██║███████╗   ██║   ██║  ██║   ██║   "
    set "lines[5]=                           ╚═╝   ╚══════╝╚══════╝╚══════╝╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝   "

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
    set "lines[0]=             Disables data collection, diagnostics, and tracking, enhancing privacy and reducing resource usage."
    set "lines[1]=                         Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

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

    set "lineGradient="
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                          %purple%[ %roxo%%underline%S%reset% %purple%]%white% Stop Telemetry ^& Logging                %purple%[ %roxo%%underline%O%reset% %purple%]%white% Open OOSU10+ Software
    echo.
    echo.
    echo                                                     %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="s" call :telemetryapply
    if "%answer%"=="S" call :telemetryapply
    if "%answer%"=="r" call :telemetryrevert
    if "%answer%"=="R" call :telemetryrevert
    if "%answer%"=="o" call :oosu10
    if "%answer%"=="O" call :oosu10
    if "%answer%"=="b" call :menu
    if "%answer%"=="B" call :menu

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto telemetry

    :telemetryapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Telemetry %white%^& %roxo%Logging%white% blocking... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Starting Telemetry Blocking --- >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% ]%white% Checking %highlight%OOSU10%reset% executable...
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    if not exist "C:\%script%\OOSU10\OOSU10.exe" (
        echo   %purple%[ %roxo%•%purple% ]%white% Downloading %highlight%OOSU10%reset% executable...
    title %script% %version% %space% %winver%

        chcp 437 >> "%logfile%" 2>&1
        powershell -Command "Invoke-WebRequest 'https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe' -OutFile 'C:\%script%\OOSU10\OOSU10.exe'" >> "%logfile%" 2>&1
        chcp 65001 >> "%logfile%" 2>&1
    title %script% %version% %space% %winver%
        if not exist "C:\%script%\OOSU10\OOSU10.exe" (
            echo   %red%[ • ]%reset% Failed to download OOSU10 executable.
            goto telemetryend
        )
    ) else (
        echo   %purple%[ %roxo%•%purple% ]%white% %highlight%OOSU10%reset% already downloaded.
        timeout /t 2 /nobreak >> "%logfile%" 2>&1
    )

    echo   %purple%[ %roxo%•%purple% ]%white% Importing %highlight%OOSU10%reset% Profile...
    title %script% %version% %space% %winver%
    curl -g -k -L -# -o "C:\%script%\OOSU10\GhostX-OOSU10.cfg" "https://github.com/louzkk/Ghost-Optimizer/raw/main/bin/GhostX-OOSU10.cfg" >> "%logfile%" 2>&1
    if errorlevel 1 (
        echo   %red%[ • ]%reset% Failed to download OOSU10 profile.
        goto telemetryend
    )
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %winver%

    echo   %purple%[ %roxo%•%purple% ]%white% Applying %highlight%OOSU10%reset% Profile...
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    if exist "C:\%script%\OOSU10\OOSU10.exe" (
        start "" /wait "C:\%script%\OOSU10\OOSU10.exe" "C:\%script%\OOSU10\GhostX-OOSU10.cfg" >> "%logfile%" 2>&1
        echo.
        echo   %purple%[ %roxo%•%purple% ]%white% OOSU10 Tweaks Applied %green%successfully%white%.
        echo --- OOSU Tweaks applied --- >> "%logfile%" 2>&1
    ) else (
        echo   %red%[ • ]%reset% OOSU10 executable not found!
    )

    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo.

    :: User Activity Upload
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Activity Upload disabled.

    :: Advertising ID
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Advertising disabled.

    :: Error reporting
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wercplsupport" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "DoReport" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "ForceQueue" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Error Reporting disabled.

    :: Experience Feedback
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
    echo   %purple%[ %roxo%•%purple% ]%white% Experience Feedback disabled.

    :: Privacy Improvements
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Privacy Improvements applied.

    :: Device Metadata/Input
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Input Metadata disabled.

    :: Location Sensor
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Geolocation disabled.

    :: Telemetry/Data Collection
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowCommercialDataPipeline" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowDeviceNameInTelemetry" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitEnhancedDiagnosticDataWindowsAnalytics" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "MicrosoftEdgeDataOptIn" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\VSStandardCollectorService150" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Data Collection disabled.

    :: DiagTrack
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
    sc config DiagTrack start= disabled >> "%logfile%" 2>&1
    sc config dmwappushservice start= disabled >> "%logfile%" 2>&1
    sc config diagnosticshub.standardcollector.service start= disabled >> "%logfile%" 2>&1
    sc config VSStandardCollectorService150 start= disabled >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Telemetry Services disabled.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Telemetry ^& Logging disabled %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Finished Telemetry & Logging --- >> "%logfile%" 2>&1
    if "%mode%"=="menu" goto menu
    exit /b

   :oosu10
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Opening %highlight%OOSU10%reset% Software...
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Opening OOSU10 --- >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% ]%white% Checking %highlight%OOSU10%reset% executable...
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    if not exist "C:\%script%\OOSU10\OOSU10.exe" (
    title %script% %version% %space% %winver%

        echo   %purple%[ %roxo%•%purple% ]%white% Downloading %highlight%OOSU10%reset% executable...
        chcp 437 >> "%logfile%" 2>&1
        powershell -Command "Invoke-WebRequest 'https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe' -OutFile 'C:\%script%\OOSU10\OOSU10.exe'" >> "%logfile%" 2>&1
        chcp 65001 >> "%logfile%" 2>&1
    ) else (
        echo   %purple%[ %roxo%•%purple% ]%white% %highlight%OOSU10%reset% already downloaded.
        timeout /t 2 /nobreak >> "%logfile%" 2>&1
    )

    title %script% %version% %space% %winver%
 %space% %winver%
    echo   %purple%[ %roxo%•%purple% ]%white% Opening %highlight%OOSU10%reset% software...
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    start /wait "" "C:\%script%\OOSU10\OOSU10.exe" >> "%logfile%" 2>&1

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% OOSU10 Software closed.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Closing OOSU10 --- >> "%logfile%" 2>&1
    goto menu

:: Mouse & Keyboard
    :kbm
    set mode=menu
    cls
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=                                                ██╗  ██╗██████╗ ███╗   ███╗"
    set "lines[1]=                                                ██║ ██╔╝██╔══██╗████╗ ████║"
    set "lines[2]=                                                █████╔╝ ██████╔╝██╔████╔██║"
    set "lines[3]=                                                ██╔═██╗ ██╔══██╗██║╚██╔╝██║"
    set "lines[4]=                                                ██║  ██╗██████╔╝██║ ╚═╝ ██║"
    set "lines[5]=                                                ╚═╝  ╚═╝╚═════╝ ╚═╝     ╚═╝"

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
    set "lines[0]=                Tweaks mouse and keyboard for minimal input lag, maximum responsiveness, and precise control."
    set "lines[1]=                         Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

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
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                                           %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply Mouse ^& Keyboard Tweaks
    echo.                 
    echo.
    echo                                                   %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" call :kbmapply
    if "%answer%"=="r" call :kbmrevert
    if "%answer%"=="A" call :kbmapply
    if "%answer%"=="R" call :kbmrevert
    if "%answer%"=="b" call :menu
    if "%answer%"=="B" call :menu

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto kbm

    :kbmapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %roxo%Mouse %white%^& %roxo%Keyboard%white% Tweaks... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying KBM Tweaks --- >> "%logfile%" 2>&1

    :: Mouse Precision
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Mouse Precision Optimized.

    :: Trackpad Precision
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v "EnablePrecision" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Trackpad Precision Optimized.

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: KBM Queue Size
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d 32 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d 32 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Data Queue Size Optimized.

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Double Click
    reg add "HKCU\Control Panel\Mouse" /v "DoubleClickSpeed" /t REG_SZ /d 300 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Click Speed Optimized.

    :: Repeat Delay
    reg add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Key Delay Optimized.

    :: Repeat Rate
    reg add "HKCU\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d 31 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Key Speed Optimized.

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Sticky Keys
    reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d 506 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Sticky Keys disabled.

    :: Filter Keys
    reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d 122 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Filter Keys disabled.

    :: Toggle Keys
    reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d 58 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Toggle Keys disabled.

    echo.
    echo   %yellow%[ • ]%reset% Set the highest polling rate value avaliable for your mouse/keyboard.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Mouse ^& Keyboard Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- KBM Tweaks Applied --- >> "%logfile%" 2>&1
    if "%mode%"=="menu" goto menu
    exit /b

:: Bloatware Apps
    :debloat
    cls
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=                                 ██████╗ ███████╗██████╗ ██╗      ██████╗  █████╗ ████████╗ "
    set "lines[1]=                                 ██╔══██╗██╔════╝██╔══██╗██║     ██╔═══██╗██╔══██╗╚══██╔══╝"
    set "lines[2]=                                 ██║  ██║█████╗  ██████╔╝██║     ██║   ██║███████║   ██║   "
    set "lines[3]=                                 ██║  ██║██╔══╝  ██╔══██╗██║     ██║   ██║██╔══██║   ██║   "
    set "lines[4]=                                 ██████╔╝███████╗██████╔╝███████╗╚██████╔╝██║  ██║   ██║   "
    set "lines[5]=                                  ╚═════╝ ╚══════╝╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   "

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
    set "lines[0]=              Uninstall pre-installed apps and Paid services to free up storage and reduce resource usage."
    set "lines[1]=                         Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

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
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                        %purple%[ %roxo%%underline%U%reset% %purple%]%white% Uninstall Bloatware Apps                %purple%[ %roxo%%underline%R%reset% %purple%]%white% Reinstall Bloatware Apps
    echo.                 
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="u" call :debloatapply
    if "%answer%"=="U" call :debloatapply
    if "%answer%"=="r" call :debloatrevert
    if "%answer%"=="R" call :debloatrevert
    if "%answer%"=="b" call :menu
    if "%answer%"=="B" call :menu

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto debloat

    :debloatapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Disabling %roxo%Bloatware%white% Auto Start ^& Features... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Uninstalling Bloatware Apps --- >> "%logfile%" 2>&1

    :: Auto Start Apps
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% OneDrive disabled.
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Lghub" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% LgHub disabled.
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "RazerSynapse" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% RazerSynapse disabled.
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "iCUE" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% iCUE disabled
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Redragon" /f >> "%logfile%" 2>&1
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "RDCfg" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Redragon disabled
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Chrome" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Chrome disabled
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Opera" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Opera disabled
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Opera GX" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Opera GX disabled
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Brave" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Brave disabled
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Firefox" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Firefox disabled
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Spotify" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Spoify disabled
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "msedge" /f >> "%logfile%" 2>&1
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "edge" /f >> "%logfile%" 2>&1
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch_1BA94C0BA16E4AD6E747BB43BB8E8E25" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Microsoft Edge disabled
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Xbox" /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Xbox App disabled

    :: Advertising
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "HideRecommenudedSection" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v "HideRecommenudedSection" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Education" /v "IsEducationEnvironment" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_Layout" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Advertising disabled.

    :: News and Widgets
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Widgets ^& News disabled.

    :: Copilot AI
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Copilot AI disabled.

    :: Edge Policies
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "CopilotCDPPageContext" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "CopilotPageContext" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeEntraCopilotPageContext" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeHistoryAISearchEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "ComposeInlineEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "GenAILocalFoundationalModelSettings" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageBingChatEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Browser AI disabled.

    :: Notepad Policies
    reg add "HKLM\SOFTWARE\Policies\WindowsNotepad" /v "DisableAIFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Notepad AI disabled.

    :: Paint Policies
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableCocreator" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeFill" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableImageCreator" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeErase" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableRemoveBackground" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Paint AI disabled.

    :: App preinstall
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerFeatures" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Apps Reinstalation disabled.

    timeout /t 2 /nobreak >> "%logfile%" 2>&1

    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Uninstalling %roxo%Bloatware%white% Apps... 
    echo.

    :: 3D Apps
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *3DBuilder* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Print3D* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Microsoft3DViewer* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "3D Apps" uninstalled.

    :: Remote Assist
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -AllUsers *Microsoft.QuickAssist* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Quick Assist" uninstalled.

    :: Bing
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *bing* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *bingfinance* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *BingNews* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *bingsports* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *BingWeather* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *News* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Bing Apps" uninstalled.

    :: Phone
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *WindowsPhone* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *YourPhone* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *CommsPhone* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Phone Apps" uninstalled.

    :: Facebook
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Facebook* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Facebook" uninstalled.

    :: Messaging
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Microsoft.Messaging* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Messaging" uninstalled.

    :: Office Hub
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *MicrosoftOfficeHub* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Office Hub" uninstalled.

    :: OneNote
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *OneNote* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Office.OneNote* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "OneNote" uninstalled.

    :: People
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *People* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "People" uninstalled.

    :: Skype
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *SkypeApp* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Skype" uninstalled.

    :: Solitaire
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *solit* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *MicrosoftSolitaireCollection* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Solitaire" uninstalled.

    :: Maps
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *WindowsMaps* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Maps" uninstalled.

    :: Feedback Hub
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *WindowsFeedbackHub* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Feedback Hub" uninstalled.

    :: Communications
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *windowscommunicationsapps* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Communications" uninstalled.

    :: Cross Device
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage *crossdevice* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Cross Device" uninstalled.

    :: Cortana
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Microsoft.549981C3F5F10* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Cortana" uninstalled.

    :: Teams
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Teams* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Teams" uninstalled.

    :: Sticky Notes
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *MicrosoftStickyNotes* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Sticky Notes" uninstalled.

    :: Mixed Reality Portal
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *MixedReality.Portal* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Mixed Reality Portal" uninstalled.

    :: LinkedIn
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *LinkedIn* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "LinkedIn" uninstalled.

    :: 365 Copilot
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Copilot* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "365 Copilot" uninstalled.

    :: Outlook
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Outlook* | Remove-AppxPackage" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *OutlookForWindows* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Outlook" uninstalled.

    :: To Do
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Microsoft.Todos* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "To Do" uninstalled.

    :: Widgets
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage *MicrosoftWindows.WebExperience* | Remove-AppxPackage" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% "Widgets" uninstalled.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Bloatware apps uninstalled %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Finished Debloat --- >> "%logfile%" 2>&1
    goto menu

    :debloatrevert
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Reverting %roxo%Bloatware%white% Features... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Reverting Bloatware Apps --- >> "%logfile%" 2>&1

    :: Advertising
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "HideRecommenudedSection" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start" /v "HideRecommenudedSection" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Education" /v "IsEducationEnvironment" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_Layout" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Advertising enabled.

    :: OneDrive
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% OneDrive Push enabled.

    :: News and Widgets
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Widgets ^& News enabled.

    :: Copilot AI
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Copilot AI enabled.

    :: Edge Policies
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "CopilotCDPPageContext" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "CopilotPageContext" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeEntraCopilotPageContext" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeHistoryAISearchEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "ComposeInlineEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "GenAILocalFoundationalModelSettings" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageBingChatEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Browser AI enabled.

    :: Notepad Policies
    reg add "HKLM\SOFTWARE\Policies\WindowsNotepad" /v "DisableAIFeatures" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Notepad AI enabled.

    :: Paint Policies
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableCocreator" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeFill" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableImageCreator" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeErase" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableRemoveBackground" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Paint AI enabled.

    :: App preinstall
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerFeatures" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerFeatures" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Apps Reinstalation enabled.

    :: App Suggestions
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314559Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280815Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-202914Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Suggestions enabled.

    :: Lockscreen Tooltips
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Tooltips enabled.

    :: Lockscreen Spotlight
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableSpotlightCollectionOnDesktop" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Spotlight enabled.

    :: Delivery Optimization
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Delivery Optimization enabled.

    timeout /t 2 /nobreak >> "%logfile%" 2>&1

    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Installing %roxo%Bloatware%white% Apps... 
    echo.

    :: Reinstall Bloatware Apps
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Bloatware apps reinstalled.

    :: Reinstall Provisioned Packages
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxProvisionedPackage -Online | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Provisioned packages reinstalled.

    :: Windows Web Experience Pack
    chcp 437 >> "%logfile%" 2>&1
    winget install "Windows Web Experience Pack" --silent >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Widgets installed.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Bloatware apps reverted %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%

    echo --- Reverted Debloat --- >> "%logfile%" 2>&1
    goto debloat

:: Latency & Input-Lag
    :latency
    set mode=menu
    cls
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=                                 ██╗      █████╗ ████████╗███████╗███╗   ██╗ ██████╗██╗   ██╗"
    set "lines[1]=                                 ██║     ██╔══██╗╚══██╔══╝██╔════╝████╗  ██║██╔════╝╚██╗ ██╔╝"
    set "lines[2]=                                 ██║     ███████║   ██║   █████╗  ██╔██╗ ██║██║      ╚████╔╝ "
    set "lines[3]=                                 ██║     ██╔══██║   ██║   ██╔══╝  ██║╚██╗██║██║       ╚██╔╝  "
    set "lines[4]=                                 ███████╗██║  ██║   ██║   ███████╗██║ ╚████║╚██████╗   ██║   "
    set "lines[5]=                                 ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝ ╚═════╝   ╚═╝   "

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
    set "lines[0]=                         Applies advanced tweaks to minimize system latency and improve responsivness."
    set "lines[1]=                            Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

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
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                                           %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply Latency ^& Input-Lag Tweaks
    echo.                 
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" call :latencyapply
    if "%answer%"=="r" call :latencyrevert
    if "%answer%"=="A" call :latencyapply
    if "%answer%"=="R" call :latencyrevert
    if "%answer%"=="b" call :menu
    if "%answer%"=="B" call :menu

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto latency

    :latencyapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %roxo%Latency %white%^& %roxo%Input-Lag%white% Tweaks... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying Latency and Input-Lag Tweaks --- >> "%logfile%" 2>&1
    :: All commented lines are unstable or undocumented tweaks.

    :: System Responsivness
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 10 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "AlwaysOn" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% System Responsivness Optimized.

    :: Desktop time
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "Append Completion" /t REG_SZ /d "yes" /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "AutoSuggest" /t REG_SZ /d "yes" /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "menuShowDelay" /t REG_SZ /d 100 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ExtendedUIHoverTime" /t REG_DWORD /d 20 /f >> "%logfile%" 2>&1
    reg add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d 20 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MouseHoverTime" /t REG_SZ /d 20 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d 300 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d 3000 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d 2000 /f >> "%logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d 50 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d 3000 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% UI Responsiveness Optimized.

    :: Energy Estimation
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1 
    echo   %purple%[ %roxo%•%purple% ]%white% Energy Estimation disabled.

    :: Kernel Timer Coalescing
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Kernel Coalescing Optimized.

    :: Hardware Scheduling
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Hardware Scheduling disabled.

    :: Overlay Test Mode
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "OverlayTestMode" /t REG_DWORD /d 5 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Overlay Test Mode enabled.

    :: Control Power Latency
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% System Latency Optimized.

    :: Graphics Power Latency
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "Latency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "TransitionLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Graphics Latency Optimized.

    :: DXGKrnl/Power Monitor Latency
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorLatencyTolerance" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Monitor Latency Optimized.

    :: Timer Resolution
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MinTimerResolution" /t REG_DWORD /d 5000 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "ClockTimerResolution" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "TimerResolution" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Timer Resolution Optimized.

    :: Distribute Timers
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DistributeTimers" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Timer Distribution enabled.

    :: HPET disable
    bcdedit /deletevalue useplatformclock >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% High Precision Timer tweaked.

    :: DXGKrnl latency
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "TdrLevel" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "TdrDelay" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "TdrDdiDelay" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% DXGKrnl Latency Optimized.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Latency ^& Input-Lag Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Latency and Input-Lag Tweaks Applied --- >> "%logfile%" 2>&1
    if "%mode%"=="menu" goto menu
    exit /b

:: GhostX Powerplan
    :powerplan
    set mode=menu
    cls
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=                      ██████╗  ██████╗ ██╗    ██╗███████╗██████╗     ██████╗ ██╗      █████╗ ███╗   ██╗"
    set "lines[1]=                      ██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗    ██╔══██╗██║     ██╔══██╗████╗  ██║"
    set "lines[2]=                      ██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝    ██████╔╝██║     ███████║██╔██╗ ██║"
    set "lines[3]=                      ██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗    ██╔═══╝ ██║     ██╔══██║██║╚██╗██║"
    set "lines[4]=                      ██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║    ██║     ███████╗██║  ██║██║ ╚████║"
    set "lines[5]=                      ╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝    ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝"

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
    set "lines[0]=                       Applies a custom Power Plan focused on highest performance and lowest latency."
    set "lines[1]=                          Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

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
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                        %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply GhostX Power Plan                %purple%[ %roxo%%underline%R%reset% %purple%]%white% Apply Balanced Power Plan
    echo.                 
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" call :powerplanapply
    if "%answer%"=="A" call :powerplanapply
    if "%answer%"=="r" call :powerplanapply2
    if "%answer%"=="R" call :powerplanapply2
    if "%answer%"=="b" call :menu
    if "%answer%"=="B" call :menu

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto powerplan

    :powerplanapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %highlight%GhostX%reset% Power Plan... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying Power Plan --- >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% ]%white% Checking Github repository...

    timeout /t 2 /nobreak >nul

    echo   %purple%[ %roxo%•%purple% ]%white% Downloading %highlight%GhostX%reset% Power Plan...
    curl -g -k -L -# -o "C:\%script%\GhostX\GhostX-POWER.pow" "https://github.com/louzkk/Ghost-Optimizer/raw/main/bin/GhostX-POWER.pow" >> "%logfile%" 2>&1
    if not exist "C:\%script%\GhostX\GhostX-POWER.pow" (
        echo   %red%[ %orange%• %red%]%white% Failed to download GhostX power plan.
        timeout /t 2 >nul
        goto powerplan
    )

    timeout /t 2 /nobreak >nul

    echo   %purple%[ %roxo%•%purple% ]%white% Importing %highlight%GhostX%reset% Power Plan...

    powercfg /import "C:\%script%\GhostX\GhostX-POWER.pow" >> "%logfile%" 2>&1
    if errorlevel 1 (
        echo   %red%[ %orange%• %red%]%white% Failed to import %highlight%GhostX%reset% power plan.
        timeout /t 3 >nul
        goto powerplan
    )

    timeout /t 2 /nobreak >nul

    echo   %purple%[ %roxo%•%purple% ]%white% Applying %highlight%GhostX%reset% Power Plan...

    set "GUID="
    for /f "tokens=2 delims=:()" %%i in ('powercfg /list ^| findstr /i "GhostX"') do (
        set "GUID=%%i"
        set "GUID=!GUID: =!"
    )

    if not defined GUID (
        echo   %red%[ %orange%• %red%]%white% Could not find %highlight%GhostX%reset% power plan GUID.
        timeout /t 3 >nul
        goto powerplan
    )

    powercfg /setactive !GUID! >> "%logfile%" 2>&1
    if errorlevel 1 (
        echo   %red%[ %orange%• %red%]%white% Failed to set %highlight%GhostX%reset% power plan active.
        timeout /t 3 >nul
        goto powerplan
    )

    chcp 437 >> "%logfile%" 2>&1
    powershell (Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods).WmiSetBrightness(1,100)
    chcp 65001 >> "%logfile%" 2>&1

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% GhostX power plan applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Power Plan applied --- >> "%logfile%" 2>&1
    if "%mode%"=="menu" goto menu
    exit /b

:: Integrity & Health
    :health
    cls
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=                              ██╗███╗   ██╗████████╗███████╗ ██████╗ ██████╗ ██╗████████╗██╗   ██╗ "
    set "lines[1]=                              ██║████╗  ██║╚══██╔══╝██╔════╝██╔════╝ ██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝"
    set "lines[2]=                              ██║██╔██╗ ██║   ██║   █████╗  ██║  ███╗██████╔╝██║   ██║    ╚████╔╝ "
    set "lines[3]=                              ██║██║╚██╗██║   ██║   ██╔══╝  ██║   ██║██╔══██╗██║   ██║     ╚██╔╝  "
    set "lines[4]=                              ██║██║ ╚████║   ██║   ███████╗╚██████╔╝██║  ██║██║   ██║      ██║   "
    set "lines[5]=                              ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝   "

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
    set "lines[0]=                        Performs a scan and repairs corrupted files, system health, updates, and disk errors."
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
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                                    %purple%[ %roxo%%underline%S%reset% %purple%] %white%Fast Integrity Fix        %purple%[ %roxo%%underline%F%reset% %purple%] %white%Full Integrity Fix
    echo.                 
    echo                                    %purple%[ %roxo%%underline%BT%reset% %purple%] %white%Bluetooth Fix            %purple%[ %roxo%%underline%XB%reset% %purple%] %white%Xbox Services Fix
    echo.
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="s" call :healthapply1
    if "%answer%"=="S" call :ealthapply1
    if "%answer%"=="f" call :healthapply2
    if "%answer%"=="F" call :healthapply2
    if "%answer%"=="bt" call :bluetoothfix
    if "%answer%"=="BT" call :bluetoothfix
    if "%answer%"=="Bt" call :bluetoothfix
    if "%answer%"=="bT" call :bluetoothfix
    if "%answer%"=="XB" call :xboxfix
    if "%answer%"=="Xb" call :xboxfix
    if "%answer%"=="xB" call :xboxfix
    if "%answer%"=="xb" call :xboxfix
    if "%answer%"=="b" call :menu
    if "%answer%"=="B" call :menu

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto health

    :healthapply1
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Fast%white% Integrity ^& Health Fix... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Starting Fast Health Fix --- >> "%logfile%" 2>&1

    :: Checking Image
    echo   %purple%[ %roxo%•%purple% ]%white% Checking Windows Image Health...
    DISM /Online /Cleanup-Image /CheckHealth >> "%logfile%" 2>&1

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Scanning Image
    echo   %purple%[ %roxo%•%purple% ]%white% Scanning Windows Image Health...
    DISM /Online /Cleanup-Image /ScanHealth >> "%logfile%" 2>&1

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Restoring Image
    echo   %purple%[ %roxo%•%purple% ]%white% Restoring Windows Image Health...
    DISM /Online /Cleanup-Image /RestoreHealth >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% ]%white% Windows Image Health restored.
    echo.

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: SFC SCANNOW
    echo   %purple%[ %roxo%•%purple% ]%white% Repairing System Integrity...
    sfc /scannow >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% ]%white% System Integrity repaired.
    echo.

    timeout /t 1 /nobreak >> "%logfile%" 2>&1

    :: Reapring Microsoft Store Cache
    echo   %purple%[ %roxo%•%purple% ]%white% Repairing Microsoft Store...
    wsreset.exe >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% ]%white% Microsoft Store repaired.
    echo.

    :: Saving Registry Integrity into Log
    reg query HKLM\SOFTWARE >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Registry Integrity saved to Log.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Integrity ^& Health fixes applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%

    echo --- Finished Fast Health Fix --- >> "%logfile%" 2>&1
    goto menu

    :healthapply2
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Full%white% Integrity ^& Health Fix... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Starting Full Health Fix --- >> "%logfile%" 2>&1

    :: Checking Image
    echo   %purple%[ %roxo%•%purple% ]%white% Checking Windows Image Health...
    DISM /Online /Cleanup-Image /CheckHealth >> "%logfile%" 2>&1

    :: Scanning Image
    echo   %purple%[ %roxo%•%purple% ]%white% Scanning Windows Image Health...
    DISM /Online /Cleanup-Image /ScanHealth >> "%logfile%" 2>&1

    :: Restoring Image
    echo   %purple%[ %roxo%•%purple% ]%white% Restoring Windows Image Health...
    DISM /Online /Cleanup-Image /RestoreHealth >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% ]%white% Windows Image Health restored.
    echo.

    :: Restoring Components
    echo   %purple%[ %roxo%•%purple% ]%white% Analyzing Drivers Base...
    DISM /Online /Cleanup-Image /AnalyzeComponentStore >> "%logfile%" 2>&1

    :: Checking Components
    echo   %purple%[ %roxo%•%purple% ]%white% Repairing Windows Drivers...
    DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% ]%white% Windows Drivers restored.
    echo.

    :: SFC SCANNOW
    echo   %purple%[ %roxo%•%purple% ]%white% Repairing System Integrity...
    sfc /scannow >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% ]%white% System Integrity repaired.
    echo.

    :: Reapring Microsoft Store Cache
    echo   %purple%[ %roxo%•%purple% ]%white% Repairing Microsoft Store...
    wsreset.exe >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% ]%white% Microsoft Store repaired.
    echo.

    :: Stopping Windows Update
    echo   %purple%[ %roxo%•%purple% ]%white% Stopping Windows Update services...
    net stop wuauserv >> "%logfile%" 2>&1
    net stop cryptSvc >> "%logfile%" 2>&1
    net stop bits >> "%logfile%" 2>&1
    net stop msiserver >> "%logfile%" 2>&1
    net stop appidsvc

    :: Repairing Windows Update
    echo   %purple%[ %roxo%•%purple% ]%white% Repairing Windows Update...
    ren C:\Windows\SoftwareDistribution SoftwareDistribution.old >> "%logfile%" 2>&1
    ren C:\Windows\System32\catroot2 catroot2.old >> "%logfile%" 2>&1
    del /q /f /s %windir%\SoftwareDistribution\Download\* >> "%logfile%" 2>&1

    :: Cleaning CBS Logs Cache
    echo   %purple%[ %roxo%•%purple% ]%white% Cleaning CBS ^& DISM cache...
    del /f /q %windir%\Logs\CBS\CBS.log >> "%logfile%" 2>&1
    del /f /q %windir%\Logs\DISM\dism.log >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% CBS ^& DISM cache cleaned.

    :: Reverting Pending Actions
    echo   %purple%[ %roxo%•%purple% ]%white% Reverting Pending Actions...
    dism /online /cleanup-image /revertpendingactions >> "%logfile%" 2>&1
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Pending Actions reverted.

    :: Files System Boot Check
    echo   %purple%[ %roxo%•%purple% ]%white% Scheduling system file repair...
    echo Y|chkdsk C: /f /r >> "%logfile%" 2>&1

    echo.
    echo   %yellow%[ • ]%reset% Files will be repaired in the next boot.

    :: Saving Registry Integrity into Log
    reg query HKLM\SOFTWARE >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Registry Integrity saved to Log.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Integrity ^& Health fixes applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Finished Full Health Fix --- >> "%logfile%" 2>&1
    goto menu

    :bluetoothfix
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Bluetooth%white% Fix... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Starting Bluetooth Fix --- >> "%logfile%" 2>&1

    :: Restart BT Drivers
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-Service *bth* | Restart-Service -Force -ErrorAction SilentlyContinue" >> "%logfile%" 2>&1
    powershell -Command "Get-PnpDevice -Class Bluetooth | Disable-PnpDevice -Confirm:$false -ErrorAction SilentlyContinue" >> "%logfile%" 2>&1
    powershell -Command "Start-Sleep -Seconds 1" >> "%logfile%" 2>&1
    powershell -Command "Get-PnpDevice -Class Bluetooth | Enable-PnpDevice -Confirm:$false -ErrorAction SilentlyContinue" >> "%logfile%" 2>&1
    powershell -Command "pnputil /scan-devices" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Bluetooth Drivers restored.

    :: BT Registry
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT\Parameters" /v "EnableOffload" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT\Parameters" /v "EnableLEEncryption" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT\Parameters" /v "EnableRadioOffload" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHUSB" /v "EnableSelectiveSuspend" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthHFSrv" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Bluetooth features restored.

    :: Radio Services
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "(Get-Service bthserv).StartType='Automatic'" >> "%logfile%" 2>&1
    powershell -Command "Start-Service bthserv -ErrorAction SilentlyContinue" >> "%logfile%" 2>&1
    powershell -Command "Start-Service DeviceAssociationService -ErrorAction SilentlyContinue" >> "%logfile%" 2>&1
    powershell -Command "Start-Service DeviceAssociationBrokerSvc -ErrorAction SilentlyContinue" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Radio Services restored.

    :: BT Services
    sc config bthserv start= auto >> "%logfile%" 2>&1
    sc config BthHFSrv start= demand >> "%logfile%" 2>&1
    sc config BthAvctpSvc start= demand >> "%logfile%" 2>&1
    sc config bthmodem start= demand >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Bluetooth Services restored.

    :: Broker Service
    net stop DeviceAssociationService /y >> "%logfile%" 2>&1
    net start DeviceAssociationService >> "%logfile%" 2>&1
    net stop DeviceAssociationBrokerSvc /y >> "%logfile%" 2>&1
    net start DeviceAssociationBrokerSvc >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Broker Service restored.

    :: Enable BT
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT" /v "Start" /t REG_DWORD /d 2 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHUSB" /v "Start" /t REG_DWORD /d 3 /f
    echo   %purple%[ %roxo%•%purple% ]%white% Bluetooth enabled.

    echo.
    echo   %yellow%[ • ]%reset% If that doesn't solve your problem, try running Full Integrity Fix.

    echo.
    timeout /t 4 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Bluetooth fixed %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Finished Bluetooth Fix --- >> "%logfile%" 2>&1
    goto menu

    :xboxfix
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Xbox App/Bar%white% Fix... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Starting Xbox Fix --- >> "%logfile%" 2>&1

    :: Reinstall Xbox App & Identity Provider
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage Microsoft.XboxApp -AllUsers | Foreach {Add-AppxPackage -Register '$($_.InstallLocation)\AppxManifest.xml' -DisableDevelopmentMode}" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage Microsoft.Xbox.TCUI -AllUsers | Foreach {Add-AppxPackage -Register '$($_.InstallLocation)\AppxManifest.xml' -DisableDevelopmentMode}" >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage Microsoft.XboxIdentityProvider -AllUsers | Foreach {Add-AppxPackage -Register '$($_.InstallLocation)\AppxManifest.xml' -DisableDevelopmentMode}" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Xbox App restored.

    :: Xbox Services
    sc config XblAuthManager start= auto >> "%logfile%" 2>&1
    sc config XblGameSave start= auto >> "%logfile%" 2>&1
    sc config XboxGipSvc start= auto >> "%logfile%" 2>&1
    sc config XboxNetApiSvc start= auto >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Xbox Services enabled.

    :: Reinstall Xbox Game Bar
    chcp 437 >> "%logfile%" 2>&1
    powershell -Command "Get-AppxPackage Microsoft.XboxGamingOverlay -AllUsers | Foreach {Add-AppxPackage -Register '$($_.InstallLocation)\AppxManifest.xml' -DisableDevelopmentMode}" >> "%logfile%" 2>&1
    chcp 65001 >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Game Bar restored.

    :: Game Bar Registry
    reg add "HKLM\Software\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v value /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    ::reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Game Bar enabled.

    echo.
    echo   %yellow%[ • ]%reset% If that doesn't solve your problem, try running Full Integrity Fix.

    echo.
    timeout /t 4 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Xbox App ^& Game Bar fixed %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Finished Xbox Fix --- >> "%logfile%" 2>&1
    goto menu

:: Temporary Files
    :clean
    cls
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=                                        ██████╗██╗     ███████╗ █████╗ ███╗   ██╗ "
    set "lines[1]=                                       ██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║"
    set "lines[2]=                                       ██║     ██║     █████╗  ███████║██╔██╗ ██║"
    set "lines[3]=                                       ██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║"
    set "lines[4]=                                       ╚██████╗███████╗███████╗██║  ██║██║ ╚████║"
    set "lines[5]=                                        ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝"

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
    set "lines[0]=                Cleans temporary files, logs, caches, and unnecessary files to free up space and fix issues."
    set "lines[1]=                         Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

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
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                         %purple%[ %roxo%%underline%G%reset% %purple%]%white% Start Ghost Clean-up                %purple%[ %roxo%%underline%W%reset% %purple%]%white% Start Windows Clean-up
    echo.
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="g" call :ghostclean
    if "%answer%"=="G" call :ghostclean
    if "%answer%"=="w" call :windowsclean
    if "%answer%"=="W" call :windowsclean
    if "%answer%"=="b" call :menu
    if "%answer%"=="B" call :menu

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto clean

    :ghostclean
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Ghost Optimizer%white% Clean... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Starting Ghost Optimizer Clean --- >> "%logfile%" 2>&1

    :: Temporary files
    rd /s /q "%windir%\Temp" >> "%logfile%" 2>&1
    md "%windir%\Temp" >> "%logfile%" 2>&1
    rd /s /q "%LocalAppData%\Temp" >> "%logfile%" 2>&1
    md "%LocalAppData%\Temp" >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Temporary files cleaned.

    :: Prefetch
    rd /s /q "%windir%\Prefetch" >> "%logfile%" 2>&1
    md "%windir%\Prefetch" >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Prefetch files cleaned.

    :: Recycle Bin
    rd /s /q "%systemdrive%\$Recycle.Bin" >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Recycle Bin cleaned.

    :: Thumbcache
    del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Thumbnail cache cleaned.

    :: System logs
    echo. > "%SystemRoot%\Logs\CBS\CBS.log" >> "%logfile%" 2>&1
    echo. > "%SystemRoot%\Logs\DISM\DISM.log" >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% System logs cleared.

    :: Clean Ghost Optimizer Logs
    if exist "C:\Ghost Optimizer\Logs" (
        del /f /q "C:\Ghost Optimizer\Logs\*.*" >> "%logfile%" 2>&1
        echo   %purple%[ %roxo%•%purple% ]%white% Ghost logs cleared.
    ) else (
        echo   %purple%[ %roxo%•%purple% ]%white% Logs folder not found.
    )

    :: Clean Ghost Optimizer Cache
    if exist "C:\Ghost Optimizer" (
        del /f /q "C:\Ghost Optimizer\*.*" >> "%logfile%" 2>&1
        echo   %purple%[ %roxo%•%purple% ]%white% Ghost cache cleared.
    ) else (
        echo   %purple%[ %roxo%•%purple% ]%white% Cache folder not found.
    )

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% System cleaned %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%

    echo --- Finished Ghost Optimizer Clean --- >> "%logfile%" 2>&1
    goto clean

    :windowsclean
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Windows%white% Clean... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Starting Windows Clean --- >> "%logfile%" 2>&1

    echo   %purple%[ %roxo%•%purple% ]%white% Click on Temporary Files.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    start ms-settings:storagesense >> "%logfile%" 2>&1

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% System cleaned %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Finished Windows Clean --- >> "%logfile%" 2>&1
    goto menu

:: Unecessary Services
    :services
    set mode=menu
    cls
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=                                ███████╗███████╗██████╗ ██╗   ██╗██╗ ██████╗███████╗███████╗ "
    set "lines[1]=                                ██╔════╝██╔════╝██╔══██╗██║   ██║██║██╔════╝██╔════╝██╔════╝"
    set "lines[2]=                                ███████╗█████╗  ██████╔╝██║   ██║██║██║     █████╗  ███████╗"
    set "lines[3]=                                ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║     ██╔══╝  ╚════██║"
    set "lines[4]=                                ███████║███████╗██║  ██║ ╚████╔╝ ██║╚██████╗███████╗███████║"
    set "lines[5]=                                ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝ ╚═════╝╚══════╝╚══════╝"

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
    set "lines[0]=                  Disables unnecessary services to reduce resource usage and improve system performance."
    set "lines[1]=                         Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

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
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                       %purple%[ %roxo%%underline%D%reset% %purple%]%white% Disable Unnecessary Services                %purple%[ %roxo%%underline%R%reset% %purple%]%white% Revert Unecessary Services
    echo.                 
    echo.
    echo                                                     %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="d" call :servicesapply
    if "%answer%"=="D" call :servicesapply
    if "%answer%"=="r" call :servicesrevert
    if "%answer%"=="R" call :servicesrevert
    if "%answer%"=="b" call :menu
    if "%answer%"=="B" call :menu

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto services

    :servicesapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Disabling %roxo%Unnecessary Services%white%...
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Disabling Unnecessary Services --- >> "%logfile%" 2>&1

    :: SysMain/Superfetch
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% SysMain disabled.

    :: Sensor/Location
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorDataService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\shpamsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Sensor services disabled.

    :: Tablet
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TouchKeyboardAndHandwritingPanelService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Tablet Input disabled.

    :: Cross Device
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Connectivity\DisableCrossDeviceResume" /v "value" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Configuration" /v "IsResumeAllowed" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Cross Device disabled.

    :: Messages
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\MessagingService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Messages disabled.

    :: Cortana
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Cortana disabled.

    :: Phone Services
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PhoneSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Phone Services disabled.

    :: Parental Control
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpcMonSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SEMgrSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedRealitySvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Parental Control disabled.

    :: Retail Demo Service
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RetailDemo" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Retail Demo Service disabled.

    :: Hyper-V Host Service
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\HvHost" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\HvHost" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmcompute" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Hyper-V host disabled.

    :: Delivery Optimization
    ::reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\PNRPsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\p2psvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\p2pimsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Delivery Optimization disabled.

    :: Sharing
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Netlogon" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CscService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\svsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% File Sharing disabled.

    :: Mixed Reality Portal
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\HolographicShell" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\FrameServerMonitor" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\perceptionsimulation" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\FrameServer" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Mixed Reality disabled.

    :: OneSync
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Microsoft OneSync disabled.

    :: Wallet
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WalletService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Wallet disabled.

    :: Maps Broker
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Maps Broker disabled.

    :: Search Index
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SearchIndexer" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SearchFilterHost" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SearchProtocolHost" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WSearch" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Search Index disabled.

    :: Print Spooler / Fax
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Fax" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Spooler services disabled.

    :: Xbox Services
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Xbox services disabled.

    :: Intel Software
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\cplspcon" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\cphs" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\jhi_service" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\esifsvc" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\igccservice" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WMIRegistrationService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RstMwService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Intel(R) TPM Provisioning Service" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\IntelAudioService" /v "Start" /t REG_DWORD /d 4 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Intel services disabled.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Unnecessary Services disabled %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Unnecessary Services Disabled --- >> "%logfile%" 2>&1
    if "%mode%"=="menu" goto menu
    exit /b

    :servicesrevert
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Reverting %roxo%Unnecessary Services%white%...
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Disabling Unnecessary Services --- >> "%logfile%" 2>&1

    :: Telephony API
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PhoneSvc" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Phone Services enabled.

    :: Parental Control
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpcMonSvc" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SEMgrSvc" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedRealitySvc" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Parental Control enabled.

    :: P2P
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PNRPsvc" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\p2psvc" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\p2pimsvc" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Peer-to-Peer enabled.

    :: Sharing
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Netlogon" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CscService" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\svsvc" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% File Sharing enabled.

    :: Sensor / Location
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorDataService" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\shpamsvc" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Sensor services enabled.

    :: Mixed Reality Portal
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\perceptionsimulation" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\FrameServer" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Mixed Reality enabled.

    :: OneSync
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Microsoft OneSync enabled.

    :: DVRU
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BcastDVRUserService" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Broadcast enabled.

    :: Edge
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdatem" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdate" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\MicrosoftEdgeElevationService" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Edge Update enabled.

    :: Cross Device
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Connectivity\DisableCrossDeviceResume" /v "value" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Configuration" /v "IsResumeAllowed" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Cross Device Resume enabled.

    :: Tablet
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TouchKeyboardAndHandwritingPanelService" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Tablet Input enabled.

    :: Themes
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Themes" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Themes enabled.

    :: Readiness
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppReadiness" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\OSRSS" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Readiness enabled.

    :: Messages
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\MessagingService" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Messages enabled.

    :: Cortana
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Cortana enabled.

    :: Print Spooler / Fax
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Fax" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Spooler/Fax services enabled.

    :: Maps Broker
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Maps Broker enabled.

    :: Search Index
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WSearch" /v "Start" /t REG_DWORD /d 2 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Search Index enabled.

    :: Remote Registry
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Remote Registry enabled.

    :: Insider
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Windows Insider enabled.

    :: Wallet
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WalletService" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Wallet enabled.

    :: Xbox Services
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Xbox services enabled.

    :: Intel Software
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\cplspcon" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\cphs" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\jhi_service" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\esifsvc" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\igccservice" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfxCUIService2.0.0.0" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WMIRegistrationService" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RstMwService" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Intel(R) TPM Provisioning Service" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\IntelAudioService" /v "Start" /t REG_DWORD /d 3 /f >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Intel services enabled.

    :: AMD Software (Soon...)
    echo   %purple%[ %roxo%•%purple% ]%white% AMD services enabled.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Services restored %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Services Re-enabled --- >> "%logfile%" 2>&1
    goto menu

:: NVIDIA Profile
    :nvidia
    cls
    echo.
    echo.

    set "W=120"
    set /a "LAST=W-2"
    set /a "MID=(W-2)/2"

    for /L %%j in (0,1,!LAST!) do (
        set /a "colorR=0"
        set /a "colorG=255 - (105 * %%j / !LAST!)"
        set /a "colorB=100 + (155 * %%j / !LAST!)"
        set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
    )

    set "lines[0]=                                         ███╗   ██╗██╗   ██╗██╗██████╗ ██╗ █████╗ "
    set "lines[1]=                                         ████╗  ██║██║   ██║██║██╔══██╗██║██╔══██╗"
    set "lines[2]=                                         ██╔██╗ ██║██║   ██║██║██║  ██║██║███████║"
    set "lines[3]=                                         ██║╚██╗██║╚██╗ ██╔╝██║██║  ██║██║██╔══██║"
    set "lines[4]=                                         ██║ ╚████║ ╚████╔╝ ██║██████╔╝██║██║  ██║"
    set "lines[5]=                                         ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═════╝ ╚═╝╚═╝  ╚═╝"

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
    set "lines[0]=                  Optimizes NVIDIA drivers to improve performance and latency while disabling telemetry."
    set "lines[1]=                         Check full documentation at: https://github.com/louzkk/Ghost-Optimizer"

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
    set /a "BeforeSpace=(135 - 121) / 2"
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
    echo                        %nvidia%[ %verde%%underline%O%reset% %nvidia%]%white% Apply Optimized Profile                %nvidia%[ %verde%%underline%P%reset% %nvidia%]%white% Apply Performance Profile
    echo.
    echo                                                %nvidia%[ %verde%%underline%PI%reset% %nvidia%]%white% Open Profile Inspector
    echo.
    echo.
    echo                                                    %nvidia%[ %verde%%underline%B%reset% %nvidia%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="o" call :nvidiaoptimized
    if "%answer%"=="O" call :nvidiaoptimized
    if "%answer%"=="p" call :nvidiaperformance
    if "%answer%"=="P" call :nvidiaperformance
    if "%answer%"=="pi" call :inspector
    if "%answer%"=="PI" call :inspector
    if "%answer%"=="pI" call :inspector
    if "%answer%"=="Pi" call :inspector
    if "%answer%"=="b" call :menu
    if "%answer%"=="B" call :menu

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto nvidia

    :nvidiaoptimized
    cls
    echo.
    echo   %verde%[ %green%•%verde% ]%reset% Applying %green%NVIDIA Profile Inspector%reset% Tweaks...
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying NVIDIA Profile --- >> "%logfile%" 2>&1

    echo   %verde%[ %green%•%verde% ]%reset% Checking %green%Profile Inspector%reset% executable...
    timeout /t 2 /nobreak >> "%logfile%" 2>&1

    if not exist "C:\%script%\NVIDIA\nvidiaProfileInspector.zip" (
        echo   %verde%[ %green%•%verde% ]%reset% Downloading %green%Profile Inspector%reset% package...
        curl -g -k -L -# -o "C:\%script%\NVIDIA\nvidiaProfileInspector.zip" "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/download/2.4.0.27/nvidiaProfileInspector.zip" >> "%logfile%" 2>&1
        if errorlevel 1 (
            echo   %red%[ • ]%reset% Failed to download NVIDIA Profile Inspector.
            goto :nvidiaend1
        )
    ) else (
        echo   %verde%[ %green%•%verde% ]%reset% %green%Profile Inspector%reset% already downloaded.
        timeout /t 2 /nobreak >> "%logfile%" 2>&1
    )

    if not exist "C:\%script%\NVIDIA\NvidiaProfileInspector" (
        echo   %verde%[ %green%•%verde% ]%reset% Extracting %green%Profile Inspector%reset% package...
        chcp 437 >> "%logfile%" 2>&1
        powershell -NoProfile Expand-Archive 'C:\%script%\NVIDIA\nvidiaProfileInspector.zip' -DestinationPath 'C:\%script%\NVIDIA\' >> "%logfile%" 2>&1
        chcp 65001 >> "%logfile%" 2>&1
        del /q "C:\%script%\NVIDIA\nvidiaProfileInspector.zip" >nul 2>&1
        if not exist "C:\%script%\NVIDIA\nvidiaProfileInspector.exe" (
            echo   %red%[ • ]%reset% Extraction failed, executable not found.
            goto :nvidiaend1
        )
    )

    echo   %verde%[ %green%•%verde% ]%reset% Importing %green%GhostX Optimized%reset% profile...
    curl -g -k -L -# -o "C:\%script%\NVIDIA\GhostX1-NVIDIA.nip" "https://github.com/louzkk/Ghost-Optimizer/raw/main/bin/GhostX1-NVIDIA.nip" >> "%logfile%" 2>&1
    if errorlevel 1 (
        echo   %red%[ • ]%reset% Failed to download NVIDIA profile.
        goto :nvidiaend1
    )
    timeout /t 2 /nobreak >> "%logfile%" 2>&1

    echo   %verde%[ %green%•%verde% ]%reset% Applying %green%GhostX Optimized%reset% profile...
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    if exist "C:\%script%\NVIDIA\nvidiaProfileInspector.exe" (
        start "" /wait "C:\%script%\NVIDIA\nvidiaProfileInspector.exe" "C:\%script%\NVIDIA\GhostX1-NVIDIA.nip" >> "%logfile%" 2>&1
        echo.
        echo   %verde%[ %green%•%verde% ]%reset% Profile Inspector Tweaks Applied %green%successfully%white%.
        echo --- NVIDIA Profile applied --- >> "%logfile%" 2>&1
    ) else (
        echo   %red%[ • ]%reset% NVIDIA Profile Inspector executable not found.
    )

    :nvidiaend1

    cls
    echo.
    echo   %verde%[ %green%•%verde% ]%reset% Applying %green%NVIDIA%reset% Tweaks... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying NVIDIA Tweaks --- >> "%logfile%" 2>&1

    :: Latency Tolerance (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "D3PCLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "F1TransitionLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "LOWLATENCY" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Node3DLowLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PciLatencyTimerControl" /t REG_DWORD /d 20 /f >> "%logfile%" 2>&1
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
    echo   %verde%[ %green%•%verde% ]%reset% Latency Tolerance Optimized.

    :: Power Saving (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Power Saving disabled.

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
    echo   %verde%[ %green%•%verde% ]%reset% Driver Telemetry disabled.

    :: DirectX Event Tracking (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Event Tracking disabled.

    :: Dedicated Video Memory (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Increased Dedicated VRAM.

    :: Redraw Acceleration (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Setting Driver Accelerationss.

    :: Filters (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Overlay Filter disabled.

    :: Write Combining (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Write Combining disabled.

    :: Contigous Memory Allocation (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Forcing Contigous Memory Allocation.

    :: DPC'S (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\NVAPI" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Core DPC enabled.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% NVIDIA Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- NVIDIA Tweaks applied --- >> "%logfile%" 2>&1
    goto nvidia

    :nvidiaperformance
    cls
    echo.
    echo   %verde%[ %green%•%verde% ]%reset% Applying %green%NVIDIA Profile Inspector%reset% Tweaks...
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying NVIDIA Profile --- >> "%logfile%" 2>&1

    echo   %verde%[ %green%•%verde% ]%reset% Checking %green%Profile Inspector%reset% executable...
    timeout /t 2 /nobreak >> "%logfile%" 2>&1

    if not exist "C:\%script%\NVIDIA\nvidiaProfileInspector.zip" (
        echo   %verde%[ %green%•%verde% ]%reset% Downloading %green%Profile Inspector%reset% package...
        curl -g -k -L -# -o "C:\%script%\NVIDIA\nvidiaProfileInspector.zip" "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/download/2.4.0.27/nvidiaProfileInspector.zip" >> "%logfile%" 2>&1
        if errorlevel 1 (
            echo   %red%[ • ]%reset% Failed to download NVIDIA Profile Inspector.
            goto :nvidiaend2
        )
    ) else (
        echo   %verde%[ %green%•%verde% ]%reset% %green%Profile Inspector%reset% already downloaded.
        timeout /t 2 /nobreak >> "%logfile%" 2>&1
    )

    if not exist "C:\%script%\NVIDIA\NvidiaProfileInspector" (
        echo   %verde%[ %green%•%verde% ]%reset% Extracting %green%Profile Inspector%reset% package...
        chcp 437 >> "%logfile%" 2>&1
        powershell -NoProfile Expand-Archive 'C:\%script%\NVIDIA\nvidiaProfileInspector.zip' -DestinationPath 'C:\%script%\NVIDIA\' >> "%logfile%" 2>&1
        chcp 65001 >> "%logfile%" 2>&1
        del /q "C:\%script%\NVIDIA\nvidiaProfileInspector.zip" >nul 2>&1
        if not exist "C:\%script%\NVIDIA\nvidiaProfileInspector.exe" (
            echo   %red%[ • ]%reset% Extraction failed, executable not found.
            goto :nvidiaend2
        )
    )

    echo   %verde%[ %green%•%verde% ]%reset% Importing %green%GhostX Performance%reset% profile...
    curl -g -k -L -# -o "C:\%script%\NVIDIA\GhostX2-NVIDIA.nip" "https://github.com/louzkk/Ghost-Optimizer/raw/main/bin/GhostX2-NVIDIA.nip" >> "%logfile%" 2>&1
    if errorlevel 1 (
        echo   %red%[ • ]%reset% Failed to download NVIDIA profile.
        goto :nvidiaend2
    )
    timeout /t 2 /nobreak >> "%logfile%" 2>&1

    echo   %verde%[ %green%•%verde% ]%reset% Applying %green%GhostX Performance%reset% profile...
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    if exist "C:\%script%\NVIDIA\nvidiaProfileInspector.exe" (
        start "" /wait "C:\%script%\NVIDIA\nvidiaProfileInspector.exe" "C:\%script%\NVIDIA\GhostX2-NVIDIA.nip" >> "%logfile%" 2>&1
        echo.
        echo   %verde%[ %green%•%verde% ]%reset% Profile Inspector Tweaks Applied %green%successfully%white%.
        echo --- NVIDIA Profile applied --- >> "%logfile%" 2>&1
    ) else (
        echo   %red%[ • ]%reset% NVIDIA Profile Inspector executable not found.
    )

    :nvidiaend2

    cls
    echo.
    echo   %verde%[ %green%•%verde% ]%reset% Applying %green%NVIDIA%reset% Tweaks... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Applying NVIDIA Tweaks --- >> "%logfile%" 2>&1

    :: Latency Tolerance (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "D3PCLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "F1TransitionLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "LOWLATENCY" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Node3DLowLatency" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PciLatencyTimerControl" /t REG_DWORD /d 20 /f >> "%logfile%" 2>&1
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
    echo   %verde%[ %green%•%verde% ]%reset% Latency Tolerance Optimized.

    :: Power Saving (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Power Saving disabled.

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
    echo   %verde%[ %green%•%verde% ]%reset% Driver Telemetry disabled.

    :: DirectX Event Tracking (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "TrackResetEngine" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Event Tracking disabled.

    :: Dedicated Video Memory (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmCacheLoc" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Increased Dedicated VRAM.

    :: Redraw Acceleration (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "Acceleration.Level" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Setting Driver Accelerationss.

    :: Filters (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NVDeviceSupportKFilter" /t REG_DWORD /d 0 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Overlay Filter disabled.

    :: Write Combining (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Write Combining disabled.

    :: Contigous Memory Allocation (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Forcing Contigous Memory Allocation.

    :: DPC'S (from Ancel's Performance Batch)
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\NVAPI" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% Core DPC enabled.

    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% NVIDIA Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- NVIDIA Tweaks applied --- >> "%logfile%" 2>&1
    goto nvidia

   :inspector
    cls
    echo.
    echo   %verde%[ %green%•%verde% ]%reset% Opening %green%NVIDIA Profile Inspector%reset% Software...
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo --- Opening Profile Inspector --- >> "%logfile%" 2>&1

    echo   %verde%[ %green%•%verde% ]%reset% Checking %green%Profile Inspector%reset% executable...
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    if not exist "C:\%script%\NVIDIA\nvidiaProfileInspector.exe" (
        echo   %verde%[ %green%•%verde% ]%reset% Downloading %green%Profile Inspector%reset% executable...
        curl -g -k -L -# -o "C:\%script%\NVIDIA\nvidiaProfileInspector.zip" "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/download/2.4.0.27/nvidiaProfileInspector.zip" >> "%logfile%" 2>&1
    ) else (
        echo   %verde%[ %green%•%verde% ]%reset% %green%Profile Inspector%reset% already downloaded.
        timeout /t 2 /nobreak >> "%logfile%" 2>&1
    )

    if not exist "C:\%script%\NVIDIA\NvidiaProfileInspector" (
        echo   %verde%[ %green%•%verde% ]%reset% Extracting %green%Profile Inspector%reset% package...
        chcp 437 >> "%logfile%" 2>&1
        powershell -NoProfile Expand-Archive 'C:\%script%\NVIDIA\nvidiaProfileInspector.zip' -DestinationPath 'C:\%script%\NVIDIA\' >> "%logfile%" 2>&1
        chcp 65001 >> "%logfile%" 2>&1
        del /q "C:\%script%\NVIDIA\nvidiaProfileInspector.zip" >nul 2>&1
        if not exist "C:\%script%\NVIDIA\nvidiaProfileInspector.exe" (
            echo   %red%[ • ]%reset% Extraction failed, executable not found.
            goto :nvidiaend
        )
    )

    echo   %verde%[ %green%•%verde% ]%reset% Opening %green%Profile Inspector%reset% software...
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    start /wait "" "C:\%script%\NVIDIA\nvidiaProfileInspector.exe" >> "%logfile%" 2>&1

    echo.
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% %green%Profile Inspector%reset% Software closed.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %reboot%
    echo --- Closing Profile Inspector --- >> "%logfile%" 2>&1
    goto menu

:: Reboot & Shutdown
    :reboot
    cls
    echo.
    echo.
    set "W=120"
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

    set "lines[0]=                                          ██████╗ ███████╗██████╗  ██████╗  ██████╗ ████████╗     "
    set "lines[1]=                                          ██╔══██╗██╔════╝██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝     "
    set "lines[2]=                                          ██████╔╝█████╗  ██████╔╝██║   ██║██║   ██║   ██║        "
    set "lines[3]=                                          ██╔══██╗██╔══╝  ██╔══██╗██║   ██║██║   ██║   ██║        "
    set "lines[4]=                                          ██║  ██║███████╗██████╔╝╚██████╔╝╚██████╔╝   ██║   "
    set "lines[5]=                                          ╚═╝  ╚═╝╚══════╝╚═════╝  ╚═════╝  ╚═════╝    ╚═╝   "

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
    set "lines[0]=                           Restart Windows to apply the tweaks. Your system will be rebooted in 10 seconds."
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
    echo                                       %purple%[ %roxo%%underline%A%reset% %purple%]%white% Reboot System                %purple%[ %roxo%%underline%R%reset% %purple%]%white% Shutdown System
    echo.                 
    echo                                                         %purple%[ %roxo%%underline%Q%reset% %purple%]%white% Quick Reboot 
    echo.                 
    echo                                                           %purple%[ %roxo%%underline%C%reset% %purple%]%white% Cancel 
    echo.
    echo.
    echo                                                        %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="a" call :rebootapply
    if "%answer%"=="r" call :shutdownapply
    if "%answer%"=="A" call :rebootapply
    if "%answer%"=="R" call :shutdownapply
    if "%answer%"=="C" call :rebootcancel
    if "%answer%"=="c" call :rebootcancel
    if "%answer%"=="b" call :menu
    if "%answer%"=="B" call :menu
    if "%answer%"=="q" call :quickreboot
    if "%answer%"=="Q" call :quickreboot

    :: Invalid Input
    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%logfile%" 2>&1
    echo.
    goto reboot

    :rebootapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% %roxo%Rebooting%white% your system in %roxo%10%white% seconds... 
    title %script% %version% %space% %rebooting%
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    shutdown /r /t 10 >> "%logfile%" 2>&1
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    goto menu

    :shutdownapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% %roxo%Turning Off%white% your system in %roxo%10%white% seconds... 
    title %script% %version% %space% %shuttingdown%
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    shutdown /s /t 10 >> "%logfile%" 2>&1
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    goto menu

    :quickreboot
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% %roxo%Rebooting%white% your system in %roxo%10%white% seconds... 
    title %script% %version% %space% %rebooting%
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    shutdown /r /t 0 >> "%logfile%" 2>&1
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    goto menu

    :rebootcancel
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% %roxo%Cancelling%white% system Reboot/Shutdown... 
    echo.
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    shutdown /a >> "%logfile%" 2>&1
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    goto menu

:: Restart Script
    :restart
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Restarting %purple%%script%%white%... 
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    start "" "%~f0"
    exit

:: Snap tap
    :socd
    cls
    echo.
    echo   %red%[ Note ]%white% Experimenal Feature, anti-cheats may detect this.
    echo            Ghost Snaptap (Input Cleaner) optimize the "A-D" movement in games.
    echo.
    echo            Press any key to continue.
    pause  >nul 2>&1
    goto socd2
    :socd2
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Checking %purple%Ghost Snaptap%white% autohotkey...
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    if not exist "C:\%script%\GhostAHK\GhostOPX-SOCD.ahk" (
    echo   %purple%[ %roxo%•%purple% ]%white% Downloading %purple%Ghost Snaptap%white% autohotkey...
    title %script% %version% %space% %winver%
    curl -g -k -L -# -o "C:\%script%\GhostAHK\GhostOPX-SOCD.ahk" "https://github.com/louzkk/Ghost-Optimizer/raw/main/bin/GhostOPX-SOCD.ahk" >> "%logfile%" 2>&1)
    if errorlevel 1 (
        echo   %red%[ • ]%reset% Failed to download Snaptap autohotkey.
        goto menu
    )
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    title %script% %version% %space% %winver%

    echo   %purple%[ %roxo%•%purple% ]%white% Starting %purple%Ghost Snaptap%white%...
    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    if exist "C:\%script%\GhostAHK\GhostOPX-SOCD.ahk" (
        start "" "C:\%script%\GhostAHK\GhostOPX-SOCD.ahk"
        echo.
        echo   %purple%[ %roxo%•%purple% ]%white% %purple%Ghost Snaptap%white% autootkey running.
    ) else (
        echo   %red%[ • ]%reset% %purple%Ghost Snaptap%white% autohotkey not found!
    )

    timeout /t 2 /nobreak >> "%logfile%" 2>&1
    echo.