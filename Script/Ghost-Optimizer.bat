@echo off
mode 107,25
powershell -command "Add-MpPreference -ExclusionPath 'C:\Ghost-Optimizer'" >nul 2>&1
powershell -command "Add-MpPreference -ExclusionPath '%USERPROFILE%\Desktop\Ghost-Optimizer'" >nul 2>&1
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
title Ghost Optimizer // Loading Script
mode 107,25
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
title Ghost Optimizer // Read this
mode 107,25
@echo off
echo !esc![?25l
cls
chcp 65001 >nul
cls
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
echo                         Welcome to %p%Ghost-Optimizer%w% %p%(%roxo%v3.5 beta%p%)%w%, made by %p%@louzkk%w%.
echo.
echo               I am not responsible for any problems that this tool may cause to your PC. 
echo           It is strictly prohibited to resell this script; doing so may lead to consequences. 
echo           To select an option, type the corresponding number on your keyboard and press Enter. 
echo                       Make sure to carefully read all warnings, pop-ups, and messages.
echo.
echo                             Press any key to first create a restore point...
echo.
echo. %COL%[90m           ─────────────────────────────────────────────────────────────────────────────── %w%                                                                                                   
echo.
set /p resposta="%w% >:%roxo%"
goto:restore

:restore
title Ghost Optimizer // Restore Point [1/1]
mode 107,25
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
echo  To restore the system, you can search %roxo%System Restore%w% in Windows Start Menu.
echo.
set /p resposta="%w% >:%roxo%"

if /i "%resposta%"=="y" (
    start /wait %windir%\System32\SystemPropertiesProtection.exe
    goto :menu
) else if /i "%resposta%"=="N" (
    goto :menu
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto :restore
)

:menu
title Ghost Optimizer // Menu v3.5 beta
mode 107,25
cls
echo.
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
echo                                            %p%[ %roxo%1 %p%]%w% Optimization
echo                                            %p%[ %roxo%2 %p%]%w% Health Repair
echo                                            %p%[ %roxo%3 %p%]%w% Input Cleaner
echo                                            %p%[ %roxo%4 %p%]%w% Process Lasso
echo.
echo. %COL%[90m           ─────────────────────────────────────────────────────────────────────────────── %w%                                                             
echo                                                  %p%@louzkk%w%
          
echo.                                         
set /p resposta="%w% >:%roxo%"

if %resposta% equ 1 goto :optimization
if %resposta% equ 2 goto :repair
if %resposta% equ 3 goto :socd
if %resposta% equ 4 goto :lasso
if "%resposta%"=="louzkk" start https://github.com/louzkk
if "%resposta%"=="@louzkk" start https://github.com/louzkk
if "%resposta%"=="ghost" start https://github.com/louzkk/Ghost-Optimizer
if "%resposta%"=="github" start https://github.com/louzkk/Ghost-Optimizer
if "%resposta%"=="reload" goto:variables
if "%resposta%"=="reboot" goto:reboot
if "%resposta%"=="cancel" goto:rebootcancel
if "%resposta%"=="exit" exit

:teclaerrada
cls
goto :menu

:optimization
title Ghost Optimizer // System Optimization [1/10]
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to start %roxo%System Optimization%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% The script optimizes Windows with regedits, improving overall performance,
echo  reducing resource usage, latency and input lag, as well as improving graphics performance.
echo.
echo  This will apply around 180 to 350 registry tweaks of various types for different optimizations.
echo.
set /p resposta="%w% >:%roxo%"

if /i "%resposta%"=="Y" (
    goto:optimization2
) else if /i "%resposta%"=="N" (
    goto :powerplan
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto :optimization
)

:optimization2
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Starting %roxo%System Optimization%w%... %p%(%roxo%~3s%p%)%w%
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
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v KeyboardDataQueueSize /t REG_DWORD /d 30 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v MouseDataQueueSize /t REG_DWORD /d 30 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v SerializeTimerExpiration /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /t REG_DWORD /d 33554432 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "01" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f >nul 2>nul
echo  %p%[ %roxo%•%p% %p%]%w% General System Optimizations Applied. %p%(%roxo%27%p%)%w%

bcdedit /set bootux disabled >nul
bcdedit /set tscsyncpolicy enhanced >nul
bcdedit /set uselegacyapicmode No >nul
bcdedit /deletevalue useplatformclock >nul
bcdedit /deletevalue useplatformtick >nul
echo  %p%[ %roxo%•%p% %p%]%w% Advanced System Optimizations %p%(%roxo%Boot%p%)%w% Applied. %p%(%roxo%5%p%)%w%

wmic computersystem >nul 2>&1
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True >nul 2>&1
sc config SysMain start= disabled >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Defrag\ScheduledDefrag" /ENABLE >nul 2>&1
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
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 36 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Games" /v "Start" /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 26 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Gaming Optimizations Applied. %p%(%roxo%24%p%)%w%

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

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\ea062031-0e34-4ff1-9b6d-eb1059334028" /v ACSettingIndex /t REG_DWORD /d 100 /f >nul 2>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4ff1-9b6d-eb1059334028" /v DCSettingIndex /t REG_DWORD /d 100 /f >nul 2>nul
powercfg -setactive SCHEME_CURRENT >nul 2>nul
echo  %p%[ %roxo%•%p% %p%]%w% Unpaked all CPU Cores %p%(%roxo%Current Powerplan%p%)%w%. %p%(%roxo%3%p%)%w%

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
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsDisableLastAccessUpdate /t REG_DWORD /d 1 /f >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% DWM Optimizations Applied. %p%(%roxo%20%p%)%w%

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v KiClockTimerPerCpu /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v KiClockTimerHighLatency /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v KiClockTimerAlwaysOnPresent /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v ClockTimerPerCpu /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v ClockTimerHighLatency /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v ClockTimerAlwaysOnPresent /t REG_DWORD /d 1 /f >nul
bcdedit /set disabledynamictick No >nul
echo  %p%[ %roxo%•%p% %p%]%w% Kernel Optimizations Applied. %p%(%roxo%7%p%)%w%

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% %r%Spectre/Meltdown%w% algorithms disabled. %p%(%roxo%3%p%)%w%

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v RequirePlatformSecurityFeatures /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v HVCIMATRequired /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul
bcdedit /set hypervisorlaunch off >nul 2>nul
echo  %p%[ %roxo%•%p% %p%]%w% Virtualization Based Security %p%(%roxo%VBS%p%)%w% disabled. %p%(%roxo%7%p%)%w%

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
echo  %p%[ %roxo%•%p% %p%]%w% Reduced system response time and latency. %p%(%roxo%54%p%)%w%

reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "SwapMouseButtons" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v "EnablePrecision" /t REG_DWORD /d 0 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Mouse and Touchpad Optimizations Applied. %p%(%roxo%5%p%)%w%

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >nul 2>nul
echo  %p%[ %roxo%•%p% %p%]%w% Windows Widgets %p%(%roxo%TaskbarDa/Mn%p%)%w% disabled. %p%(%roxo%3%p%)%w%

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectX" /v "MaxFrameLatency" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Direct3D\Global" /v "MaxQueuedFrames" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 10 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectX" /v "DisableThreadedOptimizations" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Direct3D\Global" /v EnableMultiThreadedRendering /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Direct3D\Global" /v DisableVSync /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Direct3D\Drivers" /v SoftwareOnly /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectInput" /v EnableBackgroundProcessing /t REG_DWORD /d 1 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Optimized %bb%DirectX%w% rendering. %p%(%roxo%10%p%)%w%

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
sc stop NvTelemetryContainer >nul 2>&1
sc config NvTelemetryContainer start= disabled >nul 2>&1
sc stop NvContainerLocalSystem >nul 2>&1
sc config NvContainerLocalSystem start= disabled >nul 2>&1
sc stop NvContainerNetworkService >nul 2>&1
sc config NvContainerNetworkService start= disabled >nul 2>&1
echo  %p%[ %roxo%•%p% %p%]%w% %g%NVIDIA%w% Driver Optimizations Applied. %p%(%roxo%12%p%)%w%

echo.
echo  %p%[ %roxo%•%p% %p%]%w% All %roxo%optimizations%w% applied %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul
goto:powerplan

:powerplan
title Ghost Optimizer // Power Plan [2/10]
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to apply a custom %roxo%Power Plan%w%? %p%(%roxo%1%p%/%roxo%2%p%/%roxo%3%p%/%roxo%4%p%)%w%
echo.
echo  %p%Warning:%w% This will apply a custom power plan designed to optimize system performance,
echo  improving responsiveness, FPS, and latency while balancing power efficiency when idle.
echo.
echo  I do not recommend it if you already use a custom power plan from your CPU, but give it a try.
echo.
echo  %r%(%o%1 - Core.pow%r%)%w% - Best average FPS, 1%% low and latency
echo  %b%(%bb%2 - Khorvie.pow%b%)%w% - Good average FPS, 1%% low and latency
echo  %p%(%roxo%3 - Ghost.pow%p%)%w% - Based on Khorvie with experimental tweaks
echo  %w%(%w%4 - Keep Current%w%)%w% - Dont change your current power plan.
echo.
set /p resposta="%w% >:%roxo%"

if /i "%resposta%"=="1" (
    goto :core
)
if /i "%resposta%"=="2" (
    goto :khorvie
)
if /i "%resposta%"=="3" (
    goto :ghost
)
if /i "%resposta%"=="4" (
    goto :thermal
)

echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please choose between %roxo%1%w%, %roxo%2%w%, %roxo%3%w% or %roxo%4%w%.
timeout /t 2 /nobreak >nul
goto :powerplan

:core
mode 107,25
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
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Core.pow%w% Powerplan applied %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul
goto:thermal


:khorvie
mode 107,25
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
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Khorvie.pow%w% Powerplan applied %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul
goto:thermal

:ghost
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Applying %roxo%Ghost-Optimizer%w% Power Plan... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 3 /nobreak >nul
echo  %p%[ %roxo%•%p% %p%]%w% Importing %roxo%Ghost-Optimizer.pow%w% Power Plan...  %p%(%roxo%~3s%p%)%w%

setlocal enabledelayedexpansion

powercfg /import "%~dp0Ghost-Optimizer.pow" >nul

for /f "tokens=2 delims=:()" %%i in ('powercfg /list ^| findstr /i "Ghost-Optimizer"') do (
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
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Ghost-Optimizer.pow%w% Powerplan applied %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul
goto:thermal

:thermal
title Ghost Optimizer // Thermal Limit [3/10]
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to unlock the CPU/GPU %roxo%Thermal Limit%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% Unlocking the CPU/GPU thermal limit allows maximum hardware performance,
echo  but reduces the lifespan of the components. Not recommended for Notebookos/Laptops.
echo.
echo  This will increase the average temperature of your components. May cause unexpected shutdowns
echo.
set /p resposta="%w% >:%roxo%"

if /i "%resposta%"=="Y" (
    goto:thermal2
) else if /i "%resposta%"=="N" (
    goto :effects
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto :thermal
)

:thermal2
mode 107,25
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
goto:effects

:effects
title Ghost Optimizer // Visual Effects and Animations [4/10]
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to disable %roxo%Windows Visual Effects%w% and %roxo%Animations%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% This will only affect the appearance of Windows, relieving the use of the CPU and GPU.
echo  Some visual effects like blur, window animations and shadows will be disabled (minimal effects).
echo.
set /p resposta="%w% >:%roxo%"

if /i "%resposta%"=="Y" (
    goto:effects2
) else if /i "%resposta%"=="N" (
    goto:hags
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto :effects
)

:effects2
mode 107,25
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
goto:hags

:hags
title Ghost Optimizer // GPU Optimization [5/10]
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to enable %roxo%Hardware Accelerated GPU Scheduling%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% The GPU scheduler %p%(%roxo%HwSchMode%p%)%w% allows the GPU to manage VRAM,
echo  reducing CPU usage. This can improve performance and lower latency,
echo  but on weaker or integrated GPUs, it may cause instability.
echo.
set /p resposta="%w% >:%roxo%"

if /i "%resposta%"=="Y" (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul
    echo  %p%[ %roxo%•%p% %p%]%w% Hardware Accelerated GPU Scheduling enabled %g%successfully%w%!
    timeout /t 2 /nobreak >nul
    goto:track
) else if /i "%resposta%"=="N" (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 1 /f >nul
    goto:track
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto:hags
)


:track
title Ghost Optimizer // Tracking ^& Telemetry [6/10]
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to disable and block %roxo%Tracking %w%^& %roxo%Telemetry%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% Disables Windows telemetry, tracking services, diagnostics, location
echo  and targeted ads while improving system privacy by blocking data collection and telemetry domains..
echo.
echo  Reduce overall resource usage.
echo.
set /p resposta="%w% >:%roxo%"

if /i "%resposta%"=="Y" (
    goto:track2
) else if /i "%resposta%"=="N" (
    goto:ping
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto:track
)

:track2
mode 107,25
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
echo  %p%[ %roxo%•%p% %p%]%w% Personalized %o%Feedback and Experiences%o% disabled... %p%(%roxo%5%p%)%w%

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v Value /t REG_SZ /d Deny /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v Value /t REG_SZ /d Deny /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v Value /t REG_SZ /d Deny /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >nul
echo  %p%[ %roxo%•%p% %p%]%w% Location and Data Sensors %p%(%roxo%Webcam%p%)%w% disabled... %p%(%roxo%4%p%)%w%

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
goto:ping

:ping
title Ghost Optimizer // Network Optimization [7/10]
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to start %roxo%Network %p%(%roxo%Ping%p%)%w% Optimization? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% Optimizes network to reduce latency, improve packet delivery, and boost connection by
echo  disabling bandwidth limits, enhancing DNS resolution, and fine-tuning TCP parameters for lower ping.
echo.
set /p resposta="%w% >:%roxo%"

if /i "%resposta%"=="Y" (
    goto:ping2
) else if /i "%resposta%"=="N" (
    goto:services
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto :ping
)

:ping2
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Starting %roxo%Network Optimization%w%... %p%(%roxo%~3s%p%)%w%
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
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Network Optimization%w% applied %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul
goto:services

:services
title Ghost Optimizer // Unnecessary Services [8/10]
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to disable %roxo%Unnecessary Services%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% Disables unnecessary Windows services to reduce background resource usage.
echo  Include stopping tracking, xbox services, printer service, search indexing and background update services.
echo.
echo  If any service you use is disabled, manually re-enable it in the Windows Services app.
echo.
set /p resposta="%w% >:%roxo%"

if /i "%resposta%"=="Y" (
    goto:services2
) else if /i "%resposta%"=="N" (
    goto:clean
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto :services
)

:services2
mode 107,25
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
goto:clean

:clean
title Ghost Optimizer // Temporary Files [9/10]
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to start %roxo%Disk Cleanup%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% Disk Cleanup removes temporary and unnecessary files, logs, junk files,
echo  and caches to free up storage and improve system performance. Does not affect personal files.
echo.
echo  It is recommended to perform this process every %p%2%roxo%-%p%3%w% months.
echo.
set /p resposta="%w% >:%roxo%"

if /i "%resposta%"=="Y" (
    goto:clean2
) else if /i "%resposta%"=="N" (
    goto:final
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto :clean
)

:clean2
mode 107,25
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

echo.
echo  %p%[ %roxo%•%p% %p%]%w% All %roxo%discs cleaned%w% %g%successfully%w%! %p%(%roxo%~3s%p%)%w%
timeout /t 3 /nobreak >nul
goto:final

:final
title Ghost Optimizer // Saving [10/10]
mode 107,25
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
title Ghost Optimizer // Saving [10/10]
mode 107,25
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

:repair
title Ghost Optimizer // Health Repair [1/1]
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to start System %roxo%Health Repair%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% Performs a full system health repair by scanning and fixing corrupted system files,
echo  repairing Windows image, and checking disk errors to ensure stability and performance.
echo  It is recommended to perform this process every 3-6 months. It does not affect your personal files.
echo.
echo  This process may take a while, depending on the number of files.
echo  %p%(%roxo%SSD ~15-35min%p%)%w% - %p%(%roxo%HDD ~25-50min%p%)%w%
echo.
set /p resposta="%w% >:%roxo%"

if /i "%resposta%"=="Y" (
    goto:repair2
) else if /i "%resposta%"=="N" (
    goto:menu
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto:repair
)

:repair2
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Starting System %roxo%Health Repair%w%... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 3 /nobreak >nul

echo  %p%[ %roxo%•%p% %p%]%w% Starting Windows Image Repair %p%(%roxo%DISM%p%)%w%...
echo.
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
echo.
echo  %p%[ %roxo%•%p% %p%]%w% Windows Image %p%(%roxo%DISM%p%)%w% repaired %g%successfully%w%.

echo  %p%[ %roxo%•%p% %p%]%w% Starting System Integrity Repair...
echo.
sfc /scannow
echo.
echo  %p%[ %roxo%•%p% %p%]%w% System Integrity repaired %g%successfully%w%.

echo  %p%[ %roxo%•%p% %p%]%w% Starting Disk Check %p%(%roxo%File System and Bad Sectors%p%)%w%...
echo.
chkdsk C:
echo.
echo  %p%[ %roxo%•%p% %p%]%w% File System and Bad Sectors repaired %g%successfully%w%.

echo  %p%[ %roxo%•%p% %p%]%w% Starting Windows Management Instrumentation %p%(%roxo%WMI%p%)%w% Repair...
echo.
winmgmt /verifyrepository
winmgmt /salvagerepository
echo.
echo  %p%[ %roxo%•%p% %p%]%w% Windows Management Instrumentation %p%(%roxo%WMI%p%)%w% repaired %g%successfully%w%.

echo  %p%[ %roxo%•%p% %p%]%w% Starting Windows Component Repair...
echo.
DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase
echo  %p%[ %roxo%•%p% %p%]%w% Windows Components repaired %g%successfully%w%.

echo  %p%[ %roxo%•%p% %p%]%w% Starting Windows Store Cache Repair...
echo.
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
goto:repairfinal

:repairfinal
title Ghost Optimizer // System Repair [2/2]
mode 107,25
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
goto:repairfinal2

:repairfinal2
title Ghost Optimizer // Saving [2/2]
mode 107,25
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

:socd
title Ghost Optimizer // Input Cleaner (AHK v1.1) [1/2]
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to start %roxo%Ghost Input Cleaner%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% SOCD Cleaner removes simultaneous opposite keyboard inputs (like left • right),
echo  simulating precise commands like %g%Razer Snaptap%w% to improve playability in competitive games.
echo.
echo. SOCD Cleaner may be detected by some Anti-Cheats/Anti-Virus.
echo.
set /p resposta="%w% >:%roxo%"

if /i "%resposta%"=="y" (
    goto :socd2
) else if /i "%resposta%"=="N" (
    goto :menu
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto :socd
)

:socd2
title Ghost Optimizer // Input Cleaner (AHK v1.1) [2/2]
mode 107,25
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

:lasso
title Ghost Optimizer // Process Lasso [1/2]
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Do you want to start %roxo%Process Lasso%w%? %p%(%roxo%Y%p%/%roxo%N%p%)%w%
echo.
echo  %p%Warning:%w% Process Lasso dynamically optimizes CPU by controlling process priorities and CPU affinities.
echo  Prevents background tasks from affecting performance and reduces stuttering in heavy workloads and games.
echo.
echo  Only the 64-bit version is supported.
echo.
set /p resposta="%w% >:%roxo%"

if /i "%resposta%"=="y" (
    goto :lasso2
) else if /i "%resposta%"=="n" (
    goto :menu
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% Invalid option. Please enter %roxo%Y%w% for Yes or %roxo%N%w% for No.
    timeout /t 2 /nobreak >nul
    goto :lasso
)

:lasso2
title Ghost Optimizer // Process Lasso [2/2]
mode 107,25
@echo off
cls
chcp 65001 >nul

echo.
echo  %p%[ %roxo%•%p% %p%]%w% Checking for %roxo%Process Lasso%w% installation... %p%(%roxo%~3s%p%)%w%
echo.
timeout /t 3 /nobreak >nul

if exist "C:\Program Files\Process Lasso\ProcessLasso.exe" (
    echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Process Lasso%w% is installed. Launching now...
    start "" "C:\Program Files\Process Lasso\ProcessLasso.exe"
) else (
    echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Process Lasso%w% not found. Starting installer...
    cd /d "%~dp0"
    start "" "processlassosetup64.exe"
)

echo.
echo  %p%[ %roxo%•%p% %p%]%w% %roxo%Process Lasso%w% started %g%successfully%w%. %p%(%roxo%3%p%)%w%
echo.
timeout /t 2 /nobreak >nul
goto :menu
