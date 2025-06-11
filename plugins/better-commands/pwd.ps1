if (Test-Path alias:pwd) {
    Remove-Item alias:pwd
}

<#
  Name: pwd
  Description: Print working directory
#>
function global:pwd {
	(Get-Location).Path
}