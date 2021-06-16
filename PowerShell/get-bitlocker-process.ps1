## PURPOSE: To check progress of BitLocker Process so you don't have to keep running "get-blockervolume" to keep check progress. 
#
Do
{
    $BitLockerProgress = (Get-BitLockerVolume).EncryptionPercentage
    Write-Progress -Activity "BitLocker Encryption Progress" -status $BitLockerProgress -PercentComplete $BitLockerProgress
} Until ($BitLockerProgress -eq 100)
