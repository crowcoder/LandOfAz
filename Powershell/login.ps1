
Set-Location Env:

$tenant = Get-ChildItem .\AZ_TENANT
$subscription = Get-ChildItem .\AZ_SUBSCRIPTION

Connect-AzAccount -Tenant $tenant.Value -Subscription $subscription.Value
