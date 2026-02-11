# 💜 About
**Ghost Optimizer** is a Windows optimization script that improves **performance**, **network**, **latency**, **responsiveness** and **privacy**, while reducing **telemetry**, **bloatware**, and **Copilot/AI components**.

[![Version](https://img.shields.io/badge/Version-4.9-indigo)](https://github.com/louzkk/Ghost-Optimizer)
[![Unstable](https://img.shields.io/badge/Unstable-indigo)](https://github.com/louzkk/Ghost-Optimizer)
[![Official](https://img.shields.io/badge/Official-indigo)](https://github.com/louzkk/Ghost-Optimizer)
[![Download](https://img.shields.io/badge/Download-indigo)](https://github.com/louzkk/Ghost-Optimizer/releases)
 
![Banner](images/GhostX-BANNER-denoised-4x.png)

<details>
<summary>⚡ Click to see optimization impact</summary>
 
- **Performance:**    
  **1–25%** improvement in responsiveness and FPS
- **Resource Usage:**   
  **10–30%** lower RAM usage in idle  
  **5–20%** less background CPU activity
- **Telemetry:**    
  **80–90%** reduction in telemetry, Ads and AI features
- **Network:**    
  **5–20%** less background network activity  
  **1–10 ms** lower latency in latency-sensitive scenarios
- **Bloatware:**    
  **60–80%** fewer preinstalled apps and non-essential services

  *Approximate values; results may vary depending on system and usage.*
 
</details>

# 💻 Requirements
- Windows 10 or 11
- Terminal or CMD
- Internet connection

# 🤝 Credits
Thanks to [Opendows](https://github.com/MarcoRavich/Opendows) for listing this project and to [@MysteryNich](https://github.com/MysteryNich) for testing each release.  
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
**Use this script at your own risk.** I am not responsible for any damage, instability, or data loss.     
**Need help?** Visit the [Troubleshooting & Notes](https://github.com/louzkk/Ghost-Optimizer/blob/main/GUIDE.md#troubleshooting--notes) page.     

# 📜 License
This project is released under the [MIT License](LICENSE), allowing open use, modification, and distribution with attribution.  
If you create derivative work or redistribute this project, please maintain proper credit to the original authors.   

# 💬 Bug or Suggestion
You can send me a message on **Discord** (@louzkk) or [Open an issue](https://github.com/louzkk/Ghost-Optimizer/issues).