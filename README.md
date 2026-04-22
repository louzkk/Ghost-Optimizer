<div align="center">

# 👻 Ghost Optimizer
**Minimal, Private and Optimized Windows**

[![Version](https://img.shields.io/badge/Version-5.2.3-indigo?style=for-the-badge&logo=Ghostty&logoColor=white)](https://github.com/louzkk/Ghost-Optimizer/releases)
[![License](https://img.shields.io/badge/License-MIT-indigo?style=for-the-badge)](LICENSE)
[![Discord](https://img.shields.io/badge/Discord-indigo?style=for-the-badge&logo=Discord&logoColor=white)](https://discord.gg/fBsChke59R)
[![Download](https://img.shields.io/badge/Download-indigo?style=for-the-badge&logo=Github&logoColor=white)](https://github.com/louzkk/Ghost-Optimizer#quick-install-powershell-admin)

![Banner](images/Ghost-BANNER-denoised-4x.png)

</div>

**Ghost Optimizer** is an open source advanced batch script that improves **performance**, **latency**, **network** and **privacy**, while removing **bloatware** and **AI** features.

It applies system registry and policy modifications: General and Performance tweaks targeting scheduler behavior and resource allocation, Network optimizations to improve throughput and reduce overhead, Latency and Input-lag adjustments via interrupt handling and timer resolution tuning, and reducing Telemetry, Advertising, Bloatware and AI.
All modifications are reversible via restore point option.

## 🚀 Download

### Requirements
* Windows 10/11
* [Git](https://git-scm.com/install/windows) for Quick Install 
(Check: "Use Windows' Default console window")

### Quick Install (PowerShell Admin)
Copy and paste the command below:
```
PowerShell -ExecutionPolicy Bypass -Command "if (!(Get-Command git -ErrorAction SilentlyContinue)) { Write-Host 'Downloading Ghost Optimizer...'; start-process winget -ArgumentList 'install --id Git.Git -e --source winget --silent' -Wait }; Remove-Item '$env:TEMP\Ghost' -Recurse -Force -ErrorAction SilentlyContinue; git clone https://github.com/louzkk/Ghost-Optimizer.git '$env:TEMP\Ghost'; Set-Location '$env:TEMP\Ghost\bin'; .\Ghost-Optimizer.bat"
```
### Manual Installation
1. Temporarily disable your antivirus.   
(If you are unable to open the script, try Quick Install)
2. Download latest [Ghost-Optimizer.bat](https://github.com/louzkk/Ghost-Optimizer/releases).
3. Right click and **Run as Administrator**.

## 🤝 Credits
* Listed on [Opendows](https://github.com/MarcoRavich/Opendows).
* Testing: [@MysteryNich](https://github.com/MysteryNich).
* [OOSU](https://www.oo-software.com/en/shutup10) and [NvidiaProfileInspector](https://github.com/Orbmu2k/nvidiaProfileInspector).

## ⚠️ Disclaimer
This script modifies the Windows Registry and applications. **Use at your own risk.** I'm not responsible for system instability or data loss.

## 📄 License
Released under the [MIT License](LICENSE). Free for modification and distribution with proper attribution.
  
<div align="center">
Maintained by: <a href="https://github.com/louzkk">louzkk 🇧🇷</a>
</div>