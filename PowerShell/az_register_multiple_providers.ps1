<#
.Synopsis
   Registers a specified Azure resource provider across all subscriptions in the tenant.
.DESCRIPTION
   This PowerShell script connects to your Azure account, loops through each subscription, and registers a specified provider namespace (e.g., ‘Microsoft.Network’). It then validates the registration status.
.EXAMPLE
   .\az_register_multiple_providers.ps1 -ProviderNamespace "Microsoft.Network"
.EXAMPLE
   .\az_register_multiple_providers.ps1 -ProviderNamespace "Microsoft.Compute"
.INPUTS
   No inputs parameters required.
.OUTPUTS
   No specific output; registration status is displayed during execution.
.NOTES
   Ensure you have appropriate permissions to register providers in all subscriptions.
.FUNCTIONALITY
   Registers Azure resource providers across multiple subscriptions.
#>

# Connect to Azure account
Connect-AzAccount

# Define the provider namespace you want to register
$providerNamespace = "Microsoft.Network"

# Get all subscriptions in the tenant
$subscriptions = Get-AzSubscription

# Loop through each subscription
foreach ($subscription in $subscriptions) {
    # Set the current subscription context
    Set-AzContext -SubscriptionId $subscription.Id

    # Display the current subscription being processed
    Write-Host "Registering provider in subscription: $($subscription.Name) ($($subscription.Id))"

    # Register the provider
    $registration = Register-AzResourceProvider -ProviderNamespace $providerNamespace

    # Validate the registration
    if ($registration.RegistrationState -eq "Registered") {
        Write-Host "Provider $providerNamespace successfully registered in subscription: $($subscription.Name)"
    } else {
        Write-Host "Failed to register provider $providerNamespace in subscription: $($subscription.Name)"
    }
}
