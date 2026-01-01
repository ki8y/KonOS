Import-Module "$env:systemDrive\Kon OS\Modules\Throbber.psm1"
Import-Module "$env:systemDrive\Kon OS\Modules\ColourCodes.psd1"

# ──Disable automatic driver updates─────────────────

Show-Throbber -Message "$Blue🛈 Disabling automatic driver updates..." {
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -PropertyType DWord -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate" -Name "value" -PropertyType DWord -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" -Name "PreventDeviceMetadataFromNetwork" -PropertyType DWord -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -PropertyType DWord -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "DontSearchWindowsUpdate" -PropertyType DWord -Value 1 -Force | Out-Null
}
Write-Host "`r[✓] Disabling automatic driver updates...        " -ForegroundColor Green

# ──Visual Effects───────────────────────────────────

Show-Throbber -Message "$Blue🛈 Disabling all visual effects and animations..." {
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -PropertyType DWord -Value 3 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Desktop" -Name "VisualFXSetting" -PropertyType DWord -Value 3 -Force | Out-Null
}
Write-Host "`r[✓] Disabling all visual effects and animations...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling window animations..." {
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -PropertyType String -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "WindowAnimations" -PropertyType DWord -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name "MinAnimate" -PropertyType String -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\DWM" -Name "EnableWindowShadows" -PropertyType DWord -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name "DragFullWindows" -PropertyType String -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling window animations...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling Taskbar animations..." {
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "TaskbarAnimations" -PropertyType DWord -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -PropertyType DWord -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling Taskbar animations        " -ForegroundColor Green

Write-Host "[\] 🛈 Disabling Aero Peek..." -ForegroundColor Blue -NoNewLine
New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -PropertyType DWord -Value 0 -Force | Out-Null
Write-Host "`r[✓] Disabling Aero Peek...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling menu animations..." {
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name "MenuShowDelay" -PropertyType String -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "EnableToolTips" -PropertyType DWord -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListBoxSmoothScrolling" -PropertyType DWord -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "MenuAnimations" -PropertyType DWord -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name "SmoothScroll" -PropertyType String -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling menu Animations...        " -ForegroundColor Green

Write-Host "[\] 🛈 Disabling cursor shadows..." -ForegroundColor Blue -NoNewLine
New-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'UserPreferencesMask' -Type Binary -Value ([byte[]](144,18,3,128,16,0,0,0)) -Force | Out-Null
Write-Host "`r[✓] Disabling menu Animations...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling selection rectangle..." {
New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -PropertyType DWord -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling selection rectangle...          " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Enabling font smoothing..." {
New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "FontSmoothing" -PropertyType DWord -Value 2 -Force | Out-Null
New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name "FontSmoothing" -PropertyType String -Value 2 -Force | Out-Null
}
Write-Host "`r[✓] Enabling font smoothing...              " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling slide combo box animations..." {
New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ComboBoxAnimation" -PropertyType DWord -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling slide combo box animations...               " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling desktop shadows..." {
New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -PropertyType DWord -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling desktop shadows...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Enabling Photo and video thumbnails..." {
New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "IconsOnly" -PropertyType DWord -Value 0 -Force | Out-Null
New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ThumbnailCacheSize" -PropertyType DWord -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Enabling Photo and video thumbnails...        " -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Disabling thumbnail caching..." {
New-ItemProperty -Path"Registry::HKCU\Software\Microsoft\Windows\DWM" -Name "AlwaysHibernateThumbnails" -PropertyType DWord -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling thumbnail caching...        " -ForegroundColor Green




reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f

Write-Host "Applying bootloader tweaks...`n"

Write-Host "🛈 Setting boot menu to legacy..."
bcdedit /set {current} bootmenupolicy Legacy | Out-Null

Write-Host '🛈 Deleting "useplatformclock" value...'
bcdedit /deletevalue useplatformclock | Out-Null

Write-Host '🛈 Disabling useplatformtick value...'
bcdedit /set useplatformtick no | Out-Null

Write-Host '🛈 Enabling disabledynamictick value...'
bcdedit /set disabledynamictick yes | Out-Null

Write-Host '🛈 Disabling Boot UI...'
bcdedit /set bootux disabled | Out-Null

Write-Host '🛈 Setting Time-Stamp Counter Synchronization Policy to enhanced...'
bcdedit /set tscsyncpolicy enhanced | Out-Null 

Write-Host '🛈 Enabling x2APIC...'
bcdedit /set x2apicpolicy Enable | Out-Null

Write-Host '🛈 Disabling Legacy APIC Mode...'
bcdedit /set uselegacyapicmode No | Out-Null

Show-Throbber -Message "$Blue🛈 Applying shutdown tweaks..." {
New-ItemProperty -Path "HKCU\Control Panel\Desktop" -Name "AutoEndTasks" -PropertyType String -Value "1" -Force | Out-Null
New-ItemProperty -Path "HKCU\Control Panel\Desktop" -Name "HungAppTimeout" -PropertyType String -Value "1000" -Force | Out-Null
New-ItemProperty -Path "HKCU\Control Panel\Desktop" -Name "WaitToKillAppTimeout" -PropertyType String -Value "1000" -Force | Out-Null
New-ItemProperty -Path "HKCU\Control Panel\Desktop" -Name "LowLevelHooksTimeout" -PropertyType String -Value "1000" -Force | Out-Null
New-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -PropertyType String -Value "1000" -Force | Out-Null
New-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name HiberbootEnabled -PropertyType DWord -Value "0" -Force | Out-Null
powercfg -h off
}
Write-Host "`r[✓] Applying shutdown tweaks..." -ForegroundColor Green