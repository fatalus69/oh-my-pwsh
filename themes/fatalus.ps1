 function prompt {
	$lastCommandStatus = $?
	$user = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name.split('\')[1]
	$hostName = [System.Net.Dns]::GetHostName()
	
	Write-Host "╭─" -NoNewline
	Write-Host "$user" -ForegroundColor Green -NoNewline
	Write-Host "@" -NoNewline
	Write-Host "$hostName " -ForegroundColor Cyan -NoNewline
	Write-Host "on " -ForegroundColor White -NoNewline
	Write-Host "$((Get-Location).Path) " -ForegroundColor Yellow -NoNewline
	
	# Display branch if current directory is in a git repo
	$gitBranch = (git rev-parse --abbrev-ref HEAD)
	if ($LASTEXITCODE -eq 0) {
		Write-Host "on " -ForegroundColor White -NoNewline
		Write-Host "$($gitBranch.Trim())" -ForegroundColor DarkYellow -NoNewline
		
		# Check for dirty git repo
		Write-Host "(" -ForegroundColor White -NoNewline
		if (git status -z | Out-String) {
			Write-Host "XXX" -ForegroundColor Red -NoNewline
		} else {
			Write-Host "✓" -ForegroundColor Green -NoNewline
		}
		Write-Host ")" -ForegroundColor White -NoNewline
	}
	
	Write-Host "" # New line!
	Write-Host "╰──" -ForegroundColor White -NoNewline
	
	if ($lastCommandStatus) {
		Write-Host "➤ " -ForegroundColor Green -NoNewline
	} else {
		Write-Host "➤ " -ForegroundColor Red -NoNewline
	}

    return " "
	# Update-PwshStats
}