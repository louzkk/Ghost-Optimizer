# Ghost Optimizer 5.5
# https://github.com/louzkk/Ghost-Optimizer

Set-ExecutionPolicy Unrestricted -Scope Process -Force -ErrorAction SilentlyContinue

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -Verb RunAs -ErrorAction SilentlyContinue -ArgumentList @(
        '-NoProfile', '-ExecutionPolicy', 'Bypass',
        '-Command', "irm 'https://raw.githubusercontent.com/louzkk/Ghost-Optimizer/main/launch.ps1' | iex"
    )
    exit
}

$build = [System.Environment]::OSVersion.Version.Build
if ($build -lt 19044) {
    Write-Host ""
    Write-Host "      [ • ] Ghost Optimizer requires Windows 10 21H2 or later." -ForegroundColor Red
    Write-Host "      Detected build: $build" -ForegroundColor Red
    Write-Host ""
    [void][Console]::ReadKey($true)
    exit 1
}

if (-not ([System.Management.Automation.PSTypeName]'Win32.Kernel32').Type) {
    Add-Type -Namespace 'Win32' -Name 'Kernel32' -MemberDefinition @'
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool GetConsoleMode(IntPtr hConsoleHandle, out uint lpMode);
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern bool SetConsoleMode(IntPtr hConsoleHandle, uint dwMode);
        [DllImport("kernel32.dll", SetLastError = true)]
        public static extern IntPtr GetStdHandle(int nStdHandle);
'@
}
[uint32]$mode = 0
$handle = [Win32.Kernel32]::GetStdHandle(-11)
[Win32.Kernel32]::GetConsoleMode($handle, [ref]$mode) | Out-Null
[Win32.Kernel32]::SetConsoleMode($handle, $mode -bor 4) | Out-Null

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'Gray'
Clear-Host

$ESC   = [char]0x1B
$RESET = "$ESC[0;40m"
$LAST  = 119
$MID   = [int]($LAST / 2)

$textColors = [string[]]::new($LAST + 1)
for ($j = 0; $j -le $LAST; $j++) {
    $r = if ($j -le $MID) { 40 + [int](88 * $j / $MID) }
         else              { 128 - [int](128 * ($j - $MID) / ($LAST - $MID)) }
    $textColors[$j] = "$ESC[38;2;${r};0;255m"
}

function Write-Gradient ([string]$Text) {
    $sb = [System.Text.StringBuilder]::new($Text.Length * 21)
    for ($j = 0; $j -lt $Text.Length; $j++) {
        [void]$sb.Append($textColors[[Math]::Min($j, $LAST)])
        [void]$sb.Append($Text[$j])
    }
    [void]$sb.Append($RESET)
    Write-Host $sb.ToString()
}

Write-Host ""
Write-Host ""
Write-Gradient "                    ██╗      █████╗ ██╗   ██╗███╗   ██╗ ██████╗██╗  ██╗██╗███╗   ██╗ ██████╗                      "
Write-Gradient "                    ██║     ██╔══██╗██║   ██║████╗  ██║██╔════╝██║  ██║██║████╗  ██║██╔════╝                      "
Write-Gradient "                    ██║     ███████║██║   ██║██╔██╗ ██║██║     ███████║██║██╔██╗ ██║██║  ███╗                     "
Write-Gradient "                    ██║     ██╔══██║██║   ██║██║╚██╗██║██║     ██╔══██║██║██║╚██╗██║██║   ██║                     "
Write-Gradient "                    ███████╗██║  ██║╚██████╔╝██║ ╚████║╚██████╗██║  ██║██║██║ ╚████║╚██████╔╝ ██╗██╗██╗           "
Write-Gradient "                    ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚═╝╚═╝╚═╝           "
Write-Gradient "     ────────────────────────────────────────────────────────────────────────────────────────────────────────────────"
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
    [void][Console]::ReadKey($true)
    exit 1
}

try {
    Expand-Archive -Path $zipPath -DestinationPath $dir -Force -ErrorAction Stop
} catch {
    Write-Host ""
    Write-Host "      [ • ] Extraction failed." -ForegroundColor Red
    Write-Host "      Error: $_" -ForegroundColor DarkGray
    Write-Host ""
    [void][Console]::ReadKey($true)
    exit 1
}

$inner = Get-ChildItem $dir -Directory | Select-Object -First 1 -ExpandProperty FullName
$bat   = "$inner\bin\Ghost-Optimizer.bat"

if (-not (Test-Path $bat)) {
    Write-Host ""
    Write-Host "      [ • ] Ghost-Optimizer.bat not found." -ForegroundColor Red
    Write-Host "      Expected: $bat" -ForegroundColor DarkGray
    Write-Host ""
    [void][Console]::ReadKey($true)
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