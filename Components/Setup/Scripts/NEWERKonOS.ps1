if ($env:WT_SESSION) { $WTSession = $true }
else { $WTSession = $false }

# Choices
Write-Host "Create a restore point? (Y/N) *Recommended*"
Read-Choice -Name "CreateRP"

Write-Host "Uninstall Microsoft Edge? (Y/N)"
Read-Choice -Name "RemoveEdge"

Write-Host "Would you like to uninstall Microsoft Store? (Y/N)"
Read-Choice -Name "RemoveWS"

Write-Host "Disable Wi-Fi? (Y/N)"
Read-Choice -Name "DisableWifi"