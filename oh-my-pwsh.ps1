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

Load_Plugins($env:PWSH_PLUGINS)

function Load_Plugins {
    param (
        [string[]]$pluginList
    )

    foreach ($plugin in $pluginList) {
        $pluginDir = Join-Path $env:PWSH "plugins"

        # If it's a directory load all
        $fullDir = Join-Path $pluginDir $plugin
        if ((Test-Path $fullDir) -and ((Get-Item $fullDir).PSIsContainer)) {
            Get-ChildItem "$fullDir\*.ps1" | ForEach-Object {
                . $_.FullName
            }
        }
        #  look for individual plugin files in any directory
        else {
            $match = Get-ChildItem -Recurse -Filter "$plugin.ps1" -Path $pluginDir | Select-Object -First 1
            if ($match) {
                . $match.FullName
            } else {
                Write-Warning "Plugin '$plugin' not found."
            }
        }
    }
}

function Update-PwshStats {
    $historyItem = Get-History -Count 1
    if (-not $historyItem) { return }

    $commandLine = $historyItem.CommandLine.Trim()
    if (-not $commandLine) { return }

    $firstToken = $commandLine.Split()[0]

    $global:__lastLoggedCommand = $firstToken

    if (Test-Path $PWSH_STATS_FILE) {
        $stats = Get-Content $PWSH_STATS_FILE -Raw | ConvertFrom-Json -AsHashtable
    } else {
        $stats = @{}
    }

    if ($stats.ContainsKey($firstToken)) {
        $stats[$firstToken]++
    } else {
        $stats[$firstToken] = 1
    }

    $stats | ConvertTo-Json -Depth 1 | Set-Content -Path $PWSH_STATS_FILE -Encoding UTF8
}

function pwsh_stats {
    if (Test-Path $PWSH_STATS_FILE) {
		$rawStats = Get-Content $PWSH_STATS_FILE | ConvertFrom-Json -AsHashtable
        $totalCount = ($rawStats.Values | Measure-Object -Sum).Sum

        $statData = $rawStats.GetEnumerator() | Sort-Object Value -Descending
        $top = $statData | Select-Object -First 20

        $counter = 1
		foreach ($item in $top) {
			$cmd = $item.Name
			$amount = $item.Value
            $percent = "{0:N1}" -f (($amount / $totalCount) * 100)

			Write-Host ("{0, 5} {1, 5}  {2, 5}  {3, -15}" -f $counter, $amount, "$percent%", $cmd)
            $counter++
        }
    } else {
        "No stats file found at $PWSH_STATS_FILE"
    }
}