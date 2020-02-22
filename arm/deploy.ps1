New-AzResourceGroupDeployment `
    -Name final `
    -ResourceGroupName rg-arm-temp `
    -TemplateFile .\azuredeploy.json `
    -storagePrefix "store" `
    -storageSKU "Standard_GRS"