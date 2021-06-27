# PURPOSE: To check the BitLocker Encryption Percentage progress, so you don't have keep running 'Get-BitLockerVolume' to see when encryption has completed. 
# NOTE - Trying to create a version where I can us if there are multiple mount points on a machine.

# Get BitLocker volumes on machine
$BitLockerVolumes = Get-BitLockerVolume

# Check the BitLocker status on volumes.
$BitLockerVolumes | ForEach-Object{$_.MountPoint}(
    {
        # Get BitLocker info on drive.
        $BLinfo = Get-BitLockerVolume -MountPoint "$_"

        # Check if drive is Bitlocker encrypted.
        if (($BLinfo).VolumeStatus -eq "FullyEncrypted") {
            "$_ Drive is BitLocker Encrypted"
        }
        
        # Check if drive is not Bitlocker encrypted. 
        elseif (($BLinfo).VolumeStatus -eq "FullyDecrypted") {
            "$_ Drive needs to be BitLocker Encrypted"
        }

        # If not Encrypted or Decrypted, check if Encryption is in progess on drive.
        else
        {
            # Track progress of enryption.
            Do
            {
                # Get bitlocker encryption precentage
                $BitLockerProgress = ($BLinfo).EncryptionPercentage
                # Create progress bar
                Write-Progress -Activity "BitLocker Encryption Progress" -status $BitLockerProgress -PercentComplete $BitLockerProgress
              # Close progress bar once it reaches 100%
            } Until ($BitLockerProgress -eq 100)

            # Write when drive has finish encrypting.
            Write-Host "$_ Drive is BitLocker Encrypted"
        }
    }
)
