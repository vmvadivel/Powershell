clear

$PSVersionTable.PSVersion

Get-Module -ListAvailable
Get-Module -ListAvailable -Name AzureRM -Refresh

Get-Module AzureRM -ListAvailable | Select-Object -Property Name,Version,Path