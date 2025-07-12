@echo off
mode 106,25
powershell -command "Add-MpPreference -ExclusionPath 'C:\Ghost-Optimizer'" >nul 2>&1
powershell -command "Add-MpPreference -ExclusionPath '%USERPROFILE%\Desktop\Ghost-Optimizer'" >nul 2>&1
powershell -command "Add-MpPreference -ExclusionPath '%~dp0'" >nul 2>&1
powershell -command "Add-MpPreference -ExclusionPath '%cd%'" >nul 2>&1
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b") >nul 2>&1
reg add HKCU\CONSOLE /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

:variables
set g=[92m
set r=[38;5;196m
set red=[04m
set l=[1m
set w=[0m
set b=[94m
set m=[95m
set p=[38;5;93m
set roxo=[38;5;129m
set c=[35m
set d=[96m
set u=[0m
set z=[91m
set n=[96m
set y=[33m
set g2=[102m
set r2=[101m
set t=[40m
set gg=[93m
set q=[90m
set gr=[32m
set o=[38;5;202m
set bb=[38;5;74m
set nn=[38;5;82m
set rr=[1;91m
set blb=[1;94m
set bn=[1;38;5;129m
set ha=[38;5;203m
set frr=[38;2;0;255;255m
set fw=[97m

:loading
title Ghost-Optimizer // Loading Script
mode 106,25
@echo off
echo !esc![?25l
cls
chcp 65001 >nul
echo.
echo.
echo.
echo.
echo.
echo                                                %p%  ██████       
echo                                               ████████████    
echo                                            ██████████████████ 
echo                                            █████   ██   █████ 
echo                                           ██████   ██   ██████
echo                                          ██████████████████████
echo                                         █████   ███  ███   █████
echo                                         ███  ███   ██   ███  ███
echo                                         ████████████████████████
echo                                         ████    ███  ███    ████
echo.
echo.
echo.                                             Loading (%roxo%~3s%p%)...
timeout /t 3 /nobreak >nul
goto:welcome

:welcome
title Ghost-Optimizer // Read this
mode 106,25
@echo off
echo !esc![?25l
cls
chcp 65001 >nul
cls
echo.
echo.
echo.
echo.                     %p% ██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗
echo.                      ██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝
echo.                      ██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗  
echo.                      ██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝  
echo.                      ╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗
echo.                       ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝%w%
echo.                                                                       
echo. %COL%[90m           ─────────────────────────────────────────────────────────────────────────────── %w%                                                             
echo                         Welcome to %p%Ghost-Optimizer%w% %p%(%roxo%v3.6%p%)%w%, made by %p%@louzkk%w%.
echo.
echo                I am not responsible for any problems that this tool may cause to your PC
echo           It is strictly prohibited to resell this script; doing so may lead to consequences
echo           To select an option, type the corresponding number on your keyboard and press Enter
echo                     Make sure to carefully read all warnings, titles, and messages
echo.
echo          Minimizing the script may cause bugs in the flow, so it is recommended to keep it open
echo.
echo                            Press any key to first create a restore point...
echo.
echo. %COL%[90m           ─────────────────────────────────────────────────────────────────────────────── %w%                                                                                                   
set /p answer=""
goto:restore

:restore
title Ghost-Optimizer // Restore Point
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% You want to create a Restore Point first? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% If any optimization causes any problem in the system or disables something important,
echo  you can restore the system to the previous state without losing files.
echo.
echo  This script does not include an option to revert the optimizations.
echo  To restore the system, you can type %roxo%restore%w% in Main Menu.
echo.
set /p answer="%w% >:%roxo%"

if /i "%answer%"=="y" (
    start /wait SystemPropertiesProtection.exe
    goto :menu
) else if /i "%answer%"=="N" (
    goto :menu
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto :restore
)

:menu
title Ghost-Optimizer // Main Menu
mode 106,25
cls
echo.
echo.
echo.                              %p%   ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗
echo.                                ██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝
echo.                                ██║  ███╗███████║██║   ██║███████╗   ██║   
echo.                                ██║   ██║██╔══██║██║   ██║╚════██║   ██║         
echo.                                ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║      
echo.                                 ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝%w%
echo.                                                                       
echo. %COL%[90m           ─────────────────────────────────────────────────────────────────────────────── %w%                                                             
echo                                           %p%[ %roxo%1 %p%]%w% Optimizations
echo                                           %p%[ %roxo%2 %p%]%w% Game Boost %p%(%roxo%10%p%)%w%
echo                                           %p%[ %roxo%3 %p%]%w% Health Repair
echo                                           %p%[ %roxo%4 %p%]%w% Input Cleaner
echo                                           %p%[ %roxo%5 %p%]%w% MSI Utility
echo.
echo. %COL%[90m           ─────────────────────────────────────────────────────────────────────────────── %w%                                                             
echo                                             %p%Made by: @louzkk%w%
          
echo.                                         
set /p answer="%w% >:%roxo%"

if %answer% equ 1 goto :menu2
if %answer% equ 2 goto :games
if %answer% equ 3 goto :repair
if %answer% equ 4 goto :socd
if %answer% equ 5 goto :msi
if "%answer%"=="louzkk" start https://github.com/louzkk
if "%answer%"=="@louzkk" start https://github.com/louzkk
if "%answer%"=="ghost" start https://github.com/louzkk/Ghost-Optimizer
if "%answer%"=="github" start https://github.com/louzkk/Ghost-Optimizer
if "%answer%"=="reload" goto:variables
if "%answer%"=="reboot" goto:reboot
if "%answer%"=="cancel" goto:rebootcancel
if "%answer%"=="exit" exit
if "%answer%"=="tree" goto:tree
if "%answer%"=="ipconfig" goto:ipconfig
if "%answer%"=="systeminfo" goto:systeminfo
if "%answer%"=="taskinfo" goto:taskinfo
if "%answer%"=="restore" start /wait rstrui.exe

:wronginput
goto:menu

:menu2
title Ghost-Optimizer // Select an Option
mode 106,25
cls
echo.
echo.
echo.                        %p%  ████████╗██╗    ██╗███████╗ █████╗ ██╗  ██╗███████╗
echo.                          ╚══██╔══╝██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔════╝
echo.                             ██║   ██║ █╗ ██║█████╗  ███████║█████╔╝ ███████╗   
echo.                             ██║   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ╚════██║         
echo.                             ██║   ╚███╔███╔╝███████╗██║  ██║██║  ██╗███████║      
echo.                             ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝%w%
echo.                                                                       
echo. %COL%[90m           ─────────────────────────────────────────────────────────────────────────────── %w%                                                             
echo                                          %p%[ %roxo%0 %p%]%w% Execute All
echo.
echo                      %p%[ %roxo%1 %p%]%w% General/Advanced              %p%[ %roxo%2 %p%]%w% Custom Power Plan
echo                      %p%[ %roxo%3 %p%]%w% Thermal Limit                 %p%[ %roxo%4 %p%]%w% Visual Effects
echo                      %p%[ %roxo%5 %p%]%w% GPU Scheduling                %p%[ %roxo%6 %p%]%w% Tracking ^& Telemetry
echo                      %p%[ %roxo%7 %p%]%w% Network/Ping                  %p%[ %roxo%8 %p%]%w% Unnecessary Services
echo                      %p%[ %roxo%9 %p%]%w% Disk Cleanup                  %p%[ %roxo%10 %p%]%w% Disk Decompression
echo.
echo                                       %p%[%roxo%menu%p%]%w% Back to Main Menu
echo.
echo. %COL%[90m           ─────────────────────────────────────────────────────────────────────────────── %w%                                                             
          
echo.                                         
set /p answer="%w% >:%roxo%"

if %answer% equ 0 (
    set "flow=auto"
    goto :optimization
)

if %answer% equ 1 (
    set "flow=manual"
    goto :optimization
)

if %answer% equ 2 (
    set "flow=manual"
    goto :powerplan
)

if %answer% equ 3 (
    set "flow=manual"
    goto :thermal
)

if %answer% equ 4 (
    set "flow=manual"
    goto :effects
)

if %answer% equ 5 (
    set "flow=manual"
    goto :hags
)

if %answer% equ 6 (
    set "flow=manual"
    goto :track
)

if %answer% equ 7 (
    set "flow=manual"
    goto :ping
)

if %answer% equ 8 (
    set "flow=manual"
    goto :services
)

if %answer% equ 9 (
    set "flow=manual"
    goto :clean
)

if %answer% equ 10 (
    set "flow=manual"
    goto :dskcomp
)

if "%answer%"=="louzkk" start https://github.com/louzkk
if "%answer%"=="@louzkk" start https://github.com/louzkk
if "%answer%"=="ghost" start https://github.com/louzkk/Ghost-Optimizer
if "%answer%"=="github" start https://github.com/louzkk/Ghost-Optimizer
if "%answer%"=="reload" goto:variables
if "%answer%"=="update" goto:variables
if "%answer%"=="reboot" goto:reboot
if "%answer%"=="cancel" goto:rebootcancel
if "%answer%"=="exit" exit
if "%answer%"=="menu" goto:menu
if "%answer%"=="back" goto:menu

:wronginput
goto:menu2

:optimization
title Ghost-Optimizer // System Optimization [1/10]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to start %roxo%General%w%/%roxo%Advanced%w% Optimizations? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% The script optimizes Windows with regedits, improving overall performance,
echo  reducing resource usage, latency and input lag, as well as improving gaming performance.
echo.
echo  %p%Recommended:%w% Perform basic and advanced system optimizations for better performance %p%(%roxo%Y%p%)%w%
echo.
set /p answer="%w% >:%roxo%"

if /i "%answer%"=="Y" (
    goto:optimization2
) else if /i "%answer%"=="N" (
    goto:OptimizationSkip
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto:optimization
)

:optimization2
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Starting %roxo%General%w%/%roxo%Advanced%w% Optimizations... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 3 /nobreak >nul

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v disabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 255 /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 255 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberBootEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v HibernateEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v SerializeTimerExpiration /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /t REG_DWORD /d 33554432 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "01" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul 2>nul
fsutil behavior set DisableDeleteNotify 0 >nul 2>nul
echo  %p%[ %roxo%•%p% %p%]%w% General System Optimizations Applied. %p%(%roxo%30%p%)%w%

wmic computersystem >nul 2>&1
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True >nul 2>&1
sc config SysMain start= disabled >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Defrag\ScheduledDefrag" /ENABLE >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 1 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Optimized Memory %p%(%roxo%RAM%p%)%w% Management. %p%(%roxo%4%p%)%w%

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMin" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergySaverPolicy" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Attributes" /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Affinity" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Background Only" /t REG_SZ /d "False" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Clock Rate" /t REG_DWORD /d 65536 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Priority" /t REG_DWORD /d 6 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "BackgroundPriority" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "GPU Priority" /t REG_DWORD /d 15 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Scheduling Category" /t REG_SZ /d "Medium" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Games" /v "Start" /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 26 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Gaming Optimizations Applied. %p%(%roxo%23%p%)%w%

reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d 0 /f >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Fullscreen Optimizations disabled. %p%(%roxo%3%p%)%w%

reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v value /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Xbox Game Bar%w% e Game DVR disabled. %p%(%roxo%6%p%)%w%

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >nul 2>nul
echo  %p%[ %roxo%•%p% %p%]%w% Windows Widgets %p%(%roxo%TaskbarDa%p%)%w% disabled. %p%(%roxo%3%p%)%w%

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "Latency" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "TransitionLatency" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "Append Completion" /t REG_SZ /d "yes" /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "AutoSuggest" /t REG_SZ /d "yes" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 10 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ExtendedUIHoverTime /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "10" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MouseHoverTime /t REG_SZ /d 10 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v LowLevelHooksTimeout /t REG_SZ /d 1000 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v AutoEndTasks /t REG_SZ /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WaitToKillAppTimeout /t REG_SZ /d 2000 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d 1000 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v ForegroundLockTimeout /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 2000 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "TimerResolution" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm" /v "FlipQueueSize" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v FrameLatency /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v ClockTimerResolution /t REG_DWORD /d 1 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Reduced system response time and latency. %p%(%roxo%55%p%)%w%

reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "SwapMouseButtons" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v "EnablePrecision" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v KeyboardDataQueueSize /t REG_DWORD /d 30 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MouseDataQueueSize /t REG_DWORD /d 30 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Mouse and Touchpad Optimizations Applied. %p%(%roxo%5%p%)%w%

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 10 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\Drivers" /v "SoftwareOnly" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\DirectInput" /v "EnableBackgroundProcessing" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Direct3D" /v "DisableDebugLayer" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Direct3D" /v "DisablePrintToDebugger" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global" /v "ShaderCacheMaxKBytes" /t REG_DWORD /d 33554432 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global" /v "ShaderCachePersistence" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak" /v "ThreadedOptimization" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak" /v "LowLatencyMode" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 1 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Optimized %bb%DirectX%w% ^& %o%Vulkan%w% rendering. %p%(%roxo%16%p%)%w%

bcdedit /set tscsyncpolicy enhanced >nul
bcdedit /set uselegacyapicmode No >nul
bcdedit /deletevalue useplatformclock >nul
bcdedit /deletevalue useplatformtick >nul
echo  %p%[ %roxo%•%p% %p%]%w% Boot Optimizations %p%(%roxo%bcdedit%p%)%w% Applied. %p%(%roxo%4%p%)%w%

sc stop AMDExternalEvents >nul 2>&1
sc config AMDExternalEvents start= disabled >nul 2>&1
sc stop AMDLinkAgent >nul 2>&1
sc config AMDLinkAgent start= disabled >nul 2>&1
sc stop AMDCrashDefender >nul 2>&1
sc config AMDCrashDefender start= disabled >nul 2>&1
reg add "HKLM\SOFTWARE\AMD\CN" /v "DisableDriverTelemetry" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\AMD\RadeonSettings" /v ShaderCache /t REG_DWORD /d 1 /f >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% %r%AMD%w% Driver Optimizations Applied. %p%(%roxo%8%p%)%w%

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Intel\Display" /v "EnableGameMode" /t REG_DWORD /d 1 /f >nul 2>&1
sc stop "Intel Capability Licensing Service Interface" >nul 2>&1
sc config "Intel Capability Licensing Service Interface" start= disabled >nul 2>&1
sc stop "Intel Dynamic Application Loader Host Interface Service" >nul 2>&1
sc config "Intel Dynamic Application Loader Host Interface Service" start= disabled >nul 2>&1
sc stop "Intel Service Manager" >nul 2>&1
sc config "Intel Service Manager" start= disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% %b%Intel%w% Driver Optimizations Applied. %p%(%roxo%7%p%)%w%

sc stop LMS >nul 2>&1
sc config LMS start= disabled >nul 2>&1
sc stop NvTelemetryContainer >nul 2>&1
sc config NvTelemetryContainer start= disabled >nul 2>&1
sc stop NvTelemetryNetworkService >nul 2>&1
sc config NvTelemetryNetworkService start= disabled >nul 2>&1
sc stop NvContainerLocalSystem >nul 2>&1
sc config NvContainerLocalSystem start= disabled >nul 2>&1
sc stop NvContainerNetworkService >nul 2>&1
sc config NvContainerNetworkService start= disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% %g%NVIDIA%w% Driver Optimizations Applied. %p%(%roxo%12%p%)%w%

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v RequirePlatformSecurityFeatures /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v HVCIMATRequired /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul
bcdedit /set hypervisorlaunch off >nul 2>nul
echo  %p%[ %roxo%•%p% %p%]%w% Virtualization Based Security %p%(%roxo%VBS%p%)%w% disabled. %p%(%roxo%7%p%)%w%

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% %r%Spectre%w%/%r%Meltdown%w% algorithms disabled. %p%(%roxo%3%p%)%w%

reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v WindowedGsyncGeforceFlag /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v FrameRateMin /t REG_DWORD /d 0xFFFFFFFF /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v IgnoreDisplayChangeDuration /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v LingerInterval /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v LicenseInterval /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v RestrictedNvcplUIMode /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v DisableSpecificPopups /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v DisableExpirationPopups /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v EnableForceIgpuDgpuFromUI /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v HideXGpuTrayIcon /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v ShowTrayIcon /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v HideBalloonNotification /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v PerformanceState /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v Gc6State /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v FrameDisplayBaseNegOffsetNS /t REG_DWORD /d 0xFFE17B80 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v FrameDisplayResDivValue /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v IgnoreNodeLocked /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v IgnoreSP /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM\Schedule" /v DontAskAgain /t REG_DWORD /d 1 /f >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%DWM%w% Optimizations Applied. %p%(%roxo%20%p%)%w%

reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v OverlayTestMode /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v FlipQueueSize /t REG_DWORD /d 1 /f >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%WDDM%w% Optimizations Applied. %p%(%roxo%2%p%)%w%

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v KiClockTimerPerCpu /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v KiClockTimerHighLatency /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v KiClockTimerAlwaysOnPresent /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v ClockTimerPerCpu /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v ClockTimerHighLatency /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v ClockTimerAlwaysOnPresent /t REG_DWORD /d 1 /f >nul
bcdedit /set disabledynamictick No >nul
echo  %p%[ %roxo%•%p% %p%]%w% Kernel Optimizations Applied. %p%(%roxo%7%p%)%w%

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\ea062031-0e34-4ff1-9b6d-eb1059334028" /v ACSettingIndex /t REG_DWORD /d 100 /f >nul 2>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4ff1-9b6d-eb1059334028" /v DCSettingIndex /t REG_DWORD /d 100 /f >nul 2>nul
powercfg -setactive SCHEME_CURRENT >nul 2>nul
echo  %p%[ %roxo%•%p% %p%]%w% Unpaked all CPU Cores. %p%(%roxo%3%p%)%w%

echo.
echo  %p%[ %roxo%•%p% %p%]%w% All %roxo%General%w%/%roxo%Advanced%w% Optimizations applied %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul
goto:OptimizationSkip

:OptimizationSkip
if /i "%flow%"=="auto" (
    goto :powerplan
) else (
    goto:menu2
)

:powerplan
title Ghost-Optimizer // Power Plan [2/10]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to apply a custom %roxo%Power Plan%w%? %p%(%roxo%1%p%/%roxo%2%p%/%roxo%3%p%/%roxo%4%p%%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% This will apply a custom power plan designed to optimize system performance,
echo  improving responsiveness, FPS, and latency while balancing power efficiency when idle.
echo.
echo  %p%Recommended%w% Chose a power plan based on your system's capabilities and needs.
echo.
echo  1 - %p%(%roxo%Ghost%p%)%w% - Highest performance and lower latency, with some power saving.
echo  2 - %p%(%roxo%Core%p%)%w% - Maximum performance and responsiveness, no power saving.
echo  3 - %p%(%roxo%Khorvie%p%)%w% - Good performance and lower latency, with some power saving.
echo  4 - %p%(%roxo%Skip%p%)%w% - Keep your current power plan unchanged.

echo.
set /p answer="%w% >:%roxo%"

if /i "%answer%"=="1" (
    goto:ghost
)
if /i "%answer%"=="2" (
    goto:core
)
if /i "%answer%"=="3" (
    goto:khorvie
)
if /i "%answer%"=="4" (
    goto:PowerPlanSkip
)
if /i "%answer%"=="n" (
    goto:PowerPlanSkip
)

echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please choose between %roxo%1%w%, %roxo%2%w%, %roxo%3%w% or %roxo%4%w%.
timeout /t 2 /nobreak >nul
goto :powerplan

:PowerPlanSkip
if /i "%flow%"=="auto" (
    goto:thermal
) else (
    goto:menu2
)

:core
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Applying %roxo%Core%w% Power Plan... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 3 /nobreak >nul
echo  %p%[ %roxo%•%p% %p%]%w% Importing %roxo%Core.pow%w% Power Plan...  %p%(%roxo%~3s%p%)%w%

setlocal enabledelayedexpansion

powercfg /import "%~dp0Core.pow" >nul

for /f "tokens=2 delims=:()" %%i in ('powercfg /list ^| findstr /i "Core"') do (
    set GUID=%%i
    set GUID=!GUID: =!
)

if not defined GUID (
    echo  %r%Warning:%w% Power plan not found!%w%
    exit /b 1
)

powercfg /setactive !GUID! >nul
timeout /t 1 /nobreak >nul

endlocal

echo.
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Core%w% Powerplan applied %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul

:PowerPlanSkip
if /i "%flow%"=="auto" (
    goto:thermal
) else (
    goto:menu2
)

:khorvie
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Applying %roxo%Khorvie%w% Power Plan... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 3 /nobreak >nul
echo  %p%[ %roxo%•%p% %p%]%w% Importing %roxo%Khorvie.pow%w% Power Plan...  %p%(%roxo%~3s%p%)%w%

setlocal enabledelayedexpansion

powercfg /import "%~dp0Khorvie.pow" >nul

for /f "tokens=2 delims=:()" %%i in ('powercfg /list ^| findstr /i "Khorvie"') do (
    set GUID=%%i
    set GUID=!GUID: =!
)

if not defined GUID (
    echo  %r%Warning:%w% Power plan not found!%w%
    exit /b 1
)

powercfg /setactive !GUID! >nul
timeout /t 1 /nobreak >nul

endlocal

echo.
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Khorvie%w% Powerplan applied %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul

:PowerPlanSkip
if /i "%flow%"=="auto" (
    goto:thermal
) else (
    goto:menu2
)

:ghost
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Applying %roxo%Ghost%w% Power Plan... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 3 /nobreak >nul
echo  %p%[ %roxo%•%p% %p%]%w% Importing %roxo%Ghost.pow%w% Power Plan...  %p%(%roxo%~3s%p%)%w%

setlocal enabledelayedexpansion

powercfg /import "%~dp0Ghost.pow" >nul

for /f "tokens=2 delims=:()" %%i in ('powercfg /list ^| findstr /i "Ghost's Power Plan"') do (
    set GUID=%%i
    set GUID=!GUID: =!
)

if not defined GUID (
    echo  %r%Warning:%w% Power plan not found!%w%
    exit /b 1
)

powercfg /setactive !GUID! >nul
timeout /t 1 /nobreak >nul

endlocal

echo.
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Ghost%w% Powerplan applied %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul

:PowerPlanSkip
if /i "%flow%"=="auto" (
    goto:thermal
) else (
    goto:menu2
)

:thermal
title Ghost-Optimizer // Thermal Limit [3/10]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to unlock the CPU/GPU %roxo%Thermal Limit%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% Unlocking the CPU/GPU thermal limit allows maximum hardware performance,
echo  but reduces the lifespan of the components. Not recommended for Notebookos/Laptops.
echo.
echo  %p%Recommended%w% Only activate if your cooling system is good enough to handle the heat.
echo.
set /p answer="%w% >:%roxo%"

if /i "%answer%"=="Y" (
    goto :thermal2
) else if /i "%answer%"=="N" (
    goto :ThermalSkip
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto:thermal
)

:thermal2
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Unlocking the %roxo%Thermal Limit%w%... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 3 /nobreak >nul

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\be337238-0d82-4146-a960-4f3749d470c7" /v Attributes /t REG_DWORD /d 2 /f >nul 2>nul

echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Thermal Limit%w% unlocked %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul

:ThermalSkip
if /i "%flow%"=="auto" (
    goto:effects
) else (
    goto:menu2
)

:effects
title Ghost-Optimizer // Visual Effects and Animations [4/10]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to disable %roxo%Windows Visual Effects%w% and %roxo%Animations%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% This will only affect the appearance of Windows, relieving the use of the CPU and GPU.
echo  Some visual effects like blur, window animations and shadows will be disabled (minimal effects).
echo.
echo  %p%Recommended%w% Proceed %p%(%roxo%Y%p%)%w% if you prioritize performance over appearance.
echo.
set /p answer="%w% >:%roxo%"

if /i "%answer%"=="Y" (
    goto:effects2
) else if /i "%answer%"=="N" (
    goto:EffectsSkip
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto:effects
)

:effects2
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Disabling %roxo%Windows Visual Effects%w% and %roxo%Animations%w%... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 3 /nobreak >nul

sc config defragsvc start= delayed-auto >nulreg add "HKCU\Control Panel\Desktop" /v "SmoothScroll" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v "AllowWindowsInkWorkspace" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "TaskbarAnimations" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "WindowAnimations" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ThumbnailCacheSize" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "FontSmoothing" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Desktop" /v "VisualFXSetting" /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "MenuAnimations" /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Visual Effects and Animations disabled. %p%(%roxo%10%p%)%w%

timeout /t 1 /nobreak >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Transparency %p%(%roxo%Blur%p%)%w% disabled.. %p%(%roxo%1%p%)%w%

timeout /t 1 /nobreak >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f >nul 2>nul
echo  %p%[ %roxo%•%p% %p%]%w% Aero Peak disabled.. %p%(%roxo%1%p%)%w%

echo.
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Windows Visual Effects%w% and %roxo%Animations%w% disabled %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul

:EffectsSkip
if /i "%flow%"=="auto" (
    goto:hags
) else (
    goto:menu2
)

:hags
title Ghost-Optimizer // GPU Optimization [5/10]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to enable %roxo%Hardware Accelerated GPU Scheduling%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% The GPU scheduler %p%(%roxo%HwSchMode%p%)%w% lets the GPU handle its own task
echo  scheduling, reducing CPU load and potentially improving performance and latency.
echo.
echo  %p%Recommended:%w% It's relative, in some systems there may be improvements, in others there may be stuttering.
echo.
set /p answer="%w% >:%roxo%"

if /i "%answer%"=="Y" (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul
    echo  %p%[ %roxo%•%p% %p%]%w% Hardware Accelerated GPU Scheduling enabled %g%successfully%w%!
    timeout /t 2 /nobreak >nul
    goto:HagsSkip
) else if /i "%answer%"=="N" (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 1 /f >nul
    goto:HagsSkip
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto:hags
)

:HagsSkip
if /i "%flow%"=="auto" (
    goto:track
) else (
    goto:menu2
)


:track
title Ghost-Optimizer // Tracking ^& Telemetry [6/10]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to disable and block %roxo%Tracking %w%^& %roxo%Telemetry%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% Disables Windows telemetry, tracking services, diagnostics, location
echo  and targeted ads while improving system privacy by blocking data collection and telemetry domains.
echo.
echo  %p%Recommended%w% Proceed %p%(%roxo%Y%p%)%w% for better privacy and less resource usage.
echo.
set /p answer="%w% >:%roxo%"

if /i "%answer%"=="Y" (
    goto:track2
) else if /i "%answer%"=="N" (
    goto:TrackSkip
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto:track
)

:track2
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Starting %roxo%Tracking %w%^& %roxo%Telemetry%w% blocking... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 3 /nobreak >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Advertising with Ad ID disabled... %p%(%roxo%1%p%)%w%

sc stop DiagTrack >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc stop DPS >nul 2>&1
sc config DPS start=disabled >nul 2>&1
sc stop diagnosticshub.standardcollector.service >nul 2>&1
sc config diagnosticshub.standardcollector.service start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Tracking and Telemetry Services disabled... %p%(%roxo%4%p%)%w%

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable >nul
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable >nul
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 4 /f >nul
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1

echo  %p%[ %roxo%•%p% %p%]%w% Telemetry and Diagnostics disabled... %p%(%roxo%7%p%)%w%

reg add "HKCU\Software\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v PeriodInDays /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v NumberOfNotificationsSent /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Personalized %o%Feedback and Experiences%w% disabled... %p%(%roxo%5%p%)%w%

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v Value /t REG_SZ /d Deny /f >nul
:: reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v Value /t REG_SZ /d Deny /f >nul
:: reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v Value /t REG_SZ /d Deny /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Location and Data Sensors disabled... %p%(%roxo%4%p%)%w%

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% App Suggestions on the Start Menu disabled... %p%(%roxo%3%p%)%w%

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% %bb%Tips and Tricks Suggestions%w% disabled... %p%(%roxo%1%p%)%w%

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Windows Consumer Features %p%(%roxo%Bloatware%p%)%w% disabled... %p%(%roxo%1%p%)%w%

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% %b%Cortana%w% Search disabled... %p%(%roxo%1%p%)%w%

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Global Background Apps disabled... %p%(%roxo%1%p%)%w%

reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Online Search on Start Menu disabled... %p%(%roxo%1%p%)%w%

reg add "HKLM\System\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Remote Assistance disabled. %p%(%roxo%1%p%)%w%

schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable >nul 2>&1
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Customer Experience Improvement Program collection disabled. %p%(%roxo%10%p%)%w%

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Upload Activities %p%(%roxo%Windows Timeline%p%)%w% disabled. %p%(%roxo%2%p%)%w%

reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v MetricsReportingEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v UserFeedbackAllowed /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v AllowPrelaunch /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v AllowTabPreloading /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v StartupBoostEnabled /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Microsoft Edge Webview tracking disabled. %p%(%roxo%2%p%)%w%

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\NVIDIA Corporation\Global\NvTelemetry" /v "Enabled" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\AMD\ACE\Settings\General" /v "EnableTelemetry" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Intel\Display\igfxcui\Telemetry" /v "EnableTelemetry" /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% %r%AMD%w%, %b%Intel%w% and %g%NVIDIA%w% Driver telemetry disabled. %p%(%roxo%3%p%)%w%

echo  %p%[ %roxo%•%p% %p%]%w% Blocking telemetry domains... %p%(%roxo%11%p%)%w%
(
echo 0.0.0.0 vortex.data.microsoft.com
echo 0.0.0.0 settings-win.data.microsoft.com
echo 0.0.0.0 watson.telemetry.microsoft.com
echo 0.0.0.0 telemetry.microsoft.com
echo 0.0.0.0 telecommand.telemetry.microsoft.com
echo 0.0.0.0 services.wes.df.telemetry.microsoft.com
echo 0.0.0.0 sqm.df.telemetry.microsoft.com
echo 0.0.0.0 telemetry.nvidia.com
echo 0.0.0.0 telemetry.amd.com
) >> %WINDIR%\System32\drivers\etc\hosts

timeout /t 1 /nobreak >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Tracking %w%^& %roxo%Telemetry%w% disabled %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul

:TrackSkip
if /i "%flow%"=="auto" (
    goto:ping
) else (
    goto:menu2
)

:ping
title Ghost-Optimizer // Network Optimization [7/10]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to start %roxo%Network%w%/%roxo%Ping%w% Optimizations? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% Optimizes network to reduce latency, improve packet delivery, and boost connection by
echo  disabling bandwidth limits, enhancing DNS resolution, and fine-tuning TCP parameters for lower ping.
echo.
echo  %p%Recommended%w% Proceed %p%(%roxo%Y%p%)%w% to improve the connection and security.
echo.
set /p answer="%w% >:%roxo%"

if /i "%answer%"=="Y" (
    goto:ping2
) else if /i "%answer%"=="N" (
    goto:PingSkip
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto:ping
)

:ping2
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Starting %roxo%Network%w%/%roxo%Ping%w% Optimizations... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 2 /nobreak >nul

echo  %p%[ %roxo%•%p% %p%]%w% Detecting Active Network Interface... %p%(%roxo%~2s%p%)%w%
for /f "tokens=3 delims={}" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" ^| find "{"') do (
    set "InterfaceID=%%A"
)

for /f "tokens=1*" %%i in ('netsh interface show interface ^| findstr "Conectado"') do set "netinterface=%%j"

echo  %p%[ %roxo%•%p% %p%]%w% Network Interface detected. %InterfaceID%
timeout /t 1 >nul

netsh int tcp set heuristics disabled >nul
netsh int tcp set global autotuninglevel=disabled >nul
netsh int tcp set global congestionprovider=ctcp >nul
netsh int tcp set global ecncapability=disabled >nul
netsh int tcp set global chimney=disabled >nul
netsh int ipv4 set dynamicport udp start=10000 num=55535 >nul
netsh interface ipv4 set subinterface "%netinterface%" mtu=1500 store=persistent >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% General Network %p%(%roxo%ipv4%p%)%w% Optimizations Applied. %p%(%roxo%7%p%)%w%

netsh interface ip set dns name="%netinterface%" source=static addr=1.1.1.1 register=PRIMARY >nul
netsh interface ip add dns name="%netinterface%" addr=1.0.0.1 index=2 >nul
echo  %p%[ %roxo%•%p% %p%]%w% %o%Cloudflare DNS%w% addresses configured. %p%(%roxo%2%p%)%w%

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Network Throttling disabled. %p%(%roxo%2%p%)%w%

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{%InterfaceID%}" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{%InterfaceID%}" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Nagle Algorithm %p%(%roxo%TCP%p%)%w% disabled. %p%(%roxo%2%p%)%w%

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DisableTaskOffload /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v EnableTCPChimney /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v EnableRSS /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v EnableTCPA /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% TCP Offload, RSS and NetDMA disabled. %p%(%roxo%4%p%)%w%

reg add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v DisableBandwidthThrottling /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v MaxCmds /t REG_DWORD /d 2048 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Network Throughput optimizations applied. %p%(%roxo%3%p%)%w%

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpMaxHalfOpen /t REG_DWORD /d 100 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpMaxHalfOpenRetried /t REG_DWORD /d 80 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpMaxPortsExhausted /t REG_DWORD /d 5 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpNumConnections /t REG_DWORD /d 500 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Increased TCP Simultaneous Packets. %p%(%roxo%4%p%)%w%

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v EnableECN /t REG_DWORD /d 1 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Quality of Service %p%(%roxo%QoS%p%)%w% optimizations applied. %p%(%roxo%2%p%)%w%

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v CacheHashTableBucketSize /t REG_DWORD /d 384 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v CacheHashTableSize /t REG_DWORD /d 384 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheEntryTtlLimit /t REG_DWORD /d 64000 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheTtl /t REG_DWORD /d 64000 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% DNS Cache optimizations applied. %p%(%roxo%4%p%)%w%

echo  %p%[ %roxo%•%p% %p%]%w% Clearing DNS Cache %p%(%roxo%Flush DNS%p%)%w%...
ipconfig /flushdns >nul
timeout /t 1 /nobreak >nul
echo  %p%[ %roxo%•%p% %p%]%w% DNS Cache cleared. %p%(%roxo%1%p%)%w%

reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v BufferAlignment /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DefaultReceiveWindow /t REG_DWORD /d 262144 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DefaultSendWindow /t REG_DWORD /d 262144 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DisableAddressSharing /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DisableChainedReceive /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v disabledirectAcceptEx /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DoNotHoldNICBuffers /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v DynamicSendBufferDisable /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v FastSendDatagramThreshold /t REG_DWORD /d 1024 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v FastCopyReceiveThreshold /t REG_DWORD /d 1024 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v IgnoreOrderlyRelease /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v IgnorePushBitOnReceives /t REG_DWORD /d 1 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Buffer and Address Optimizations Applied. %p%(%roxo%14%p%)%w%

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DownloadMode /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Delivery Optimization disabled. %p%(%roxo%2%p%)%w%

echo.
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Network%w%/%roxo%Ping%w% Optimizations applied %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul

:PingSkip
if /i "%flow%"=="auto" (
    goto:services
) else (
    goto:menu2
)

:services
title Ghost-Optimizer // Unnecessary Services [8/10]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to disable %roxo%Unnecessary Services%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% Disables unnecessary Windows services to reduce background resource usage.
echo  Include tracking, xbox services, printer service, search indexing and background update.
echo.
echo  %p%Recommended%w% Proceed %p%(%roxo%Y%p%)%w% to free up resources. You can manually activate them later.
echo.
set /p answer="%w% >:%roxo%"

if /i "%answer%"=="Y" (
    goto:services2
) else if /i "%answer%"=="N" (
    goto:ServicesSkip
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto:services
)

:services2
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Starting %roxo%Unnecessary Services%w% deactivation... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 3 /nobreak >nul

reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v Status /t REG_DWORD /d 0 /f >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Location Service disabled. %p%(%roxo%1%p%)%w%

sc stop WerSvc >nul 2>&1
sc config WerSvc start=disabled >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Error Reporting Service disabled. %p%(%roxo%3%p%)%w%

sc stop Spooler >nul 2>&1
sc config Spooler start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Print Spooler %p%(%roxo%Printer%p%)%w% Service disabled. %p%(%roxo%2%p%)%w%

sc stop MapsBroker >nul 2>&1
sc config MapsBroker start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Map Agent Service disabled. %p%(%roxo%2%p%)%w%

sc stop TabletInputService >nul 2>&1
sc config TabletInputService start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Tablet Input Service disabled. %p%(%roxo%2%p%)%w%

sc stop WSearch >nul 2>&1
sc config WSearch start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Search Indexing Service %p%(%roxo%WSearch%p%)%w% disabled. %p%(%roxo%2%p%)%w%

sc stop bits >nul 2>&1
sc config bits start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Intelligent Transfer %p%(%roxo%BITS%p%)%w% Service disabled. %p%(%roxo%2%p%)%w%

sc stop CDPSvc >nul 2>&1
sc config CDPSvc start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Connected User Experiences disabled. %p%(%roxo%2%p%)%w%

sc stop RemoteRegistry >nul 2>&1
sc config RemoteRegistry start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Remote Registry disabled. %p%(%roxo%2%p%)%w%

sc stop WbioSrvc >nul 2>&1
sc config WbioSrvc start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Biometric Service disabled. %p%(%roxo%2%p%)%w%

sc stop wisvc >nul 2>&1
sc config wisvc start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Windows Insider Service disabled. %p%(%roxo%2%p%)%w%

sc stop WalletService >nul 2>&1
sc config WalletService start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Wallet Service disabled. %p%(%roxo%2%p%)%w%

sc stop FrameServer >nul 2>&1
sc config FrameServer start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Camera Frame Server disabled. %p%(%roxo%2%p%)%w%

sc stop SysMain >nul 2>&1
sc config SysMain start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% SysMain ^& Superfetch %p%(%roxo%Preloader%p%)%w% disabled. %p%(%roxo%2%p%)%w%

sc stop XblAuthManager >nul 2>&1
sc config XblAuthManager start=disabled >nul 2>&1
sc stop XblGameSave >nul 2>&1
sc config XblGameSave start=disabled >nul 2>&1
sc stop XboxGipSvc >nul 2>&1
sc config XboxGipSvc start=disabled >nul 2>&1
sc stop XboxNetApiSvc >nul 2>&1
sc config XboxNetApiSvc start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Xbox Services disabled. %p%(%roxo%8%p%)%w%

sc stop RetailDemo >nul 2>&1
sc config RetailDemo start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Retail Demo Service disabled. %p%(%roxo%2%p%)%w%

sc stop wuauserv >nul 2>&1
sc config wuauserv start=disabled >nul 2>&1
sc stop UsoSvc >nul 2>&1
sc config UsoSvc start=disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Windows Update Service disabled. %p%(%roxo%4%p%)%w%

echo.
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Unnecessary Services%w% disabled %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul

:ServicesSkip
if /i "%flow%"=="auto" (
    goto:clean
) else (
    goto:menu2
)

:clean
title Ghost-Optimizer // Temporary Files [9/10]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to start %roxo%Disk Cleanup%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% Disk Cleanup removes temporary and unnecessary files, logs, junk files,
echo  and caches to free up storage and improve system performance. Does not affect personal files.
echo.
echo  %p%Recommended%w% Only perform this process every %p%2%roxo%-%p%3%w% months.
echo.
set /p answer="%w% >:%roxo%"

if /i "%answer%"=="Y" (
    goto:clean2
) else if /i "%answer%"=="N" (
    goto:CleanSkip
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto:clean
)

:clean2
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Starting %roxo%Disk Cleanup%w%... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 3 /nobreak >nul

echo  %p%[ %roxo%•%p% %p%]%w% Cleaning user temporary files...
del /f /s /q %temp%\* >nul 2>&1
rd /s /q %temp% >nul 2>&1
mkdir %temp% >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% User temporary files cleaned. %p%(%roxo%3%p%)%w%

echo  %p%[ %roxo%•%p% %p%]%w% Cleaning system temporary files...
del /f /s /q C:\Windows\Temp\* >nul 2>&1
rd /s /q C:\Windows\Temp >nul 2>&1
mkdir C:\Windows\Temp >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% System temporary files cleaned. %p%(%roxo%3%p%)%w%

echo  %p%[ %roxo%•%p% %p%]%w% Cleaning Prefetch files %p%(%roxo%Preloader%p%)%w%...
del /f /s /q C:\Windows\Prefetch\* >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Prefetch files cleaned. %p%(%roxo%1%p%)%w%

echo  %p%[ %roxo%•%p% %p%]%w% Cleaning Event Log files...
wevtutil cl Application
wevtutil cl Security
wevtutil cl System
echo  %p%[ %roxo%•%p% %p%]%w% Event Log files cleaner. %p%(%roxo%3%p%)%w%

echo  %p%[ %roxo%•%p% %p%]%w% Cleaning Windows Update Temp files...
net stop wuauserv >nul 2>&1
del /f /s /q C:\Windows\SoftwareDistribution\Download\* >nul 2>&1
net start wuauserv >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Windows Update Temp files cleaned. %p%(%roxo%3%p%)%w%

echo  %p%[ %roxo%•%p% %p%]%w% Cleaning Delivery Optimization files...
del /f /s /q C:\Windows\SoftwareDistribution\DeliveryOptimization\* >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Delivery Optimization files cleaned. %p%(%roxo%1%p%)%w%

echo  %p%[ %roxo%•%p% %p%]%w% Cleaning Thumbnails cache files...
del /f /s /q %userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_* >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Thumbnails cache files cleaned. %p%(%roxo%1%p%)%w%

echo  %p%[ %roxo%•%p% %p%]%w% Cleaning Recycle Bin %p%(%roxo%C:\, D:\, E:\.%p%)%w%...
rd /s /q C:\$Recycle.Bin
rd /s /q D:\$Recycle.Bin
rd /s /q E:\$Recycle.Bin
echo  %p%[ %roxo%•%p% %p%]%w% Recycle Bin cleaned. %p%(%roxo%3%p%)%w%

echo  %p%[ %roxo%•%p% %p%]%w% Cleaning Mini-Dump files...
del /f /s /q C:\Windows\Minidump\* >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% Mini-Dump files cleaned. %p%(%roxo%1%p%)%w%

del /q /f "%LocalAppData%\D3DSCache\*.*" >nul 2>&1
del /q /f "%LocalAppData%\NVIDIA\DXCache\*.*" >nul 2>&1
del /q /f "%LocalAppData%\NVIDIA\GLCache\*.*" >nul 2>&1
del /q /f "%LocalAppData%\AMD\DxCache\*.*" >nul 2>&1
del /q /f "%AppData%\Vulkan\*.*" >nul 2>&1
del /q /f "%LocalAppData%\Vulkan\*.*" >nul 2>&1
mkdir "%LocalAppData%\D3DSCache" >nul 2>&1
mkdir "%LocalAppData%\NVIDIA\DXCache" >nul 2>&1
mkdir "%LocalAppData%\NVIDIA\GLCache" >nul 2>&1
mkdir "%LocalAppData%\AMD\DxCache" >nul 2>&1
mkdir "%AppData%\Vulkan" >nul 2>&1
mkdir "%LocalAppData%\Vulkan" >nul 2>&1 
echo  %p%[ %roxo%•%p% %p%]%w% %bb%DirectX%w% ^& %o%Vulkan%w% temp files cleaned. %p%(%roxo%12%p%)%w%

echo.
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Temporary files%w% cleaned %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul
goto:final

:CleanSkip
if /i "%flow%"=="auto" (
    goto:dskcomp
) else (
    goto:menu2
)

:dskcomp
title Ghost-Optimizer // Disk Compression [10/10]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to disable %roxo%Disk Compression%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% Disabling Disk Compression reduces CPU usage on file access, improves loading times,
echo  reduces stuttering, and increases system responsiveness. It will decompress every compressed file.
echo.
echo  %p%Recommended%w% Only perform this process %p%1%w% time. It can increase storage usage.
echo.
set /p answer="%w% >:%roxo%"

if /i "%answer%"=="y" (
    goto:DskCompSkip
) else if /i "%answer%"=="n" (
    goto:menu2
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto:dskcomp
)

:dskcomp2
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Disabling %roxo%Disk Compression%w%... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 3 /nobreak >nul

fsutil behavior set DisableCompression 1
echo  %p%[ %roxo%•%p% %p%]%w% Disk File Compression disabled. %p%(%roxo%1%p%)%w%

echo  %p%[ %roxo%•%p% %p%]%w% Starting Disk Decompression...
echo.
compact /U /S:C:\ /I /Q
echo.
echo  %p%[ %roxo%•%p% %p%]%w% Disk Decompressed %g%successfully%w%.

echo  %p%[ %roxo%•%p% %p%]%w% Running System File Checker %p%(%roxo%SFC%p%)%w% to ensure integrity...
echo.
sfc /scannow
echo.
echo  %p%[ %roxo%•%p% %p%]%w% System Integrity repaired %g%successfully%w%.

echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Disk Compression%w% disabled %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul

:DskCompSkip
if /i "%flow%"=="auto" (
    goto:final
) else (
    goto:menu2
)

:final
title Ghost-Optimizer // Final Steps
mode 106,25
@echo off
echo !esc![?25l
cls
chcp 65001 >nul
echo.
echo.
echo.
echo.
echo.
echo                                                %p%  ██████       
echo                                               ████████████    
echo                                            ██████████████████ 
echo                                            █████   ██   █████ 
echo                                           ██████   ██   ██████
echo                                          ██████████████████████
echo                                         █████   ███  ███   █████
echo                                         ███  ███   ██   ███  ███
echo                                         ████████████████████████
echo                                         ████    ███  ███    ████
echo.
echo.
echo.                                            Finishing (%roxo%~3s%p%)...
timeout /t 3 /nobreak >nul
goto:final2

:final2
title Ghost-Optimizer // Final Steps
mode 106,25
@echo off
echo !esc![?25l
cls
chcp 65001 >nul
echo.
echo.
echo.
echo.
echo.
echo                                                %p%  ██████       
echo                                               ████████████    
echo                                            ██████████████████ 
echo                                            █████   ██   █████ 
echo                                           ██████   ██   ██████
echo                                          ██████████████████████
echo                                         █████   ███  ███   █████
echo                                         ███  ███   ██   ███  ███
echo                                         ████████████████████████
echo                                         ████    ███  ███    ████
echo.
echo.
echo.                                   Reboot to apply optimizations! (%roxo%~3s%p%)
timeout /t 3 /nobreak >nul
goto:menu

pause >nul
pause >nul
pause >nul

:reboot
shutdown /r /t 10
echo  %p%[ %roxo%•%p% %p%]%w% Your system will reboot in 10 seconds to apply optimizations. %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul
goto:menu

:rebootcancel
shutdown /a
echo  %p%[ %roxo%•%p% %p%]%w% Scheduled 10 seconds reboot has been cancelled. %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul
goto:menu

pause >nul
pause >nul
pause >nul

:games
title Ghost-Optimizer // Select an Option
mode 106,25
cls
echo.
echo.
echo.                        %p%      ██████╗  █████╗ ███╗   ███╗███████╗███████╗
echo.                             ██╔════╝ ██╔══██╗████╗ ████║██╔════╝██╔════╝
echo.                             ██║  ███╗███████║██╔████╔██║█████╗  ███████╗   
echo.                             ██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ╚════██║         
echo.                             ╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗███████║      
echo.                              ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝%w%
echo.                                                                       
echo. %COL%[90m           ─────────────────────────────────────────────────────────────────────────────── %w%                                                             
echo                        %w%Quick tweaks focused on optimizing specific game priority. %w%
echo.
echo                                             %w%Coming soon... %w%
echo.
echo.
echo                                       %p%[%roxo%menu%p%]%w% Back to Main Menu
echo.
echo. %COL%[90m           ─────────────────────────────────────────────────────────────────────────────── %w%                                                             
          
echo.                                         
set /p answer="%w% >:%roxo%"

if "%answer%"=="louzkk" start https://github.com/louzkk
if "%answer%"=="@louzkk" start https://github.com/louzkk
if "%answer%"=="ghost" start https://github.com/louzkk/Ghost-Optimizer
if "%answer%"=="games" start https://github.com/louzkk/Ghost-Optimizer
if "%answer%"=="github" start https://github.com/louzkk/Ghost-Optimizer
if "%answer%"=="reload" goto:variables
if "%answer%"=="update" goto:variables
if "%answer%"=="reboot" goto:reboot
if "%answer%"=="cancel" goto:rebootcancel
if "%answer%"=="exit" exit
if "%answer%"=="menu" goto:menu
if "%answer%"=="back" goto:menu

:wronginput
goto:games

pause >nul
pause >nul
pause >nul

:repair
title Ghost-Optimizer // Health Repair [1/1]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to start System %roxo%Health Repair%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% Performs a full system health repair by scanning and fixing corrupted system files,
echo  repairing Windows image, and checking disk errors to ensure stability and performance.
echo  It is recommended to perform this process every %p%3%roxo%-%p%6%w% months. It does not affect your personal files.
echo.
echo  This process may take a while, depending on the number of files.
echo  %p%(%roxo%SSD ~15-35min%p%)%w% - %p%(%roxo%HDD ~25-50min%p%)%w%
echo.
set /p answer="%w% >:%roxo%"

if /i "%answer%"=="Y" (
    goto:repair2
) else if /i "%answer%"=="N" (
    goto:menu
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto:repair
)

:repair2
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Starting System %roxo%Health Repair%w%... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 3 /nobreak >nul

echo  %p%[ %roxo%•%p% %p%]%w% Starting Windows Image Repair %p%(%roxo%DISM%p%)%w%...
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
echo  %p%[ %roxo%•%p% %p%]%w% Windows Image %p%(%roxo%DISM%p%)%w% repaired %g%successfully%w%.

echo  %p%[ %roxo%•%p% %p%]%w% Starting System Integrity Repair...
sfc /scannow
echo  %p%[ %roxo%•%p% %p%]%w% System Integrity repaired %g%successfully%w%.

echo  %p%[ %roxo%•%p% %p%]%w% Starting Disk Check %p%(%roxo%File System and Bad Sectors%p%)%w%...
chkdsk C:
echo  %p%[ %roxo%•%p% %p%]%w% File System and Bad Sectors repaired %g%successfully%w%.

echo  %p%[ %roxo%•%p% %p%]%w% Starting Windows Management Instrumentation %p%(%roxo%WMI%p%)%w% Repair...
winmgmt /verifyrepository
winmgmt /salvagerepository
echo  %p%[ %roxo%•%p% %p%]%w% Windows Management Instrumentation %p%(%roxo%WMI%p%)%w% repaired %g%successfully%w%.

echo  %p%[ %roxo%•%p% %p%]%w% Starting Windows Component Repair...
DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase
echo  %p%[ %roxo%•%p% %p%]%w% Windows Components repaired %g%successfully%w%.

echo  %p%[ %roxo%•%p% %p%]%w% Starting Windows Store Cache Repair...
wsreset.exe
echo  %p%[ %roxo%•%p% %p%]%w% Windows Store Cache repaired %g%successfully%w%.

echo  %p%[ %roxo%•%p% %p%]%w% Starting Icon Cache and Thumbnails Cache Repair...
echo  %y%Warning: Windows Explorer %p%(%roxo%Interface%p%)%w% will be restarted.%w%
echo.
taskkill /f /im explorer.exe
del /f /q %localappdata%\IconCache.db
del /f /s /q %localappdata%\Microsoft\Windows\Explorer\thumbcache_*.db
start explorer.exe
echo  %p%[ %roxo%•%p% %p%]%w% Icon Cache and Thumbnails Cache repaired %g%successfully%w%.

echo  %p%[ %roxo%•%p% %p%]%w% System %roxo%Health%w% repaired %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul
goto:finalfix

:finalfix
title Ghost-Optimizer // Final Steps
mode 106,25
@echo off
echo !esc![?25l
cls
chcp 65001 >nul
echo.
echo.
echo.
echo.
echo.
echo                                                %p%  ██████       
echo                                               ████████████    
echo                                            ██████████████████ 
echo                                            █████   ██   █████ 
echo                                           ██████   ██   ██████
echo                                          ██████████████████████
echo                                         █████   ███  ███   █████
echo                                         ███  ███   ██   ███  ███
echo                                         ████████████████████████
echo                                         ████    ███  ███    ████
echo.
echo.
echo.                                            Finishing (%roxo%~3s%p%)...
timeout /t 3 /nobreak >nul
goto:finishing2

:finalfix
mode 106,25
@echo off
echo !esc![?25l
cls
chcp 65001 >nul
echo.
echo.
echo.
echo.
echo.
echo                                                %p%  ██████       
echo                                               ████████████    
echo                                            ██████████████████ 
echo                                            █████   ██   █████ 
echo                                           ██████   ██   ██████
echo                                          ██████████████████████
echo                                         █████   ███  ███   █████
echo                                         ███  ███   ██   ███  ███
echo                                         ████████████████████████
echo                                         ████    ███  ███    ████
echo.
echo.
echo.                                       Reboot to apply fixes! (%roxo%~3s%p%)
timeout /t 3 /nobreak >nul
goto:menu

pause >nul
pause >nul
pause >nul

:socd
title Ghost-Optimizer // Input Cleaner [1/2]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to start %roxo%Input Cleaner%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% SOCD Cleaner removes simultaneous opposite keyboard inputs (like left - right),
echo  simulating precise commands like %g%Razer Snaptap%w% to improve playability in competitive games.
echo.
echo. SOCD Cleaner may be detected by some Anti-Cheats/Anti-Virus.
echo  %p%(%roxo%AHK 1.1%p%)%w% %p%(%roxo%It will run in the background%p%)%w%
echo.
set /p answer="%w% >:%roxo%"

if /i "%answer%"=="y" (
    goto :socd2
) else if /i "%answer%"=="N" (
    goto :menu
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto :socd
)

:socd2
title Ghost-Optimizer // Input Cleaner [2/2]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Starting %roxo%Input Cleaner%w%... %p%(%roxo%~2s%p%)%w%
echo.
timeout /t 2 /nobreak >nul
cd /d "%~dp0"
start "" "Input-Cleaner.exe"
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Input Cleaner%w% started %g%successfully%w%. %p%(%roxo%2%p%)%w%
echo.
timeout /t 2 /nobreak >nul
goto:menu

:msi
title Ghost-Optimizer // MSI Utility [1/2]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to start %roxo%MSI Utility%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% MSI Utility V3 optimizes device interrupt handling by enabling MSI Mode.
echo  Reduces system latency, improves responsiveness, and helps eliminate stuttering or audio crackling.
echo.
echo  %p%Recommended:%w% Set your GPU and Audio Device to 'MSI' mode with 'High' priority and apply.
echo.
set /p answer="%w% >:%roxo%"

if /i "%answer%"=="y" (
    goto:msi2
) else if /i "%answer%"=="n" (
    goto:menu
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto:msi
)

:msi2
title Ghost-Optimizer // MSI Utility [2/2]
mode 106,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Starting %roxo%MSI Utility%w%... %p%(%roxo%~2s%p%)%w%
echo.
timeout /t 2 /nobreak >nul
cd /d "%~dp0"
start "" "MSI_util_v3.exe"
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%MSI Utility%w% started %g%successfully%w%. %p%(%roxo%2%p%)%w%
echo.
timeout /t 2 /nobreak >nul
goto:menu

:tree
title Ghost-Optimizer // System Tree
mode 200,50
@echo off
cls
chcp 65001 >nul
tree /f
echo  %p%[ %roxo%•%p% %p%]%w% System Tree displayed %g%successfully%w%! %p%(%roxo%Press any key to continue%p%)%w%
pause >nul
goto:menu

:ipconfig
title Ghost-Optimizer // IP Configuration
mode 200,50
@echo off
cls
chcp 65001 >nul

ipconfig /all
pause >nul
goto:menu

:systeminfo
title Ghost-Optimizer // System Information
mode 200,50
@echo off
cls
chcp 65001 >nul
systeminfo
pause >nul
goto:menu

:taskinfo
title Ghost-Optimizer // Tasks List
mode 200,50
@echo off
cls
chcp 65001 >nul
tasklist
pause >nul
goto:menu
