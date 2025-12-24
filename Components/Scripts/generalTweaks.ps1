<#
STILL WORKING ON CONVERTING TO POWERSHELL CMDLETS
#>
Clear-Host

Write-Host "🛈 Disabling automatic driver updates..." -ForegroundColor Blue
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force -WhatIf| Out-Null
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force -WhatIf| Out-Null
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force -WhatIf | Out-Null
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force -WhatIf | Out-Null
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate" -Name "value" -PropertyType DWord -Value 1 -Force -WhatIf | Out-Null
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -PropertyType DWord -Value 1 -Force -WhatIf | Out-Null
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -PropertyType DWord -Value 0 -Force -WhatIf | Out-Null
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "DontSearchWindowsUpdate" -PropertyType DWord -Value 1 -Force -WhatIf | Out-Null

Write-Host "🛈 Disabling all visual effects and animations..."
New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -PropertyType DWord -Value 3 -Force -WhatIf | Out-Null 
New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Desktop" -Name "VisualFXSetting" -PropertyType DWord -Value 3 -Force -WhatIf | Out-Null 

Write-Host "🛈 Disabling window animations..." -ForegroundColor Blue
New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -PropertyType String -Value 0 -Force -WhatIf | Out-Null
New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "WindowAnimations" -PropertyType DWord -Value 0 -Force -WhatIf | Out-Null
New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name "MinAnimate" -PropertyType String -Value 0 -Force -WhatIf | Out-Null 
New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\DWM" -Name "EnableWindowShadows" -PropertyType DWord -Value 0 -Force -WhatIf | Out-Null 
New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name "DragFullWindows" -PropertyType String -Value 0 -Force -WhatIf | Out-Null 

Write-Host "🛈 Disabling Taskbar animations..."