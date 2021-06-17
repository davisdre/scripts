# PURPOSE: To check the BitLocker Encryption Percentage progress, so you don't have keep running 'Get-BitLockerVolume' to see when encryption has completed. 

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