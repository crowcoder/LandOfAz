
Connect-AzAccount -Tenant $Env:AZ_TENANT -Subscription $Env:AZ_SUBSCRIPTION

$rgn = "rg-tekhed-bicep-demo"
New-AzResourceGroup -Name $rgn -Location "eastus"
New-AzResourceGroupDeployment -TemplateFile ./main.json -ResourceGroupName $rgn -location eastus -name "stortekhedtemp01"
