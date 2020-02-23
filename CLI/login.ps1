Set-Location Env:


# Script assumes you have the following environment variables set.
# Don't forget to restart your terminal session after creating env variables.

$tenant = Get-ChildItem .\AZ_TENANT
$subscription = Get-ChildItem .\AZ_SUBSCRIPTION

# Logs in with specific tenant
az login --tenant $tenant.Value

# Sets all actions in current terminal to a specific subscription
az account set --subscription $subscription