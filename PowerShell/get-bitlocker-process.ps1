## PURPOSE: To check progress of BitLocker Process.
##
## Initial creator: Drew Davis
#
## Revised last by:
## Revised date:
#
# Version history
#
# version 0.1
# Initial PowerShell script for checking progress
#
#
Do
{
    $BitLockerProgress = (Get-BitLockerVolume).EncryptionPercentage
    Write-Progress -Activity "BitLocker Encryption Progress" -status $BitLockerProgress -PercentComplete $BitLockerProgress
} Until ($BitLockerProgress -eq 100)
