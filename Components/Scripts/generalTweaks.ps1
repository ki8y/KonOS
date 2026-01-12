Import-Module "$env:systemDrive\Kon OS\Modules\Throbber.psm1"
Import-Module "$env:systemDrive\Kon OS\Modules\ColourCodes.psm1"

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

Write-Host "[\] 🛈 Disabling selection rectangle..." -ForegroundColor Blue -NoNewLine
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -PropertyType DWord -Value 0 -Force | Out-Null
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
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\DWM" -Name "AlwaysHibernateThumbnails" -PropertyType DWord -Value 0 -Force | Out-Null
}
Write-Host "`r[✓] Disabling thumbnail caching...        " -ForegroundColor Green

# ──Mouse Acceleration───────────────────────────────

Show-Throbber -Message "$Blue🛈 Disabling Mouse Acceleration..." {
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Mouse" -Name MouseSpeed -PropertyType String -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Mouse" -Name MouseThreshold1 -PropertyType String -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Mouse" -Name MouseThreshold2 -PropertyType String -Value 0 -Force | Out-Null
}

# ──Bootloader Tweaks────────────────────────────────

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
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name "AutoEndTasks" -PropertyType String -Value "1" -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name "HungAppTimeout" -PropertyType String -Value "1000" -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name "WaitToKillAppTimeout" -PropertyType String -Value "1000" -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name "LowLevelHooksTimeout" -PropertyType String -Value "1000" -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control" -Name "WaitToKillServiceTimeout" -PropertyType String -Value "1000" -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name HiberbootEnabled -PropertyType DWord -Value "0" -Force | Out-Null
    powercfg -h off
}
Write-Host "`r[✓] Applying shutdown tweaks..." -ForegroundColor Green

Show-Throbber -Message "$Blue🛈 Adding verbose logon screens and bluescreens..." {
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -PropertyType Dword -Value '1' -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" -Name "DisplayParameters" -PropertyType Dword -Value '1' -Force | Out-Null
}
Write-Host "`r[✓] Adding verbose logon screens and bluescreens..." -ForegroundColor Green 

# ──Explorer Tweaks──────────────────────────────────

Write-Host "🛈 Disabling wallpaper compression..." -NoNewline
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name 'JPEGImportQuality' -PropertyType Dword -Value 100 -Force | Out-Null

Write-Host '🛈 Enabling "End Task" button in taskbar...' -NoNewLine
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" -Name 'TaskbarEndTask' -PropertyType Dword -Value 1 -Force | Out-Null

Write-Host "🛈 Enabling hidden files and showing file extensions..."
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name 'HideFileExt' -PropertyType Dword -Value 0 -Force | Out-Null 
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name 'UseCompactMode' -PropertyType Dword -Value 1 -Force | Out-Null 
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL" -Name 'CheckedValue' -PropertyType Dword -Value 1 -Force | Out-Null

Write-Host "🛈 Enabling legacy context menu..."
    New-Item -Path "Registry::HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force

Write-Host "🛈 Enabling dark mode..."
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name 'SystemUsesLightTheme' -PropertyType Dword -Value 0 -Force | Out-Null 
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name 'AppsUseLightTheme' -PropertyType Dword -Value 0 -Force | Out-Null 

Write-Host "🛈 Disabling copilot..."
    New-ItemProperty -Path "Registry::HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" -Name 'TurnOffWindowsCopilot' -PropertyType Dword -Value 1 -Force | Out-Null 
New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name 'ShowCopilotButton' -PropertyType Dword -Value 0 -Force | Out-Null 

Write-Host "🛈 Disabling transparency..."
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name 'EnableTransparency' -PropertyType Dword -Value 0 -Force | Out-Null 

Write-Host "🛈 Disabling sticky keys..."
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Accessibility\StickyKeys" -Name Flags -PropertyType String -Value 506 -Force | Out-Null 

Write-Host "🛈 Disabling Toast Notifications..."
    New-ItemProperty -Path "Registry::HKCU\Software\Policies\Microsoft\Windows\Explorer" -Name 'DisableNotificationCenter' -PropertyType Dword -Value 1 -Force | Out-Null 
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" -Name 'ToastEnabled' -PropertyType Dword -Value 0 -Force | Out-Null

# ──Useless background processes─────────────────────

Write-Host "🛈 Disabling background processes..." -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name GlobalUserDisabled -PropertyType Dword -Value 1 -Force | Out-Null 
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Search" -Name BackgroundAppGlobalToggle -PropertyType Dword -Value 0 -Force | Out-Null 
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\AppPrivacy" -Name LetAppsRunInBackground -PropertyType Dword -Value 2 -Force | Out-Null 

Write-Host "🛈 Disabling activity history..." -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\System" -Name EnableActivityFeed -PropertyType Dword -Value 0 -Force | Out-Null 
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\System" -Name PublishUserActivities -PropertyType Dword -Value 0 -Force | Out-Null 
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\System" -Name UploadUserActivities -PropertyType Dword -Value 0 -Force | Out-Null 

Write-Host "🛈 Disabling location services..." -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -PropertyType String -Value "deny" -Force | Out-Null 
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -PropertyType Dword -Value "0" -Force | Out-Null 
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -PropertyType Dword -Value "0" -Force | Out-Null 
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\Maps" -Name "AutoUpdateEnabled" -PropertyType Dword -Value "0" -Force | Out-Null 

Write-Host "🛈 Disabling UAC" -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name EnableLUA -PropertyType Dword -Value 0 -Force | Out-Null 

Write-Host "🛈 Disabling login blur" -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\System" -Name DisableAcrylicBackgroundOnLogon -PropertyType Dword -Value 1 -Force | Out-Null

Write-Host @"
$accent
                                              ╭──────────────────────────╮
                                              │  🛡️ Disabling Telemetry  │
                                              ╰──────────────────────────╯
"@
    $tasks = @(
        'Microsoft Compatibility Appraiser',
        'ProgramDataUpdater',
        'MareBackup',
        'StartupAppTask',
        'PcaPatchDbTask'
    )
    foreach ($task in $tasks) {
        try {
            Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Application Experience\' -Taskname "$Task" -ErrorAction Stop
            Write-Host "`r                                           ──────────────────────────────────────────────────────────────────────── [$($Green)ok$White]" -NoNewLine
            Write-Host ("`r" + "$Green*$White Disabling " + $task + ' in task scheduler... ─────────────────────────')
        } catch {
            Write-Host "                                              ─────────────────────────────────────────────────────────────────── [$($Red)fail$White]" -NoNewLine
            Write-Host ("`r" + '[91m*[97m Disabling ' + $task + ' in task scheduler... ──────────────────────────────────────')
        }
    }

    $tasks = @(
        'DmClient',
        'DmClientOnScenarioDownload'
    )
    foreach ($task in $tasks) {
        try {
            Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Feedback\Siuf\' -Taskname "$Task" -ErrorAction Stop | Out-Null
            Write-Host "`r                                           ──────────────────────────────────────────────────────────────────────── [$($Green)ok$White]" -NoNewLine
            Write-Host ("`r" + "$Green*$White Disabling " + $task + ' in task scheduler... ─────────────────────────')
        } catch {
            Write-Host "                                              ─────────────────────────────────────────────────────────────────── [$($Red)fail$White]" -NoNewLine
            Write-Host ("`r" + '[91m*[97m Disabling ' + $task + ' in task scheduler... ──────────────────────────────────────')
        }
    }

    $tasks = @(
        'Consolidator',
        'UsbCeip'
    )
    foreach ($task in $tasks) {
        try {
            Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Customer Experience Improvement Program\' -Taskname "$Task" -ErrorAction Stop | Out-Null
            Write-Host "`r                                           ──────────────────────────────────────────────────────────────────────── [$($Green)ok$White]" -NoNewLine
            Write-Host ("`r" + "$Green*$White Disabling " + $task + ' in task scheduler... ─────────────────────────')
        } catch {
            Write-Host "                                              ─────────────────────────────────────────────────────────────────── [$($Red)fail$White]" -NoNewLine
            Write-Host ("`r" + '[91m*[97m Disabling ' + $task + ' in task scheduler... ──────────────────────────────────────')
        }
    }

Show-Throbber -Message "$($Blue)Disabling Telemetry via various scheduled tasks and registry keys..." {
    
    Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Autochk\' -TaskName "Proxy" | Out-Null
    Disable-ScheduledTask -TaskPath 'Microsoft\Windows\DiskDiagnostic\' -TaskName 'Microsoft-Windows-DiskDiagnosticDataCollector' | Out-Null
    Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Maps\' -TaskName 'MapsUpdateTask' | Out-Null
    Disable-ScheduledTask -TaskPath 'Microsoft\Windows\Windows Error Reporting\' -Taskname 'QueueReporting' | Out-Null

    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name 'AllowTelemetry' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name 'AllowTelemetry' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name 'ContentDeliveryAllowed' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name 'OemPreInstalledAppsEnabled' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name 'PreInstalledAppsEnabled' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name 'PreInstalledAppsEverEnabled' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name 'SilentInstalledAppsEnabled' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name 'SubscribedContent-338387Enabled' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name 'SubscribedContent-338388Enabled' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name 'SubscribedContent-338389Enabled' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name 'SubscribedContent-353698Enabled' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name 'SystemPaneSuggestionsEnabled' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name 'DisableWindowsConsumerFeatures' -PropertyType Dword -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Microsoft\Siuf\Rules" -Name 'NumberOfSIUFInPeriod' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name 'DoNotShowFeedbackNotifications' -PropertyType Dword -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name 'DisableTailoredExperiencesWithDiagnosticData' -PropertyType Dword -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name 'DisabledByGroupPolicy' -PropertyType Dword -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name 'Disabled' -PropertyType Dword -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name 'DODownloadMode' -PropertyType Dword -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" -Name 'fAllowToGetHelp' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name 'EnthusiastMode' -PropertyType Dword -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name 'PeopleBand' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name 'LaunchTo' -PropertyType Dword -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" -Name 'LongPathsEnabled' -PropertyType Dword -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name 'SystemResponsiveness' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name 'NetworkThrottlingIndex' -PropertyType Dword -Value 4294967295 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name 'ClearPageFileAtShutdown' -PropertyType Dword -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\ControlSet001\Services\Ndu" -Name 'Start' -PropertyType Dword -Value 2 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Mouse" -Name 'MouseHoverTime' -PropertyType String -Value 400 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name 'IRPStackSize' -PropertyType Dword -Value 30 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name 'ShellFeedsTaskbarViewMode' -PropertyType Dword -Value 2 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name 'HideSCAMeetNow' -PropertyType Dword -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name 'GPU Priority' -PropertyType Dword -Value 8 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name 'Priority' -PropertyType Dword -Value 6 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" -Name 'Scheduling Category' -PropertyType String -Value High -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name 'ScoobeSystemSettingEnabled' -PropertyType Dword -Value 0 -Force | Out-Null
}

Write-Host "🛈 Disabling IPv6..." -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name "DisabledComponents" -PropertyType Dword -Value "255" -Force | Out-Null
    Disable-NetAdapterBinding -Name '*' -ComponentID ms_tcpip6 | Out-Null

Write-Host "🛈 Disabling GameDVR..." -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKCU\System\GameConfigStore" -Name 'GameDVR_Enabled' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name 'AllowGameDVR' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name 'AppCaptureEnabled' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name 'AudioCaptureEnabled' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name 'HistoricalCaptureEnabled' -PropertyType Dword -Value 0 -Force | Out-Null

Write-Host "🛈 Disabling Bing Search in start menu..." -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Search" -Name 'BingSearchEnabled' -PropertyType Dword -Value 0 -Force | Out-Null

Write-Host "🛈 Disabling Fullscreen Optimizations (FSO)" -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKCU\System\GameConfigStore" -Name 'GameDVR_FSEBehavior' -PropertyType Dword -Value 2 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\System\GameConfigStore" -Name 'GameDVR_DSEBehavior' -PropertyType Dword -Value 2 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\System\GameConfigStore" -Name 'GameDVR_DXGIHonorFSEWindowsCompatible' -PropertyType Dword -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\System\GameConfigStore" -Name 'GameDVR_HonorUserFSEBehaviorMode' -PropertyType Dword -Value 1 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\System\GameConfigStore" -Name 'GameDVR_EFSEFeatureFlags' -PropertyType Dword -Value 0 -Force | Out-Null

Write-Host "🛈 Disabling Game bar..." -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\GameBar" -Name 'ShowStartupPanel' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\GameBar" -Name 'GamePanelStartupTipIndex' -PropertyType Dword -Value 3 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\GameBar" -Name 'UseNexusForGameBarEnabled' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\GameBar" -Name 'AllowAutoGameMode' -PropertyType Dword -Value 0 -Force | Out-Null
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\GameBar" -Name 'AutoGameModeEnabled' -PropertyType Dword -Value 0 -Force | Out-Null 
    New-ItemProperty -Path "Registry::HKCU\Software\Microsoft\GameBar" -Name 'GameBarEnabled' -PropertyType Dword -Value 0 -Force | Out-Null

Write-Host "🛈 Disabling Core Isolation..." -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKLM\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name 'Enabled' -PropertyType Dword -Value 0 -Force | Out-Null

Write-Host "🛈 Disabling Live Tiles..." -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" -Name 'NoTileApplicationNotification' -PropertyType Dword -Value 1 -Force | Out-Null

Write-Host "🛈 Disabling smooth scrolling" -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKCU\Control Panel\Desktop" -Name 'SmoothScroll' -PropertyType Dword -Value 0 -Force | Out-Null

Write-Host "🛈 Flushing Windows Explorer..." -ForegroundColor Blue
    Remove-Item "Registry::HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags" -Force
    New-ItemProperty -Path "Registry::HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" -Name 'FolderType' -PropertyType String -Value "NotSpecified" -Force | Out-Null

Write-Host "🛈 Disabling fast user switching..." -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name 'HideFastUserSwitching' -PropertyType Dword -Value 1 -Force | Out-Null

Write-Host "🛈 Disabling Windows Ink related features..." -ForegroundColor Blue
    New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" -Name 'AllowWindowsInkWorkspace' -PropertyType Dword -Value 0 -Force | Out-Null