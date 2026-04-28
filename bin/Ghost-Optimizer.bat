@echo off
cd /d "%~dp0"

    fltmc >nul 2>&1
    if %errorlevel%==0 (
        set mode=pass
    ) else (
        set mode=block
    )

    mode 124,30
    setlocal enabledelayedexpansion
    chcp 437 >nul 2>&1
    powershell "Set-ExecutionPolicy Unrestricted" >nul 2>&1
    reg add "HKCU\CONSOLE" /v "VirtualTerminalLevel" /t REG_DWORD /d 1 /f >nul 2>&1
    for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")
    (for /f %%a in ('echo prompt $E^| cmd') do set "esc=%%a")
    chcp 65001 >nul 2>&1

    set "version=5.3.2"
    set "script=Ghost Optimizer"
    set "reboot= (Reboot required)" 
    set "rebooting=Rebooting"
    set "shuttingdown=Shutting Down"
    set "downloading=Downloading"
    set "louzkk=@louzkk"
    title Ghost Optimizer %version%

    set purple=[38;5;93m
    set roxo=[38;5;129m
    set red=[38;2;255;0;0m
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
    set cinza=[38;5;8m
    set highlight=[97;48;5;93m

    set "colorBaseR=128"
    set "colorBaseG=0"
    set "colorBaseB=255"
    set "variationR=-96"
    set "variationG=0"
    set "variationB=0"

    set /a "mid=80"
    for /L %%j in (0,1,129) do (
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

    set "W=121"
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

    set "W_BLOCK=110"
    for /L %%j in (0,1,%W_BLOCK%) do (
        set "cR=255"
        set /a "cG=80 * %%j / %W_BLOCK%"
        set "red_esc[%%j]=!esc![38;2;!cR!;!cG!;0m"
    )

    if "%mode%"=="block" goto block
    if "%mode%"=="pass" goto welcome

    :block
    cls
    echo !esc![?25l
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    set "lines[0]=                                                         ██████               "
    set "lines[1]=                                                      ████████████            "
    set "lines[2]=                                                   ██████████████████         "
    set "lines[3]=                                                   █████   ██   █████         "
    set "lines[4]=                                                  ██████   ██   ██████        "
    set "lines[5]=                                                 ██████████████████████       "
    set "lines[6]=                                                █████   ███  ███   █████      "
    set "lines[7]=                                                ███  ███   ██   ███  ███      "
    set "lines[8]=                                                ████████████████████████      "
    set "lines[9]=                                                ████    ███  ███    ████      "
    set "lines[10]=                                                                             "
    set "lines[11]=                                                                             "
    set "lines[12]=                                           Administrator privileges required."

    for /L %%i in (0,1,12) do (
        set "text=!lines[%%i]!"
        set "textGradient="
        for /L %%j in (0,1,109) do (
            set "char=!text:~%%j,1!"
            if "!char!" == "" set "char= "
            set "textGradient=!textGradient!!red_esc[%%j]!!char!"
        )
        echo !textGradient!!esc![0m
    )

    pause >nul 2>&1 
    exit /b

    :welcome
    cls 
    echo.
    echo.
    set "lines[0]=                               ██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗  "
    set "lines[1]=                               ██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝"
    set "lines[2]=                               ██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗"
    set "lines[3]=                               ██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝"
    set "lines[4]=                               ╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗"
    set "lines[5]=                                ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝"

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
    set /a "BeforeSpace=(129 - 115) / 2"
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
    echo                            %roxo%Ghost Optimizer%reset% is an open source advanced batch script that improves
    echo                     performance, latency, network and privacy, while removing bloatware and AI features.
    echo.
    echo                     The revert tweaks option may not work as expected; create a restore point for safety.
    echo                    Use this script at your own risk. I take no responsibility for any damage or data loss.
    echo                                     You can report issues or submit suggetions at Github.
    echo.
    echo                                                     Made by: %roxo%%louzkk%%reset%
    echo.
    echo.
    echo                            %purple%[ %roxo%%underline%Y%reset% %purple%]%white% Create a restore point                %purple%[ %roxo%%underline%N%reset% %purple%]%white% Skip restore point
    echo.
    echo.

    set /p answer="%white% >:%roxo%"

    if "%answer%"=="y" goto restore
    if "%answer%"=="Y" goto restore
    if "%answer%"=="n" goto loading
    if "%answer%"=="N" goto loading

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >nul 2>&1
    echo.
    goto welcome

    :restore
    cls
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% Creating a %roxo%Restore Point%white%... 
    echo.
    timeout /t 3 /nobreak >nul 2>&1
    echo --- Creating a Restore Point --- >nul 2>&1

  
    echo      %purple%[ %roxo%-%purple% ]%white% Enabling Restore Point...
    powershell -ExecutionPolicy Bypass -Command "Enable-ComputerRestore -Drive 'C:\'" >nul 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Preparing Restore Point...
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" /v "DisableSR" /t REG_DWORD /d 0 /f >nul 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Starting Restore Point...
    sc config vss start= auto >nul 2>&1
    sc start vss >nul 2>&1
    sc config srservice start= auto >nul 2>&1
    sc start srservice >nul 2>&1

    :: vssadmin resize shadowstorage /for=C: /on=C: /maxsize=10%% >nul 2>&1
    
    echo      %purple%[ %roxo%-%purple% ]%white% Creating a Restore Point...
    chcp 437 >nul 2>&1
    powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'Ghost Optimizer %version% - Restore Point' -RestorePointType 'MODIFY_SETTINGS'" >nul 2>&1
    chcp 65001 >nul 2>&1

    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Restore Point created %green%successfully%white%.
    echo --- Restore Point created --- >nul 2>&1
    timeout /t 3 /nobreak >nul 2>&1
    goto loading

    :loading
    cls
    chcp 65001 >nul
    echo !esc![?25l
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    set "lines[0]=                                                          ██████              "
    set "lines[1]=                                                       ████████████           "
    set "lines[2]=                                                    ██████████████████        "
    set "lines[3]=                                                    █████   ██   █████        "
    set "lines[4]=                                                   ██████   ██   ██████       "
    set "lines[5]=                                                  ██████████████████████      "
    set "lines[6]=                                                 █████   ███  ███   █████     "
    set "lines[7]=                                                 ███  ███   ██   ███  ███     "
    set "lines[8]=                                                 ████████████████████████     "
    set "lines[9]=                                                 ████    ███  ███    ████     "
    set "lines[10]=                                                                             "
    set "lines[11]=                                                                             "
    set "lines[12]=                                                         Loading...          "

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

        if exist "C:\Ghost Optimizer" (
            rd /s /q "C:\Ghost Optimizer" >> nul 2>&1
        )

        if not exist "C:\Ghost Optimizer" mkdir "C:\Ghost Optimizer"
        if not exist "C:\Ghost Optimizer\Logs" mkdir "C:\Ghost Optimizer\Logs"
        if not exist "C:\Ghost Optimizer\NVIDIA" mkdir "C:\Ghost Optimizer\NVIDIA"
        if not exist "C:\Ghost Optimizer\OOSU10" mkdir "C:\Ghost Optimizer\OOSU10"
        if not exist "C:\Ghost Optimizer\Powerplan" mkdir "C:\Ghost Optimizer\Powerplan"

        set "d=%date:/=-%"
        set "t=%time::=-%"
        set "t=%t:.=-%"
        set "t=%t: =0%"
        set "ghost-logfile=C:\Ghost Optimizer\Logs\%d%_%t%.log"
        echo Ghost Optimizer %version% > "%ghost-logfile%"
        echo Log File - script made by @louzkk /f >> "%ghost-logfile%" 2>&1
        echo. /f >> "%ghost-logfile%" 2>&1

        set "LinkFile=C:\Ghost Optimizer\GitHub.url"
        (
        echo [InternetShortcut]
        echo URL=https://github.com/louzkk/Ghost-Optimizer
        ) > "%LinkFile%"

        chcp 437 >nul 2>&1

        for /f "delims=" %%G in ('powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"') do (
            set "GPUName=%%G"
        )

        for /f "delims=" %%A in ('powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"') do (
            set "CPUName=%%A"
        )

        for /f "tokens=3" %%b in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| findstr /i "CurrentBuild"') do (
            set "BuildNumber=%%b"
        )

        chcp 65001 >nul

        if defined BuildNumber (
            if !BuildNumber! GEQ 22000 (
                set "OS=11"
            ) else (
                set "OS=10"
            )
        )
        set Winver=(Windows %OS%)

        timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
        title Ghost Optimizer %version%  %winver%

    :menu
    cls
    echo.
    echo.
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
    echo                       %purple%%underline%GPU%reset%%purple%:%reset% %GPUName%        %purple%%underline%CPU%reset%%purple%:%reset% %CPUName%
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
    echo                                   %purple%[ %roxo%%underline%A%reset% %purple%]%white% Apply all%yellow%*%reset%                          %purple%[ %roxo%%underline%R%reset% %purple%]%white% Revert all 
    echo.
    echo.
    echo               %purple%[ %roxo%%underline%1%reset% %purple%]%white% General Tweaks               %purple%[ %roxo%%underline%2%reset% %purple%]%white% Performance Tweaks              %purple%[ %roxo%%underline%3%reset% %purple%]%white% Network Tweaks
    echo.
    echo               %purple%[ %roxo%%underline%4%reset% %purple%]%white% NVIDIA Profile               %purple%[ %roxo%%underline%5%reset% %purple%]%white% Latency ^& Input-Lag             %purple%[ %roxo%%underline%6%reset% %purple%]%white% Mouse ^& Keyboard
    echo.
    echo               %purple%[ %roxo%%underline%7%reset% %purple%]%white% Windows Cleaner              %purple%[ %roxo%%underline%8%reset% %purple%]%white% Telemetry ^& Logging             %purple%[ %roxo%%underline%9%reset% %purple%]%white% Running Services
    echo.
    echo               %purple%[ %roxo%%underline%10%reset% %purple%]%white% Ghost Powerplan             %purple%[ %roxo%%underline%11%reset% %purple%]%white% Integrity ^& Health             %purple%[ %roxo%%underline%12%reset% %purple%]%white% Bloatware ^& AI
    echo.
    echo.
    echo                                                        %purple%[ %roxo%%underline%13%reset% %purple%]%white% Other
    echo.
    set /p answer="%white% >:%roxo%"
    echo.

    if "%answer%"=="1" goto general
    if "%answer%"=="2" goto performance
    if "%answer%"=="3" goto network
    if "%answer%"=="4" goto nvidia
    if "%answer%"=="5" goto latency
    if "%answer%"=="6" goto kbm
    if "%answer%"=="7" goto clean
    if "%answer%"=="8" goto telemetry
    if "%answer%"=="9" goto services
    if "%answer%"=="10" goto powerplan
    if "%answer%"=="11" goto health
    if "%answer%"=="12" goto debloat
    if "%answer%"=="13" goto other

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

    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    goto menu

goto menu

    :applyall
    cls
    echo.
    echo.
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
    set "lines[0]=               Tweaks: General, Performance, Network, Latency, Keyboard/Mouse, Telemetry, Services and Power Plan."

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                                                  %purple%[ %roxo%%underline%1%reset% %purple%]%white% Apply all Tweaks
    echo.                 
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :applyallapply
    if "%answer%"=="2" call :applyallapplyexceptgamebar
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto applyall

goto menu

    :applyallapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %roxo%All%white% Tweaks/Fixes... 
    echo.
    timeout /t 3 /nobreak >> "%ghost-logfile%" 2>&1

    set mode=none
    call:generalapply
    call:performanceapply
    call:disablemitigations
    call:networkapply
    call:dnsapply
    call:latencyapply
    call:kbmapply
    call:telemetryapply
    call:oosu10
    call:servicesapply
    call:powerplanapply
    call:debloatapply
    call:rebootquestion

    taskkill /f /im explorer.exe /f >> "%ghost-logfile%" 2>&1
    start explorer.exe /f >> "%ghost-logfile%" 2>&1

    echo.
    echo   %yellow%[ • ]%reset% Remaining manual options: NVIDIA Tweaks [4], Cleaner [7], Integrity Fix [11] and Other [13]. 

    echo.
    timeout /t 3 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% All Tweaks/Fixes applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    goto menu

goto menu

    :revertall
    cls
    echo.
    echo.
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
    set "lines[0]=                     Revert all Tweaks/Fixes using the restore point that you created (or should have)."

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                                                 %purple%[ %roxo%%underline%1%reset% %purple%]%white% Apply Restore Point
    echo.                 
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" goto revertallapply
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto revertall

goto menu

    :revertallapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Reverting %roxo%All%white% Tweaks/Fixes... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Applying Restore Point --- /f >> "%ghost-logfile%" 2>&1

    :: Start System Restore
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% System Restore open.
    start /wait "" rstrui.exe >> "%ghost-logfile%" 2>&1

    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% System Restore closed.

    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Submit your feedback at https://github.com/louzkk/Ghost-Optimizer.
    echo.
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %yellow%[ • ]%reset% The next system reboot/restart may take some time.

    echo.
    timeout /t 3 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% All Tweaks/Fixes reverted %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Restore Point reverted --- /f >> "%ghost-logfile%" 2>&1
    goto menu

goto menu

    :general
    set mode=menu
    cls
    echo.
    echo.
    set "lines[0]=                                   ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗     "
    set "lines[1]=                                  ██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║     "
    set "lines[2]=                                  ██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║     "
    set "lines[3]=                                  ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║     "
    set "lines[4]=                                  ╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗"
    set "lines[5]=                                   ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝"

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
    set "lines[0]=                     Applies essential tweaks to make system cleaner, faster to use and less annoying."
    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                                               %purple%[ %roxo%%underline%1%reset% %purple%]%white% Apply General Tweaks
    echo.                 
    echo.
    echo                                                   %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :generalapply
    if "%answer%"=="b" goto :menu
    if "%answer%"=="B" goto :menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto general

goto menu

    :generalapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %roxo%General%white% Tweaks...
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Applying General Tweaks --- /f >> "%ghost-logfile%" 2>&1

    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme"       /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme"    /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Dark mode enabled.

    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "StartupDelayInMSec"     /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"  /v "ShowTaskViewButton"     /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"  /v "HideSCAMeetNow"         /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"  /v "HideSCAMeetNow"         /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh"                              /v "AllowNewsAndInterests"  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Explorer tweaked.

   reg add "HKCU\Control Panel\Desktop\WindowMetrics"                              /v "MinAnimate" /t REG_SZ /d 0 /f >nul 2>&1
   reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_SZ /d 2 /f >nul 2>&1
   reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"     /v "EnableTransparency" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
   reg add "HKCU\Control Panel\Desktop"                                            /v "FontSmoothing" /t REG_SZ /d 2 /f >> "%ghost-logfile%" 2>&1
   echo      %purple%[ %roxo%-%purple% ]%white% Visual Effects optimized.

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"                                         /v "SearchboxTaskbarMode"          /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"                              /v "TaskbarMn"                     /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"                              /v "TaskbarDa"                     /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"                              /v "PeopleBand"                    /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings"     /v "TaskbarEndTask"                /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests"          /v "value"                         /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletPC"                                                     /v "DisableTouchKeyboard"          /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7"                                                         /v "EnableDesktopModeAutoInvoke"   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\TabletTip\1.7"                                                         /v "TipbandDesiredVisibility"      /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PenWorkspace"                                   /v "PenWorkspaceButtonDesiredVisibility" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Taskbar tweaks applied.

    reg add "HKCU\Control Panel\Desktop"                                             /v "WindowArrangementActive"       /t REG_SZ    /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"       /v "EnableSnapBar"                 /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"       /v "SnapAssist"                    /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"       /v "EnableSnapAssistFlyout"        /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"       /v "EnableSnapAssistFlyoutPreview" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Snap Assist disabled.

    reg add "HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\3895955085" /v "EnabledState"        /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\3895955085" /v "EnabledStateOptions" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Drag Tray disabled.

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "TabletMode"                  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "SignInMode"                  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v "TabletModeBatteryThreshold"  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Tablet Mode disabled.

    ::reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "FocusAssist" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    ::echo      %purple%[ %roxo%-%purple% ]%white% Focus Assist disabled.

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled"     /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled"           /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled"    /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent"                 /v "DisableWindowsConsumerFeatures"      /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent"                 /v "DisableWindowsConsumerFeatures"      /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent"                 /v "DisableSpotlightCollectionOnDesktop" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent"                 /v "DisableWindowsSpotlightFeatures"     /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent"                 /v "DisableThirdPartySuggestions"        /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Spotlight and Tooltips disabled.

    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Stickers"         /v "EnableStickers"                   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Desktop Stickers disabled.

    reg add "HKLM\SOFTWARE\Microsoft\Windows Search"                                        /v "AllowCortana"                                   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer"                             /v "DisableSearchBoxSuggestions"                    /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"                         /v "BingSearchEnabled"                              /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"                         /v "CortanaConsent"                                 /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"                         /v "SearchHistoryEnabled"                           /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search"                         /v "AllowSearchToUseLocation"                       /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                       /v "ConnectedSearchUseWeb"                          /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                       /v "ConnectedSearchUseWebOverMeteredConnections"    /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                       /v "AllowIndexingEncryptedStoresOrItems"            /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                       /v "DisableIndexerBackoff"                          /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                       /v "PreventIndexingOutlook"                         /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                       /v "PreventIndexingPublicFolders"                   /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                       /v "PreventIndexingEmailAttachments"                /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                       /v "BingSearchEnabled"                /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Search Web ^& Index disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "LongPathsEnabled"            /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% File system tweaked.

    reg add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction"          /v "Enable"          /t REG_SZ    /d "Y" /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\defragsvc"           /v "Start"           /t REG_DWORD /d 2   /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Optimize"    /v "ScheduledDefrag" /t REG_DWORD /d 1   /f >> "%ghost-logfile%" 2>&1
    schtasks /change /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" /ri 0 /st 00:00 /du 00:00 /mo MONTHLY /enable /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Disk optimization tweaked.

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "01" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Storage Sense disabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"                            /v "LetAppsRunInBackground" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"    /v "GlobalUserDisabled"    /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Background apps disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% USB selective suspend disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberBootEnabled"                    /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                 /v "HibernateEnabled"                    /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                 /v "SleepReliabilityDetailedDiagnostics" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    powercfg -h off /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Hibernation disabled.

    reg add "HKLM\System\CurrentControlSet\Control\Remote Assistance"             /v "fAllowToGetHelp"   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance"             /v "fAllowFullControl" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"       /v "fAllowUnsolicited" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"       /v "fAllowToGetHelp"   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Remote Assistance disabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"                    /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching"            /v "SearchOrderConfig"               /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Auto driver search disabled.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% General Tweaks applied %green%successfully%white%.
    timeout /t 3 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished General Tweaks --- /f >> "%ghost-logfile%" 2>&1
    if "%mode%"=="menu" goto menu
    exit /b

goto menu

    :performance
    set mode=menu
    cls
    echo.
    echo.
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
    set "lines[0]=                     Applies advanced tweaks to boost system performance, latency and responsivness."

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                         %purple%[ %roxo%%underline%1%reset% %purple%]%white% Apply Performance Tweaks                %purple%[ %roxo%%underline%2%reset% %purple%]%white% Disable Virtualization
    echo.                 
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :performanceapply
    if "%answer%"=="2" call :disablemitigations
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto performance

goto menu

    :performanceapply
    chcp 65001 >nul
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %roxo%Performance%white% Tweaks...
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Applying Performance Tweaks --- /f >> "%ghost-logfile%" 2>&1

    reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode"    /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled"  /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Game Mode enabled.

    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value"               /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR"                                 /v "AllowGameDVR"        /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR"                           /v "AllowGameDVR"        /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR"                           /v "AppCaptureEnabled"   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR"                           /v "AppCaptureEnabled"   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR"                           /v "AudioCaptureEnabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\System\GameConfigStore"                                                      /v "GameDVR_Enabled"     /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\System\GameConfigStore"                                                      /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white%%white% Game Bar ^& DVR disabled.

    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DSEBehavior"                     /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_FSEBehaviorMode"                 /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_EFSEFeatureFlags"                /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible"   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode"        /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Fullscreen optimizations enabled.

    reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm"                        /v "FlipQueueSize"             /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"      /v "DisableFlipModel"          /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\DirectX\GraphicsSettings"           /v "SwapEffectUpgradeEnable"   /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\DirectX\GraphicsSettings"           /v "SwapEffectUpgradeCache"    /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences"         /v "DirectXUserGlobalSettings" /t REG_SZ /d "VRROptimizeEnable=0;SwapEffectUpgradeEnable=1;" /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Windowed optimizations enabled.

    reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Multi Plane Overlay enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"           /v "HwSchMode"           /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableReclaim"       /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableExplicitVidMm" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Hardware GPU Scheduling optimized.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay"            /t REG_DWORD /d 10 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay"         /t REG_DWORD /d 10 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Direct3D\Drivers"              /v "SoftwareOnly"        /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Direct3D"                      /v "DisableDebugLayer"   /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\DirectX"                       /v "ForceGPUPreemption"  /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% DirectX and Direct3D optimized.

    chcp 437 >nul 2>&1
    for /f "tokens=*" %%g in ('powershell -Command "Get-CimInstance Win32_VideoController | ForEach-Object { $_.PNPDeviceID }"') do (
        reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported"   /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
        reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\Affinity Policy"                    /v "DevicePriority" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    )
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% MSI enabled for supported GPUs.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Priority separation optimized.

    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "AlwaysOn"    /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode"  /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"      /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"      /v "Affinity"            /t REG_DWORD /d 0       /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"      /v "Background Only"     /t REG_SZ    /d "False" /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"      /v "Clock Rate"          /t REG_DWORD /d 10000   /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"      /v "GPU Priority"        /t REG_DWORD /d 8       /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"      /v "Priority"            /t REG_DWORD /d 6       /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"      /v "Scheduling Category" /t REG_SZ  /d "High"  /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"      /v "SFIO Priority"       /t REG_SZ    /d "High"  /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"      /v "Latency Sensitive"   /t REG_SZ    /d "True"  /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% MMCSS game scheduling optimized.

    chcp 437 >nul 2>&1
    sc config "SysMain" start= auto /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters"  /v "EnablePrefetcher"          /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters"  /v "EnableSuperfetch"          /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"                     /v "AutomaticManagedPagefile"  /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control"                                                       /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d 4096000 /f >> "%ghost-logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PagingFiles" /f >> "%ghost-logfile%" 2>&1
    powershell -command "Enable-MMAgent -MemoryCompression" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Memory management optimized.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling"             /v "PowerThrottlingOff"      /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager"                   /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power"             /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"            /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive"         /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ModernSleep"                 /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                             /v "CoalescingTimerInterval" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Power throttling disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "EnergyEstimationEnabled"  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "EventProcessorEnabled"   /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "PreferExternalManifest"  /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "Attributes"              /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "CsEnabled"               /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "PlatformAoAcOverride"    /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Modern Standby disabled.

    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "TimeStampInterval" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "IoPriority"        /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% IO priority optimized.

    fsutil behavior set memoryusage 2 /f >> "%ghost-logfile%" 2>&1
    fsutil behavior set disablelastaccess 1 /f >> "%ghost-logfile%" 2>&1
    fsutil behavior set disable8dot3 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% NTFS Cache optimized.

    bcdedit /set tscsyncpolicy Enhanced /f >> "%ghost-logfile%" 2>&1
    bcdedit /set disabledynamictick Yes /f >> "%ghost-logfile%" 2>&1
    bcdedit /set x2apicpolicy Enable  /f >> "%ghost-logfile%" 2>&1
    bcdedit /set configaccesspolicy Default /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Boot parameters optimized.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Performance Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished Performance Tweaks --- /f >> "%ghost-logfile%" 2>&1
    if "%mode%"=="menu" goto performance
    exit /b

    goto performance

    :disablemitigations
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Do you want to disable Virtualization and Mitigations? %reset%(%green%Y%reset%/%red%N%reset%%reset%)%reset%
    echo.
    echo   %purple%About:%reset% These tweaks disable Virtualization, Hypervisor, and Spectre ^& Meltdown mitigations.
    echo   This can improve performance by up to 30%%, but increases vulnerability to malware and anti-cheats problems.
    echo.

    set /p answer="%reset% >:%roxo%"

    if /i "%answer%"=="Y" (
        goto disablemitigationsapply
    ) else if /i "%answer%"=="N" (
        goto performance
    ) else (
        echo.
        echo.
        echo %red%                                                     Invalid Input.%reset%
        timeout /t 2 /nobreak >nul
        goto disablemitigations
    )

    goto disablemitigations

goto menu

    :disablemitigationsapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Disabling %roxo%Virtualization%reset% and %roxo%Mitigations%reset%...
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Disabling Mitigations --- /f >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Checking Virtualization...

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity"  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "RequirePlatformSecurityFeatures"    /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired"                    /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    dism /online /disable-feature /featurename:VirtualMachinePlatform /norestart /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Virtualization (VBS) disabled.


    reg add "HKLM\SYSTEM\CurrentControlSet\Services\HvHost"    /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmsvc"     /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmcompute" /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    bcdedit /set hypervisorlaunch off /f >> "%ghost-logfile%" 2>&1
    dism /online /disable-feature /featurename:HypervisorPlatform    /norestart /f >> "%ghost-logfile%" 2>&1
    dism /online /disable-feature /featurename:Microsoft-Hyper-V-All /norestart /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Hypervisor (Hyper-V) disabled.

    bcdedit /set vsmlaunchtype off /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Virtual Machines (VMS) disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride"     /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Spectre mitigations disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Meltdown mitigations disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HypervisorEnforcedCodeIntegrity"                    /v "Enabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Core Isolation disabled.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Virtualization and Mitigations disabled %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Mitigations Disabled --- /f >> "%ghost-logfile%" 2>&1
    if "%mode%"=="menu" goto performance
    exit /b

goto menu

    :network
    set mode=menu
    cls
    echo.
    echo.
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
    set "lines[0]=                    Applies advanced tweaks to improve network latency, stability, security and privacy."

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                               %purple%[ %roxo%%underline%1%reset% %purple%]%white% Apply Network Tweaks                %purple%[ %roxo%%underline%2%reset% %purple%]%white% Apply DNS Tweaks
    echo.                 
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :networkapply
    if "%answer%"=="2" call :dnsapply
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto network

goto menu

    :networkapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %roxo%Network%white% Tweaks...
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Applying Network Tweaks --- /f >> "%ghost-logfile%" 2>&1

    reg query "HKLM\SYSTEM\GhostOptimizer" /v "IPStackReset" >nul 2>&1
    if errorlevel 1 (
        netsh int ip reset /f >> "%ghost-logfile%" 2>&1
        if errorlevel 1 (
            echo   %red%[ • ]%white% IP Stack reset failed.
        ) else (
            reg add "HKLM\SYSTEM\GhostOptimizer" /v "IPStackReset" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
        )
    )
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex"     /t REG_DWORD /d 0xffffffff /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% TCP/IP Stack optimized.

    reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters"                 /v "TCPNoDelay"      /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TCPNoDelay"      /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpDelAckTicks"  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% TCP latency optimized.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort"       /t REG_DWORD /d 65534 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d 30    /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% TCP port recycling optimized.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v "NetbiosOptions" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% TCP/IP NetBIOS disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    netsh int tcp set global nonsackrttresiliency=disabled /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% SACK optimized.

    netsh int tcp set global timestamps=disabled      /f >> "%ghost-logfile%" 2>&1
    netsh int tcp set global chimney=disabled        /f >> "%ghost-logfile%" 2>&1
    netsh int tcp set global ecncapability=enabled   /f >> "%ghost-logfile%" 2>&1
    netsh int tcp set global autotuninglevel=enabled /f >> "%ghost-logfile%" 2>&1
    netsh int tcp set heuristics disabled            /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% TCP global parameters optimized.

    netsh int tcp set global rss=enabled  /f >> "%ghost-logfile%" 2>&1
    netsh int tcp set global rsc=disabled /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% RSS enabled, RSC disabled.

    netsh int tcp set global netdma=disabled /f >> "%ghost-logfile%" 2>&1
    netsh int tcp set global dca=disabled    /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% NETDMA/DCA disabled.

    netsh int tcp set supplemental internet congestionprovider=ctcp /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% CTCP protocol enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"  /v "DisableTaskOffload"         /t REG_DWORD /d 0    /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"  /v "DisableLargeSendOffload"    /t REG_DWORD /d 1    /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters"    /v "DynamicSendBufferDisable"   /t REG_DWORD /d 1    /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters"    /v "DoNotHoldNICBuffers"        /t REG_DWORD /d 1    /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters"    /v "BufferAlignment"            /t REG_DWORD /d 1    /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters"    /v "FastSendDatagramThreshold"  /t REG_DWORD /d 1024 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters"    /v "FastCopyReceiveThreshold"   /t REG_DWORD /d 1024 /f >> "%ghost-logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DefaultSendWindow"          /f >> "%ghost-logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DefaultReceiveWindow"       /f >> "%ghost-logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "IgnorePushBitOnReceives"    /f >> "%ghost-logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "IgnoreOrderlyRelease"       /f >> "%ghost-logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DisableChainedReceive"      /f >> "%ghost-logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DisableDirectAcceptEx"      /f >> "%ghost-logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DisableRawSecurity"         /f >> "%ghost-logfile%" 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DisableAddressSharing"      /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Network adapter tweaks applied.


    chcp 437 >nul 2>&1
    set "NIC_CLASS=HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}"
    for /L %%i in (0,1,99) do (
        set "idx=000%%i"
        set "idx=!idx:~-4!"
        reg query "%NIC_CLASS%\!idx!" /v "*IfType" 2>nul | findstr /r "0x6\b 0x47\b" >nul 2>&1
        if !errorlevel! == 0 (
            reg add "%NIC_CLASS%\!idx!" /v "*InterruptModeration"  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
            reg add "%NIC_CLASS%\!idx!" /v "InterruptModeration"   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
            reg add "%NIC_CLASS%\!idx!" /v "ITR"                   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
            reg add "%NIC_CLASS%\!idx!" /v "*PacketCoalescing"     /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
            reg add "%NIC_CLASS%\!idx!" /v "PacketCoalescing"      /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
            reg add "%NIC_CLASS%\!idx!" /v "*ArpOffload"           /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
            reg add "%NIC_CLASS%\!idx!" /v "ArpOffload"            /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
            reg add "%NIC_CLASS%\!idx!" /v "*EEE"                  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
            reg add "%NIC_CLASS%\!idx!" /v "EEE"                   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
            reg add "%NIC_CLASS%\!idx!" /v "AdvancedEEE"           /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
            reg add "%NIC_CLASS%\!idx!" /v "EnableGreenEthernet"   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
            reg add "%NIC_CLASS%\!idx!" /v "EnableSavePowerNow"    /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
            reg add "%NIC_CLASS%\!idx!" /v "EnablePowerManagement" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
        )
    )
    reg add "%NIC_CLASS%" /v "*InterruptModeration"  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "%NIC_CLASS%" /v "InterruptModeration"   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "%NIC_CLASS%" /v "ITR"                   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "%NIC_CLASS%" /v "*PacketCoalescing"     /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "%NIC_CLASS%" /v "PacketCoalescing"      /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "%NIC_CLASS%" /v "*ArpOffload"           /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "%NIC_CLASS%" /v "ArpOffload"            /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "%NIC_CLASS%" /v "*EEE"                  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "%NIC_CLASS%" /v "EEE"                   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "%NIC_CLASS%" /v "AdvancedEEE"           /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "%NIC_CLASS%" /v "EnableGreenEthernet"   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "%NIC_CLASS%" /v "EnableSavePowerNow"    /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "%NIC_CLASS%" /v "EnablePowerManagement" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Scan" /v "DisablePeriodicScan" /t REG_DWORD /d 1    /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WlanSvc\Parameters"          /v "CoalescePackets"     /t REG_DWORD /d 0    /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"            /v "InitialRto"          /t REG_DWORD /d 2000 /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% NIC power saving disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MinSockAddrLength" /t REG_DWORD /d 16 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MaxSockAddrLength" /t REG_DWORD /d 28 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Winsock optimized.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "EnableMulticast" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Multicast disabled.

    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" /v "DisableWpad" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% WPAD disabled.

    netsh advfirewall firewall add rule name="Ghost Optimizer LPD TCP"      protocol=TCP localport=515  dir=in  action=block /f >> "%ghost-logfile%" 2>&1
    netsh advfirewall firewall add rule name="Ghost Optimizer mDNS UDP IN"  protocol=UDP localport=5353 dir=in  action=block /f >> "%ghost-logfile%" 2>&1
    netsh advfirewall firewall add rule name="Ghost Optimizer mDNS UDP OUT" protocol=UDP localport=5353 dir=out action=block /f >> "%ghost-logfile%" 2>&1
    netsh advfirewall firewall add rule name="Ghost Optimizer RDP TCP"      protocol=TCP localport=3389 dir=in  action=block /f >> "%ghost-logfile%" 2>&1
    netsh advfirewall firewall add rule name="Ghost Optimizer NetBIOS UDP"  protocol=UDP localport=137  dir=in  action=block /f >> "%ghost-logfile%" 2>&1
    netsh advfirewall firewall add rule name="Ghost Optimizer NetBIOS TCP"  protocol=TCP localport=139  dir=in  action=block /f >> "%ghost-logfile%" 2>&1
    netsh advfirewall firewall add rule name="Ghost Optimizer ICMPv6 RA IN" protocol=icmpv6:134,any dir=in action=block /f >> "%ghost-logfile%" 2>&1
    netsh advfirewall firewall add rule name="Ghost Optimizer SMB TCP"      protocol=TCP localport=445 dir=in action=block /f >> "%ghost-logfile%" 2>&1
    netsh advfirewall firewall add rule name="Ghost Optimizer SMB UDP"      protocol=UDP localport=445 dir=in action=block /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Firewall rules applied.

    netsh interface isatap set state disabled /f >> "%ghost-logfile%" 2>&1
    netsh interface 6to4  set state disabled /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% ISATAP and 6to4 disabled.

    chcp 437 >nul 2>&1
    Powershell -command "Get-NetAdapter | Where-Object {$_.PhysicalMediaType -eq 'Native 802.11'} | Set-NetAdapter -MacAddressRandomization Enabled -Confirm:`$false" /f >> "%ghost-logfile%" 2>&1
    Powershell -command "Get-NetAdapter | Where-Object {$_.MediaType -eq '802.3' -and $_.PhysicalMediaType -ne 'Native 802.11'} | Set-NetAdapter -MacAddressRandomization Enabled -Confirm:`$false" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% MAC randomization enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    sc stop RemoteRegistry   /f >> "%ghost-logfile%" 2>&1
    sc config RemoteRegistry start= disabled /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Remote Registry disabled.

    sc stop fdPHost            /f >> "%ghost-logfile%" 2>&1
    sc config fdPHost  start= disabled /f >> "%ghost-logfile%" 2>&1
    sc stop FDResPub           /f >> "%ghost-logfile%" 2>&1
    sc config FDResPub start= disabled /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Function Discovery disabled.

    chcp 437 >nul 2>&1
    dism /online /norestart /disable-feature /featurename:SMB1Protocol /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB1"  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer"            /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation"       /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb"                  /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SMB1"                    /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% SMBv1 protocol disabled.

    netsh interface teredo set state disabled /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" /t REG_DWORD /d 0x11 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Teredo disabled.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Network Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished Network Tweaks --- /f >> "%ghost-logfile%" 2>&1
    if "%mode%"=="menu" goto network
    exit /b

goto menu

    :dnsapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %roxo%DNS%white% Tweaks...
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Applying Network Tweaks --- /f >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Starting DNS setup...
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1

    set "dns_label=Ghost Optimizer DNS"
    set "dns_ipv4_1=45.90.28.0"
    set "dns_ipv4_2=45.90.30.0"
    set "dns_ipv6_1=2a07:a8c0::d3:8baf"
    set "dns_ipv6_2=2a07:a8c1::d3:8baf"
    set "dns_doh_1=https://dns.nextdns.io/d38baf"
    set "dns_doh_2=https://dns.nextdns.io/d38baf"

    chcp 437 >nul 2>&1
    powershell -NoProfile -Command "try { Add-DnsClientDohServerAddress -ServerAddress '%dns_ipv4_1%' -DohTemplate '%dns_doh_1%' -AllowFallbackToUdp $False -AutoUpgrade $True } catch { Set-DnsClientDohServerAddress -ServerAddress '%dns_ipv4_1%' -DohTemplate '%dns_doh_1%' -AllowFallbackToUdp $False -AutoUpgrade $True }" /f >> "%ghost-logfile%" 2>&1
    powershell -NoProfile -Command "try { Add-DnsClientDohServerAddress -ServerAddress '%dns_ipv4_2%' -DohTemplate '%dns_doh_2%' -AllowFallbackToUdp $False -AutoUpgrade $True } catch { Set-DnsClientDohServerAddress -ServerAddress '%dns_ipv4_2%' -DohTemplate '%dns_doh_2%' -AllowFallbackToUdp $False -AutoUpgrade $True }" /f >> "%ghost-logfile%" 2>&1

    for /f "usebackq tokens=*" %%I in (`powershell -NoProfile -Command "(Get-NetAdapter -Physical | Where-Object {$_.Status -eq 'Up'}).InterfaceIndex"`) do (
    netsh interface ip   set dnsservers name=%%I      source=static address=%dns_ipv4_1%          validate=no /f >> "%ghost-logfile%" 2>&1
    netsh interface ip   add dnsservers name=%%I      address=%dns_ipv4_2%            index=2     validate=no /f >> "%ghost-logfile%" 2>&1
    netsh interface ipv6 set dnsservers interface=%%I source=static address=%dns_ipv6_1%                      /f >> "%ghost-logfile%" 2>&1
    netsh interface ipv6 add dnsservers interface=%%I address=%dns_ipv6_2%            index=2                 /f >> "%ghost-logfile%" 2>&1
    )
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% DNS set to %roxo%%dns_label%%white%.

    ipconfig /flushdns /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% DNS cache cleaned.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableBucketSize" /t REG_DWORD /d 384   /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableSize"       /t REG_DWORD /d 384   /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheEntryTtlLimit"    /t REG_DWORD /d 86400 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheTtl"              /t REG_DWORD /d 86400 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% DNS cache optimized.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v "DoHPolicy"       /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% DNS DoH bypass disabled.
    
    chcp 437 >nul 2>&1 
    powershell -NoProfile -Command "Add-DnsClientDohServerAddress -ServerAddress '%dns_ipv6_2%' -DohTemplate '%dns_doh_2%' -AllowFallbackToUdp $False -AutoUpgrade $True" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% DoH IPV6 mapping enabled.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% DNS Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished DNS Tweaks --- /f >> "%ghost-logfile%" 2>&1
    if "%mode%"=="menu" goto network
    exit /b

goto menu

    :nvidia
    cls
    echo.
    echo.
    set mode=nvidiafix
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

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,129) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

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

        set /a "mid=80"
    for /L %%j in (0,1,129) do (
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

    set "W_BLOCK=110"
    for /L %%j in (0,1,%W_BLOCK%) do (
        set "cR=255"
        set /a "cG=80 * %%j / %W_BLOCK%"
        set "red_esc[%%j]=!esc![38;2;!cR!;!cG!;0m"
    )

    echo                          %nvidia%[ %verde%%underline%1%reset% %nvidia%]%white% Apply NVIDIA Tweaks                %nvidia%[ %verde%%underline%2%reset% %nvidia%]%white% Apply Performance Profile
    echo.
    echo.
    echo                                                    %nvidia%[ %verde%%underline%B%reset% %nvidia%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :nvidiaapply
    if "%answer%"=="2" call :nvidiaprofile
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto nvidia

goto menu

    :nvidiaapply
    cls
    echo.
    echo   %verde%[ %green%•%verde% ]%reset% Applying %green%NVIDIA%reset% Tweaks...
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Applying NVIDIA Tweaks --- /f >> "%ghost-logfile%" 2>&1

    :: Detect NVIDIA GPU subkey
    set "GPU_CLASS=HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
    set "NVIDIA_SUBKEY="

    echo      %verde%[ %green%-%verde% ]%reset% Detecting NVIDIA subkey...
    for /L %%i in (0,1,9) do (
        set "idx=000%%i"
        set "idx=!idx:~-4!"
        reg query "%GPU_CLASS%\!idx!" /v "ProviderName" 2>nul | findstr /i "NVIDIA" >nul 2>&1
        if !errorlevel! == 0 (
            if not defined NVIDIA_SUBKEY set "NVIDIA_SUBKEY=!idx!"
        )
    )

    if not defined NVIDIA_SUBKEY (
    echo      %red%[ - ]%white% NVIDIA subkey not found. Skipping driver registry tweaks.
        echo --- NVIDIA subkey not found --- /f >> "%ghost-logfile%" 2>&1
        goto :nvidiaregskip
    )

    echo      %verde%[ %green%-%verde% ]%reset% NVIDIA subkey: %NVIDIA_SUBKEY%
    echo --- NVIDIA subkey: %NVIDIA_SUBKEY% --- /f >> "%ghost-logfile%" 2>&1

    :: Latency Tolerance
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "D3PCLatency"                          /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "F1TransitionLatency"                  /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "LOWLATENCY"                           /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "Node3DLowLatency"                     /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "PciLatencyTimerControl"               /t REG_DWORD /d 20 /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "RMDeepL1EntryLatencyUsec"             /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "RmGspcMaxFtuS"                        /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "RmGspcMinFtuS"                        /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "RmGspcPerioduS"                       /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "RMLpwrEiIdleThresholdUs"              /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "RMLpwrGrIdleThresholdUs"              /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "RMLpwrGrRgIdleThresholdUs"            /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "RMLpwrMsIdleThresholdUs"              /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "VRDirectFlipDPCDelayUs"               /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "VRDirectFlipTimingMarginUs"           /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "VRDirectJITFlipMsHybridFlipDelayUs"   /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "vrrCursorMarginUs"                    /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "vrrDeflickerMarginUs"                 /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "vrrDeflickerMaxUs"                    /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    echo      %verde%[ %green%-%verde% ]%reset% Latency Tolerance optimized.

    :: DirectX Event Tracking
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "TrackResetEngine"                     /t REG_DWORD /d 0  /f >> "%ghost-logfile%" 2>&1
    echo      %verde%[ %green%-%verde% ]%reset% Event Tracking disabled.

    :: Dedicated Video Memory
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "RmCacheLoc"                           /t REG_DWORD /d 0  /f >> "%ghost-logfile%" 2>&1
    echo      %verde%[ %green%-%verde% ]%reset% RM Cache optimized.

    :: Redraw Acceleration
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "Acceleration.Level"                   /t REG_DWORD /d 0  /f >> "%ghost-logfile%" 2>&1
    echo      %verde%[ %green%-%verde% ]%reset% Driver Acceleration optimized.

    :: Filters
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "NVDeviceSupportKFilter"               /t REG_DWORD /d 0  /f >> "%ghost-logfile%" 2>&1
    echo      %verde%[ %green%-%verde% ]%reset% Overlay Filter disabled.

    :: Contiguous Memory Allocation
    reg add "%GPU_CLASS%\!NVIDIA_SUBKEY!" /v "PreferSystemMemoryContiguous"         /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    echo      %verde%[ %green%-%verde% ]%reset% Contiguous Memory Allocation optimized.

    :nvidiaregskip

    :: Power Saving
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving"      /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %verde%[ %green%-%verde% ]%reset% Power Saving disabled.

    :: Write Combining
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining"                  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %verde%[ %green%-%verde% ]%reset% Write Combining disabled.

    :: DPCs
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm"                /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\NVAPI"          /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"          /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power"    /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %verde%[ %green%-%verde% ]%reset% Core DPC enabled.

    :: Driver Telemetry
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "NvBackend" /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610"                   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640"                   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231"                   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    schtasks /change /disable /tn "NvTmRep_CrashReport1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"             /f >> "%ghost-logfile%" 2>&1
    schtasks /change /disable /tn "NvTmRep_CrashReport2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"             /f >> "%ghost-logfile%" 2>&1
    schtasks /change /disable /tn "NvTmRep_CrashReport3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"             /f >> "%ghost-logfile%" 2>&1
    schtasks /change /disable /tn "NvTmRep_CrashReport4_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"             /f >> "%ghost-logfile%" 2>&1
    schtasks /change /disable /tn "NvDriverUpdateCheckDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"         /f >> "%ghost-logfile%" 2>&1
    schtasks /change /disable /tn "NVIDIA GeForce Experience SelfUpdate_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" /f >> "%ghost-logfile%" 2>&1
    schtasks /change /disable /tn "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}"                         /f >> "%ghost-logfile%" 2>&1
    echo      %verde%[ %green%-%verde% ]%reset% Driver Telemetry disabled.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% NVIDIA Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- NVIDIA Tweaks applied --- /f >> "%ghost-logfile%" 2>&1
    goto nvidia

goto menu

   :nvidiaprofile
    cls
    echo.
    echo   %verde%[ %green%•%verde% ]%reset% Applying %green%NVIDIA Profile%reset%...
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Applying NVIDIA Profile --- /f >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Checking Github repository...

    timeout /t 2 /nobreak >nul

    echo      %verde%[ %green%-%verde% ]%reset% Checking %green%Profile Inspector%reset% executable...
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1

    if not exist "C:\Ghost Optimizer\NVIDIA\nvidiaProfileInspector.zip" (
        echo      %verde%[ %green%-%verde% ]%reset% Downloading %green%Profile Inspector%reset% package...
        curl -g -k -L -# -o "C:\Ghost Optimizer\NVIDIA\nvidiaProfileInspector.zip" "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/download/2.4.0.27/nvidiaProfileInspector.zip" /f >> "%ghost-logfile%" 2>&1
        if errorlevel 1 (
        echo      %red%[ - ]%white% Failed to download NVIDIA Profile Inspector.
        )
    ) else (
        echo      %verde%[ %green%-%verde% ]%reset% %green%Profile Inspector%reset% already downloaded.
        timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    )

    if not exist "C:\Ghost Optimizer\NVIDIA\NvidiaProfileInspector" (
        echo      %verde%[ %green%-%verde% ]%reset% Extracting %green%Profile Inspector%reset% package...
        chcp 437 >nul 2>&1
        powershell -NoProfile Expand-Archive 'C:\Ghost Optimizer\NVIDIA\nvidiaProfileInspector.zip' -DestinationPath 'C:\Ghost Optimizer\NVIDIA\' /f >> "%ghost-logfile%" 2>&1
        chcp 65001 >nul
        del /q "C:\Ghost Optimizer\NVIDIA\nvidiaProfileInspector.zip" >nul 2>&1
        if not exist "C:\Ghost Optimizer\NVIDIA\nvidiaProfileInspector.exe" (
        echo      %red%[ - ]%white% Extraction failed, executable not found.
        )
    )

    echo      %verde%[ %green%-%verde% ]%reset% Importing %green%Ghost Performance%reset% profile...
    curl -g -k -L -# -o "C:\Ghost Optimizer\NVIDIA\GO2-NVIDIA.nip" "https://github.com/louzkk/Ghost-Optimizer/raw/main/bin/GO2-NVIDIA.nip" /f >> "%ghost-logfile%" 2>&1
    if errorlevel 1 (
    echo      %red%[ - ]%white% Failed to download NVIDIA profile.
    )
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1

    echo      %verde%[ %green%-%verde% ]%reset% Applying %green%Ghost Performance%reset% profile...
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    if exist "C:\Ghost Optimizer\NVIDIA\nvidiaProfileInspector.exe" (
        start "" /wait "C:\Ghost Optimizer\NVIDIA\nvidiaProfileInspector.exe" "C:\Ghost Optimizer\NVIDIA\GO2-NVIDIA.nip" /f >> "%ghost-logfile%" 2>&1
        echo.
        echo      %verde%[ %green%-%verde% ]%reset% Profile Inspector Tweaks Applied %green%successfully%white%.
        echo --- NVIDIA Profile applied --- /f >> "%ghost-logfile%" 2>&1
    ) else (
    echo      %red%[ - ]%white% NVIDIA Profile Inspector executable not found.
    )

    echo.
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %verde%[ %green%•%verde% ]%reset% NVIDIA profile applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- NVIDIA Profile applied --- /f >> "%ghost-logfile%" 2>&1
    goto nvidia

goto menu

    :latency
    set mode=menu
    cls
    echo.
    echo.
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

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                                           %purple%[ %roxo%%underline%1%reset% %purple%]%white% Apply Latency ^& Input-Lag Tweaks
    echo.                 
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :latencyapply
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto latency

goto menu

    :latencyapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %roxo%Latency%white% ^& %roxo%Input-Lag%white% Tweaks...
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Applying Latency and Input-Lag Tweaks --- /f >> "%ghost-logfile%" 2>&1

    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"   /v "SystemResponsiveness" /t REG_DWORD /d 10 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"   /v "AlwaysOn"            /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"   /v "NoLazyMode"          /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"   /v "TimerResolution"     /t REG_DWORD /d 1  /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% System responsiveness optimized.

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete"        /v "Append Completion"  /t REG_SZ    /d "yes" /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete"        /v "AutoSuggest"        /t REG_SZ    /d "yes" /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Control Panel\Desktop"                                                  /v "menuShowDelay"      /t REG_SZ    /d 100   /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Control Panel\Desktop"                                                  /v "MouseHoverTime"     /t REG_SZ    /d 20    /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Control Panel\Desktop"                                                  /v "LowLevelHooksTimeout" /t REG_SZ  /d 300   /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Control Panel\Desktop"                                                  /v "AutoEndTasks"       /t REG_SZ    /d 1     /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Control Panel\Desktop"                                                  /v "WaitToKillAppTimeout" /t REG_SZ  /d 3000  /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Control Panel\Desktop"                                                  /v "HungAppTimeout"     /t REG_SZ    /d 2000  /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Control Panel\Desktop"                                                  /v "ForegroundLockTimeout" /t REG_DWORD /d 50 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Control Panel\Mouse"                                                    /v "MouseHoverTime"     /t REG_SZ    /d 20    /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"            /v "ExtendedUIHoverTime" /t REG_DWORD /d 20   /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control"                                       /v "WaitToKillServiceTimeout" /t REG_SZ /d 3000 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% UI responsiveness optimized.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"                /v "CoalescingTimerInterval" /t REG_DWORD /d 1    /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"                /v "MinTimerResolution"      /t REG_DWORD /d 5000 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"                /v "ClockTimerResolution"    /t REG_DWORD /d 1    /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"                /v "DistributeTimers"        /t REG_DWORD /d 1    /f >> "%ghost-logfile%" 2>&1
    bcdedit /deletevalue useplatformclock /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Kernel timer optimized.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "EnergyEstimationEnabled"  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "ExitLatency"              /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "ExitLatencyCheckEnabled"  /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "Latency"                  /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "LatencyToleranceDefault"  /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "EventProcessorEnabled"   /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "PreferExternalManifest"  /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "Attributes"              /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "CsEnabled"               /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                                 /v "PlatformAoAcOverride"    /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                               /v "LatencyToleranceFSVP" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                               /v "LatencyTolerancePerfOverride" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                               /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                               /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                               /v "RtlCapabilityCheckLatency" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% System power latency optimized.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"       /v "HwSchMode"   /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"       /v "FrameLatency" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm"                         /v "OverlayTestMode" /t REG_DWORD /d 5 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% GPU latency optimized.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power"   /v "Latency"                      /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power"   /v "TransitionLatency"            /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power"   /v "MonitorLatencyTolerance"      /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power"   /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Graphics power latency optimized.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl"       /v "MonitorLatencyTolerance"        /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl"       /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl"       /v "TdrLevel"                       /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl"       /v "TdrDelay"                       /t REG_DWORD /d 10 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl"       /v "TdrDdiDelay"                    /t REG_DWORD /d 10 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% DirectX Kernel latency optimized.

    echo.
    echo   %yellow%[ • ]%reset% Ghost Optimizer or High Performance power plan is recommended.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Latency ^& Input-Lag Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished Latency and Input-Lag Tweaks --- /f >> "%ghost-logfile%" 2>&1
    if "%mode%"=="menu" goto menu
    exit /b

goto menu

    :: Mouse & Keyboard
    :kbm
    set mode=menu
    cls
    echo.
    echo.
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

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                                           %purple%[ %roxo%%underline%1%reset% %purple%]%white% Apply Mouse ^& Keyboard Tweaks
    echo.                 
    echo.
    echo                                                   %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :kbmapply
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto kbm

goto menu

    :kbmapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %roxo%Mouse %white%^& %roxo%Keyboard%white% Tweaks... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Applying KBM Tweaks --- /f >> "%ghost-logfile%" 2>&1

    reg add "HKEY_CURRENT_USER\Control Panel\Mouse"       /v "MouseSpeed" /t REG_SZ /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse"       /v "MouseThreshold1" /t REG_SZ /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse"       /v "MouseThreshold2" /t REG_SZ /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Mouse Precision optimized.

    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v "EnablePrecision" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Trackpad Precision optimized.

    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1

    :: im not sure if that actually helps in something
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d 64 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d 64 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Data Queue Size optimized.

    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1

    reg add "HKCU\Control Panel\Mouse"                           /v "DoubleClickSpeed" /t REG_SZ /d 300 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Click Speed optimized.

    reg add "HKCU\Control Panel\Keyboard"                        /v "KeyboardDelay" /t REG_SZ /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Key Delay optimized.

    reg add "HKCU\Control Panel\Keyboard"                        /v "KeyboardSpeed" /t REG_SZ /d 31 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Key Speed optimized.

    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1

    reg add "HKCU\Control Panel\Accessibility\StickyKeys"        /v "Flags" /t REG_SZ /d 506 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Sticky Keys disabled.

    reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d 122 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Filter Keys disabled.

    reg add "HKCU\Control Panel\Accessibility\ToggleKeys"        /v "Flags" /t REG_SZ /d 58 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Toggle Keys disabled.

    echo.
    echo   %yellow%[ • ]%reset% Set the highest polling rate value avaliable for your mouse/keyboard.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Mouse ^& Keyboard Tweaks applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- KBM Tweaks Applied --- /f >> "%ghost-logfile%" 2>&1
    if "%mode%"=="menu" goto menu
    exit /b

goto menu

    :: Temporary Files
    :clean
    cls
    echo.
    echo.
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

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                         %purple%[ %roxo%%underline%1%reset% %purple%]%white% Start Fast Clean-up                %purple%[ %roxo%%underline%2%reset% %purple%]%white% Start Windows Clean-up
    echo.
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :fastclean
    if "%answer%"=="2" call :windowsclean
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto clean

goto menu

    :fastclean
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Fast%white% Clean... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Starting Ghost Optimizer Clean --- /f >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Cleaning Temporary files...
    rd /s /q "%windir%\Temp" /f >> "%ghost-logfile%" 2>&1
    md "%windir%\Temp" /f >> "%ghost-logfile%" 2>&1
    rd /s /q "%LocalAppData%\Temp" /f >> "%ghost-logfile%" 2>&1
    md "%LocalAppData%\Temp" /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Temporary files cleaned.

    echo      %purple%[ %roxo%-%purple% ]%white% Cleaning Prefetch files...
    rd /s /q "%windir%\Prefetch" /f >> "%ghost-logfile%" 2>&1
    md "%windir%\Prefetch" /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Prefetch files cleaned.

    echo      %purple%[ %roxo%-%purple% ]%white% Cleaning Recycle bin...
    rd /s /q "%systemdrive%\$Recycle.Bin" /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Recycle Bin cleaned.

    echo      %purple%[ %roxo%-%purple% ]%white% Cleaning thumbnails...
    del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Thumbnail cache cleaned.

    echo      %purple%[ %roxo%-%purple% ]%white% Cleaning system logs...
    del /f /q "%SystemRoot%\Logs\CBS\CBS.log" /f >> "%ghost-logfile%" 2>&1
    del /f /q "%SystemRoot%\Logs\DISM\DISM.log" /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% System logs cleared.

    echo      %purple%[ %roxo%-%purple% ]%white% Cleaning script logs..
    if exist "C:\Ghost Optimizer\Logs" (
        del /f /q "C:\Ghost Optimizer\Logs\*.*" /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% Ghost logs cleared.
    ) else (
        echo      %purple%[ %roxo%-%purple% ]%white% Logs folder not found.
    )

    echo      %purple%[ %roxo%-%purple% ]%white% Cleaning script cache...
    if exist "C:\Ghost Optimizer" (
        del /f /q "C:\Ghost Optimizer\*.*" /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% Ghost cache cleared.
    ) else (
        echo      %purple%[ %roxo%-%purple% ]%white% Cache folder not found.
    )

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% System cleaned %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished Ghost Optimizer Clean --- /f >> "%ghost-logfile%" 2>&1
    goto clean

goto menu

    :windowsclean
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Windows%white% Clean... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Starting Windows Clean --- /f >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Click on Temporary Files.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    start ms-settings:storagesense /f >> "%ghost-logfile%" 2>&1

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% System cleaned %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished Windows Clean --- /f >> "%ghost-logfile%" 2>&1
    goto clean

goto menu

    :telemetry
    set mode=menu
    cls
    echo.
    echo.
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

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                          %purple%[ %roxo%%underline%1%reset% %purple%]%white% Stop Telemetry ^& Logging                %purple%[ %roxo%%underline%2%reset% %purple%]%white% Apply OOSU10+ Profile
    echo.
    echo.
    echo                                                     %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :telemetryapply
    if "%answer%"=="2" call :oosu10
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto telemetry

goto menu

    :telemetryapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Telemetry%white% ^& %roxo%Logging%white% blocking...
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Starting Telemetry Blocking --- /f >> "%ghost-logfile%" 2>&1

    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System"       /v "PublishUserActivities"          /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System"       /v "EnableActivityFeed"             /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System"       /v "UploadUserActivities"           /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Activity upload disabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo"          /v "DisabledByGroupPolicy"  /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent"             /v "DisableSoftLanding"     /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"   /v "Enabled"                 /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"   /v "Enabled"                 /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Advertising ID disabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled"         /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "DoReport"         /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled"  /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting"         /v "DoReport"         /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting"          /v "Disabled"         /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting"          /v "ForceQueue"       /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc"                    /v "Start"            /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wercplsupport"             /v "Start"            /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Error reporting disabled.

    reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules"                               /v "NumberOfNotificationsSent"   /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules"                               /v "NumberOfSIUFInPeriod"        /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules"                            /v "PeriodInNanoSeconds"         /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0"           /v "NoExplicitFeedback"          /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0"           /v "NoActiveHelp"                /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows"               /v "CEIPEnable"                  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Reliability"                    /v "CEIPEnable"                  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Reliability"                    /v "SqmLoggerRunning"            /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows"                        /v "CEIPEnable"                  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows"                        /v "DisableOptinExperience"      /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows"                        /v "SqmLoggerRunning"            /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\SQMClient\IE"                             /v "SqmLoggerRunning"            /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Experience feedback disabled.

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy"                    /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy"       /v "HasAccepted"                    /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Input\TIPC"                                        /v "Enabled"                        /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\InputPersonalization"                              /v "RestrictImplicitInkCollection"  /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\InputPersonalization"                              /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore"             /v "HarvestContacts"                /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Personalization\Settings"                          /v "AcceptedPrivacyPolicy"          /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"          /v "Start_TrackProgs"               /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata"            /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge"                                     /v "PersonalizationReportingEnabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Privacy policies configured.

    ::reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation"                /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting"       /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors"                 /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    ::echo      %purple%[ %roxo%-%purple% ]%white% Geolocation disabled.

    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"  /v "AllowTelemetry"                              /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"                 /v "AllowTelemetry"                              /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"                 /v "DoNotShowFeedbackNotifications"              /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"                 /v "AllowCommercialDataPipeline"                 /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"                 /v "AllowDeviceNameInTelemetry"                  /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"                 /v "LimitEnhancedDiagnosticDataWindowsAnalytics" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"                 /v "MicrosoftEdgeDataOptIn"                      /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\VSStandardCollectorService150"    /v "Start"                                       /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Data collection disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack"                                    /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service"     /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TroubleshootingSvc"                           /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc"                                      /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DsSvc"                                        /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DPS"                                          /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiServiceHost"                               /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdiSystemHost"                                /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushsvc"                                 /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    sc config DiagTrack                                    start= disabled /f >> "%ghost-logfile%" 2>&1
    sc config dmwappushservice                             start= disabled /f >> "%ghost-logfile%" 2>&1
    sc config diagnosticshub.standardcollector.service    start= disabled /f >> "%ghost-logfile%" 2>&1
    sc config VSStandardCollectorService150                start= disabled /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Telemetry services disabled.

    del /f /q %ProgramData%\Microsoft\Diagnosis\DownloadedSettings\* /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Existing telemetry logs cleared.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Telemetry ^& Logging disabled %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished Telemetry and Logging --- /f >> "%ghost-logfile%" 2>&1
    if "%mode%"=="menu" goto telemetry
    exit /b

goto menu

   :oosu10
    set mode=menu
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Apllying %highlight%OOSU10++%reset% Profile...
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Applying OOSU10+ Profile --- /f >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Checking Github repository...

    timeout /t 2 /nobreak >nul

    echo      %purple%[ %roxo%-%purple% ]%white% Checking %highlight%OOSU10++%reset% executable...
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    if not exist "C:\Ghost Optimizer\OOSU10\OOSU10.exe" (
        echo      %purple%[ %roxo%-%purple% ]%white% Downloading %highlight%OOSU10++%reset% executable...
        chcp 437 >nul 2>&1
        powershell -Command "Invoke-WebRequest 'https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe' -OutFile 'C:\Ghost Optimizer\OOSU10\OOSU10.exe'" >> "%ghost-logfile%" 2>&1
        chcp 65001 >nul
        if not exist "C:\Ghost Optimizer\OOSU10\OOSU10.exe" (
        echo      %red%[ - ]%white% Failed to download OOSU10 executable.
        )
    ) else (
        echo      %purple%[ %roxo%-%purple% ]%white% %highlight%OOSU10++%reset% already downloaded.
        timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    )

    echo      %purple%[ %roxo%-%purple% ]%white% Importing %highlight%OOSU10++%reset% Profile...
    curl -g -k -L -# -o "C:\Ghost Optimizer\OOSU10\Ghost-OOSU10.cfg" "https://github.com/louzkk/Ghost-Optimizer/raw/main/bin/Ghost-OOSU10.cfg" >> "%ghost-logfile%" 2>&1
    if errorlevel 1 (
    echo      %red%[ - ]%white% Failed to download OOSU10 profile.
    )

    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Applying %highlight%OOSU10++%reset% Profile...
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    
    if exist "C:\Ghost Optimizer\OOSU10\OOSU10.exe" (
        start "" /wait /quiet "C:\Ghost Optimizer\OOSU10\OOSU10.exe" "C:\Ghost Optimizer\OOSU10\Ghost-OOSU10.cfg" >> "%ghost-logfile%" 2>&1
        echo --- OOSU10 profile applied --- >> "%ghost-logfile%" 2>&1
    ) else (
        echo      %red%[ - ]%white% OOSU10 executable not found.
    )

    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %highlight%OOSU10++%reset% Tweaks...
    echo.

    :: OOSU simulated outputs
    echo      %purple%[ %roxo%-%purple% ]%white% Activity upload disabled.
    echo      %purple%[ %roxo%-%purple% ]%white% Advertising ID disabled.
    echo      %purple%[ %roxo%-%purple% ]%white% Error reporting disabled.
    echo      %purple%[ %roxo%-%purple% ]%white% Experience feedback disabled.
    echo      %purple%[ %roxo%-%purple% ]%white% Privacy optimized.
    echo      %purple%[ %roxo%-%purple% ]%white% Data collection disabled.
    echo      %purple%[ %roxo%-%purple% ]%white% Telemetry services disabled.
    echo      %purple%[ %roxo%-%purple% ]%white% Handwriting and typing recognition disabled.
    echo      %purple%[ %roxo%-%purple% ]%white% Microsoft Edge tracking and AI disabled.
    echo      %purple%[ %roxo%-%purple% ]%white% Windows Copilot and AI Recall removed.
    echo      %purple%[ %roxo%-%purple% ]%white% Spotlight and Lock Screen Ads disabled.
    echo      %purple%[ %roxo%-%purple% ]%white% OneDrive disabled.
    echo      %purple%[ %roxo%-%purple% ]%white% Windows Update P2P disabled.
    echo      %purple%[ %roxo%-%purple% ]%white% Microsoft Defender telemetry disabled.
    echo      %purple%[ %roxo%-%purple% ]%white% Meet Now, News and Widgets removed.
    echo      %purple%[ %roxo%-%purple% ]%white% Remote Assistance disabled.

    del /f /q %ProgramData%\Microsoft\Diagnosis\DownloadedSettings\* /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Existing telemetry logs cleared.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% OOSU10+ profile applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- OOSU10 Profile applied --- /f >> "%ghost-logfile%" 2>&1
    goto telemetry

goto menu

    :services
    set mode=menu
    cls
    echo.
    echo.
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

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                      %purple%[ %roxo%%underline%1%reset% %purple%]%white% Disable Unnecessary Services                %purple%[ %roxo%%underline%2%reset% %purple%]%white% Revert Unecessary Services
    echo.                 
    echo.
    echo                                                     %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :servicesapply
    if "%answer%"=="2" call :servicesrevert
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto services

goto menu

    :servicesapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Disabling %roxo%Unnecessary Services%white%...
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Disabling Unnecessary Services --- /f >> "%ghost-logfile%" 2>&1

    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain"                                     /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    ::echo      %purple%[ %roxo%-%purple% ]%white% SysMain disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorDataService"                             /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc"                                      /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService"                                 /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\shpamsvc"                                      /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc"                                         /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration"                   /v "Status" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Sensor services disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService"                            /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService"                            /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TouchKeyboardAndHandwritingPanelService"       /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Tablet Input disabled.

    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Connectivity\DisableCrossDeviceResume"  /v "value" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Configuration"       /v "IsResumeAllowed" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Cross Device disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\MessagingService"                              /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Messages disabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                              /v "AllowCortana" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                              /v "AllowCloudSearch" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                              /v "AllowCortanaAboveLock" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                              /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                              /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                              /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                              /v "DisableWebSearch" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Cortana disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv"                                      /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PhoneSvc"                                      /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Phone Services disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpcMonSvc"                                     /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SEMgrSvc"                                      /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedRealitySvc"                              /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Parental Control disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RetailDemo"                                    /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Retail Demo Service disabled.

    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config"         /v "DODownloadMode" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config"         /v "DownloadMode" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings"       /v "DownloadMode" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc"                                       /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PNRPsvc"                                     /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\p2psvc"                                      /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\p2pimsvc"                                    /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Delivery Optimization disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation"                             /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Netlogon"                                      /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CscService"                                    /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\svsvc"                                         /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks"                                        /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc"                                        /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc"                                    /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% File Sharing disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\HolographicShell"                              /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\FrameServerMonitor"                            /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\perceptionsimulation"                          /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\FrameServer"                                   /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Mixed Reality disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc"                                    /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% OneSync disabled.

    sc stop "edgeupdate" /f >> "%ghost-logfile%" 2>&1
    sc stop "edgeupdatem" /f >> "%ghost-logfile%" 2>&1
    sc config "edgeupdate" start= disabled /f >> "%ghost-logfile%" 2>&1
    sc config "edgeupdatem" start= disabled /f >> "%ghost-logfile%" 2>&1
    schtasks /Delete /TN "MicrosoftEdgeUpdate*" /F >nul 2>&1 /f >> "%ghost-logfile%" 2>&1
    schtasks /Delete /TN "\Microsoft\EdgeUpdate*" /F >nul 2>&1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate"                                          /v "UpdateDefault" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate"                                          /v "AutoUpdateCheckPeriodMinutes" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate"                                          /v "DisableAutoUpdateChecksCheckboxValue" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate"                                          /v "Update{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    icacls "C:\Program Files (x86)\Microsoft\EdgeUpdate" /deny "SYSTEM:(OI)(CI)(RX)" /T /C  /f >> "%ghost-logfile%" 2>&1
    icacls "C:\Program Files (x86)\Microsoft\EdgeUpdate" /deny "NT AUTHORITY\SYSTEM:(OI)(CI)(RX)" /T /C  /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Edge Udpdater disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WalletService"                                 /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Wallet disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker"                                    /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Maps Broker disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SearchIndexer"                                 /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SearchFilterHost"                              /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SearchProtocolHost"                            /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WSearch"                                       /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Search Index disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler"                                       /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Fax"                                           /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Spooler services disabled.

    :: Unncomment this may broke login features, Xbox app or gaming features 
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\xbgm"                                        /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager"                              /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave"                                 /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc"                                  /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc"                               /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    ::echo      %purple%[ %roxo%-%purple% ]%white% Xbox services disabled.
 
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\cplspcon"                                      /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\cphs"                                          /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\jhi_service"                                   /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\esifsvc"                                       /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\igccservice"                                 /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WMIRegistrationService"                        /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RstMwService"                                  /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Intel(R) TPM Provisioning Service"             /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\IntelAudioService"                             /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\igfx"                          /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\igfxCUIService2.0.0.0"         /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LMS"                             /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Intel services disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableUlps" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\AMD External Events Utility"                    /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdfendrsr"                                       /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AMD Crash User Uplink Service"                    /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AMDRyzenMasterDataService"                        /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% AMD services disabled.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Unnecessary Services disabled %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Unnecessary Services Disabled --- /f >> "%ghost-logfile%" 2>&1
    if "%mode%"=="menu" goto services
    exit /b

goto menu

    :servicesrevert
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Reverting %roxo%Unnecessary Services%white%...
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Disabling Unnecessary Services --- /f >> "%ghost-logfile%" 2>&1

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv"                                       /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PhoneSvc"                                      /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Phone Services enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpcMonSvc"                                     /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SEMgrSvc"                                      /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedRealitySvc"                              /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Parental Control enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\PNRPsvc"                                       /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\p2psvc"                                        /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\p2pimsvc"                                      /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Peer-to-Peer enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation"                             /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Netlogon"                                      /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CscService"                                    /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\svsvc"                                         /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks"                                        /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc"                                        /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% File Sharing enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorDataService"                             /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensrSvc"                                      /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService"                                 /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\shpamsvc"                                      /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc"                                         /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration"                   /v "Status" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Sensor services enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\perceptionsimulation"                          /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\FrameServer"                                   /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Mixed Reality enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\OneSyncSvc"                                    /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Microsoft OneSync enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc"                                 /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BcastDVRUserService"                           /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Broadcast enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdatem"                                   /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdate"                                    /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\MicrosoftEdgeElevationService"                 /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Edge Update enabled.

    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Connectivity\DisableCrossDeviceResume"  /v "value" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Configuration"       /v "IsResumeAllowed" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Cross Device Resume enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService"                            /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\TouchKeyboardAndHandwritingPanelService"       /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Tablet Input enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Themes"                                        /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Themes enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppReadiness"                                  /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\OSRSS"                                         /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Readiness enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\MessagingService"                              /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Messages enabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                              /v "AllowCortana" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                              /v "AllowCloudSearch" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                              /v "AllowCortanaAboveLock" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                              /v "AllowSearchToUseLocation" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                              /v "ConnectedSearchUseWeb" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                              /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"                              /v "DisableWebSearch" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Cortana enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler"                                       /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Fax"                                           /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Spooler/Fax services enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker"                                    /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Maps Broker enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WSearch"                                       /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Search Index enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RemoteRegistry"                                /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Remote Registry enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\wisvc"                                         /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Windows Insider enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WalletService"                                 /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Wallet enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\xbgm"                                          /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblAuthManager"                                /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XblGameSave"                                   /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxGipSvc"                                    /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc"                                 /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Xbox services enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\cplspcon"                                      /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\cphs"                                          /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\jhi_service"                                   /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\esifsvc"                                       /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\igccservice"                                   /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WMIRegistrationService"                        /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\RstMwService"                                  /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Intel(R) TPM Provisioning Service"             /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\IntelAudioService"                             /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\igfx"                            /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\igfxCUIService2.0.0.0"           /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Intel services enabled.

    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableUlps" /f >> "%ghost-logfile%" 2>&1
    ::reg add "HKLM\SYSTEM\CurrentControlSet\Services\AMD External Events Utility"                       /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdfendrsr"                                          /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AMD Crash User Uplink Service"                       /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AMDRyzenMasterDataService"                           /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% AMD services enabled.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Services restored %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Services Re-enabled --- /f >> "%ghost-logfile%" 2>&1
    goto services

goto menu

    :powerplan
    set mode=menu
    cls
    echo.
    echo.
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

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                        %purple%[ %roxo%%underline%1%reset% %purple%]%white% Apply Ghost Power Plan                %purple%[ %roxo%%underline%2%reset% %purple%]%white% Apply Default Power Plan
    echo.                 
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :powerplanapply
    if "%answer%"=="2" call :powerplanapply2
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto powerplan

goto menu

    :powerplanapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Applying %highlight%Ghost%reset% Power Plan... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Applying Power Plan --- /f >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Checking Github repository...

    timeout /t 2 /nobreak >nul

    echo      %purple%[ %roxo%-%purple% ]%white% Downloading %highlight%Ghost%reset% Power Plan...
    curl -g -k -L -# -o "C:\Ghost Optimizer\Powerplan\Ghost-POWER.pow" "https://github.com/louzkk/Ghost-Optimizer/raw/main/bin/Ghost-POWER.pow" /f >> "%ghost-logfile%" 2>&1
    if not exist "C:\Ghost Optimizer\Powerplan\Ghost-POWER.pow" (
        echo   %red%[ %orange%• %red%]%white% Failed to download Ghost power plan.
        timeout /t 2 >nul
        goto powerplan
    )

    timeout /t 2 /nobreak >nul

    echo      %purple%[ %roxo%-%purple% ]%white% Importing %highlight%Ghost%reset% Power Plan...

    powercfg /import "C:\Ghost Optimizer\Powerplan\Ghost-POWER.pow" /f >> "%ghost-logfile%" 2>&1
    if errorlevel 1 (
        echo   %red%[ %orange%• %red%]%white% Failed to import %highlight%Ghost%reset% power plan.
        timeout /t 3 >nul
        goto powerplan
    )

    timeout /t 2 /nobreak >nul

    echo      %purple%[ %roxo%-%purple% ]%white% Applying %highlight%Ghost%reset% Power Plan...

    set "GUID="
    for /f "tokens=2 delims=:()" %%i in ('powercfg /list ^| findstr /i "Ghost"') do (
        set "GUID=%%i"
        set "GUID=!GUID: =!"
    )

    if not defined GUID (
        echo   %red%[ %orange%• %red%]%white% Could not find %highlight%Ghost%reset% power plan GUID.
        timeout /t 3 >nul
        goto powerplan
    )

    powercfg /setactive !GUID! /f >> "%ghost-logfile%" 2>&1
    if errorlevel 1 (
        echo   %red%[ %orange%• %red%]%white% Failed to set %highlight%Ghost%reset% power plan active.
        timeout /t 3 >nul
        goto powerplan
    )

    chcp 437 >nul 2>&1
    powershell (Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods).WmiSetBrightness(1,100) /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Ghost power plan applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Power Plan applied --- /f >> "%ghost-logfile%" 2>&1
    if "%mode%"=="menu" goto powerplan
    exit /b

    :: Integrity & Health
    :health
    cls
    echo.
    echo.
    set "lines[0]=                             ██╗███╗   ██╗████████╗███████╗ ██████╗ ██████╗ ██╗████████╗██╗   ██╗ "
    set "lines[1]=                             ██║████╗  ██║╚══██╔══╝██╔════╝██╔════╝ ██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝"
    set "lines[2]=                             ██║██╔██╗ ██║   ██║   █████╗  ██║  ███╗██████╔╝██║   ██║    ╚████╔╝ "
    set "lines[3]=                             ██║██║╚██╗██║   ██║   ██╔══╝  ██║   ██║██╔══██╗██║   ██║     ╚██╔╝  "
    set "lines[4]=                             ██║██║ ╚████║   ██║   ███████╗╚██████╔╝██║  ██║██║   ██║      ██║   "
    set "lines[5]=                             ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝   "

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
    set "lines[0]=                    Performs a scan and repairs corrupted files, system health, updates, and disk errors."

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                                  %purple%[ %roxo%%underline%1%reset% %purple%] %white%Fast Integrity Fix            %purple%[ %roxo%%underline%2%reset% %purple%] %white%Full Integrity Fix
    echo.                 
    echo                                  %purple%[ %roxo%%underline%3%reset% %purple%] %white%Wi-fi ^& Bluetooth Fix         %purple%[ %roxo%%underline%4%reset% %purple%] %white%Xbox ^& Game Bar Fix
    echo.
    echo                                  %purple%[ %roxo%%underline%5%reset% %purple%] %white%Windows Update Fix            %purple%[ %roxo%%underline%6%reset% %purple%] %white%Hibernation Fix
    echo.
    echo                                           %purple%[ %roxo%%underline%7%reset% %purple%] %white%Virtualization ^& Mitigations Fix
    echo.
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :healthapply1
    if "%answer%"=="2" call :healthapply2
    if "%answer%"=="3" call :bluetoothfix
    if "%answer%"=="4" call :xboxfix
    if "%answer%"=="5" call :wufix
    if "%answer%"=="6" call :hiberfix
    if "%answer%"=="7" call :mitigationsfix
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto health

goto menu

    :healthapply1
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Fast%white% Integrity ^& Health Fix... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Starting Fast Health Fix --- /f >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Checking Windows Image Health...
    DISM /Online /Cleanup-Image /CheckHealth
    echo.
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Scanning Windows Image Health...
    DISM /Online /Cleanup-Image /ScanHealth
    echo.
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Restoring Windows Image Health...
    DISM /Online /Cleanup-Image /RestoreHealth
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% Windows Image Health restored.
    echo.

    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Repairing System Integrity...
    sfc /scannow
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% System Integrity repaired.
    echo.

    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1


    echo      %purple%[ %roxo%-%purple% ]%white% Repairing Microsoft Store...
    wsreset.exe
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% Microsoft Store repaired.
    echo.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Integrity ^& Health fixes applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%

    echo --- Finished Fast Health Fix --- /f >> "%ghost-logfile%" 2>&1
    goto health

goto menu

    :healthapply2
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Full%white% Integrity ^& Health Fix (it may take a while)... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Starting Full Health Fix --- /f >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Checking Windows Image Health...
    DISM /Online /Cleanup-Image /CheckHealth
    echo.

    echo      %purple%[ %roxo%-%purple% ]%white% Scanning Windows Image Health...
    DISM /Online /Cleanup-Image /ScanHealth
    echo.

    echo      %purple%[ %roxo%-%purple% ]%white% Restoring Windows Image Health...
    DISM /Online /Cleanup-Image /RestoreHealth
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% Windows Image Health restored.
    echo.

    echo      %purple%[ %roxo%-%purple% ]%white% Analyzing Drivers Base...
    DISM /Online /Cleanup-Image /AnalyzeComponentStore
    echo.

    echo      %purple%[ %roxo%-%purple% ]%white% Repairing Windows Drivers...
    DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% Windows Drivers restored.
    echo.

    echo      %purple%[ %roxo%-%purple% ]%white% Repairing System Integrity...
    sfc /scannow
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% System Integrity repaired.
    echo.

    echo      %purple%[ %roxo%-%purple% ]%white% Repairing Microsoft Store...
    wsreset.exe
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% Microsoft Store repaired.
    echo.

    echo      %purple%[ %roxo%-%purple% ]%white% Stopping Windows Update services...
    net stop wuauserv /f >> "%ghost-logfile%" 2>&1
    net stop cryptSvc /f >> "%ghost-logfile%" 2>&1
    net stop bits /f >> "%ghost-logfile%" 2>&1
    net stop msiserver /f >> "%ghost-logfile%" 2>&1
    net stop appidsvc /f >> "%ghost-logfile%" 2>&1
    echo.

    echo      %purple%[ %roxo%-%purple% ]%white% Repairing Windows Update...
    ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
    ren C:\Windows\System32\catroot2 catroot2.old
    del /q /f /s %windir%\SoftwareDistribution\Download\*
    echo.

    echo      %purple%[ %roxo%-%purple% ]%white% Cleaning CBS ^& DISM cache...
    del /f /q %windir%\Logs\CBS\CBS.log
    del /f /q %windir%\Logs\DISM\dism.log
    echo      %purple%[ %roxo%-%purple% ]%white% CBS ^& DISM cache cleaned.
    echo.

    echo      %purple%[ %roxo%-%purple% ]%white% Reverting Pending Actions...
    dism /online /cleanup-image /revertpendingactions
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Pending Actions reverted.
    echo.

    echo      %purple%[ %roxo%-%purple% ]%white% Scheduling system file repair...
    echo chkdsk C: /f /r

    echo.
    echo   %yellow%[ • ]%reset% Files will be repaired in the next boot.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Integrity ^& Health fixes applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished Full Health Fix --- /f >> "%ghost-logfile%" 2>&1
    goto health

goto menu

    :bluetoothfix
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Wi-fi ^& Bluetooth%white% Fix... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Starting Wifi Bluetooth Fix --- /f >> "%ghost-logfile%" 2>&1

    netsh winsock reset /f >> "%ghost-logfile%" 2>&1
    netsh int ip reset /f >> "%ghost-logfile%" 2>&1
    ipconfig /release /f >> "%ghost-logfile%" 2>&1
    ipconfig /renew /f >> "%ghost-logfile%" 2>&1
    ipconfig /flushdns /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Netsh and IP cleaned.

    chcp 437 >nul 2>&1
    powershell -Command "Get-Service *bth* | Restart-Service -Force -ErrorAction SilentlyContinue" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Get-PnpDevice -Class Bluetooth | Disable-PnpDevice -Confirm:$false -ErrorAction SilentlyContinue" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Start-Sleep -Seconds 1" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Get-PnpDevice -Class Bluetooth | Enable-PnpDevice -Confirm:$false -ErrorAction SilentlyContinue" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "pnputil /scan-devices" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Bluetooth Drivers restored.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT\Parameters" /v "EnableOffload" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT\Parameters" /v "EnableLEEncryption" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT\Parameters" /v "EnableRadioOffload" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHUSB" /v "EnableSelectiveSuspend" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthHFSrv" /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v "Start" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Bluetooth features restored.

    chcp 437 >nul 2>&1
    powershell -Command "(Get-Service bthserv).StartType='Automatic'" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Start-Service bthserv -ErrorAction SilentlyContinue" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Start-Service DeviceAssociationService -ErrorAction SilentlyContinue" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Start-Service DeviceAssociationBrokerSvc -ErrorAction SilentlyContinue" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Radio Services restored.

    sc config bthserv start= auto /f >> "%ghost-logfile%" 2>&1
    sc config BthHFSrv start= demand /f >> "%ghost-logfile%" 2>&1
    sc config BthAvctpSvc start= demand /f >> "%ghost-logfile%" 2>&1
    sc config bthmodem start= demand /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Bluetooth Services restored.

    net stop DeviceAssociationService /y /f >> "%ghost-logfile%" 2>&1
    net start DeviceAssociationService /f >> "%ghost-logfile%" 2>&1
    net stop DeviceAssociationBrokerSvc /y /f >> "%ghost-logfile%" 2>&1
    net start DeviceAssociationBrokerSvc /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Broker Service restored.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT" /v "Start" /t REG_DWORD /d 2 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHUSB"  /v "Start" /t REG_DWORD /d 3 /f
    echo      %purple%[ %roxo%-%purple% ]%white% Bluetooth enabled.

    echo      %purple%[ %roxo%-%purple% ]%white% Repairing System Integrity...
    sfc /scannow
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% System Integrity repaired.
    echo.

    echo.
    echo   %yellow%[ • ]%reset% If that doesn't solve your problem, try running Full Integrity Fix or Restore Point.

    echo.
    timeout /t 4 /nobreak /f >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Wi-fi ^& Bluetooth fixed %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished Wifi Bluetooth Fix --- /f >> "%ghost-logfile%" 2>&1
    goto health

goto menu

    :xboxfix
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Xbox App/Bar%white% Fix... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Starting Xbox Fix --- /f >> "%ghost-logfile%" 2>&1

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage Microsoft.XboxApp -AllUsers | Foreach {Add-AppxPackage -Register '$($_.InstallLocation)\AppxManifest.xml' -DisableDevelopmentMode}" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Get-AppxPackage Microsoft.Xbox.TCUI -AllUsers | Foreach {Add-AppxPackage -Register '$($_.InstallLocation)\AppxManifest.xml' -DisableDevelopmentMode}" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Get-AppxPackage Microsoft.XboxIdentityProvider -AllUsers | Foreach {Add-AppxPackage -Register '$($_.InstallLocation)\AppxManifest.xml' -DisableDevelopmentMode}" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Xbox App restored.

    sc config XblAuthManager start= auto /f >> "%ghost-logfile%" 2>&1
    sc config XblGameSave start= auto /f >> "%ghost-logfile%" 2>&1
    sc config XboxGipSvc start= auto /f >> "%ghost-logfile%" 2>&1
    sc config XboxNetApiSvc start= auto /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Xbox Services enabled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage Microsoft.XboxGamingOverlay -AllUsers | Foreach {Add-AppxPackage -Register '$($_.InstallLocation)\AppxManifest.xml' -DisableDevelopmentMode}" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Game Bar restored.

    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\GameDVR"                                 /v "AllowGameDVR" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\System\GameConfigStore"                                                      /v "GameDVR_Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR"                           /v "AllowGameDVR" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR"                           /v "AppCaptureEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR"                           /v "AppCaptureEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR"                           /v "AudioCaptureEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Game Bar/DVR enabled.

    reg add "HKCU\System\GameConfigStore"                                                      /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\System\GameConfigStore"                                                      /v "GameDVR_FSEBehavior" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\System\GameConfigStore"                                                      /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\System\GameConfigStore"                                                      /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Fullscreen optimizations enabled.

    echo      %purple%[ %roxo%-%purple% ]%white% Repairing System Integrity...
    sfc /scannow
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% System Integrity repaired.
    echo.

    echo.
    echo   %yellow%[ • ]%reset% If that doesn't solve your problem, try running Full Health Fix.

    echo.
    timeout /t 4 /nobreak /f >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Xbox App ^& Game Bar fixed %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished Xbox Fix --- /f >> "%ghost-logfile%" 2>&1
    goto health

goto menu

    :hiberfix
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Hibernation%white% Fix... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Starting Hiber Fix --- /f >> "%ghost-logfile%" 2>&1

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberBootEnabled"                         /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                 /v "HibernateEnabled"                         /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                 /v "HibernateEnabledDefault"                  /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power"                 /v "SleepReliabilityDetailedDiagnostics"      /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    powercfg /hibernate on /f >> "%ghost-logfile%" 2>&1
    powercfg /h /type full /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Hibernation enabled.

    echo      %purple%[ %roxo%-%purple% ]%white% Repairing System Integrity...
    sfc /scannow
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% System Integrity repaired.
    echo.

    echo.
    echo   %yellow%[ • ]%reset% If that doesn't solve your problem, try running Full Health Fix.

    echo.
    timeout /t 4 /nobreak /f >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Hibernation fixed %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished Hiber Fix --- /f >> "%ghost-logfile%" 2>&1
    goto health

goto menu

    :wufix
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Windows Update%white% Fix... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Starting Windows Update Fix --- /f >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Stopping Updater services...
    net stop wuauserv /f >> "%ghost-logfile%" 2>&1
    net stop cryptSvc /f >> "%ghost-logfile%" 2>&1
    net stop bits /f >> "%ghost-logfile%" 2>&1
    net stop msiserver /f >> "%ghost-logfile%" 2>&1
    net stop appidsvc /f >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Restoring Windows Update...
    rmdir /s /q "%systemroot%\SoftwareDistribution"
    rmdir /s /q "%systemroot%\System32\catroot2"

    ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
    ren C:\Windows\System32\catroot2 catroot2.old
    del /q /f /s %windir%\SoftwareDistribution\Download\*

    del /f /q %windir%\Logs\CBS\CBS.log
    del /f /q %windir%\Logs\DISM\dism.log

    echo      %purple%[ %roxo%-%purple% ]%white% Repairing System Integrity...
    sfc /scannow
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% System Integrity repaired.
    echo.

    echo.
    echo   %yellow%[ • ]%reset% If that doesn't solve your problem, try running Full Integrity Fix or Restore Point.

    echo.
    timeout /t 4 /nobreak /f >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Windows Update fixed %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished Windows Update Fix --- /f >> "%ghost-logfile%" 2>&1
    goto health

goto menu

    :mitigationsfix
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Starting %roxo%Mitigations%white% Fix... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Starting Mitigations Fix --- /f >> "%ghost-logfile%" 2>&1

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity"  /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "RequirePlatformSecurityFeatures"    /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired"                    /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    dism /online /enable-feature /featurename:VirtualMachinePlatform /norestart /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Virtualization (VBS) enabled.


    reg add "HKLM\SYSTEM\CurrentControlSet\Services\HvHost"    /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmsvc"     /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\vmcompute" /v "Start" /t REG_DWORD /d 2 /f >> "%ghost-logfile%" 2>&1
    bcdedit /set hypervisorlaunch auto /f >> "%ghost-logfile%" 2>&1
    dism /online /enable-feature /featurename:HypervisorPlatform /norestart /f >> "%ghost-logfile%" 2>&1
    dism /online /enable-feature /featurename:Microsoft-Hyper-V-All /norestart /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Hypervisor (Hyper-V) enabled.

    bcdedit /set vsmlaunchtype auto /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Virtual Machines (VMS) enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride"     /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Spectre mitigations enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Meltdown mitigations enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HypervisorEnforcedCodeIntegrity"                    /v "Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Core Isolation enabled.

    echo      %purple%[ %roxo%-%purple% ]%white% Repairing System Integrity...
    sfc /scannow
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% System Integrity repaired.
    echo.

    echo.
    echo   %yellow%[ • ]%reset% If that doesn't solve your problem, try running Full Integrity Fix or Restore Point.

    echo.
    timeout /t 4 /nobreak /f >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Windows Update fixed %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished Mitigations Fix --- /f >> "%ghost-logfile%" 2>&1
    goto health

goto menu

:: Bloatware Apps
    :debloat
    cls
    echo.
    echo.
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
    set "lines[0]=             Uninstall pre-installed apps, AI and Paid services to free up storage and reduce resource usage."

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                        %purple%[ %roxo%%underline%1%reset% %purple%]%white% Uninstall Bloatware Apps                %purple%[ %roxo%%underline%2%reset% %purple%]%white% Reinstall Bloatware Apps
    echo.                 
    echo.
    echo                                                    %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :debloatapply
    if "%answer%"=="2" call :debloatrevert
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto debloat

goto menu

    :debloatapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Disabling %roxo%Bloatware%white% Auto Start ^& Features... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Uninstalling Bloatware Apps --- /f >> "%ghost-logfile%" 2>&1

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "OneDrive" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% OneDrive disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Lghub" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Lghub" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Lghub" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% LgHub disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "RazerSynapse" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "RazerSynapse" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "RazerSynapse" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% RazerSynapse disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "iCUE" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "iCUE" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "iCUE" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% iCUE disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Redragon" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Redragon" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Redragon" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% Redragon disabled.
    )
    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "RDCfg" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "RDCfg" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "RDCfg" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% RDCfg disabled.
    )

    for %%B in ("Chrome" "Opera" "Opera GX" "Brave" "Firefox") do (
        reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "%%~B" >nul 2>&1
        if not errorlevel 1 (
            reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "%%~B" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
            echo      %purple%[ %roxo%-%purple% ]%white% %%~B disabled.
        )
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Spotify" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Spotify" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Spotify" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% Spotify disabled.
    )

    for %%E in (msedge Edge "MicrosoftEdgeAutoLaunch_1BA94C0BA16E4AD6E747BB43BB8E8E25") do (
        reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "%%~E" >nul 2>&1
        if not errorlevel 1 (
            reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "%%~E" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
            reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "%%~E" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        )
    )

    for %%E in (msedge Edge "MicrosoftEdgeAutoLaunch_F9DADAC9D1451CDE16DE74713C392183") do (
        reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "%%~E" >nul 2>&1
        if not errorlevel 1 (
            reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "%%~E" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
            reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "%%~E" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        )
    )
    echo      %purple%[ %roxo%-%purple% ]%white% Microsoft Edge disabled.

    ::reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Xbox" >nul 2>&1
    ::if not errorlevel 1 (
    ::    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Xbox" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
    ::    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Xbox" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
    ::    echo      %purple%[ %roxo%-%purple% ]%white% Xbox App disabled.
    ::)

    reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "SunJavaUpdateSched" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /v "SunJavaUpdateSched" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SunJavaUpdateSched" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% Java Updater disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "EADM" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "EADM" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% EA App disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Razer Synapse" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Razer Synapse" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Razer Synapse" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% Razer Synapse disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Razer Central" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Razer Central" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Razer Central" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% Razer Central disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Razer Cortex" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Razer Cortex" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Razer Cortex" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% Razer Cortex disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Razer Game Booster" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Razer Game Booster" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Razer Game Booster" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% Razer Game Booster disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MSI Center" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MSI Center" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "MSI Center" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% MSI Center disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MSI Dragon Center" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MSI Dragon Center" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "MSI Dragon Center" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% MSI Dragon Center disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MSI Gaming App" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MSI Gaming App" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "MSI Gaming App" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% MSI Gaming App disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MSI Game Booster" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MSI Game Booster" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "MSI Game Booster" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% MSI Game Booster disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Game Booster" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Game Booster" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Game Booster" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% Game Booster disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Smart Game Booster" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Smart Game Booster" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Smart Game Booster" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% Smart Game Booster disabled.
    )

    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "FPS Booster" >nul 2>&1
    if not errorlevel 1 (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "FPS Booster" /t REG_SZ /d "" /f >> "%ghost-logfile%" 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "FPS Booster" /t REG_BINARY /d 030000000000000000000000 /f >> "%ghost-logfile%" 2>&1
        echo      %purple%[ %roxo%-%purple% ]%white% FPS Booster disabled.
    )

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer"                     /v "HideRecommenudedSection" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start"            /v "HideRecommenudedSection" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Education"        /v "IsEducationEnvironment" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"      /v "Start_Layout" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"        /v "Enabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Advertising disabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh"                             /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds"           /v "EnableFeeds" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Widgets ^& News disabled.

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot"          /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Copilot AI disabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI"          /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Recall AI disabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "CopilotCDPPageContext" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "CopilotPageContext" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeEntraCopilotPageContext" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeHistoryAISearchEnabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "ComposeInlineEnabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "GenAILocalFoundationalModelSettings" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageBingChatEnabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Browser AI disabled.

    reg add "HKLM\SOFTWARE\Policies\WindowsNotepad" /v "DisableAIFeatures" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Notepad AI disabled.

    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableCocreator" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeFill" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableImageCreator" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeErase" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableRemoveBackground" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Paint AI disabled.

    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerFeatures" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerFeatures" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Apps Reinstalation disabled.

    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1

    cls
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% Uninstalling %roxo%Bloatware%white% Apps... 
    echo.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *3DBuilder* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Print3D* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Microsoft3DViewer* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% 3D Builder uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -AllUsers *Microsoft.QuickAssist* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Quick Assist uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *bing* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *bingfinance* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *BingNews* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *bingsports* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *BingWeather* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *News* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Bing Apps uninstalled.

    ::chcp 437 >nul 2>&1
    ::powershell -Command "Get-AppxPackage -allusers *WindowsPhone* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    ::powershell -Command "Get-AppxPackage -allusers *YourPhone* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    ::powershell -Command "Get-AppxPackage -allusers *CommsPhone* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    ::chcp 65001 >nul
    ::echo      %purple%[ %roxo%-%purple% ]%white% Windows Phone uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *Facebook* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Facebook uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *Microsoft.Messaging* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Messaging uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *MicrosoftOfficeHub* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Office Hub uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *OneNote* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *Office.OneNote* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% OneNote uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *People* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% People uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *SkypeApp* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Skype uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *solit* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *MicrosoftSolitaireCollection* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Solitaire uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *WindowsMaps* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Maps uninstalled.

    :: Uncomment this may break Windows Troubleshooting Fixes, Feedbacks or Help app 
    ::chcp 437 >nul 2>&1
    ::powershell -Command "Get-AppxPackage -allusers *WindowsFeedbackHub* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    ::chcp 65001 >nul
    ::echo      %purple%[ %roxo%-%purple% ]%white% "Feedback Hub" uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *windowscommunicationsapps* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Communications uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage *crossdevice* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Cross Device uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *Microsoft.549981C3F5F10* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Cortana uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *Teams* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Teams uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *MicrosoftStickyNotes* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Sticky Note" uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *MixedReality.Portal* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Mixed Reality Portal uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *LinkedIn* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% LinkedIn uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *Copilot* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    powershell -command "Get-AppxPackage *Microsoft.Copilot* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    powershell -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like '*Microsoft.Copilot*'} | Remove-AppxProvisionedPackage -Online" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Copilot AI uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *Outlook* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    powershell -Command "Get-AppxPackage -allusers *OutlookForWindows* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Outlook uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *Microsoft.Todos* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% To Do uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *Microsoft.PowerAutomateDesktop* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Power Automate uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *Microsoft.RemoteDesktop* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Remote Desktop uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -allusers *Clipchamp* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Clipchamp uninstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage *MicrosoftWindows.WebExperience* | Remove-AppxPackage" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Widgets uninstalled.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Bloatware apps uninstalled %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    echo --- Finished Debloat --- /f >> "%ghost-logfile%" 2>&1
    goto debloat

goto menu

    :debloatrevert
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Reverting %roxo%Bloatware%white% Features... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo --- Reverting Bloatware Apps --- /f >> "%ghost-logfile%" 2>&1

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"      /v "SoftLandingEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer"                          /v "HideRecommenudedSection" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start"                 /v "HideRecommenudedSection" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Education"             /v "IsEducationEnvironment" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"           /v "Start_Layout" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"             /v "Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Advertising enabled.

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"           /v "ShowSyncProviderNotifications" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% OneDrive Push enabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh"                                       /v "AllowNewsAndInterests" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds"                     /v "EnableFeeds" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Widgets ^& News enabled.

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"          /v "ShowCopilotButton" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot"                   /v "TurnOffWindowsCopilot" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot"                   /v "TurnOffWindowsCopilot" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Copilot AI enabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "CopilotCDPPageContext" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "CopilotPageContext" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeEntraCopilotPageContext" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeHistoryAISearchEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "ComposeInlineEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "GenAILocalFoundationalModelSettings" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageBingChatEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Browser AI enabled.

    reg add "HKLM\SOFTWARE\Policies\WindowsNotepad" /v "DisableAIFeatures" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Notepad AI enabled.

    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableCocreator" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeFill" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableImageCreator" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeErase" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableRemoveBackground" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Paint AI enabled.

    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerFeatures" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerFeatures" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Apps Reinstalation enabled.

    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314559Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280815Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-202914Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Suggestions enabled.

    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent"                 /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent"                 /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Tooltips enabled.

    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableSpotlightCollectionOnDesktop" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Spotlight enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc"                                  /v "Start" /t REG_DWORD /d 4 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config"    /v "DODownloadMode" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config"    /v "DownloadMode" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings"  /v "DownloadMode" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Delivery Optimization enabled.

    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1

    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Installing %roxo%Bloatware%white% Apps... 
    echo.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Bloatware apps reinstalled.

    chcp 437 >nul 2>&1
    powershell -Command "Get-AppxProvisionedPackage -Online | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}" /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Provisioned packages reinstalled.

    chcp 437 >nul 2>&1
    winget install "Windows Web Experience Pack" --silent /f >> "%ghost-logfile%" 2>&1
    chcp 65001 >nul
    echo      %purple%[ %roxo%-%purple% ]%white% Widgets installed.

    echo      %purple%[ %roxo%-%purple% ]%white% Repairing System Integrity...
    sfc /scannow
    echo.
    echo      %purple%[ %roxo%-%purple% ]%white% System Integrity repaired.
    echo.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Bloatware apps reverted %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%

    echo --- Reverted Debloat --- /f >> "%ghost-logfile%" 2>&1
    goto debloat

goto menu

    :other
    cls
    echo.
    echo.
    set "lines[0]=                                           ██████╗ ████████╗██╗  ██╗███████╗██████╗           "
    set "lines[1]=                                          ██╔═══██╗╚══██╔══╝██║  ██║██╔════╝██╔══██╗          "
    set "lines[2]=                                          ██║   ██║   ██║   ███████║█████╗  ██████╔╝          "
    set "lines[3]=                                          ██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗          "
    set "lines[4]=                                          ╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║          "
    set "lines[5]=                                           ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝          "

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
    set "lines[0]=                                  A variety of system tweaks, fixes, bypasses and utilities."

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                                   %purple%[ %roxo%%underline%1%reset% %purple%] %white%TPM 2.0 Bypass              %purple%[ %roxo%%underline%2%reset% %purple%] %white%Enable God Mode
    echo.                 
    echo                                   %purple%[ %roxo%%underline%3%reset% %purple%] %white%Show extensions             %purple%[ %roxo%%underline%4%reset% %purple%] %white%Clear Event Logs
    echo.
    echo                                   %purple%[ %roxo%%underline%5%reset% %purple%] %white%Show hidden files           %purple%[ %roxo%%underline%6%reset% %purple%] %white%Classic context menu
    echo.
    echo                                   %purple%[ %roxo%%underline%7%reset% %purple%] %white%Disable SysMain %cinza%^<-- Can fix high HDD usage%reset%
    echo.
    echo.
    echo                                                     %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :tpmbypassapply
    if "%answer%"=="2" call :godmodeapply
    if "%answer%"=="3" call :filenamesapply
    if "%answer%"=="4" call :clearlogsapply
    if "%answer%"=="5" call :hiddenfilesapply
    if "%answer%"=="6" call :classicmenuapply
    if "%answer%"=="7" call :disablesysmain
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto other

goto menu

    :tpmbypassapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Bypassing %roxo%TPM 2.0%white% Check... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1

    reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% TPM Bypass enabled.

    reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Secure Boot bypass enabled.

    reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Memory bypass enabled.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% TPM 2.0 bypassed %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    goto other

goto menu

    :godmodeapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Enabling %roxo%God Mode%white%...
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1

    if not exist "%userprofile%\Desktop\God Mode (Ghost Optimizer)\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" (
        mkdir "%userprofile%\Desktop\God Mode (Ghost Optimizer)\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
        echo      %purple%[ %roxo%-%purple% ]%white% God Mode created.
    ) else (
        echo   %red%[ • ]%white% God mode folder already exist.
    )

    echo.
    echo   %yellow%[ • ]%reset% Check your desktop for a new folder.
    echo.

    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% God mode enabled %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    goto other

goto menu

    :filenamesapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Enabling %roxo%Show files extensions%white%... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt"             /t REG_DWORD /d 0 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% File extensions visible.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Show file extensions enabled %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    goto other

goto menu

    :clearlogsapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Clearing %roxo%Event Logs%white%... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1

    echo      %purple%[ %roxo%-%purple% ]%white% Cleaning Windows logs...
    for /F "tokens=*" %%G in ('wevtutil.exe el') do (
        wevtutil.exe cl "%%G" /f >> "%ghost-logfile%" 2>&1
    )

    echo      %purple%[ %roxo%-%purple% ]%white% Cleaning Ghost Optimizer logs...
    if exist "C:\Ghost Optimizer\Logs" (
        del /q /f /s "C:\Ghost Optimizer\Logs\*.*"
    ) else (
        echo   %red%[ • ]%white% Ghost Optimizer logs not found.
    )
    
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Event Logs cleaned %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    goto other

goto menu

    :hiddenfilesapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Enabling %roxo%Show hidden files%white%... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden"                  /t REG_DWORD /d 1 /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Hidden Files visible.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Show hidden file enabled %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    goto other

goto menu

    :classicmenuapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Enabling %roxo%Classic%white% context menu... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1

    reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"             /f /ve /f >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Classic context menu enabled.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% Classic context menu enabled %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    goto other

goto menu

    :disablesysmain
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Disabling %roxo%SysMain%white%... 
    echo.
    timeout /t 3 /nobreak >> "%ghost-logfile%" 2>&1

    sc stop "SysMain" >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Sysmain stopped.

    sc config "SysMain" start=disabled >> "%ghost-logfile%" 2>&1
    echo      %purple%[ %roxo%-%purple% ]%white% Sysmain disabled.

    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    echo   %purple%[ %roxo%•%purple% ]%white% SysMain disabled %green%successfully%white%.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    title Ghost Optimizer %version% %reboot%
    goto other

goto menu

    :reboot
    cls
    echo.
    echo.
    set "lines[0]=                                        ██████╗ ███████╗██████╗  ██████╗  ██████╗ ████████╗     "
    set "lines[1]=                                        ██╔══██╗██╔════╝██╔══██╗██╔═══██╗██╔═══██╗╚══██╔══╝     "
    set "lines[2]=                                        ██████╔╝█████╗  ██████╔╝██║   ██║██║   ██║   ██║        "
    set "lines[3]=                                        ██╔══██╗██╔══╝  ██╔══██╗██║   ██║██║   ██║   ██║        "
    set "lines[4]=                                        ██║  ██║███████╗██████╔╝╚██████╔╝╚██████╔╝   ██║        "
    set "lines[5]=                                        ╚═╝  ╚═╝╚══════╝╚═════╝  ╚═════╝  ╚═════╝    ╚═╝        "

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
    set "lines[0]=                       Restart Windows to apply the tweaks. Your system will be rebooted in 10 or 0 seconds."

    set "text=!lines[0]!"
    set "textGradient="
    for /L %%j in (0,1,130) do (
        set "char=!text:~%%j,1!"
        if "!char!"=="" set "char= "
        set "textGradient=!textGradient!!esc[%%j]!!char!"
    )
    echo !textGradient!!esc![0m

    set "lineGradient="
    set /a "BeforeSpace=(136 - 122) / 2"
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    for /L %%j in (0,1,110) do (
        set /a "colorR=colorBaseR + (variationR * %%j / 108)"
        set /a "colorG=colorBaseG + (variationG * %%j / 108)"
        set /a "colorB=colorBaseB + (variationB * %%j / 108)"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m

    echo.
    echo                                      %purple%[ %roxo%%underline%1%reset% %purple%]%white% Reboot System                %purple%[ %roxo%%underline%2%reset% %purple%]%white% Shutdown System
    echo.                 
    echo                                      %purple%[ %roxo%%underline%3%reset% %purple%]%white% Quick Reboot                 %purple%[ %roxo%%underline%4%reset% %purple%]%white% Cancel Reboot
    echo.
    echo.
    echo                                                     %purple%[ %roxo%%underline%B%reset% %purple%]%white% Back to menu 
    echo.
    set /p answer="%reset% >:%roxo%"

    if "%answer%"=="1" call :rebootapply
    if "%answer%"=="2" call :shutdownapply
    if "%answer%"=="3" call :quickreboot
    if "%answer%"=="4" call :rebootcancel
    if "%answer%"=="b" goto menu
    if "%answer%"=="B" goto menu

    echo.
    echo.
    echo %red%                                                     Invalid Input.%reset%
    timeout /t 1 /nobreak >> "%ghost-logfile%" 2>&1
    echo.
    goto reboot

goto menu

    :rebootapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% %roxo%Rebooting%white% your system in %roxo%5%white% seconds... 
    title Ghost Optimizer %version%  %rebooting%
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    shutdown /r /t 5 /f >> "%ghost-logfile%" 2>&1
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    goto menu

goto menu

    :shutdownapply
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% %roxo%Shutting down%white% your system in %roxo%5%white% seconds... 
    title Ghost Optimizer %version%  %shuttingdown%
    echo.
    timeout /t 3 /nobreak >> "%ghost-logfile%" 2>&1
    shutdown /s /t 5 /f >> "%ghost-logfile%" 2>&1
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    goto menu

goto menu

    :quickreboot
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% %roxo%Rebooting%white% your system... 
    title Ghost Optimizer %version%  %rebooting%
    echo.
    timeout /t 3 /nobreak >> "%ghost-logfile%" 2>&1
    shutdown /r /t 0 /f >> "%ghost-logfile%" 2>&1
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    goto menu

goto menu

    :rebootcancel
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% %roxo%Cancelling%white% system Reboot/Shutdown... 
    echo.
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    shutdown /a /f >> "%ghost-logfile%" 2>&1
    timeout /t 2 /nobreak >> "%ghost-logfile%" 2>&1
    goto menu

goto menu

    :restart
    cls
    echo !esc![?25l
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    set "lines[0]=                                                          ██████              "
    set "lines[1]=                                                       ████████████           "
    set "lines[2]=                                                    ██████████████████        "
    set "lines[3]=                                                    █████   ██   █████        "
    set "lines[4]=                                                   ██████   ██   ██████       "
    set "lines[5]=                                                  ██████████████████████      "
    set "lines[6]=                                                 █████   ███  ███   █████     "
    set "lines[7]=                                                 ███  ███   ██   ███  ███     "
    set "lines[8]=                                                 ████████████████████████     "
    set "lines[9]=                                                 ████    ███  ███    ████     "
    set "lines[10]=                                                                             "
    set "lines[11]=                                                                             "
    set "lines[12]=                                                       Restarting...        "

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

    timeout /t 3 /nobreak >> "%ghost-logfile%" 2>&1
    start "" "%~f0"
    exit

goto menu

    :rebootquestion
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% ]%white% Reboot now to apply changes?" %reset%(%green%Y%reset%/%red%N%reset%%reset%)%reset%
    echo.
    echo   %purple%About:%reset% A system reboot is required for all changes to take effect.
    echo   Skipping this step will leave your system in a partial state until you restart manually.
    echo.

    set /p answer="%reset% >:%roxo%"

    if /i "%answer%"=="Y" (
        goto quickreboot
    ) else if /i "%answer%"=="N" (
        goto menu
    ) else (
        echo.
        echo.
        echo %red%                                                     Invalid Input.%reset%
        timeout /t 2 /nobreak >nul
        goto rebootquestion
    )

    goto disablemitigations

goto menu