<#
  Name: touch
  Description: create files
#>
function global:touch {
	param(
		[Parameter(Mandatory = $true)]
		[string]$filename
	)

	New-Item -Name $filename -ItemType File | Out-Null
}