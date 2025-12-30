Import-Module "$env:systemDrive\Kon OS\Modules\Throbber.psm1"
Import-Module "$env:systemDrive\Kon OS\Modules\ColourCodes.psd1"






Show-Throbber -Message "$Blue🛈 Disabling automatic driver updates..." {
<#New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate" -Name "value" -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -PropertyType DWord -Value 0 -Force | Out-Null
New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "DontSearchWindowsUpdate" -PropertyType DWord -Value 1 -Force | Out-Null#>
}
Write-Host "`r[✓] Disabling automatic driver updates...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling all visual effects and animations..." {
# New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -PropertyType DWord -Value 3 -Force | Out-Null
# New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Desktop" -Name "VisualFXSetting" -PropertyType DWord -Value 3 -Force | Out-Null
}
Write-Host "`r[✓] Disabling all visual effects and animations...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling window animations..." {
# New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -PropertyType String -Value 0 -Force | Out-Null
# New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "WindowAnimations" -PropertyType DWord -Value 0 -Force | Out-Null
# New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name "MinAnimate" -PropertyType String -Value 0 -Force | Out-Null
# New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\DWM" -Name "EnableWindowShadows" -PropertyType DWord -Value 0 -Force | Out-Null
# New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name "DragFullWindows" -PropertyType String -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling window animations...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling Taskbar animations..." {
# New-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "TaskbarAnimations" -PropertyType DWord -Value 0 -Force | Out-Null
# New-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -PropertyType DWord -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling Taskbar animations        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling Aero Peek..." {
# New-ItemProperty -Path "HKCU\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -PropertyType DWord -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling Aero Peek...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling menu animations..." {
# New-ItemProperty -Path "HKCU\Control Panel\Desktop" -Name "MenuShowDelay" -PropertyType String -Value 0 -Force | Out-Null
# New-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "EnableToolTips" -PropertyType DWord -Value 0 -Force | Out-Null
# New-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListBoxSmoothScrolling" -PropertyType DWord -Value 0 -Force | Out-Null
# New-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "MenuAnimations" -PropertyType DWord -Value 0 -Force | Out-Null
# New-ItemProperty -Path "HKCU\Control Panel\Desktop" -Name "SmoothScroll" -PropertyType String -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling menu Animations...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling cursor shadows..." {
# New-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'UserPreferencesMask' -Type Binary -Value ([byte[]](144,18,3,128,16,0,0,0)) -Force | Out-Null
}
Write-Host "`r[✓] Disabling menu Animations...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling selection rectangle..." {
# New-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -PropertyType DWord -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling selection rectangle...          " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Enabling font smoothing..." {
# New-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "FontSmoothing" -PropertyType DWord -Value 2 -Force | Out-Null
# New-ItemProperty -Path "HKCU\Control Panel\Desktop" -Name "FontSmoothing" -PropertyType String -Value 2 -Force | Out-Null
}
Write-Host "`r[✓] Enabling font smoothing...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling slide combo box animations" {
# New-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ComboBoxAnimation" -PropertyType DWord -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Enabling font smoothing...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling desktop shadows..." {
# New-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -PropertyType DWord -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling desktop shadows...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Enabling Photo and video thumbnails..." {
# New-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "IconsOnly" -PropertyType DWord -Value 0 -Force | Out-Null
# New-ItemProperty -Path "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ThumbnailCacheSize" -PropertyType DWord -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Enabling Photo and video thumbnails...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling thumbnail caching..." {
# New-ItemProperty -Path "HKCU\Software\Microsoft\Windows\DWM" -Name "AlwaysHibernateThumbnails" -PropertyType DWord -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling thumbnail caching...        " -ForegroundColor Green