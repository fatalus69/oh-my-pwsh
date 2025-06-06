if (Test-Path alias:pwd) {
    Remove-Item alias:pwd
}

<#
  Name: pwd
  Description: Print working directory
#>
function pwd {
	(Get-Location).Path
}