$RSATInstall=Get-WindowsCapability -Online -Source .\ -LimitAccess |where name -like rsat* | select name
  foreach ($item in $RSATInstall){
  Write-Output $item.Name
  Add-WindowsCapability -Online -Name $item.name -LimitAccess -source .\ 
  }
