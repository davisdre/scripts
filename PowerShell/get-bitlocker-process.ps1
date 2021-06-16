# PURPOSE: To check the Encryption Percentage progress, so you don't have keep running 'Get-BitLockerVolume' to see when encrypting has completed. 
#
Do
{
    $BitLockerProgress = (Get-BitLockerVolume).EncryptionPercentage
    Write-Progress -Activity "BitLocker Encryption Progress" -status $BitLockerProgress -PercentComplete $BitLockerProgress
} Until ($BitLockerProgress -eq 100)
