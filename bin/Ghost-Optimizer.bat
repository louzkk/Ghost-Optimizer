:: Ghost Optimizer Batch Script
:: Created by: @louzkk
:: Feel free to use, just keep the credits :)

:start
@echo off

:: Window Proprieties
    title Ghost Optimizer
    mode 135,30

:: Delayed Expansion
    setlocal enabledelayedexpansion

:: Execution Policy
    powershell "Set-ExecutionPolicy Unrestricted"

:: Script Outputs
    if not exist "C:\Ghost Optimizer" md "C:\Ghost Optimizer"
    if not exist "C:\Ghost Optimizer" mkdir "C:\Ghost Optimizer"
    echo Ghost Optimizer (Outputs) > "C:\Ghost Optimizer\Ghost_Log.txt"
    echo Created by: @louzkk >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo Created on %date% at %time% >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo. >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

:: ANSI Escape
    reg add "HKCU\CONSOLE" /v "VirtualTerminalLevel" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b")
    (for /f %%a in ('echo prompt $E^| cmd') do set "esc=%%a")

:: Disable UAC
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

:: Restore Point
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'Ghost Optimizer | Restore Point' -RestorePointType 'MODIFY_SETTINGS'" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

:: UTF-8 Encoding
    chcp 65001 >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

:: Setting Colors
    set red=[38;2;255;0;0m
    set blue=[94m
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

:: Gradient setup
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

:: Check for Admin
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting %purple%%underline%Ghost Optimizer%reset%...
    timeout /t 3 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
    >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
    ) ELSE (
    >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
    )

    if '%errorlevel%' NEQ '0' (
        goto:UACPrompt
    ) else ( goto:GotAdmin )

    :UACPrompt
        echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
        set params= %*
        echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

        "%temp%\getadmin.vbs"
        del "%temp%\getadmin.vbs"
        exit /B

    :GotAdmin
        pushd "%CD%"
        CD /D "%~dp0"

:: Loading Screen
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

    timeout /t 3 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    goto:menu

:: Script Main Menu
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

    set "lines[0]=           ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗      ██████╗ ██████╗ ████████╗██╗███╗   ███╗██╗███████╗███████╗██████╗  "
    set "lines[1]=          ██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝     ██╔═══██╗██╔══██╗╚══██╔══╝██║████╗ ████║██║╚══███╔╝██╔════╝██╔══██╗"
    set "lines[2]=          ██║  ███╗███████║██║   ██║███████╗   ██║        ██║   ██║██████╔╝   ██║   ██║██╔████╔██║██║  ███╔╝ █████╗  ██████╔╝"
    set "lines[3]=          ██║   ██║██╔══██║██║   ██║╚════██║   ██║        ██║   ██║██╔═══╝    ██║   ██║██║╚██╔╝██║██║ ███╔╝  ██╔══╝  ██╔══██╗"
    set "lines[4]=          ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║        ╚██████╔╝██║        ██║   ██║██║ ╚═╝ ██║██║███████╗███████╗██║  ██║"
    set "lines[5]=           ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝         ╚═════╝ ╚═╝        ╚═╝   ╚═╝╚═╝     ╚═╝╚═╝╚══════╝╚══════╝╚═╝  ╚═╝"

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
    set "lines[0]=                                                        Created by: @louzkk"
    set "lines[1]=                                                            Version: 5.0"

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
    echo.

    echo                           %purple%[ %roxo%%underline%1%reset% %purple%]%white% System Optimizations                       %purple%[ %roxo%%underline%2%reset% %purple%]%white% Performance Optimizations        
    echo.
    echo                           %purple%[ %roxo%%underline%3%reset% %purple%]%white% Network Optimizations                      %purple%[ %roxo%%underline%4%reset% %purple%]%white% Disable/Block Telemetry        
    echo.
    echo                           %purple%[ %roxo%%underline%5%reset% %purple%]%white% GhostOPX Power Plan                        %purple%[ %roxo%%underline%6%reset% %purple%]%white% System Health Repair    
    echo.
    echo                           %purple%[ %roxo%%underline%7%reset% %purple%]%white% System Cache Cleaner                       %purple%[ %roxo%%underline%8%reset% %purple%]%white% Unlock Thermal Limits                        
    echo.
    echo                           %purple%[ %roxo%%underline%9%reset% %purple%]%white% %g%NVIDIA%reset% Custom Tweaks                       %purple%[ %roxo%%underline%10%reset% %purple%]%white% Disable Services/Bloatware

    set /p answer="%white% >:%roxo%"

    :: Script Keys
    if "%answer%"=="Louzkk" start https://github.com/louzkk
    if "%answer%"=="louzkk" start https://github.com/louzkk
    if "%answer%"=="@louzkk" start https://github.com/louzkk
    if "%answer%"=="@Louzkk" start https://github.com/louzkk
    if "%answer%"=="ghost" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="Ghost" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="GHOST" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="github" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="Github" start https://github.com/louzkk/Ghost-Optimizer
    if "%answer%"=="help" start https://github.com/louzkk/Ghost-Optimizer/blob/main/COMMANDS.md
    if "%answer%"=="reload" goto:variables
    if "%answer%"=="update" goto:variables
    if "%answer%"=="restart" goto:restart
    if "%answer%"=="reload" goto:start
    if "%answer%"=="exit" exit
    if "%answer%"=="menu" goto:menu
    if "%answer%"=="hack" call:tree
    if "%answer%"=="reboot" goto:reboot
    if "%answer%"=="rebootcancel" goto:rebootcancel
    if "%answer%"=="cancel" goto:rebootcancel

    if %answer% equ 1 call:system
    if %answer% equ 2 call:performance
    if %answer% equ 3 call:network
    if %answer% equ 4 call:telemetry
    if %answer% equ 5 call:powerplan
    if %answer% equ 6 call:health
    if %answer% equ 7 call:cachecleaner
    if %answer% equ 8 call:thermal
    if %answer% equ 9 call:nvidia
    if %answer% equ 10 call:services

    :: Invalid Input
    goto:menu

:: System Optimizations
    :system
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

    set "lines[0]=                                          ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗"
    set "lines[1]=                                          ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║"
    set "lines[2]=                                          ███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║"
    set "lines[3]=                                          ╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║"
    set "lines[4]=                                          ███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║"
    set "lines[5]=                                          ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝"

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
    set "lines[0]=                                Applies basic tweaks to improve system performance and responsiveness"
    set "lines[1]=                                 Disables unnecessary features and minor obstacles that slow Windows"

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
    echo.
    echo                                                    %purple%[ %roxo%%underline%1%reset% %purple%]%white% Start System Optimizations
    echo.
    echo                                                    %purple%[ %roxo%%underline%2%reset% %purple%]%white% Revert System Optimizations        
    echo.
    echo.
    echo                                                          %purple%[ %roxo%%underline%M%reset% %purple%]%white% Back to Menu

    set /p answer="%white% >:%roxo%"

    :: Option Keys
    if %answer% equ 1 goto:system2
    if %answer% equ 2 goto:system_undo
    if "%answer%"=="m" goto:menu
    if "%answer%"=="M" goto:menu

    :: Invalid Input
    goto:system

    :system2
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting %roxo%System%white% Optimizations... %purple%(%roxo%~2s%purple%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting System Optimizations --- >> Ghost_Log.txt

    reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /t REG_DWORD /d 33554432 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsDisableLastAccessUpdate /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v AlwaysOn /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NoLazyMode /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% General Tweaks applied.

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Taskbar Tweaks applied.

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Transparency disabled.

    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v "EnablePrecision" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v KeyboardDataQueueSize /t REG_DWORD /d 32 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MouseDataQueueSize /t REG_DWORD /d 32 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Pointer Precision Optimized.

    reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Sticky Keys disabled.

    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% StartUp delay removed.

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Storage Sense disabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Background Apps disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsDisableLastAccessUpdate /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Last Access Update disabled.

    reg add "HKLM\System\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Remote Assist disabled.

    wmic computersystem >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config SysMain start= disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Memory Management Optimized.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Driver Search disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberBootEnabled /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SleepReliabilityDetailedDiagnostics" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Hibernation disabled.

    reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v value /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Game Bar/DVR disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v DisableSelectiveSuspend /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% USB Selective Suspend disabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DoReport /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v LoggingDisabled /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v DoReport /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Error Reporting disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergySaverPolicy" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ModernSleep" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PlatformAoAcOverride" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Energy Saving Features disabled.

    bcdedit /set tscsyncpolicy enhanced >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    bcdedit /set uselegacyapicmode No >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    bcdedit /deletevalue useplatformclock >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    bcdedit /deletevalue useplatformtick >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    bcdedit /set disabledynamictick No >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% BCD Tweaks applied.

    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% All Optimizations applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer (Reboot Required)
    echo --- Finished System Optimizations --- >> Ghost_Log.txt
    goto:menu

    :system_undo
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Reverting %roxo%System%white% Optimizations... %purple%(%roxo%~2s%purple%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting System Optimizations Revert --- >> Ghost_Log.txt

    reg delete "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /t REG_DWORD /d 33554432 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsDisableLastAccessUpdate /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v AlwaysOn /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NoLazyMode /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% General Tweaks Reverted.

    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Taskbar Tweaks Reverted.

    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Transparency (Blur) enabled.

    reg delete "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v "EnablePrecision" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v KeyboardDataQueueSize /t REG_DWORD /d 32 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MouseDataQueueSize /t REG_DWORD /d 32 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Pointer Precision Reverted.

    reg delete "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Sticky Keys enabled.

    reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% StartUp delay Reverted.

    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Storage Sense enabled.

    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Background Apps enabled.

    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsDisableLastAccessUpdate /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Last Access Update enabled.

    reg delete "HKLM\System\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Remote Assist enabled.

    wmic computersystem >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config SysMain start= disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Memory Management Reverted.

    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Driver Search enabled.

    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberBootEnabled /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Hibernation enabled.

    reg delete "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v value /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Game Bar/DVR enabled.

    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v DisableSelectiveSuspend /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% USB Selective Suspend enabled.

    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DoReport /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v LoggingDisabled /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v DoReport /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Error Reporting enabled.

    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergySaverPolicy" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power\ModernSleep" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PlatformAoAcOverride" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Energy Saving Features enabled.

    bcdedit /deletevalue tscsyncpolicy >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    bcdedit /deletevalue uselegacyapicmode >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    bcdedit /deletevalue useplatformclock >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    bcdedit /deletevalue useplatformtick >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    bcdedit /deletevalue disabledynamictick >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% BCD Tweaks applied.

    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% All Optimizations reverted %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer (Reboot Required)
    echo --- Finished System Optimizations Revert --- >> Ghost_Log.txt
    goto:menu

:: Performance Optimizations
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
    set "lines[0]=                                       Applies advanced tweaks to boost overall system performance"
    set "lines[1]=                                         Improves responsiveness, latency, and gaming experience"

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
    echo.
    echo                                                  %purple%[ %roxo%%underline%1%reset% %purple%]%white% Start Performance Optimizations
    echo.
    echo                                                  %purple%[ %roxo%%underline%2%reset% %purple%]%white% Revert Performance Optimizations     
    echo.
    echo                                                  %cinza%[ 3 ] AMD - NVIDIA - INTEL Tweaks   
    echo.
    echo.
    echo                                                          %purple%[ %roxo%%underline%M%reset% %purple%]%white% Back to Menu

    set /p answer="%white% >:%roxo%"

    :: Option Keys
    if %answer% equ 1 goto:performance2
    if %answer% equ 2 goto:performance_undo
    if %answer% equ 3 goto:performance
    if "%answer%"=="m" goto:menu
    if "%answer%"=="M" goto:menu

    :: Invalid Input
    goto:performance

    :performance2
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting %roxo%Performance%white% Optimizations... %purple%(%roxo%~2s%purple%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Performance Optimizations --- >> Ghost_Log.txt

    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d False /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d High /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d True /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Game Priorities Optimized.

    reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Game Mode enabled.

    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Fullscreen Optimizations enabled.

    reg delete "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% MPO (Multiple Plane Overlay) enabled.

    for /f %%g in ('wmic path win32_videocontroller get PNPDeviceID ^| findstr /L "VEN_"') do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    )
    echo   %purple%[ %roxo%•%purple% %purple%]%white% MSI (Message Signaled Interrupts) enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Priority Separation Optimized.

    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Power Throttling disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "Latency" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "TransitionLatency" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "Append Completion" /t REG_SZ /d "yes" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "AutoSuggest" /t REG_SZ /d "yes" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ExtendedUIHoverTime /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "10" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MouseHoverTime" /t REG_SZ /d 10 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d 1000 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d 2000 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d 1000 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d 2000 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "5" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Input-Lag and Latency Optimized.

    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm" /v "FlipQueueSize" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v FrameLatency /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v ClockTimerResolution /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "TimerResolution" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Timer Resolution Optimized.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DistributeTimers" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo  %purple%[ %roxo%•%purple% %purple%]%white% Timer Distribution enabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Hardware-Accelerated GPU Scheduling disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Largue System Cache Optimized.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v RequirePlatformSecurityFeatures /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v HVCIMATRequired /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    bcdedit /set hypervisorlaunch off >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Virtualization Based Security disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Spectre/Meltdown algorithms disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 10 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Direct3D\Drivers" /v "SoftwareOnly" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Microsoft\DirectInput" /v "EnableBackgroundProcessing" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\Software\Microsoft\Direct3D" /v "DisableDebugLayer" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% DirectX/Vulkan Optimized.

    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% All Optimizations applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer (Reboot Required)
    echo --- Finished Performance Optimizations --- >> Ghost_Log.txt
    goto:menu

    :: Undo Performance Optimizations
    :performance_undo
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Reverting %roxo%Performance%white% Optimizations... %purple%(%roxo%~2s%purple%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Performance Optimizations Revert --- >> Ghost_Log.txt

    reg delete "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d False /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d High /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d True /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Gaming Optimizations Reverted.

    reg delete "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Fullscreen Optimizations disabled.

    reg delete "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% MPO (Multiple Plane Overlay) disabled.

    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Priority Separation Reverted.

    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Power Throttling enabled.

    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "Latency" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "TransitionLatency" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "Append Completion" /t REG_SZ /d "yes" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "AutoSuggest" /t REG_SZ /d "yes" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ExtendedUIHoverTime /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "10" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MouseHoverTime" /t REG_SZ /d 10 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d 1000 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d 2000 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d 1000 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d 2000 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "5" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Input-Lag and Latency Reverted.

    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm" /v "FlipQueueSize" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v FrameLatency /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v ClockTimerResolution /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "TimerResolution" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo    %purple%[ %roxo%•%purple% %purple%]%white% Timer Resolution Reverted.

    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Hardware-Accelerated GPU Scheduling enabled.

    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 10 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Direct3D\Drivers" /v "SoftwareOnly" /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\DirectInput" /v "EnableBackgroundProcessing" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\Software\Microsoft\Direct3D" /v "DisableDebugLayer" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% DirectX/Vulkan Reverted.

    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Largue System Cache Reverted.

    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v RequirePlatformSecurityFeatures /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v HVCIMATRequired /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    bcdedit /set hypervisorlaunch off >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Virtualization Based Security enabled.

    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Spectre/Meltdown algorithms enabled.

    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% All Optimizations reverted %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer (Reboot Required)
    echo --- Finished Performance Optimizations reverted --- >> Ghost_Log.txt
    goto:menu

:: Network Optimizations
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
    set "lines[0]=                                      Improves connection stability and responsiveness (ping)."
    set "lines[1]=                                Adjusts network settings, algorithms and DNS for better performance."

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
    echo.
    echo                                                   %purple%[ %roxo%%underline%1%reset% %purple%]%white% Start Network Optimizations
    echo.
    echo                                                   %purple%[ %roxo%%underline%2%reset% %purple%]%white% Revert Network Optimizations        
    echo.
    echo.
    echo                                                          %purple%[ %roxo%%underline%M%reset% %purple%]%white% Back to Menu

    set /p answer="%white% >:%roxo%"

    :: Option Keys
    if %answer% equ 1 goto:network2
    if %answer% equ 2 goto:network_undo
    if "%answer%"=="m" goto:menu
    if "%answer%"=="M" goto:menu

    :: Invalid Input
    goto:network

    :network2
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting %roxo%Netowork%white% Optimizations... %purple%(%roxo%~2s%purple%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Network Optimizations --- >> Ghost_Log.txt

    for /f "tokens=3 delims={}" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" ^| find "{"') do (
        set "InterfaceID=%%A"
    )

    for /f "tokens=1*" %%i in ('netsh interface show interface ^| findstr /i /C:"Connected" /C:"Conectado" /C:"Conectada"') do (
        set "netinterface=%%j"
    )

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Network Interface detected. %InterfaceID%
    timeout /t 1 >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    netsh int tcp set global autotuninglevel=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    netsh int tcp set global ecncapability=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    netsh int tcp set global dca=enabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    netsh int tcp set global timestamps=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% General Network Tweaks applied.

    netsh int tcp set global netdma=enabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo  %purple%[ %roxo%•%purple% %purple%]%white% Direct Memory Access enabled.

    netsh int tcp set global dca=enabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo  %purple%[ %roxo%•%purple% %purple%]%white% Direct Cache Access enabled.

    netsh int ip set global taskoffload=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Task Offload disabled.

    netsh int tcp set heuristics disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Heuristics disabled.

    netsh interface ip set dns name="%netinterface%" source=static addr=1.1.1.1 register=PRIMARY >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    netsh interface ip add dns name="%netinterface%" addr=1.0.0.1 index=2 >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% %orange%Cloudflare%reset% DNS configured. 

    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Network Throttling disabled. 

    reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v TCPNoDelay /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v DisableBandwidthThrottling /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v MaxCmds /t REG_DWORD /d 2048 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Network Throughput Optimized. 

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{%InterfaceID%}" /v TcpAckFrequency /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{%InterfaceID%}" /v TCPNoDelay /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Nagle's Algorithm disabled. 

    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Delivery Optimization disabled. 

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DisableTaskOffload /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v EnableTCPChimney /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v EnableRSS /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v EnableTCPA /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Tcpip parameters Optimized. 

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpMaxHalfOpen /t REG_DWORD /d 100 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpMaxHalfOpenRetried /t REG_DWORD /d 80 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpMaxPortsExhausted /t REG_DWORD /d 5 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpNumConnections /t REG_DWORD /d 500 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Increased TCP Simultaneous Packets. 

    netsh int tcp set global congestionprovider=ctcp >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    netsh int tcp set supplemental template=Internet congestionprovider=ctcp >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    netsh int tcp set supplemental Internet congestionprovider=ctcp >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% CTCP Optimized.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v EnableECN /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Quality of Service Optimized. 

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v CacheHashTableBucketSize /t REG_DWORD /d 384 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v CacheHashTableSize /t REG_DWORD /d 384 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheEntryTtlLimit /t REG_DWORD /d 64000 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheTtl /t REG_DWORD /d 64000 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% DNS Cache Optimized. 

    ipconfig /flushdns >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% DNS Cache cleared. 

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v BufferAlignment /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DefaultReceiveWindow /t REG_DWORD /d 262144 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DefaultSendWindow /t REG_DWORD /d 262144 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DisableAddressSharing /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DisableChainedReceive /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v disabledirectAcceptEx /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DoNotHoldNICBuffers /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DynamicSendBufferDisable /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v FastSendDatagramThreshold /t REG_DWORD /d 1024 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v FastCopyReceiveThreshold /t REG_DWORD /d 1024 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v IgnoreOrderlyRelease /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v IgnorePushBitOnReceives /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Buffer and Address Optimized. 

    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DownloadMode /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Delivery Optimization disabled. 

    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% All Optimizations applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer (Reboot Required)
    echo --- Finished Network Optimizations --- >> Ghost_Log.txt
    goto:menu

    :: Undo Network Optimizations
    :network_undo
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Reverting %roxo%Netowork%white% Optimizations... %purple%(%roxo%~2s%purple%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Network Optimizations Revert --- >> Ghost_Log.txt

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Detecting Active Network Interface...
    for /f "tokens=3 delims={}" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" ^| find "{"') do (
        set "InterfaceID=%%A"
    )

    for /f "tokens=1*" %%i in ('netsh interface show interface ^| findstr /i /C:"Connected" /C:"Conectado" /C:"Conectada"') do (
        set "netinterface=%%j"
    )

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Network Interface detected. %InterfaceID%
    timeout /t 1 >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    netsh int tcp set global autotuninglevel=enabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    netsh int tcp set global ecncapability=enabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    netsh int tcp set global dca=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    netsh int tcp set global timestamps=enabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% General Network Tweaks reverted.

    netsh int ip set global taskoffload=enabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Task Offload enabled.

    netsh int tcp set heuristics enabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Heuristics enabled.

    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Network Throttling enabled. 

    reg delete "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v TCPNoDelay /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v DisableBandwidthThrottling /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v MaxCmds /t REG_DWORD /d 2048 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Network Throughput reverted. 

    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{%InterfaceID%}" /v TcpAckFrequency /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{%InterfaceID%}" /v TCPNoDelay /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Nagle Algorithm enabled. 

    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Delivery Optimization enabled. 

    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DisableTaskOffload /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v EnableTCPChimney /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v EnableRSS /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v EnableTCPA /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% TCP Offload, RSS and NetDMA disabled. 

    netsh int tcp set global congestionprovider=ctcp >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    netsh int tcp set supplemental template=Internet congestionprovider=ctcp >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% CTCP reverted.

    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpMaxHalfOpen /t REG_DWORD /d 100 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpMaxHalfOpenRetried /t REG_DWORD /d 80 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpMaxPortsExhausted /t REG_DWORD /d 5 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpNumConnections /t REG_DWORD /d 500 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Reverted TCP Simultaneous Packets. 

    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v EnableECN /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Quality of Service Reverted. 

    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v CacheHashTableBucketSize /t REG_DWORD /d 384 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v CacheHashTableSize /t REG_DWORD /d 384 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheEntryTtlLimit /t REG_DWORD /d 64000 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheTtl /t REG_DWORD /d 64000 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% DNS Cache Reverted. 

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Flushing DNS Cache...
    ipconfig /flushdns >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% DNS Cache cleared. 

    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v BufferAlignment /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DefaultReceiveWindow /t REG_DWORD /d 262144 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DefaultSendWindow /t REG_DWORD /d 262144 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DisableAddressSharing /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DisableChainedReceive /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v disabledirectAcceptEx /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DoNotHoldNICBuffers /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DynamicSendBufferDisable /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v FastSendDatagramThreshold /t REG_DWORD /d 1024 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v FastCopyReceiveThreshold /t REG_DWORD /d 1024 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v IgnoreOrderlyRelease /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v IgnorePushBitOnReceives /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Buffer and Address Reverted. 

    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DownloadMode /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Delivery Optimization enabled. 

    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% All Optimizations reverted %green%successfully%white%..
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer (Reboot Required)
    echo --- Finished Network Optimizations Reverted --- >> Ghost_Log.txt
    goto:menu

:: Telemetry Block
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
    set "lines[0]=                                       Disable data collection, diagnostics and tracking services"
    set "lines[1]=                                           Enhances privacy and reduces background activity"

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
    echo.
    echo                                                    %purple%[ %roxo%%underline%1%reset% %purple%]%white% Start Telemetry Blocking
    echo.
    echo                                                    %purple%[ %roxo%%underline%2%reset% %purple%]%white% Revert Telemetry Blocking        
    echo.
    echo                                                    %purple%[ %roxo%%underline%3%reset% %purple%]%white% Apply OOSU10 Optimizations        
    echo.
    echo.
    echo                                                           %purple%[ %roxo%%underline%M%reset% %purple%]%white% Back to Menu

    set /p answer="%white% >:%roxo%"

    :: Option Keys
    if %answer% equ 1 goto:telemetry2
    if %answer% equ 2 goto:telemetry_undo
    if %answer% equ 3 goto:OOSU10
    if "%answer%"=="m" goto:menu
    if "%answer%"=="M" goto:menu

    :: Invalid Input
    goto:telemetry

    :telemetry2
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting %roxo%Telemetry%white% Blocking... %purple%(%roxo%~2s%purple%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Telemetry Blocking --- >> Ghost_Log.txt

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 4 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% General Telemetry disabled.

    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Device Metadata/Input disabled.

    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogEnable" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogLevel" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Update/Logging disabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowCommercialDataPipeline" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowDeviceNameInTelemetry" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitEnhancedDiagnosticDataWindowsAnalytics" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "MicrosoftEdgeDataOptIn" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Feedback/Edge Data disabled.

    reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfNotificationsSent" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoExplicitFeedback" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoActiveHelp" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Experience Feedback disabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% User Activity Upload disabled.

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Advertising ID disabled.

    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Location Sensor disabled.

    reg add "HKCU\Software\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\Software\Microsoft\Siuf\Rules" /v PeriodInDays /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKCU\Software\Microsoft\Siuf\Rules" /v NumberOfNotificationsSent /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Experience Feedback disabled.

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Cellcore" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\CloudExperienceHostOobe" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DataMarket" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\HolographicDevice" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsClient" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\iclsProxy" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\LwtNetLog" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Mellanox-Kernel" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-AssignedAccess-Trace" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Microsoft-Windows-Setup" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NBSMBLOGGER" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\PEAuthLog" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\RdrLog" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatform" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SetupPlatformTel" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SocketHeciServer" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SpoolerLogger" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPLOGGER" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TileStore" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Tpm" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TPMProvisioningService" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WFP-IPsec Trace" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSession" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiDriverIHVSessionRepro" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WiFiSession" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WinPhoneCritical" /v "Start" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogEnable" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogLevel" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1 
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableThirdPartySuggestions" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Credssp" /v "DebugLogLevel" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo  %purple%[ %roxo%•%purple% %purple%]%white% Autologgers disabled.

    sc config DiagTrack start= disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config dmwappushservice start= disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config DPS start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config diagnosticshub.standardcollector.service start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Tracking/Telemetry services disabled.

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Blocking Tracking/Telemetry domains... 
    (
    echo 0.0.0.0 vortex.data.microsoft.com >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo 0.0.0.0 settings-win.data.microsoft.com >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo 0.0.0.0 watson.telemetry.microsoft.com >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo 0.0.0.0 telemetry.microsoft.com >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo 0.0.0.0 telecommand.telemetry.microsoft.com >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo 0.0.0.0 services.wes.df.telemetry.microsoft.com >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo 0.0.0.0 sqm.df.telemetry.microsoft.com >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo 0.0.0.0 telemetry.nvidia.com >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo 0.0.0.0 telemetry.amd.com >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    )
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Tracking/Telemetry domains blocked. 

    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% All telemetry disabled %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer (Reboot Required)
    echo --- Finished Telemetry Blocking --- >> Ghost_Log.txt
    goto:menu

    :: Undo Telemetry Blocking
    :telemetry_undo
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Reverting %roxo%Telemetry%white% Blocking... %purple%(%roxo%~2s%purple%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Telemetry Blocking Revert --- >> Ghost_Log.txt

    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 4 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% General Telemetry enabled.

    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Device Metadata/Input enabled.

    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogEnable" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WUDF" /v "LogLevel" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Update/Logging enabled.

    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowCommercialDataPipeline" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowDeviceNameInTelemetry" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitEnhancedDiagnosticDataWindowsAnalytics" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "MicrosoftEdgeDataOptIn" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Feedback/Edge Data enabled.

    reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfNotificationsSent" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoExplicitFeedback" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoActiveHelp" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Experience Feedback enabled.

    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% User Activity Upload enabled.

    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Advertising ID enabled.

    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d "1" /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Location Sensor enabled.

    reg delete "HKCU\Software\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\Software\Microsoft\Siuf\Rules" /v PeriodInDays /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKCU\Software\Microsoft\Siuf\Rules" /v NumberOfNotificationsSent /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Experience Feedback enabled.

    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% All telemetry enabled %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer (Reboot Required)
    echo --- Finished Telemetry Blocking Revert --- >> Ghost_Log.txt
    goto:menu

   :OOSU10
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting %blue%OOSU10%white%... %purple%(%roxo%~2s%purple%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting OOSU10 --- >> Ghost_Log.txt
    powershell -Command "Invoke-WebRequest 'https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe' -OutFile 'C:\Ghost Optimizer\OOSU10.exe'"
    curl -g -k -L -# -o "C:\Ghost Optimizer\GhostOPX-OOSU10.cfg" "https://github.com/louzkk/Ghost-Optimizer/raw/main/bin/GhostOPX-OOSU10.cfg"
    start "" /wait "C:\Ghost Optimizer\OOSU10.exe" "C:\Ghost Optimizer\GhostOPX-OOSU10.cfg"
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Restarting %purple%%underline%Ghost Optimizer%white%... %purple%(%roxo%~2s%purple%)%white%
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Finishing OOSU10 --- >> Ghost_Log.txt
    start "" "%~f0"
    exit

:: Power Plan
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

    set "lines[0]=                          ██████╗  ██████╗ ██╗    ██╗███████╗██████╗     ██████╗ ██╗      █████╗ ███╗   ██╗"
    set "lines[1]=                          ██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗    ██╔══██╗██║     ██╔══██╗████╗  ██║"
    set "lines[2]=                          ██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝    ██████╔╝██║     ███████║██╔██╗ ██║"
    set "lines[3]=                          ██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗    ██╔═══╝ ██║     ██╔══██║██║╚██╗██║"
    set "lines[4]=                          ██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║    ██║     ███████╗██║  ██║██║ ╚████║"
    set "lines[5]=                          ╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝    ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝"

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
    set "lines[0]=                                         Applies a custom power plan for highest performance"
    set "lines[1]=                                               Reduces system latency and increases FPS"

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
    echo.
    echo                                                 %purple%[ %roxo%%underline%1%reset% %purple%]%white% Apply GhostOPX Power Plan
    echo.
    echo                                                 %cinza%[ 2 ] Apply GhostOPX V2 Power Plan
    echo.
    echo                                                 %purple%[ %roxo%%underline%3%reset% %purple%]%white% Revert Default Power Plan    
    echo.
    echo.
    echo                                                       %purple%[ %roxo%%underline%M%reset% %purple%]%white% Back to Menu

    set /p answer="%white% >:%roxo%"

    :: Option Keys
    if %answer% equ 1 goto:powerplan2
    if %answer% equ 2 goto:powerplan
    if %answer% equ 3 goto:powerplan4
    if "%answer%"=="m" goto:menu
    if "%answer%"=="M" goto:menu

    :: Invalid Input
    goto:powerplan

    :powerplan2
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Applying %purple%GhostOPX%reset% Power Plan... %purple%(%roxo%~2s%purple%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Power Plan --- >> Ghost_Log.txt

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Checking repository.

    if not exist "C:\GhostOPX\" mkdir "C:\GhostOPX\" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Importing Power Plan...

    curl -g -k -L -# -o "C:\GhostOPX\GhostOPX-POWERPLAN.pow" "https://github.com/louzkk/Ghost-Optimizer/raw/main/bin/GhostOPX-POWERPLAN.pow" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    if not exist "C:\GhostOPX\GhostOPX-POWERPLAN.pow" (
        echo   %red%[ %orange%• %red%]%white% Failed to download GhostOPX Power Plan >> Ghost_Log.txt
        echo   %red%[ %orange%• %red%]%white% Power plan file not found. Aborting...
        timeout /t 2 >nul
        goto:menu
    )

    powercfg /import "C:\GhostOPX\GhostOPX-POWERPLAN.pow" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    if errorlevel 1 (
        echo   %red%[ %orange%• %red%]%white% Failed to import GhostOPX power plan >> Ghost_Log.txt
        echo   %red%[ %orange%• %red%]%white% Failed to import power plan. Aborting...
        timeout /t 2 >nul
        goto:menu
    )

    timeout /t 2 /nobreak >nul

    set "GUID="
    for /f "tokens=2 delims=:()" %%i in ('powercfg /list ^| findstr /i "GhostOPX"') do (
        set "GUID=%%i"
        set "GUID=!GUID: =!"
    )

    if not defined GUID (
        echo   %red%[ %orange%• %red%]%white% Could not find GhostOPX power plan GUID >> Ghost_Log.txt
        echo   %red%[ %orange%• %red%]%white% Failed to locate imported power plan. Aborting...
        timeout /t 2 >nul
        goto:menu
    )

    powercfg /setactive !GUID! >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    if errorlevel 1 (
        echo   %red%[ %orange%• %red%]%white% Failed to set GhostOPX power plan active >> Ghost_Log.txt
        echo   %red%[ %orange%• %red%]%white% Failed to apply GhostOPX power plan. Aborting...
        timeout /t 2 >nul
        goto:menu
    )

    echo   %purple%[ %roxo%•%purple% %purple%]%white% GhostOPX Power Plan applied.

    timeout /t 1 /nobreak >nul

    echo   %purple%[ %roxo%•%purple% %purple%]%white% GhostOPX Power Plan applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer
    echo --- Finished Power Plan --- >> Ghost_Log.txt
    goto:menu


    :powerplan4
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Applying %purple%Default (Balanced)%reset% Power Plan... %purple%(%roxo%~2s%purple%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Power Plan --- >> Ghost_Log.txt

    powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    if errorlevel 1 (
        echo   %purple%[ %roxo%•%purple% %purple%]%white% Failed to set Balanced power plan >> Ghost_Log.txt
        echo   %purple%[ %roxo%•%purple% %purple%]%white% Failed to activate Windows Balanced Power Plan.
        timeout /t 2 >nul
        goto:menu
    )

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Default Power Plan applied %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer
    echo --- Finished Power Plan --- >> Ghost_Log.txt
    goto:menu

:: Health Repair
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

    set "lines[0]=                                             ██╗  ██╗███████╗ █████╗ ██╗  ████████╗██╗  ██╗ "
    set "lines[1]=                                             ██║  ██║██╔════╝██╔══██╗██║  ╚══██╔══╝██║  ██║"
    set "lines[2]=                                             ███████║█████╗  ███████║██║     ██║   ███████║"
    set "lines[3]=                                             ██╔══██║██╔══╝  ██╔══██║██║     ██║   ██╔══██║"
    set "lines[4]=                                             ██║  ██║███████╗██║  ██║███████╗██║   ██║  ██║"
    set "lines[5]=                                             ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝   ╚═╝  ╚═╝"

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
    set "lines[0]=                                   Performs a general system scan to detect and fix integrity issues."
    set "lines[1]=                                 Repairs corrupted files, Windows image, Windws update, and disk errors."

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
    echo.
    echo                                                   %purple%[ %roxo%%underline%1%reset% %purple%]%white% Start Standard Health Repair
    echo.
    echo                                                   %purple%[ %roxo%%underline%2%reset% %purple%]%white% Start Complete Health Repair      
    echo.
    echo.
    echo                                                         %purple%[ %roxo%%underline%M%reset% %purple%]%white% Back to Menu

    set /p answer="%white% >:%roxo%"

    :: Option Keys
    if %answer% equ 1 goto:health2
    if %answer% equ 2 goto:health3
    if "%answer%"=="m" goto:menu
    if "%answer%"=="M" goto:menu

    :: Invalid Input
    goto:health

    :health2
    cls
    echo.
    echo   %purple%[ %roxo%%underline%•%reset% %purple%]%white% Starting %nvidia%Standard Health%reset% Check/Repair... %purple%(%roxo%~2s%purple%)%reset%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Standard Health Check/Repair --- >> Ghost_Log.txt

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Checking Windows Image Health...
    DISM /Online /Cleanup-Image /CheckHealth >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Scanning Windows Image Health...
    DISM /Online /Cleanup-Image /ScanHealth >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Restoring Windows Image Health...
    DISM /Online /Cleanup-Image /RestoreHealth
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Image Health restored %green%successfully%white%.

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting Windows Components Check/Repair...
    DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Components repaired %green%successfully%white%.

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting System Integrity Check/Repair...
    sfc /scannow >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% System Integrity repaired %green%successfully%white%.

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Repairing Microsoft Store Cache...
    wsreset.exe >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Microsoft Store Cache repaired %green%successfully%white%.

    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Standard Health Check/Repair completed %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer (Reboot Required)
    echo --- Finished Standard Health Check/Repair --- >> Ghost_Log.txt
    goto:menu

    :health3
    cls
    echo.
    echo   %purple%[ %roxo%%underline%•%reset% %purple%]%white% Starting %nvidia%Full Health%reset% Check/Repair... %purple%(%roxo%~2s%purple%)%reset%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Full Health Check/Repair --- >> Ghost_Log.txt

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Checking Windows Image Health...
    DISM /Online /Cleanup-Image /CheckHealth >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Scanning Windows Image Health...
    DISM /Online /Cleanup-Image /ScanHealth >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Restoring Windows Image Health...
    DISM /Online /Cleanup-Image /RestoreHealth
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Image Health restored %green%successfully%white%.

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting Windows Components Check/Repair...
    DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Components repaired %green%successfully%white%.

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting System Integrity Check/Repair...
    sfc /scannow >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% System Integrity repaired %green%successfully%white%.

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Repairing Microsoft Store Cache...
    wsreset.exe >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Microsoft Store Cache repaired %green%successfully%white%.

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting Files System Check/Repair...
    chkdsk C: /f /r >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Files System repaired %green%successfully%white%.

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Stopping Windows Update services...
    net stop wuauserv >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    net stop cryptSvc >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    net stop bits >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    net stop msiserver >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Repairing Windows Update...
    ren C:\Windows\SoftwareDistribution SoftwareDistribution.old >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    ren C:\Windows\System32\catroot2 catroot2.old >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Restarting Windows Update services...
    net start wuauserv >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    net start cryptSvc >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    net start bits >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    net start msiserver >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Repairing Microsoft Store Cache...
    wsreset.exe >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Microsoft Store Cache repaired %green%successfully%white%.

    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Full Health Check/Repair completed %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer (Reboot Required)
    echo --- Finished Full Health Check/Repair --- >> Ghost_Log.txt
    goto:menu
:: Cache Cleaner
    :cachecleaner
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
    set "lines[0]=                                           Cleans temporary files, logs, and system clutter."
    set "lines[1]=                                               Frees up space and improves system speed."

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
    echo.
    echo                                                    %purple%[ %roxo%%underline%1%reset% %purple%]%white% Start System Cache Cleaner
    echo.
    echo                                                    %purple%[ %roxo%%underline%2%reset% %purple%]%white% Start Windows Clean Manager      
    echo.
    echo.
    echo                                                       %purple%[ %roxo%%underline%M%reset% %purple%]%white% Back to Menu

    set /p answer="%white% >:%roxo%"

    :: Option Keys
    if %answer% equ 1 goto:cachecleaner2
    if %answer% equ 2 goto:cachecleaner3
    if "%answer%"=="m" goto:menu
    if "%answer%"=="M" goto:menu

    :: Invalid Input
    goto:cachecleaner

    :cachecleaner2
    cls
    echo.
    echo   %purple%[ %roxo%%underline%•%reset% %purple%]%white% Starting %purple%Cache%reset% Cleaner... %purple%(%roxo%~2s%purple%)%reset%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Cache Cleaner --- >> Ghost_Log.txt

    del /s /f /q c:\windows\temp. >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    del /s /f /q %temp%. >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Temporary files cleaned.

    del /s /f /q C:\WINDOWS\Prefetch >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    del /s /f /q %windir%\prefetch\*.* >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Prefetch files cleaned.

    del /s /f /q %systemdrive%\*.tmp >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    del /s /f /q %systemdrive%\*._mp >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    del /s /f /q %systemdrive%\*.log >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    del /s /f /q %systemdrive%\*.gid >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    del /s /f /q %systemdrive%\*.chk >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    del /s /f /q %systemdrive%\*.old >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Unnecessary files cleaned.

    del /s /f /q %systemdrive%\recycled\*.* >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    del /s /f /q %systemdrive%\$Recycle.Bin\*.* >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Recicle Bin cleaned.

    del /s /f /q %windir%\*.bak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Old backup files cleaned.
    
    del /s /f /q %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    del /s /f /q %LocalAppData%\Microsoft\Windows\Explorer\*.db >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Thumb files cleaned.

    del /f /q %SystemRoot%\Logs\CBS\CBS.log >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    del /f /q %SystemRoot%\Logs\DISM\DISM.log >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Log files cleaned.

    rd /s /q C:\Windows\Temp >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    md C:\Windows\Temp >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    rd /s /q C:\Windows\tmp >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    md C:\Windows\tmp >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    rd /s /q C:\Windows\tempor~1 >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    md C:\Windows\tempor~1 >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    del /f /s /q C:\Windows\ff*.tmp >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo  %purple%[ %roxo%•%purple% %purple%]%white% Temporary directories cleaned.

    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% System Cache cleaned %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- System Cache cleaned --- >> Ghost_Log.txt
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer (Reboot Required)
    goto:menu

    :cachecleaner3
    cls
    echo.
    echo   %purple%[ %roxo%%underline%•%reset% %purple%]%white% Starting %purple%Windows Clean%reset% Manager... %purple%(%roxo%~2s%purple%)%reset%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Windows Clean Manager --- >> Ghost_Log.txt

    start /wait cleanmgr.exe

    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% System Cache cleaned %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Closing Windows Clean Manager --- >> Ghost_Log.txt
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer (Reboot Required)
    goto:menu

:: Unlock Thermal
    :thermal
    cls
    echo.
    echo.

    set "W=130"
    set /a "LAST=W-2"
    set /a "MID=(W-2)/2"

    for /L %%j in (0,1,!LAST!) do (
        set /a "colorR=255"
        set /a "colorG=(165 * %%j / !LAST!)"
        set /a "colorB=0"
        set "esc[%%j]=!esc![38;2;!colorR!;!colorG!;!colorB!m"
    )

    set "lines[0]=                                     ████████╗██╗  ██╗███████╗██████╗ ███╗   ███╗ █████╗ ██╗     "
    set "lines[1]=                                     ╚══██╔══╝██║  ██║██╔════╝██╔══██╗████╗ ████║██╔══██╗██║     "
    set "lines[2]=                                        ██║   ███████║█████╗  ██████╔╝██╔████╔██║███████║██║     "
    set "lines[3]=                                        ██║   ██╔══██║██╔══╝  ██╔══██╗██║╚██╔╝██║██╔══██║██║     "
    set "lines[4]=                                        ██║   ██║  ██║███████╗██║  ██║██║ ╚═╝ ██║██║  ██║███████╗"
    set "lines[5]=                                        ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝"

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
    set "lines[0]=                                      Disable thermal Throttling for maximum hardware performance."
    set "lines[1]=                             Not recomended with poor cooling systems or laptops, may not work in some BIOS."

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
        set /a "colorR=255"
        set /a "colorG=(165 * %%j / 108)"
        set /a "colorB=0"
        set "lineGradient=!lineGradient!!esc![38;2;!colorR!;!colorG!;!colorB!m─"
    )
    for /L %%k in (1,1,!BeforeSpace!) do set "lineGradient=!lineGradient! "
    echo !lineGradient!!esc![0m


    echo.
    echo.
    echo                                                     %red%[ %orange%%underline%1%reset% %red%]%white% Unlock Thermal Limits
    echo.
    echo                                                     %red%[ %orange%%underline%2%reset% %red%]%white% Lock Thermal Limits   
    echo.
    echo.
    echo                                                        %red%[ %orange%%underline%M%reset% %red%]%white% Back to Menu

    set /p answer="%white% >:%roxo%"

    :: Option Keys
    if %answer% equ 1 goto:thermal2
    if %answer% equ 2 goto:thermal3
    if "%answer%"=="m" goto:menu
    if "%answer%"=="M" goto:menu

    :: Invalid Input
    goto:thermal

    :thermal2
    cls
    echo.
    echo   %red%[ %orange%•%purple% %red%]%white% Unlocking %red%Thermal%reset% Limit... %red%(%orange%~2s%red%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Unlocking Thermal Limit --- >> Ghost_Log.txt

    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %red%[ %orange%•%purple% %red%]%white% Power Throttling disabled.

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\be337238-0d82-4146-a960-4f3749d470c7" /v Attributes /t REG_DWORD /d 2 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %red%[ %orange%•%purple% %red%]%white% Thermal Throttling disabled.

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo.
    echo   %red%[ %orange%•%purple% %red%]%white% Thermal Limit Unlocked %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %red%[ %orange%•%purple% %red%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer
    echo --- Thermal Limit unlocked --- >> Ghost_Log.txt
    goto:menu


    :thermal3
    cls
    echo.
    echo   %red%[ %orange%•%purple% %red%]%white% Locking %red%Thermal%reset% Limit... %red%(%orange%~2s%red%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Unlocking Thermal Limit --- >> Ghost_Log.txt

    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v PowerThrottlingOff /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v PowerThrottlingOff /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %red%[ %orange%•%purple% %red%]%white% Power Throttling enabled.

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\be337238-0d82-4146-a960-4f3749d470c7" /v Attributes /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\be337238-0d82-4146-a960-4f3749d470c7" /v Attributes /t REG_DWORD /d 0 /f >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %red%[ %orange%•%purple% %red%]%white% Thermal Throttling enabled.

    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo.
    echo   %red%[ %orange%•%purple% %red%]%white% Thermal Limit Locked %green%successfully%white%.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %red%[ %orange%•%purple% %red%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer
    echo --- Thermal Limit unlocked --- >> Ghost_Log.txt
    goto:menu

:: NVIDIA Tweaks
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
    set "lines[0]=                                         Applies general performance tweaks for NVIDIA GPUs."
    set "lines[1]=                                       Custom Ghost Optimizer NVIDIA Profile Inspector settings."

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
    echo.
    echo                                                       %nvidia%[ %verde%%underline%1%reset% %nvidia%]%white% Apply NVIDIA Tweaks
    echo.
    echo                                                       %cinza%[ 2 ] Revert NVIDIA Tweaks%reset%       
    echo.
    echo                                                       %nvidia%[ %verde%%underline%3%reset% %nvidia%]%white% Open Profile Inspector    
    echo.
    echo.
    echo                                                          %nvidia%[ %verde%%underline%M%reset% %nvidia%]%white% Back to Menu

    set /p answer="%white% >:%roxo%"

    :: Option Keys
    if %answer% equ 1 goto:nvidia2
    if %answer% equ 2 goto:nvidia
    if %answer% equ 3 goto:nvidia3
    if "%answer%"=="m" goto:menu
    if "%answer%"=="M" goto:menu

    :: Invalid Input
    goto:nvidia

    :nvidia2
    cls
    echo.
    echo   %nvidia%[ %verde%%underline%•%reset% %nvidia%]%white% Applying %nvidia%NVIDIA%reset% Tweaks... %nvidia%(%verde%~2s%nvidia%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting NVIDIA Tweaks --- >> Ghost_Log.txt

    curl -g -k -L -# -o "C:\Ghost Optimizer\nvidiaProfileInspector.zip" "https://github.com/Orbmu2k/nvidiaProfileInspector/releases/download/2.4.0.27/nvidiaProfileInspector.zip" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    if not exist "C:\Ghost Optimizer\nvidiaProfileInspector.zip" (
        echo   %nvidia%[ %verde%%underline%•%reset% %nvidia%]%white% %red% Failed to download NVIDIA Profile Inspector.%reset% >> Ghost_Log.txt
        echo   %nvidia%[ %verde%%underline%•%reset% %nvidia%]%white% %red% Download failed. Aborting...%reset%
        timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
        goto :nvidia
    )

    if not exist "C:\Ghost Optimizer\NvidiaProfileInspector\" (
        powershell -NoProfile Expand-Archive 'C:\Ghost Optimizer\nvidiaProfileInspector.zip' -DestinationPath 'C:\Ghost Optimizer' >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    )

    del /q "C:\Ghost Optimizer\nvidiaProfileInspector.zip" >nul 2>&1

    curl -g -k -L -# -o "C:\Ghost Optimizer\GhostOPX-NVIDIA.nip" "https://github.com/louzkk/Ghost-Optimizer/raw/main/bin/GhostOPX-NVIDIA.nip" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    if not exist "C:\Ghost Optimizer\GhostOPX-NVIDIA.nip" (
        echo   %nvidia%[ %verde%%underline%•%reset% %nvidia%]%white% %red% Failed to download NVIDIA profile.%reset% >> Ghost_Log.txt
        echo   %nvidia%[ %verde%%underline%•%reset% %nvidia%]%white% %red% Download failed. Aborting...%reset%
        timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
        goto :nvidia
    )

    "C:\Ghost Optimizer\nvidiaProfileInspector.exe" "C:\Ghost Optimizer\GhostOPX-NVIDIA.nip" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1

    echo   %nvidia%[ %verde%%underline%•%reset% %nvidia%]%white% Restarting %nvidia%%underline%Ghost Optimizer%white%... %nvidia%(%verde%~2s%nvidia%)%white%
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Finishing NVIDIA Tweaks --- >> Ghost_Log.txt
    start "" "%~f0"
    exit

    :nvidia3
    cls
    echo.
    echo   %nvidia%[ %verde%%underline%•%reset% %nvidia%]%white% Starting %nvidia%Profile Inspector%white%... %nvidia%(%verde%~2s%nvidia%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Profile Inspector --- >> Ghost_Log.txt
    start "" /wait "C:\Ghost Optimizer\nvidiaProfileInspector.exe" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Profile Inspector Closed --- >> Ghost_Log.txt
    goto:nvidia

:: Services/Bloatware
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
    set "lines[0]=                                             Turns off unnecessary services and bloatware."
    set "lines[1]=                                   Reduces background resource usage without affecting core functions."

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
    echo.
    echo                                                       %purple%[ %roxo%%underline%1%reset% %purple%]%white% Start Services ^& Bloatware Removal
    echo.
    echo                                                       %purple%[ %roxo%%underline%2%reset% %purple%]%white% Revert Services ^& Bloatware Removal      
    echo.
    echo.
    echo                                                         %purple%[ %roxo%%underline%M%reset% %purple%]%white% Back to Menu

    set /p answer="%white% >:%roxo%"

    :: Option Keys
    if %answer% equ 1 goto:services2
    if %answer% equ 2 goto:services3
    if "%answer%"=="m" goto:menu
    if "%answer%"=="M" goto:menu

    :: Invalid Input
    goto:services

    :services2
    cls
    echo.
    echo   %purple%[ %roxo%%underline%•%reset% %purple%]%white% Starting %purple%Services ^& Bloatware%reset% Removal... %purple%(%roxo%~2s%purple%)%reset%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Services and Bloatware Removal --- >> Ghost_Log.txt

    sc config WerSvc start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Error Reporting disabled.

    sc config Spooler start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Print Spooler disabled.

    sc config MapsBroker start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Maps Broker disabled.

    sc config TabletInputService start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config TouchKeyboardAndHandwritingPanelService start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Tablet Input disabled.

    sc config WSearch start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Search disabled.

    sc config bits start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Background Intelligent Transfer disabled.

    sc config CDPSvc start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Connected Devices Platform disabled.

    sc config DiagTrack start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Connected User Experience disabled.

    sc config RemoteRegistry start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Remote Registry disabled.

    sc config WbioSrvc start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Biometric disabled.

    sc config wisvc start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Insider disabled.

    sc config WalletService start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Wallet disabled.

    sc config FrameServer start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Frame Server disabled.

    sc config SysMain start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% SysMain disabled.

    sc config RetailDemo start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Retail Demo disabled.

    sc config xbgm start= disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config XblAuthManager start= disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config XblGameSave start= disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config XboxGipSvc start= disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config XboxNetApiSvc start= disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Xbox Services disabled.

    sc config dmwappushservice start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Device Management Wireless App Push disabled.

    sc config Fax start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Fax service disabled.

    sc config PhoneSvc start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Phone Service disabled.

    sc config SharedAccess start=disabled >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Internet Connection Sharing disabled.

    PowerShell -Command "Get-AppxPackage -allusers *3DBuilder* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% 3DBuilder uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *bing* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Bing Apps uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *bingfinance* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Bing Finance uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *bingsports* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Bing Sports uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *BingWeather* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Bing Weather uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *CommsPhone* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Communications uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *Drawboard PDF* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Drawboard PDF uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *Facebook* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Facebook uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *Getstarted* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Get Started uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *Microsoft.Messaging* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Messaging uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *MicrosoftOfficeHub* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Office Hub uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *Office.OneNote* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% OneNote uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *OneNote* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% OneNote uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *people* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% People uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *SkypeApp* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Skype uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *solit* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Solitaire uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *Sway* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Sway uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *Twitter* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Twitter uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *WindowsAlarms* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Alarms uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *WindowsPhone* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Phone uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *WindowsMaps* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Maps uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *WindowsFeedbackHub* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Feedback Hub uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *WindowsSoundRecorder* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Sound Recorder uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *windowscommunicationsapps* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Communications uninstalled.

    PowerShell -Command "Get-AppxPackage -allusers *zune* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Zune uninstalled.

    Powershell -Command "Get-appxpackage -allusers *Microsoft.549981C3F5F10* | Remove-AppxPackage" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Cortana uninstalled.

    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer (Reboot Required)
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Services ^& Bloatware removed %green%successfully%white%.
    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Finished Services and Bloatware Removal --- >> Ghost_Log.txt
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Restarting %purple%%underline%Ghost Optimizer%white%... %nvidia%(%verde%~2s%nvidia%)%white%
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    start "" "%~f0"
    exit

    :services3
    cls
    echo.
    echo   %purple%[ %roxo%%underline%•%reset% %purple%]%white% Reverting %purple%Services ^& Bloatware%reset% Removal... %purple%(%roxo%~2s%purple%)%reset%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Reverting Services and Bloatware Removal --- >> Ghost_Log.txt

    sc config WerSvc start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Error Reporting enabled.

    sc config Spooler start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Print Spooler enabled.

    sc config MapsBroker start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Maps Broker enabled.

    sc config TabletInputService start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config TouchKeyboardAndHandwritingPanelService start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Tablet Input enabled.

    sc config WSearch start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Search enabled.

    sc config bits start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Background Intelligent Transfer enabled.

    sc config CDPSvc start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Connected Devices Platform enabled.

    sc config DiagTrack start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Connected User Experience enabled.

    sc config RemoteRegistry start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Remote Registry enabled.

    sc config WbioSrvc start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Biometric enabled.

    sc config wisvc start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Insider enabled.

    sc config WalletService start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Wallet enabled.

    sc config FrameServer start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Frame Server enabled.

    sc config SysMain start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% SysMain enabled.

    sc config RetailDemo start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Retail Demo enabled.

    sc config xbgm start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config XblAuthManager start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config XblGameSave start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config XboxGipSvc start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    sc config XboxNetApiSvc start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Xbox Services enabled.

    sc config dmwappushservice start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Device Management Wireless App Push enabled.

    sc config Fax start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Fax service enabled.

    sc config PhoneSvc start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Phone Service enabled.

    sc config SharedAccess start=auto >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Internet Connection Sharing enabled.

    PowerShell -Command "Get-AppxPackage -allusers *3DBuilder* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% 3DBuilder reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *bing* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Bing Apps reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *bingfinance* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Bing Finance reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *bingsports* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Bing Sports reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *BingWeather* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Bing Weather reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *CommsPhone* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Communications reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *Drawboard PDF* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Drawboard PDF reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *Facebook* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Facebook reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *Getstarted* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Get Started reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *Microsoft.Messaging* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Messaging reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *MicrosoftOfficeHub* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Office Hub reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *Office.OneNote* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% OneNote reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *OneNote* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% OneNote reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *people* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% People reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *SkypeApp* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Skype reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *solit* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Solitaire reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *Sway* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Sway reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *Twitter* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Twitter reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *WindowsAlarms* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Alarms reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *WindowsPhone* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Windows Phone reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *WindowsMaps* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Maps reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *WindowsFeedbackHub* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Feedback Hub reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *WindowsSoundRecorder* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Sound Recorder reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *windowscommunicationsapps* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Communications reinstalled.

    PowerShell -Command "Get-AppxPackage -allusers *zune* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}" >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Zune reinstalled.

    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer (Reboot Required)
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Services ^& Bloatware Removal reverted %green%successfully%white%.
    timeout /t 1 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Reverted Services and Bloatware Removal --- >> Ghost_Log.txt
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Restarting %purple%%underline%Ghost Optimizer%white%... %nvidia%(%verde%~2s%nvidia%)%white%
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    start "" "%~f0"
    exit

:: Restart Script

    :restart
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Restarting %purple%%underline%Ghost Optimizer%white%... %purple%(%roxo%~2s%purple%)%white%
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Restarting Ghost Optimizer --- >> Ghost_Log.txt
    start "" "%~f0"
    exit

:: System Tree


    :tree
    title There is literally no reason for me to add this.
    cls
    echo.
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Starting %purple%Tree%white%... %purple%(%roxo%~2s%purple%)%white%
    echo.
    timeout /t 2 /nobreak >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    echo --- Starting Tree --- >> Ghost_Log.txt

    color 5
    tree C:\ /f

    echo   %purple%[ %roxo%•%purple% %purple%]%white% Press Enter to continue...
    pause >> "C:\Ghost Optimizer\Ghost_Log.txt"  2>&1
    title Ghost Optimizer
    echo --- Finished Tree --- >> Ghost_Log.txt
    start "" "%~f0"
    exit

:: Reboot System
    :reboot
    shutdown /r /t 10
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Your system will reboot in %purple%10%reset% seconds to apply optimizations...
    timeout /t 3 /nobreak >nul
    goto:menu

:: Reboot Cancel
    :rebootcancel
    shutdown /a
    echo   %purple%[ %roxo%•%purple% %purple%]%white% Scheduled reboot cancelled %green%successfully%white%..
    timeout /t 3 /nobreak >nul
    goto:menu
