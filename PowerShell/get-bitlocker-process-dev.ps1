# PURPOSE: To check the BitLocker Encryption Percentage progress, so you don't have keep running 'Get-BitLockerVolume' to see when encryption has completed. 
# NOTE - Trying to create a version where I can us if there are multiple mount points on a machine.

$BitLockerVolumes = Get-BitLockerVolume

$BitLockerVolumes | ForEach-Object{$_.MountPoint}(
    {
        $BLinfo = Get-BitLockerVolume -MountPoint "$_"
        if (($BLinfo).VolumeStatus -eq "FullyEncrypted") {
            "$_ Drive is BitLocker Encrypted"
        }
        elseif (($BLinfo).VolumeStatus -eq "FullyDecrypted") {
            "$_ Drive needs to be BitLocker Encrypted"
        }
        else
        {
            Do
            {
                $BitLockerProgress = ($BLinfo).EncryptionPercentage
                Write-Progress -Activity "BitLocker Encryption Progress" -status $BitLockerProgress -PercentComplete $BitLockerProgress
            } Until ($BitLockerProgress -eq 100)

            Write-Host "$_ Drive is BitLocker Encrypted"
        }
    }
)
