if (Test-Path alias:ls) {
    Remove-Item alias:ls
}
<#
  Name: ls
  Description: Colorized, columnized directory listing
#>
function ls {
	 param (
        [string]$Path = "."
    )

	$White  = "`e[37m"
	$Green  = "`e[32m"
	$Blue   = "`e[34m"
	$Reset  = "`e[0m"

    Get-ChildItem -Force -LiteralPath $Path | ForEach-Object {
        $typeChar = if ($_.PSIsContainer) { "/" } elseif ($_.Mode -match 'x') { "*" } else { "" }
		$color = if ($_.PSIsContainer) {
            $Blue
        } elseif ($_.Mode -match 'x') {
            $Green
        } else {
            $White
        }

        $mode = $_.Mode
        $size = $_.Length
        $time = $_.LastWriteTime.ToString("MMM dd HH:mm")
        $name = $_.Name + $typeChar

        Write-Host ("{0,-10} {1,10} {2,12} " -f $mode, $size, $time) -NoNewline
        Write-Host "$color$name$Reset"
    }
}