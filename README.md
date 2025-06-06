# Powershell Profile Configuration

This file contains customizations and configurations for your PowerShell environment, that makes Powershell feel like home if you're coming from ZSH.

### Features

- Custom prompt displaying the current branch, git status (clean or dirty), and a color-changing prompt arrow based on the last command's exit code
- Improvements for many commands such as `pwd`, `ls` and `mkdir`
- A stat system inspired by zsh_stats 
- Added Comamands such as:
    - `touch [filename]` - Create a new file
    - `pwsh_stats` - Display your 10 most used Commands
- Additon of global variables such as:
    - `$PWSH_HOME` - Directory where `$PROFILE` is located
    - `PWSH_STATS_FILE` - Path to the file storing your stats

### Installation / Usage

1. Copy `Microsoft.Powershell_profile.ps1` to your PowerShell profile path:
    - On Windows:  
        `$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`
    - On Linux/macOS:
        ##### IMPORTANT: will cause major issues with custom commands and some aliases. The prompt works without any issues.
        `~/.config/powershell/Microsoft.PowerShell_profile.ps1`

2. Edit the file to add your preferred customizations.

3. Restart your PowerShell session to apply changes.
```powershell
. $PROFILE
```

### Requirements
- [Powershell < 7.4.x](https://github.com/PowerShell/PowerShell/)
- [PSReadLine](https://github.com/PowerShell/PSReadLine)
- [Winget-Command-NotFound](https://github.com/microsoft/winget-command-not-found)