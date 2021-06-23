<#
.SYNOPSIS
    Create a progress bar to BitLocker Encryption
.DESCRIPTION
    The use of this script to follow allong when BitLocker is in a encryption progress state so you can follow along till it reaches 100% completion.
.EXAMPLE
    PS C:\> .\get-bitlocker-process.ps1
    Checks if drive is in a encryption progress state.
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    This is a as-is, best effort script.
#>

# Create a progress bar.
Do
{
    # Get BitLocker Encryption progress.
    $BitLockerProgress = (Get-BitLockerVolume).EncryptionPercentage

    # Create Progress bar.
    Write-Progress -Activity "BitLocker Encryption Progress" -status $BitLockerProgress -PercentComplete $BitLockerProgress

# End progress bar when encryption reaches 100%.
} Until ($BitLockerProgress -eq 100)

# If Encryption percentage equals 100%, write that drive is bitlocker.
Write-Host "Drive is BitLocker Encrypted"