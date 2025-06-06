if (-not(Get-Module -ListAvailable -Name PSReadLine)) {
	Throw "PSReadLine is not installed. Please reffer to https://github.com/PowerShell/PSReadLine"
}
if (-not(Get-Module -ListAvailable -Name Microsoft.WinGet.CommandNotFound)) {
	Throw "Winget-Command-Not-Found is not installed. Please reffer to https://github.com/microsoft/winget-command-not-found"
}

# Modules to Import
Import-Module Microsoft.WinGet.CommandNotFound

$global:PWSH_HOME = "$HOME\Documents\PowerShell"
$global:PWSH_STATS_FILE = Join-Path $PWSH_HOME "pwsh_stats.json"

# Load Theme
$themePath = "$env:PWSH/themes/$env:PWSH_THEME.ps1"
if (Test-Path $themePath) {
    . $themePath
} else {
    Write-Warning "Theme '$env:PWSH_THEME' not found."
}