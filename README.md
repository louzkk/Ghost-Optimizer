# 💜 About
**Ghost Optimizer** – the original project is a lightweight script made to optimize Windows by improving **performance**, **network efficiency**, **latency**, **telemetry reduction** and **privacy**, while **preserving system integrity**.

[![Version](https://img.shields.io/badge/Version-5.0-indigo)](https://github.com/louzkk/Ghost-Optimizer)
[![Official](https://img.shields.io/badge/Official-indigo)](https://github.com/louzkk/Ghost-Optimizer)
[![Download](https://img.shields.io/badge/Download-indigo)](https://github.com/louzkk/Ghost-Optimizer/releases)
 
![Banner](images/GhostX-BANNER-denoised-4x.png)

# ⚡Impact
- **Performance:**    
  **3–20%** improvement in responsiveness and FPS
- **Resource Usage:**   
  **10–30%** lower RAM usage in idle  
  **5–20%** less background CPU activity
- **Telemetry:**    
  **80–90%** reduction in telemetry, ads and AI features
- **Network:**    
  **5–20%** less background network activity  
  **1–5 ms** lower latency in latency-sensitive scenarios
- **Bloatware:**    
  **60–80%** fewer preinstalled apps and non-essential services
  
*Approximate values; results may vary depending on system and usage.*

# 💻 Requirements
- Windows 10 or 11
- Terminal or CMD
- Internet connection

# 🤝 Credits
Thanks to [Opendows](https://github.com/MarcoRavich/Opendows) for listing this project and to **@MysteryNich** for testing each release.  
Some software and parts of the code were adapted from other developers, with proper credits included in the script comments.

# ❓ How to Use
### Manual Install
1. Go to [**Releases**](https://github.com/louzkk/Ghost-Optimizer/releases)  
2. Download **Ghost Optimizer.bat**  
3. Run the script as **Administrator**

### Quick Install
1. Open **PowerShell** as **Administrator**  
2. **Copy and Paste** this command:
```
PowerShell -ExecutionPolicy Bypass -Command "if (!(Get-Command git -ErrorAction SilentlyContinue)) { Write-Host 'Downloading Ghost Optimizer...'; start-process winget -ArgumentList 'install --id Git.Git -e --source winget --silent' -Wait }; Remove-Item '$env:TEMP\Ghost' -Recurse -Force -ErrorAction SilentlyContinue; git clone https://github.com/louzkk/Ghost-Optimizer.git '$env:TEMP\Ghost'; Set-Location '$env:TEMP\Ghost\bin'; .\Ghost-Optimizer.bat"
```

*Your antivirus may need to be temporarily disabled to avoid issues.*

# 🚨 Disclaimer
Use this script at your own risk, I take no responsibility for any damage or data loss.   
If you are unable to run the script or apply the optimizations, visit the [Help](https://github.com/louzkk/Ghost-Optimizer/blob/main/GUIDE.md#troubleshooting--notes) page.

# 📜 License
This project is released under the [MIT License](LICENSE), allowing open use, modification, and distribution with attribution.  
If you create derivative work or redistribute this project, please maintain proper credit to the original authors.   

# 💬 Bug or Suggestion
You can send me a message on **Discord** (@louzkk) or [Open an issue](https://github.com/louzkk/Ghost-Optimizer/issues).
