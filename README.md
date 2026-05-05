<div align="center">

# 👻 Ghost Optimizer
**Minimal, Private and Optimized Windows**

[![Version](https://img.shields.io/badge/Version-5.3.8-indigo?style=for-the-badge&logo=Ghostty&logoColor=white)](https://github.com/louzkk/Ghost-Optimizer/releases)
[![License](https://img.shields.io/badge/License-MIT-indigo?style=for-the-badge)](LICENSE)
[![Discord](https://img.shields.io/badge/Discord-indigo?style=for-the-badge&logo=Discord&logoColor=white)](https://discord.gg/QJPdw2UrVt)
[![Download](https://img.shields.io/badge/Download-indigo?style=for-the-badge&logo=Github&logoColor=white)](https://github.com/louzkk/Ghost-Optimizer#-download)

![Banner](images/Ghost-BANNER-denoised-4x.png)

</div>

---

**Ghost Optimizer** is an open source advanced batch script that improves **performance**, **latency**, **network** and **privacy**, while removing **bloatware** and **AI** features.

It applies registry and policy modifications across four areas: performance, targeting scheduler behavior and resource allocation; network, reducing overhead and improving throughput; latency and input lag, via interrupt handling and timer resolution tuning; and telemetry, advertising, bloatware, and AI features. All modifications are reversible through the restore point option.

Every optimization in this script has been individually tested and included for a specific reason. If you don't understand what a command does, do not run it. Blindly executing random tweaks you found online is how you break things.

---

## 🚀 Download

1. Download [Git 2.54](https://github.com/git-for-windows/git/releases/download/v2.54.0.windows.1/Git-2.54.0-64-bit.exe)
2. Check: "*Use Windows' Default console window*" on install
3. Open Powershell as Administrator
4. Copy and paste the command below:

```
PowerShell -ExecutionPolicy Bypass -Command "if (!(Get-Command git -ErrorAction SilentlyContinue)) { Write-Host 'Downloading Ghost Optimizer...'}; Remove-Item '$env:TEMP\Ghost-Optimizer' -Recurse -Force -ErrorAction SilentlyContinue; git clone https://github.com/louzkk/Ghost-Optimizer.git '$env:TEMP\Ghost-Optimizer'; Set-Location '$env:TEMP\Ghost-Optimizer\bin'; .\Ghost-Optimizer.bat"
```

## 🤝 Credits
* Listed on [Opendows](https://github.com/MarcoRavich/Opendows).
* Testing: [@MysteryNich](https://github.com/MysteryNich).
* [OOSU++](https://www.oo-software.com/en/shutup10) and [NvidiaProfileInspector](https://github.com/Orbmu2k/nvidiaProfileInspector).

## ⚠️ Disclaimer
This script modifies the Windows Registry and applications. **Use at your own risk.** I'm not responsible for system instability or data loss.

## 📄 License
Released under the [MIT License](LICENSE). Free for modification and distribution with proper attribution.

---

<div align="center">
Maintained by: <a href="https://github.com/louzkk">louzkk 🇧🇷</a>
</div>
