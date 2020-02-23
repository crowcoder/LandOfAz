Write-Host "Listing All Resource Groups"
Write-Host "----------------------------------------------------------"
az group list

Write-Host "Create some random resource groups and add tags"
Write-Host "----------------------------------------------------------"

# Create some random resource groups and add tags
$random_grp_name_1 = "rg-demo-" + [System.IO.Path]::GetRandomFileName()
$id = az group create --location centralus --name $random_grp_name_1 --query id
az resource tag --tags owner=alice purpose=test todelete=true --ids $id

$random_grp_name_2 = "rg-demo-" + [System.IO.Path]::GetRandomFileName()
$id = az group create --location centralus --name $random_grp_name_2 --query id
az resource tag --tags owner=wally purpose=qa todelete=true --ids $id

$random_grp_name_3 = "rg-demo-" + [System.IO.Path]::GetRandomFileName()
$id = az group create --location eastus --name $random_grp_name_3 --query id
az resource tag --tags owner=dilbert purpose=prod  todelete=true --ids $id

Write-Host "Show JMESpath query examples"
Write-Host "----------------------------------------------------------"

az group list --query "[?location=='centralus']" #queries list of resource groups with centralus location
az group list --query "[?location=='centralus'].tags" # queries list of resourse groups with centralus location that have tags defined
az group list --query "[?location=='centralus'].tags | [?purpose=='qa']" # filters the groups for tags named "purpose" that have value of "qa"
az group list --query "[?location=='centralus'].tags | [?purpose=='qa'].owner" # Grabs the owner tag value
az group list --query "[?location=='centralus'].tags | [?purpose=='qa'].owner | [0]" #outputs a json string, not just a string value
az group list --query "[?location=='centralus'].tags | [?purpose=='qa'].owner | [0]" --output tsv #this outputs just a string value

Write-Host "JSON output to powershell object"
Write-Host "----------------------------------------------------------"

# If you don't need filtering, you may find it easier to convert json to an object
$group_as_json = az group show --name $random_grp_name_2  | ConvertFrom-Json
$group_as_json # observe output
$group_as_json.tags # observe output
$group_as_json.tags.owner # observe output

Write-Host "Clean up"
Write-Host "----------------------------------------------------------"

# Clean up
az group delete --name $random_grp_name_1 --yes --no-wait
az group delete --name $random_grp_name_2 --yes --no-wait
az group delete --name $random_grp_name_3 --yes --no-wait

[Console]::ResetColor()