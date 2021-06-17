# PURPOSE: To check the BitLocker Encryption Percentage progress, so you don't have keep running 'Get-BitLockerVolume' to see when encryption has completed. 
# NOTE - Trying to create a version where I can us if there are multiple mount points on a machine.

$BitLockerVolumes = @()
$BitLockerVolumes = (Get-BitLockerVolume).MountPoint

$BitLockerVolumes.ForEach(
    {
        if ((Get-BitLockerVolume).VolumeStatus -eq "FullyEncrypted") {
            "c: Drive is BitLocker Encrypted"
        }
        elseif ((Get-BitLockervolume).VolumeStatus -eq "FullyDecrypted") {
            "Drive needs to be BitLocker Encrypted"
        }
        else
        {
            Do
            {
                $BitLockerProgress = (Get-BitLockerVolume).EncryptionPercentage
                Write-Progress -Activity "BitLocker Encryption Progress" -status $BitLockerProgress -PercentComplete $BitLockerProgress
            } Until ($BitLockerProgress -eq 100)

            Write-Host "Drive is BitLocker Encrypted"
        }
    }
)
