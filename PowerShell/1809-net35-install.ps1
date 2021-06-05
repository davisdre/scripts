$NETFX3Install=Get-WindowsCapability -Online -Source .\ -LimitAccess |where name -like netfx3* | select name
  foreach ($item in $NETFX3Install){
  Write-Output $item.Name
  Add-WindowsCapability -Online -Name $item.name -LimitAccess -source .\ 
  }
