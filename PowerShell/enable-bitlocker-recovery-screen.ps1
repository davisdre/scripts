<#
.SYNOPSIS
    Good example of possible hostile termination using the BitLocker Recovery Screen.
.NOTES
    Note you need your decryption/recovery key to get back in.
#>

# Set Mount point variable.
$MountPoint = "C:"

# Get key proctectors for Mount Point.
$KeyProtectors = (Get-BitLockerVolume -MountPoint $MountPoint).KeyProtector

# Remove BitLocker Key Protector.
foreach($KeyProtector in $KeyProtectors){
Remove-BitLockerKeyProtector -MountPoint $MountPoint -KeyProtectorId $KeyProtector.KeyProtectorId
}

# Force computer restart on machine. 
shutdown -r -t 0 -f