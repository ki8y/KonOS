<#
STILL WORKING ON CONVERTING TO POWERSHELL CMDLETS
#>
Clear-Host

Write-Host "🛈 Disabling automatic driver updates..." -ForegroundColor Blue
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f | Out-Null
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f | Out-Null
reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f | Out-Null
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f | Out-Null
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate" /v value /t REG_DWORD /d 1 /f | Out-Null
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f | Out-Null
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f | Out-Null
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v DontSearchWindowsUpdate /t REG_DWORD /d 1 /f | Out-Null

