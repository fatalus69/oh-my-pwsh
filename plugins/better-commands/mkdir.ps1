if (Test-Path alias:mkdir) {
    Remove-Item alias:mkdir
}

<#
  Name: mkdir
  Description: create directories without output
#>
function mkdir {
    param(
        [Parameter(Mandatory = $true)]
        [string]$dirname
    )
    New-Item -Name $dirname -ItemType Directory | Out-Null
}