:: *************************************************************
:: ENGLISH

:: Ghost Optimizer - Windows Optimization Script
:: Developer: @louzkk
:: 
:: For personal use only. Commercial use of this software is strictly 
:: prohibited. Do not edit this code.
:: 
:: Disclaimer: The developer is not responsible for any damage 
:: caused to systems, data, or hardware while using this application.
:: *************************************************************

:: *************************************************************
:: PORTUGUÊS

:: Ghost Optimizer - Script de Otimização do Windows
:: Desenvolvedor: @louzkk
:: 
:: Para uso pessoal apenas. O uso comercial deste software é estritamente
:: proibido. Não edite este código.
:: 
:: Atenção: O desenvolvedor não é responsável por qualquer dano
:: causado a sistemas, dados ou hardware ao usar este aplicativo.
:: *************************************************************

title Ghost Optimizer // Iniciando
@echo off
mode 105,25
powershell -command "Add-MpPreference -ExclusionPath 'C:\Ghost Optimizer'" >nul 2>&1
powershell -command "Add-MpPreference -ExclusionPath '%USERPROFILE%\Desktop\Ghost Optimizer'" >nul 2>&1
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "COL=%%b") >nul 2>&1
reg add HKCU\CONSOLE /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1
@echo off
mode 105,25
:: @louzkk

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
set y=[40;33m
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

@echo off
title Ghost Optimizer // Sem Permissões
mode 105,24
:: @louzkk
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo.
    echo                        %r%[ %r%!%r% %r%]%w% Este Script precisa ser executado como Administrador.
    echo                      Sem Administrador o Script não tem acesso ao registro do sistema.
    pause >nul 2>&1
    exit
)

:loading
title Ghost Optimizer // Carregando
mode 105,25
:: @louzkk
@echo off
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
echo.                                           Carregando (%roxo%~3s%p%)...
timeout /t 3 /nobreak >nul
goto:menu

:menu
title Ghost Optimizer // Menu 2.2
mode 105,25
cls
echo.
echo.
echo.
echo.                              %p%   ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗
echo.                                ██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝
echo.                                ██║  ███╗███████║██║   ██║███████╗   ██║   
echo.                                ██║   ██║██╔══██║██║   ██║╚════██║   ██║         
echo.                                ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║      
echo.                                 ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝ TM%w%
echo.                                                                       
echo. %COL%[90m           ─────────────────────────────────────────────────────────────────────────────── %w%                                                             
echo.                                        %p%[ %roxo%0 %p%]%w% Ponto de Restauração                       
echo.
echo                         %p%[ %roxo%1 %p%]%w% Otimizar Desempenho          %p%[ %roxo%2 %p%]%w% Otimizar Conexão
echo                         %p%[ %roxo%3 %p%]%w% Escanear Windows             %p%[ %roxo%4 %p%]%w% Desativar Telemetria
echo                         %p%[ %roxo%5 %p%]%w% Desativar Serviços           %p%[ %roxo%6 %p%]%w% Executar Limpeza
echo.
echo                                                  %p%@louzkk%w%
echo.
echo. %COL%[90m           ─────────────────────────────────────────────────────────────────────────────── %w%                                                             
          
echo.                                         
set /p resposta="%w%>:%roxo%"

if %resposta% equ 0 goto :ponto
if %resposta% equ 1 goto :optimize
if %resposta% equ 2 goto :ping
if %resposta% equ 3 goto :scan
if %resposta% equ 4 goto :bloat
if %resposta% equ 5 goto :tasks
if %resposta% equ 6 goto :clean
if "%resposta%"=="hack" goto :hack
if "%resposta%"=="reload" goto :loading
if "%resposta%"=="recarregar" goto :loading
if "%resposta%"=="exit" exit
if "%resposta%"=="sair" exit
if "%resposta%"=="fechar" exit
if "%resposta%"=="close" exit
if "%resposta%"=="?" goto :comandos
:: @louzkk
if "%resposta%"=="ajuda" goto :comandos
if "%resposta%"=="help" goto :comandos
if "%resposta%"=="comandos" goto :comandos
if "%resposta%"=="commands" goto :comandos
if "%resposta%"=="Ghost" goto :anything
if "%resposta%"=="ghost" goto :anything
if "%resposta%"=="louzkk" start https://github.com/louzk
if "%resposta%"=="@louzkk" start https://github.com/louzk
if "%resposta%"=="github" start https://github.com/louzk
if "%resposta%"=="louzk" start https://github.com/louzk
if "%resposta%"=="@louzk" start https://github.com/louzk
if "%resposta%"=="reboot" goto :reboot
if "%resposta%"=="reiniciar" goto :reboot

:teclaerrada
cls
call :menu

:ponto
title Ghost Optimizer // Ponto de Restauração
@echo off
cls
chcp 65001 >nul
:: @louzkk
echo.
echo %p%[ %roxo%+%p% %p%]%w% Você deseja criar um Ponto de Restauração antes de iniciar a otimização? (S/N)
echo Caso algo dê errado você poderá restaurar o sistema.
echo.
set /p resposta="%w%>:%roxo%"

if /i "%resposta%"=="S" (
    cls
    echo.
    echo %p%[ %roxo%+%p% %p%]%w% Criando Ponto de Restauração %p%(%roxo%~2s%p%)%w%...
    timeout /t 2 /nobreak >nul
    start %SystemRoot%\system32\SystemPropertiesProtection.exe
    if %errorlevel% equ 0 (
        echo.
        echo %p%[ %roxo%+%p% %p%]%w% Ponto de Restauração criado com sucesso.
    ) else (
        echo.
        echo %p%[ %roxo%+%p% %p%]%w% Falha ao criar Ponto de Restauração.
    )
    timeout /t 5 /nobreak >nul
    echo %p%[ %roxo%+%p% %p%]%w% Voltando para tela inicial...
    timeout /t 2 /nobreak >nul
    :: @louzkk
    goto:menu
) else if /i "%resposta%"=="N" (
    cls
    echo.
    echo %p%[ %roxo%+%p% %p%]%w% Criação de Ponto de Restauração cancelada.
    timeout /t 2 /nobreak >nul
    echo.
    echo %p%[ %roxo%+%p% %p%]%w% Voltando para a tela inicial...
    timeout /t 1 /nobreak >nul
    goto:menu
) else (
    echo %p%[ %roxo%+%p% %p%]%w% Opção inválida. Por favor, digite S para Sim ou N para Não.
    timeout /t 2 /nobreak >nul
    goto:ponto
)

:optimize
title Ghost Optimizer // Otimizando o Windows

@echo off
cls
chcp 65001 >nul
:: @louzkk

echo.
echo %p%[ %roxo%+%p% %p%]%w% Iniciando Otimização do Windows %p%(%roxo%~3s%p%)%w%...
echo %p%[ %roxo%+%p% %p%]%w% Evite minimizar a janela durante o processo.
echo.
timeout /t 3 /nobreak >nul

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "GPU Priority" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Scheduling Category" /t REG_SZ /d "Medium" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "TimerResolution" /t REG_DWORD /d 1 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Latência do sistema Otimizada.
:: @louzkk
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "Append Completion" /t REG_SZ /d "yes" /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /v "AutoSuggest" /t REG_SZ /d "yes" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 50 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ExtendedUIHoverTime /t REG_DWORD /d 0 /f >nul
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /v AltTabSettings /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v MouseHoverTime /t REG_SZ /d 10 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v LowLevelHooksTimeout /t REG_SZ /d 1000 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v AutoEndTasks /t REG_SZ /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WaitToKillAppTimeout /t REG_SZ /d 2000 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d 1000 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v ForegroundLockTimeout /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 2000 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Tempo de resposta de janelas reduzido.

taskkill /f /im explorer.exe && start explorer.exe
echo %p%[ %roxo%+%p% %p%]%w% Interface do Windows reiniciada.
:: @louzkk
reg add "HKLM\System\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Assistência Remota desativada.

reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f >nul
reg add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm" /v "FlipQueueSize" /t REG_DWORD /d 0 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% DWM, Explorer e Shell Otimizados.
:: @louzkk
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Seleção de Prioridade Otimizada.

reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows Media Foundation" /v "EnableFrameServerMode" /t REG_DWORD /d 0 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% %o%Frame Work Server%w% ativado.

reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "SwapMouseButtons" /t REG_SZ /d "0" /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" /v "EnablePrecision" /t REG_DWORD /d 0 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Otimizações de Mouse e Touchpad aplicadas.
:: @louzkk
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=True >nul
sc config SysMain start= disabled >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Gerenciamento de Memória Otimizado.

powercfg -h off >nul
echo %p%[ %roxo%+%p% %p%]%w% Modo de Hibernação desativado.

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d 2 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Apps em Segundo Plano desativados.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul
sc config wuauserv start=disabled >nul
echo %p%[ %roxo%+%p% %p%]%w% Atualização em Segundo Plano desativada.

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d 1 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Suspensão seletiva de USB desativada.

reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Games" /v "Start" /t REG_DWORD /d 3 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Modo de Jogo do Windows ativado.

reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v value /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% %g%Xbox Game Bar %w%e %g%Game DVR%w% desativados.
:: @louzkk
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectX" /v "MaxFrameLatency" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectX" /v "DisableThreadedOptimizations" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Direct3D\Global" /v EnableMultiThreadedRendering /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Direct3D\Global" /v DisableVSync /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Direct3D\Drivers" /v SoftwareOnly /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectInput" /v EnableBackgroundProcessing /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v LargeSystemCache /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Renderização do %bb%DirectX%w% Otimizada.

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Agendamento de GPU acelerado por Hardware Otimizado.

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Intel\Display" /v "EnableGameMode" /t REG_DWORD /d 1 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Otimizações de Driver da %b%Intel%w% aplicadas.

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\AMD\RadeonSettings" /v ShaderCache /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v FrameLatency /t REG_DWORD /d 0 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Otimizações de Driver da %r%AMD%w% aplicadas.
:: @louzkk
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\NVIDIA Corporation\Global\NvControlPanel2\Client" /v PreferredRefreshRate /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\NVIDIA Corporation\Global\LowLatencyMode" /v Value /t REG_DWORD /d 1 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Otimizações de Driver da %g%NVIDIA%w% aplicadas.

echo %p%[ %roxo%+%p% %p%]%w% Finalizando %p%(%roxo%~3s%p%)%w%.
timeout /t 3 /nobreak >nul
echo.
echo %p%[ %roxo%+%p% %p%]%w% É recomendado reiniciar o computador para aplicar todas as otimizações.
echo.
echo %p%Aperte Enter para continuar%w%
set /p "resposta=%w%>:%roxo%"
:: @louzkk
goto:menu

:ping
title Ghost Optimizer // Otimizando sua Conexão

@echo off
cls
chcp 65001 >nul
echo.

echo %p%[ %roxo%+%p% %p%]%w% Iniciando Otimizações de Rede %p%(%roxo%~3s%p%)%w%...
echo %p%[ %roxo%+%p% %p%]%w% Evite minimizar a janela durante o processo.
timeout /t 3 /nobreak >nul
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 0xffffffff /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Throttling de Rede desativado.

netsh int tcp set global autotuninglevel=disabled >nul
echo %p%[ %roxo%+%p% %p%]%w% autotuninglevel desativado.

netsh int tcp set heuristics disabled >nul
echo %p%[ %roxo%+%p% %p%]%w% Dados Heurísticos desativados.
:: @louzkk
netsh int tcp set global ecncapability=disabled >nul
echo %p%[ %roxo%+%p% %p%]%w% Global ecncapability desativado.

netsh int tcp set global chimney=disabled >nul
echo %p%[ %roxo%+%p% %p%]%w% Otimizações de TCP aplicadas com sucesso.

netsh int tcp set global congestionprovider=ctcp >nul
echo %p%[ %roxo%+%p% %p%]%w% congestionprovider alterado para ctcp.

netsh interface ip set dns name="Wi-Fi" source=static addr=1.1.1.1 register=PRIMARY >nul
netsh interface ip add dns name="Wi-Fi" addr=1.0.0.1 index=2 >nul
echo %p%[ %roxo%+%p% %p%]%w% Endereços %o%DNS Cloudfire%w% configuradas com sucesso.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{NIC-ID}" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{NIC-ID}" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{NIC-ID}" /v "DisableTaskOffload" /t REG_DWORD /d 1 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% %bb%Nagle Algorithm %w%Otimizado.

echo %p%[ %roxo%+%p% %p%]%w% Limpando cache do DNS (flush dns).
timeout /t 1 /nobreak >nul
ipconfig /flushdns >nul
echo %p%[ %roxo%+%p% %p%]%w% Cache do DNS limpo com sucesso.
:: @louzkk
netsh interface ipv4 set subinterface "Wi-Fi" mtu=1492 store=persistent >nul
echo %p%[ %roxo%+%p% %p%]%w% MTU ajustado com sucesso (ipv4).

netsh int ipv4 set dynamicport udp start=10000 num=55535 >nul
echo %p%[ %roxo%+%p% %p%]%w% Otimização UDP ativada. (ipv4).

echo %p%[ %roxo%+%p% %p%]%w% Otimizações de Rede aplicadas com sucesso.
timeout /t 2 /nobreak >nul

echo %p%[ %roxo%+%p% %p%]%w% Finalizando %p%(%roxo%~3s%p%)%w%.
timeout /t 3 /nobreak >nul
echo.
echo %p%[ %roxo%+%p% %p%]%w% É recomendado reiniciar o computador para aplicar todas as otimizações.
echo.
echo %p%Aperte Enter para continuar%w%
set /p "resposta=%w%>:%roxo%"
goto:menu

:tasks
title Ghost Optimizer // Desativando Serviços
:: @louzkk
@echo off
cls
chcp 65001 >nul
echo.
echo %p%[ %roxo%+%p% %p%]%w% Desativando serviços não essenciais do Windows %p%(%roxo%~3s%p%)%w%...
echo %p%[ %roxo%+%p% %p%]%w% Evite minimizar a janela durante o processo.
timeout /t 3 /nobreak >nul
echo.

sc stop DPS >nul 2>&1
sc config DPS start=disabled >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Serviço de Diagnóstico de Problemas desativado.

sc stop WerSvc >nul 2>&1
sc config WerSvc start=disabled >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Serviço de Relatórios de Erros desativado.

sc stop Spooler >nul 2>&1
sc config Spooler start=disabled >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Serviço de Spooler de Impressão desativado.
:: @louzkk
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start=disabled >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Serviço de Rastreamento de Diagnóstico desativado.

sc stop MapsBroker >nul 2>&1
sc config MapsBroker start=disabled >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Serviço de Agente de Mapas desativado.

sc stop WpcMonSvc >nul 2>&1
sc config WpcMonSvc start=disabled >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Serviço de Monitoramento de Controle dos Pais desativado.

sc stop diagnosticshub.standardcollector.service >nul 2>&1
sc config diagnosticshub.standardcollector.service start=disabled >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Serviço de Coletor de Diagnóstico desativado.

sc stop TabletInputService >nul 2>&1
sc config TabletInputService start=disabled >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Serviço de Entrada de Tablet desativado.
:: @louzkk
sc stop WSearch >nul 2>&1
sc config WSearch start=disabled >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Serviço de Indexação de Pesquisa desativado.

sc stop DoSvc >nul 2>&1
sc config DoSvc start=disabled >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Serviço de Otimização de Entregas do Windows Update desativado.

sc stop bits >nul 2>&1
sc config bits start=disabled >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Serviço de Transferência Inteligente em Segundo Plano desativado.

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Widgets do Windows 11 desativados.

echo.
echo %p%[ %roxo%+%p% %p%]%w% Serviços não essenciais do Windows desativados com sucesso.
timeout /t 2 /nobreak >nul

@echo off
chcp 65001 >nul
cls
echo.
:: @louzkk
echo %p%[ %roxo%+%p% %p%]%w% Você deseja desativar e desinstalar o %b%Microsoft OneDrive%w%? (S/N)
echo Caso não use o backup na nuvem, é recomendado desativar para reduzir uso de recursos.
echo.
set /p resposta="%w%>:%roxo%"

if /i "%resposta%"=="S" (
    cls
    echo.
    echo %p%[ %roxo%+%p% %p%]%w% Desativando %b%Microsoft OneDrive%w%...
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /t REG_SZ /d "" /f >nul
    taskkill /f /im OneDrive.exe >nul 2>&1
    %SystemRoot%\System32\OneDriveSetup.exe /uninstall >nul
    timeout /t 1 /nobreak >nul
    echo %p%[ %roxo%+%p% %p%]%w% %b%Microsoft OneDrive%w% desativado com sucesso.
) else if /i "%resposta%"=="N" (
    cls
    echo.
    echo %p%[ %roxo%+%p% %p%]%w% Pulando desativação do %b%Microsoft OneDrive%w%...
) else (
    echo %p%[ %roxo%+%p% %p%]%w% Opção inválida. Por favor, digite S para Sim ou N para Não.
)
timeout /t 2 /nobreak >nul
:: @louzkk
echo %p%[ %roxo%+%p% %p%]%w% Finalizando %p%(%roxo%~3s%p%)%w%.
timeout /t 3 /nobreak >nul
echo.
echo %p%[ %roxo%+%p% %p%]%w% É recomendado reiniciar o computador para aplicar todas as otimizações.
echo.
echo %p%Aperte Enter para continuar%w%
set /p "resposta=%w%>:%roxo%"
goto:menu

:scan
title Ghost Optimizer // Escaneando Sistema

@echo off
cls
chcp 65001 >nul
powercfg -requestsoverride PROCESS cmd.exe DISPLAY SYSTEM AWAYMODE >nul

echo %p%[ %roxo%+%p% %p%]%w% Iniciando Escaneamento do Sistema %p%(%roxo%~3s%p%)%w%...
echo %p%[ %roxo%+%p% %p%]%w% Evite minimizar a janela durante o processo.
timeout /t 3 /nobreak >nul
:: @louzkk
echo.
echo %p%[ %roxo%+%p% %p%]%w% Buscando por arquivos corrompidos %p%(%roxo%~5min%p%)%w%...
sfc /scannow >nul

echo %p%[ %roxo%+%p% %p%]%w% Busca concluída, os arquivos corrompidos foram corrigidos com sucesso.
timeout /t 2 /nobreak >nul

echo %p%[ %roxo%+%p% %p%]%w% Verificando integridade dos arquivos do sistema %p%(%roxo%~1min%p%)%w%...
DISM /Online /Cleanup-Image /CheckHealth >nul

echo %p%[ %roxo%+%p% %p%]%w% Executando uma verificação mais detalhada %p%(%roxo%~5min%p%)%w%...
DISM /Online /Cleanup-Image /ScanHealth >nul

echo %p%[ %roxo%+%p% %p%]%w% Reparando a integridade dos arquivos do sistema %p%(%roxo%~15min%p%)%w%...
DISM /Online /Cleanup-Image /RestoreHealth >nul

echo.
echo %p%[ %roxo%+%p% %p%]%w% Todos os arquivos corrompidos foram corrigidos com sucesso.
:: @louzkk
echo %p%[ %roxo%+%p% %p%]%w% Finalizando %p%(%roxo%~3s%p%)%w%.
powercfg -requestsoverride PROCESS cmd.exe >nul
timeout /t 3 /nobreak >nul
echo.
echo %p%[ %roxo%+%p% %p%]%w% É recomendado reiniciar o computador para aplicar todas as otimizações.
echo.
echo %p%Aperte Enter para continuar%w%
set /p "resposta=%w%>:%roxo%"
goto:menu

:clean
title Ghost Optimizer // Limpando seu Windows

@echo off
cls
chcp 65001 >nul
echo.
echo %p%[ %roxo%+%p% %p%]%w% Iniciando Limpeza do Sistema %p%(%roxo%~3s%p%)%w%...
echo %p%[ %roxo%+%p% %p%]%w% Caso os arquivos estejam sendo usados feche a janela.
echo %p%[ %roxo%+%p% %p%]%w% Evite minimizar a janela durante o processo.
timeout /t 3 /nobreak >nul
echo.
:: @louzkk
echo %p%[ %roxo%+%p% %p%]%w% Limpando Arquivos Temporários...
takeown /f "%TEMP%\*" /r /d y >nul
icacls "%TEMP%\*" /grant %USERNAME%:F /t /c /q >nul
del /s /f /q "%TEMP%\*.*" >nul

takeown /f "C:\Windows\Temp\*" /r /d y >nul
icacls "C:\Windows\Temp\*" /grant %USERNAME%:F /t /c /q >nul
del /s /f /q "C:\Windows\Temp\*.*" >nul

takeown /f "C:\Windows\Prefetch\*" /r /d y >nul
icacls "C:\Windows\Prefetch\*" /grant %USERNAME%:F /t /c /q >nul
del /s /f /q "C:\Windows\Prefetch\*.*" >nul

takeown /f "C:\Users\%USERNAME%\AppData\Local\Temp\*" /r /d y >nul
icacls "C:\Users\%USERNAME%\AppData\Local\Temp\*" /grant %USERNAME%:F /t /c /q >nul
del /s /f /q "C:\Users\%USERNAME%\AppData\Local\Temp\*.*" >nul

echo %p%[ %roxo%+%p% %p%]%w% Limpando Arquivos de Logs...
takeown /f "C:\Windows\Logs\*" /r /d y >nul
icacls "C:\Windows\Logs\*" /grant %USERNAME%:F /t /c /q >nul
del /s /f /q "C:\Windows\Logs\*.*" >nul

takeown /f "C:\Windows\SoftwareDistribution\Download\*" /r /d y >nul
icacls "C:\Windows\SoftwareDistribution\Download\*" /grant %USERNAME%:F /t /c /q >nul
del /s /f /q "C:\Windows\SoftwareDistribution\Download\*.*" >nul

echo %p%[ %roxo%+%p% %p%]%w% Limpando Arquivos de Cache...
takeown /f "C:\Users\%USERNAME%\Recent\*" /r /d y >nul
icacls "C:\Users\%USERNAME%\Recent\*" /grant %USERNAME%:F /t /c /q >nul
del /s /f /q "C:\Users\%USERNAME%\Recent\*.*" >nul

takeown /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.*" /r /d y >nul
icacls "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.*" /grant %USERNAME%:F /t /c /q >nul
del /s /f /q "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.*" >nul

echo %p%[ %roxo%+%p% %p%]%w% Limpando a Lixeira...
rd /s /q C:\$Recycle.Bin >nul
:: @louzkk
echo %p%[ %roxo%+%p% %p%]%w% Finalizando %p%(%roxo%~3s%p%)%w%.
timeout /t 3 /nobreak >nul
echo.
echo %p%[ %roxo%+%p% %p%]%w% É recomendado reiniciar o computador para aplicar todas as otimizações.
echo.
echo %p%Aperte Enter para continuar%w%
set /p "resposta=%w%>:%roxo%"
goto:menu

:bloat
title Ghost Optimizer // Desativando Telemetria
:: @louzkk
@echo off
cls
chcp 65001 >nul
:: @louzkk

echo.
echo %p%[ %roxo%+%p% %p%]%w% Interrompendo a Coleta de Dados %p%(%roxo%~3s%p%)%w%...
echo %p%[ %roxo%+%p% %p%]%w% Evite minimizar a janela durante o processo.
echo.
timeout /t 3 /nobreak >nul

schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Consolidator desativado.

schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% BthSQM desativado.

schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% KernelCeipTask desativado.
:: @louzkk
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% UsbCeip desativado.

schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Uploader desativado.
:: @louzkk
schtasks /end /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Microsoft Compatibility Appraiser desativado.

schtasks /end /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% ProgramDataUpdater desativado.
:: @louzkk
schtasks /end /tn "\Microsoft\Windows\Application Experience\StartupAppTask" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% StartupAppTask desativado.

schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% DiskDiagnosticDataCollector desativado.

schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% DiskDiagnosticResolver desativado.

schtasks /end /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% AnalyzeSystem desativado.

schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% FamilySafetyMonitor desativado.
:: @louzkk
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% FamilySafetyRefresh desativado.

schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% FamilySafetyUpload desativado.

schtasks /end /tn "\Microsoft\Windows\Autochk\Proxy" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Autochk Proxy desativado.

schtasks /end /tn "\Microsoft\Windows\Maintenance\WinSAT" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Maintenance\WinSAT" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% WinSAT desativado.
:: @louzkk
schtasks /end /tn "\Microsoft\Windows\Application Experience\AitAgent" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\AitAgent" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% AitAgent desativado.

schtasks /end /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% QueueReporting desativado.

schtasks /end /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% CreateObjectTask desativado.

schtasks /end /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% DiskFootprint Diagnostics desativado.

schtasks /end /tn "\Microsoft\Windows\FileHistory\File History (maintenance mode)" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\FileHistory\File History (maintenance mode)" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% File History desativado.
:: @louzkk
schtasks /end /tn "\Microsoft\Windows\PI\Sqm-Tasks" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\PI\Sqm-Tasks" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Sqm-Tasks desativado.

schtasks /end /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% GatherNetworkInfo desativado.

schtasks /end /tn "\Microsoft\Windows\AppID\SmartScreenSpecific" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\AppID\SmartScreenSpecific" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% SmartScreenSpecific desativado.

schtasks /Change /TN "\Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Automatic App Update desativado.

schtasks /Change /TN "\Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Time Synchronization desativado.
:: @louzkk
schtasks /end /tn "\Microsoft\Windows\HelloFace\FODCleanupTask" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\HelloFace\FODCleanupTask" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% FODCleanupTask desativado.

schtasks /end /tn "\Microsoft\Windows\Feedback\Siuf\DmClient" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Feedback\Siuf\DmClient" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% DmClient desativado.

schtasks /end /tn "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% DmClientOnScenarioDownload desativado.

schtasks /end /tn "\Microsoft\Windows\Application Experience\PcaPatchDbTask" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% PcaPatchDbTask desativado.

schtasks /end /tn "\Microsoft\Windows\Device Information\Device" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Device Information\Device" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Device desativado.
:: @louzkk
schtasks /end /tn "\Microsoft\Windows\Device Information\Device User" >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Device Information\Device User" /disable >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Device User desativado.

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\NVIDIA Corporation\Global\NvTelemetry" /v "Enabled" /t REG_DWORD /d 0 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Telemetria da %g%NVIDIA%w% desativada.
:: @louzkk
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\AMD\ACE\Settings\General" /v "EnableTelemetry" /t REG_DWORD /d 0 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Telemetria da %r%AMD%w% desativada.

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Intel\Display\igfxcui\Telemetry" /v "EnableTelemetry" /t REG_DWORD /d 0 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Telemetria da %b%Intel%w% desativada.

timeout /t 1 /nobreak >nul

sc stop DiagTrack >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1
echo %p%[ %roxo%+%p% %p%]%w% Serviço de Telemetria desativado.

timeout /t 1 /nobreak >nul
:: @louzkk
echo %p%[ %roxo%+%p% %p%]%w% Bloqueando domínios de telemetria...
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

echo %p%[ %roxo%+%p% %p%]%w% Domínios de telemtria bloqueados com sucesso.

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome" /v "MetricsReportingEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome" /v "ChromeCleanupReportingEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome" /v "ChromeCleanupEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome" /v "UserFeedbackAllowed" /t REG_DWORD /d 0 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome" /v "DeviceMetricsReportingEnabled" /t REG_DWORD /d 0 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Telemetria do %bb%Chrome%w% desativada.
:: @louzkk
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Mozilla\Firefox" /v "DisableTelemetry" /t REG_DWORD /d 1 /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Mozilla\Firefox" /v "DisableDefaultBrowserAgent" /t REG_DWORD /d 1 /f >nul
echo %p%[ %roxo%+%p% %p%]%w% Telemetria do %o%Firefox%w% desativada.

echo %p%[ %roxo%+%p% %p%]%w% Finalizando %p%(%roxo%~3s%p%)%w%.
timeout /t 3 /nobreak >nul
echo.
echo %p%[ %roxo%+%p% %p%]%w% É recomendado reiniciar o computador para aplicar todas as otimizações.
echo.
echo %p%Aperte Enter para continuar%w%
set /p "resposta=%w%>:%roxo%"
goto:menu
:: @louzkk
:comandos
@echo off
title Ghost Optimizer // Lista de Comandos
chcp 65001 >nul
cls
echo.
echo %p%[ %roxo%+%p% %p%]%w% Lista de Comandos e Dicas do Ghost Optmizer:
echo.
echo %p%[ %roxo%0%p% %p%]%w% Iniciar Criação do Ponto de Restauração. %p%(%roxo%Recomendado%p%)%w%
echo %p%[ %roxo%1%p% %p%]%w% Iniciar processo de Otimização do Windows.
echo %p%[ %roxo%2%p% %p%]%w% Iniciar processo de Otimização de Conexão.
echo %p%[ %roxo%3%p% %p%]%w% Iniciar processo de Correção de Arquivos.
echo %p%[ %roxo%4%p% %p%]%w% Iniciar processo de Desativação de Telemetria.
echo %p%[ %roxo%5%p% %p%]%w% Iniciar processo de Desativação de Serviços.
echo %p%[ %roxo%6%p% %p%]%w% Iniciar processo de Limpeza do Sistema.
echo %p%[ %roxo%recarregar%p% %p%]%w% Recarrega Script na mesma janela.
echo %p%[ %roxo%hack%p% %p%]%w% Abrir janela com árvore da raiz do sistema. %p%(%roxo%Tree%p%)%w%
echo %p%[ %roxo%sair%p% %p%]%w% Fecha a janela do Script.
echo %p%[ %roxo%github%p% %p%]%w% Abre página do Script no Github.
echo %p%[ %roxo%@louzkk%p% %p%]%w% Abre o perfil do desenvolvedor do Script.
echo %p%[ %roxo%ajuda%p% %p%]%w% Abre página com lista com comandos.
echo %p%[ %roxo%reiniciar%p% %p%]%w% Reinicia o seu computador instantaneamente.
echo %p%[ %roxo%Ghost%p% %p%]%w% Créditos especiais. %p%(%roxo%Dev e Tester%p%)%w%
echo.
echo %p%[ %roxo%Dica:%p% %p%]%w% Caso você inicie algum processo sem querer, feche a janela do Script.
echo %p%[ %roxo%Dica:%p% %p%]%w% Caso o Windows Defender dê falso alarme, defina o Ghost Optimizer como exceção.
echo %p%[ %roxo%Dica:%p% %p%]%w% Reinicie o PC pelo Script para garantir uma reinicialização limpa.
echo %p%[ %roxo%Dica:%p% %p%]%w% O Ghost Script oferece suporte apenas ao Windows 10 e 11.
echo.
echo %p%Aperte Enter para continuar%w%
set /p "resposta=%w%>:%roxo%"
goto:menu
:: @louzkk
:hack
@echo off
title Ghost Optimizer // Hack
chcp 65001 >nul
cls
tree C:\
goto :menu
:: @louzkk
:anything
@echo off
title Ghost Optimizer // Referencias
chcp 65001 >nul
cls
echo.
echo.
echo.
echo.
echo                                                %b%  ██████       
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
echo.                                         %w%Ascii Art by: @louzkk
echo.                                        %w%Tested by: @MysteryNich
timeout /t 5 /nobreak >nul
goto:menu

:: Trava para evitar reboot acidental
:: @louzkk
pause
goto:menu

:reboot
shutdown /r /t 0
pause > nul
