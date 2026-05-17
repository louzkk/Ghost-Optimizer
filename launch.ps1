# Ghost Optimizer 5.4
# https://github.com/louzkk/Ghost-Optimizer

Set-ExecutionPolicy Unrestricted -Scope Process -Force -ErrorAction SilentlyContinue

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm 'https://raw.githubusercontent.com/louzkk/Ghost-Optimizer/main/launch.ps1' | iex`"" -Verb RunAs
    exit
}

$build = [System.Environment]::OSVersion.Version.Build
if ($build -lt 19044) {
    Write-Host ""
    Write-Host "      [ • ] Ghost Optimizer requires Windows 10 21H2 or later." -ForegroundColor Red
    Write-Host "      Detected build: $build" -ForegroundColor Red
    Write-Host ""
    pause
    exit 1
}

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'Gray'
Clear-Host
Write-Host ""
Write-Host ""
Write-Host "                    ██╗      █████╗ ██╗   ██╗███╗   ██╗ ██████╗██╗  ██╗██╗███╗   ██╗ ██████╗                      " -ForegroundColor Blue
Write-Host "                    ██║     ██╔══██╗██║   ██║████╗  ██║██╔════╝██║  ██║██║████╗  ██║██╔════╝                      " -ForegroundColor Blue
Write-Host "                    ██║     ███████║██║   ██║██╔██╗ ██║██║     ███████║██║██╔██╗ ██║██║  ███╗                     " -ForegroundColor Blue
Write-Host "                    ██║     ██╔══██║██║   ██║██║╚██╗██║██║     ██╔══██║██║██║╚██╗██║██║   ██║                     " -ForegroundColor Blue
Write-Host "                    ███████╗██║  ██║╚██████╔╝██║ ╚████║╚██████╗██║  ██║██║██║ ╚████║╚██████╔╝ ██╗██╗██╗           " -ForegroundColor Blue
Write-Host "                    ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚═╝╚═╝╚═╝           " -ForegroundColor Blue
Write-Host ""
Write-Host "     ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────" -ForegroundColor Blue
Write-Host ""

$zipUrl  = "https://github.com/louzkk/Ghost-Optimizer/archive/refs/heads/main.zip"
$zipPath = "$env:TEMP\Ghost-Optimizer.zip"
$dir     = "$env:TEMP\Ghost-Optimizer"

Remove-Item $zipPath -Force          -ErrorAction SilentlyContinue
Remove-Item $dir     -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "      [ • ] Downloading latest version..." -ForegroundColor White

$ProgressPreference = 'SilentlyContinue'

try {
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath -UseBasicParsing -ErrorAction Stop
} catch {
    Write-Host ""
    Write-Host "      [ • ] Download failed. Check your connection and try again." -ForegroundColor Red
    Write-Host "      Error: $_" -ForegroundColor DarkGray
    Write-Host ""
    pause
    exit 1
}

try {
    Expand-Archive -Path $zipPath -DestinationPath $dir -Force -ErrorAction Stop
} catch {
    Write-Host ""
    Write-Host "      [ • ] Extraction failed." -ForegroundColor Red
    Write-Host "      Error: $_" -ForegroundColor DarkGray
    Write-Host ""
    pause
    exit 1
}

$inner = Get-ChildItem $dir -Directory | Select-Object -First 1 -ExpandProperty FullName
$bat   = "$inner\bin\Ghost-Optimizer.bat"

if (-not (Test-Path $bat)) {
    Write-Host ""
    Write-Host "      [ • ] Ghost-Optimizer.bat not found." -ForegroundColor Red
    Write-Host "      Expected: $bat" -ForegroundColor DarkGray
    Write-Host ""
    pause
    exit 1
}

Get-ChildItem "$inner\bin" -Filter "*.bat" | ForEach-Object {
    Unblock-File -Path $_.FullName -ErrorAction SilentlyContinue
    $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
    $crlf  = [System.Collections.Generic.List[byte]]::new()
    for ($i = 0; $i -lt $bytes.Length; $i++) {
        if ($bytes[$i] -eq 10 -and ($i -eq 0 -or $bytes[$i - 1] -ne 13)) {
            $crlf.Add(13)
        }
        $crlf.Add($bytes[$i])
    }
    [System.IO.File]::WriteAllBytes($_.FullName, $crlf.ToArray())
}

$content = [System.IO.File]::ReadAllText($bat, [System.Text.Encoding]::UTF8)
$content = $content -replace '\[0m', '[0;40m'
[System.IO.File]::WriteAllText($bat, $content, [System.Text.Encoding]::UTF8)

Write-Host "      [ • ] Launching Ghost Optimizer..." -ForegroundColor White
Write-Host ""

try {
    Set-Location "$inner\bin"
    & ".\Ghost-Optimizer.bat"
} finally {
    Remove-Item $zipPath -Force          -ErrorAction SilentlyContinue
    Remove-Item $dir     -Recurse -Force -ErrorAction SilentlyContinue
}