<div align="center">

# 👻 Ghost Optimizer
**Minimal, Private and Optimized Windows**

[![Version](https://img.shields.io/badge/Version-5.6-indigo?style=for-the-badge)](https://github.com/louzkk/Ghost-Optimizer/releases)
[![Downloads](https://img.shields.io/endpoint?url=https://badge-api-delta.vercel.app/api/downloads&style=for-the-badge&color=indigo)](https://github.com/louzkk/Ghost-Optimizer/releases)
[![Download](https://img.shields.io/badge/Download-indigo?style=for-the-badge&logo=Github&logoColor=white)](https://github.com/louzkk/Ghost-Optimizer#-launch)
[![Discord](https://img.shields.io/badge/Discord-indigo?style=for-the-badge&logo=Discord&logoColor=white)](https://discord.gg/QJPdw2UrVt)

![Banner](images/Ghost-Banner(denoised-4x).png)

</div>

**Ghost Optimizer** is an open source batch script that focuses on **performance**, **latency**, **network** and **privacy** on Windows, **removing bloatware** and **built-in AI** features like Copilot, Recall and Paint/Notepad AI.

It works through registry and policy changes, service management, AppX removal, and by downloading and applying custom profiles for third-party tools: [O&O ShutUp10++](https://www.oo-software.com/shutup10), [NVIDIA Profile Inspector](https://github.com/Orbmu2k/nvidiaProfileInspector) and [ViVeTool](https://github.com/thebookisclosed/ViVe).

Every optimization has been individually tested.

## 🚀 Launch
Open PowerShell as Administrator

```powershell
irm https://raw.githubusercontent.com/louzkk/Ghost-Optimizer/main/launch.ps1 | iex
```

## 🔨 Installation
1. Go to [Releases](https://github.com/louzkk/Ghost-Optimizer/releases/latest) page
2. Download and run `Ghost-Optimizer.bat`

## 💾 Reverting
Before making any changes, the script offers to create a System Restore point. This creates a snapshot of your system so you can restore Windows if something breaks or if you simply want to revert everything.
To restore your system, use **R (Revert all)** from the main menu and select the latest Ghost Optimizer restore point in Windows System Restore.

## 🔍 Notes
> [!IMPORTANT]
> **Use at your own risk.** This script modifies the Windows registry, services and installed apps. If you don't understand what a command does, do not run it.

> [!IMPORTANT]
> Ghost Optimizer is an independent project and is not affiliated with Microsoft, Ghost Spectre, O&O, NVIDIA, or any other tool it utilizes.

> [!CAUTION]
> The Performance menu includes an option to disable VBS, Hyper-V and Spectre/Meltdown mitigations. It's a real performance gain, but it can break kernel-level anti-cheats and lowers your protection against speculative-execution exploits. It always asks for your confirmation.

## 📖 License
Released under the [MIT License](LICENSE). Free for modification and distribution with proper attribution.