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
