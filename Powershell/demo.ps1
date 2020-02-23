# Where-Object for filtering similar to jmespath and cli

Write-Host "Listing All Resource Groups"
Write-Host "----------------------------------------------------------"
Get-AzResourceGroup

Write-Host "Create some random resource groups and add tags"
Write-Host "----------------------------------------------------------"

# Create some random resource groups and add tags
$random_grp_name_1 = "rg-demo-" + [System.IO.Path]::GetRandomFileName()
New-AzResourceGroup -Name $random_grp_name_1 -Location "East US"
Set-AzResourceGroup -Name $random_grp_name_1 -Tag @{ "owner" = "dilbert"; "purpose" = "prod";"todelete" = "true" }

$random_grp_name_2 = "rg-demo-" + [System.IO.Path]::GetRandomFileName()
New-AzResourceGroup -Name $random_grp_name_2 -Location "Central US" -Tag @{ "owner" = "alice"; "purpose" = "test"; "todelete" = "true" }

$random_grp_name_3 = "rg-demo-" + [System.IO.Path]::GetRandomFileName()
New-AzResourceGroup -Name $random_grp_name_3 -Location "East US" -Tag @{ "owner" = "wally"; "purpose" = "qa"; "todelete" = "true" }

Write-Host "query examples"
Write-Host "----------------------------------------------------------"

Get-AzResourceGroup | Where-Object { $_.location -eq "centralus" }
Get-AzResourceGroup | Where-Object { $_.location -eq "centralus"} | Where-Object { $_.Tags -ne $null}
$grp = Get-AzResourceGroup | Where-Object { $_.location -eq "centralus"} | Where-Object { $_.Tags.purpose -eq "test"}
$grp.Tags.owner

# Clean up
# notice unlike the Azure CLI, there is no straightforward way to --no-wait (https://docs.microsoft.com/en-us/powershell/azure/using-psjobs?view=azps-3.5.0)
Remove-AzResourceGroup -Name $random_grp_name_1 -Force
Remove-AzResourceGroup -Name $random_grp_name_2 -Force
Remove-AzResourceGroup -Name $random_grp_name_3 -Force

[Console]::ResetColor()