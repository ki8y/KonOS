<# so funny story about this script, originally it was coded in batch, then i remade it in powershell, then i realized New-ItemProperty 
causes issues if it tries to add a value to a key that doesnt exist, so I switched all the commands back to reg.exe again...#>

Import-Module "$env:systemDrive\Kon OS\Modules\Throbber.psm1"
Import-Module "$env:systemDrive\Kon OS\Modules\ColourCodes.psm1"

# ──Disable automatic driver updates─────────────────

Show-Throbber -Message "$($Blue)Disabling automatic driver updates..." {
    reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Update" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate" /v "value" /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "DontSearchWindowsUpdate" /t REG_DWORD /d 1 /f | Out-Null
}
Write-Host "`r[✓] Disabling automatic driver updates...        " -ForegroundColor Green

# ──Visual Effects───────────────────────────────────

Show-Throbber -Message "$($Blue)Disabling all visual effects and animations..." {
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 3 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Desktop" /v "VisualFXSetting" /t REG_DWORD /d 3 /f | Out-Null
}
Write-Host "`r[✓] Disabling all visual effects and animations...        " -ForegroundColor Green

Show-Throbber -Message "$($Blue)Disabling window animations..." {

    reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d 0 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "WindowAnimations" /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\Control Panel\Desktop" /v "MinAnimate" /t REG_SZ /d 0 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableWindowShadows" /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d 0 /f | Out-Null

}
Write-Host "`r[✓] Disabling window animations...        " -ForegroundColor Green

Show-Throbber -Message "$($Blue)Disabling Taskbar animations..." {
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "TaskbarAnimations" /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAnimations" /t REG_DWORD /d 0 /f | Out-Null
}
Write-Host "`r[✓] Disabling Taskbar animations        " -ForegroundColor Green

Write-Host "[\] Disabling Aero Peek..." -ForegroundColor Blue -NoNewLine
    reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d 0 /f | Out-Null
Write-Host "`r[✓] Disabling Aero Peek...        " -ForegroundColor Green

Show-Throbber -Message "$($Blue)Disabling menu animations..." {
    reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d 0 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "EnableToolTips" /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListBoxSmoothScrolling" /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "MenuAnimations" /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\Control Panel\Desktop" /v "SmoothScroll" /t REG_SZ /d 0 /f | Out-Null
}
Write-Host "`r[✓] Disabling menu Animations...        " -ForegroundColor Green

Write-Host "[\] Disabling cursor shadows..." -ForegroundColor Blue -NoNewLine
    
    New-ItemProperty -Path 'Registry::HKCU:\Control Panel\Desktop' -Name 'UserPreferencesMask' -PropertyType Binary /d ([byte[]](144,18,3,128,16,0,0,0)) -Force | Out-Null # this breaks in reg.exe soooo
Write-Host "`r[✓] Disabling menu Animations...        " -ForegroundColor Green

Write-Host "[\] Disabling selection rectangle..." -ForegroundColor Blue -NoNewLine
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d 0 /f | Out-Null
Write-Host "`r[✓] Disabling selection rectangle...          " -ForegroundColor Green

Show-Throbber -Message "$($Blue)Enabling font smoothing..." {
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "FontSmoothing" /t REG_DWORD /d 2 /f | Out-Null
    reg.exe add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d 2 /f | Out-Null
}
Write-Host "`r[✓] Enabling font smoothing...              " -ForegroundColor Green

Show-Throbber -Message "$($Blue)Disabling slide combo box animations..." {
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ComboBoxAnimation" /t REG_DWORD /d 0 /f | Out-Null
}
Write-Host "`r[✓] Disabling slide combo box animations...               " -ForegroundColor Green

Show-Throbber -Message "$($Blue)Disabling desktop shadows..." {
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewShadow" /t REG_DWORD /d 0 /f | Out-Null
}
Write-Host "`r[✓] Disabling desktop shadows...        " -ForegroundColor Green

Show-Throbber -Message "$($Blue)Enabling Photo and video thumbnails..." {
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ThumbnailCacheSize" /t REG_DWORD /d 0 /f | Out-Null
}
Write-Host "`r[✓] Enabling Photo and video thumbnails...        " -ForegroundColor Green

Show-Throbber -Message "$($Blue)Disabling thumbnail caching..." {
    reg.exe add "HKCU\Software\Microsoft\Windows\DWM" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d 0 /f | Out-Null
}
Write-Host "`r[✓] Disabling thumbnail caching...        " -ForegroundColor Green

# ──Mouse Acceleration───────────────────────────────

Show-Throbber -Message "$($Blue)Disabling Mouse Acceleration..." {
    reg.exe add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f | Out-Null
    reg.exe add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f | Out-Null
    reg.exe add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f | Out-Null
}

# ──Bootloader Tweaks────────────────────────────────

Write-Host "Applying bootloader tweaks...`n"

Write-Host "Setting boot menu to legacy..."
bcdedit /set {current} bootmenupolicy Legacy | Out-Null

Write-Host 'Deleting "useplatformclock" value...'
bcdedit /deletevalue useplatformclock | Out-Null

Write-Host 'Disabling useplatformtick value...'
bcdedit /set useplatformtick no | Out-Null

Write-Host 'Enabling disabledynamictick value...'
bcdedit /set disabledynamictick yes | Out-Null

Write-Host 'Disabling Boot UI...'
bcdedit /set bootux disabled | Out-Null

Write-Host 'Setting Time-Stamp Counter Synchronization Policy to enhanced...'
bcdedit /set tscsyncpolicy enhanced | Out-Null 

Write-Host 'Enabling x2APIC...'
bcdedit /set x2apicpolicy Enable | Out-Null

Write-Host 'Disabling Legacy APIC Mode...'
bcdedit /set uselegacyapicmode No | Out-Null

Show-Throbber -Message "$($Blue)Applying shutdown tweaks..." {
    reg.exe add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f | Out-Null
    reg.exe add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f | Out-Null
    reg.exe add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "1000" /f | Out-Null
    reg.exe add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f | Out-Null
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "1000" /f | Out-Null
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d "0" /f | Out-Null
    powercfg -h off
}
Write-Host "`r[✓] Applying shutdown tweaks..." -ForegroundColor Green

Show-Throbber -Message "$($Blue)Adding verbose logon screens and bluescreens..." {
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "VerboseStatus" /t REG_DWORD /d '1' /f | Out-Null
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "DisplayParameters" /t REG_DWORD /d '1' /f | Out-Null
}
Write-Host "`r[✓] Adding verbose logon screens and bluescreens..." -ForegroundColor Green 

# ──Explorer Tweaks──────────────────────────────────

Write-Host "Disabling wallpaper compression..." -NoNewline
    reg.exe add "HKCU\Control Panel\Desktop" /v 'JPEGImportQuality' /t REG_DWORD /d 100 /f | Out-Null

Write-Host 'Enabling "End Task" button in taskbar...' -NoNewLine
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" /v 'TaskbarEndTask' /t REG_DWORD /d 1 /f | Out-Null

Write-Host "Enabling hidden files and showing file extensions..."
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v 'HideFileExt' /t REG_DWORD /d 0 /f | Out-Null 
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v 'UseCompactMode' /t REG_DWORD /d 1 /f | Out-Null 
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Folder\Hidden\SHOWALL" /v 'CheckedValue' /t REG_DWORD /d 1 /f | Out-Null

Write-Host "Enabling legacy context menu..."
    New-Item -Path "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f

Write-Host "Enabling dark mode..."
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v 'SystemUsesLightTheme' /t REG_DWORD /d 0 /f | Out-Null 
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v 'AppsUseLightTheme' /t REG_DWORD /d 0 /f | Out-Null 

Write-Host "Disabling copilot..."
    reg.exe add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v 'TurnOffWindowsCopilot' /t REG_DWORD /d 1 /f | Out-Null 
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v 'ShowCopilotButton' /t REG_DWORD /d 0 /f | Out-Null 

Write-Host "Disabling transparency..."
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v 'EnableTransparency' /t REG_DWORD /d 0 /f | Out-Null 

Write-Host "Disabling sticky keys..."
    reg.exe add "HKCU\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d 506 /f | Out-Null 

Write-Host "Disabling Toast Notifications..."
    reg.exe add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v 'DisableNotificationCenter' /t REG_DWORD /d 1 /f | Out-Null 
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v 'ToastEnabled' /t REG_DWORD /d 0 /f | Out-Null

# ──Useless background processes─────────────────────

Write-Host "Disabling background processes..." -ForegroundColor Blue
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f | Out-Null 
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f | Out-Null 
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f | Out-Null 

Write-Host "Disabling activity history..." -ForegroundColor Blue
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f | Out-Null 
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f | Out-Null 
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f | Out-Null 

Write-Host "Disabling location services..." -ForegroundColor Blue
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "deny" /f | Out-Null 
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "0" /f | Out-Null 
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d "0" /f | Out-Null 
    reg.exe add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t REG_DWORD /d "0" /f | Out-Null 

Write-Host "Disabling UAC" -ForegroundColor Blue
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f | Out-Null 

Write-Host "Disabling login blur" -ForegroundColor Blue
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v DisableAcrylicBackgroundOnLogon /t REG_DWORD /d 1 /f | Out-Null

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

    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v 'AllowTelemetry' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v 'AllowTelemetry' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v 'ContentDeliveryAllowed' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v 'OemPreInstalledAppsEnabled' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v 'PreInstalledAppsEnabled' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v 'PreInstalledAppsEverEnabled' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v 'SilentInstalledAppsEnabled' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v 'SubscribedContent-338387Enabled' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v 'SubscribedContent-338388Enabled' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v 'SubscribedContent-338389Enabled' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v 'SubscribedContent-353698Enabled' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v 'SystemPaneSuggestionsEnabled' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v 'DisableWindowsConsumerFeatures' /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v 'NumberOfSIUFInPeriod' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v 'DoNotShowFeedbackNotifications' /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v 'DisableTailoredExperiencesWithDiagnosticData' /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v 'DisabledByGroupPolicy' /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v 'Disabled' /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v 'DODownloadMode' /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v 'fAllowToGetHelp' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v 'EnthusiastMode' /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v 'PeopleBand' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v 'LaunchTo' /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v 'LongPathsEnabled' /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v 'SystemResponsiveness' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v 'NetworkThrottlingIndex' /t REG_DWORD /d 4294967295 /f | Out-Null
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v 'ClearPageFileAtShutdown' /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v 'Start' /t REG_DWORD /d 2 /f | Out-Null
    reg.exe add "HKCU\Control Panel\Mouse" /v 'MouseHoverTime' /t REG_SZ /d 400 /f | Out-Null
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v 'IRPStackSize' /t REG_DWORD /d 30 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v 'ShellFeedsTaskbarViewMode' /t REG_DWORD /d 2 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v 'HideSCAMeetNow' /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v 'GPU Priority' /t REG_DWORD /d 8 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v 'Priority' /t REG_DWORD /d 6 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v 'Scheduling Category' /t REG_SZ /d High /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v 'ScoobeSystemSettingEnabled' /t REG_DWORD /d 0 /f | Out-Null
}

Write-Host "Disabling Teredo..."
    reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" /t REG_DWORD /d "255" /f | Out-Null
    netsh.exe interface teredo set state disabled

Write-Host "Disabling IPv6..." -ForegroundColor Blue
    Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6 | Out-Null

Write-Host "Disabling GameDVR..." -ForegroundColor Blue
    reg.exe add "HKCU\System\GameConfigStore" /v 'GameDVR_Enabled' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v 'AllowGameDVR' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v 'AppCaptureEnabled' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v 'AudioCaptureEnabled' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v 'HistoricalCaptureEnabled' /t REG_DWORD /d 0 /f | Out-Null

Write-Host "Disabling Bing Search in start menu..." -ForegroundColor Blue
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v 'BingSearchEnabled' /t REG_DWORD /d 0 /f | Out-Null

Write-Host "Disabling Fullscreen Optimizations (FSO)" -ForegroundColor Blue
    reg.exe add "HKCU\System\GameConfigStore" /v 'GameDVR_FSEBehavior' /t REG_DWORD /d 2 /f | Out-Null
    reg.exe add "HKCU\System\GameConfigStore" /v 'GameDVR_DSEBehavior' /t REG_DWORD /d 2 /f | Out-Null
    reg.exe add "HKCU\System\GameConfigStore" /v 'GameDVR_DXGIHonorFSEWindowsCompatible' /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKCU\System\GameConfigStore" /v 'GameDVR_HonorUserFSEBehaviorMode' /t REG_DWORD /d 1 /f | Out-Null
    reg.exe add "HKCU\System\GameConfigStore" /v 'GameDVR_EFSEFeatureFlags' /t REG_DWORD /d 0 /f | Out-Null

Write-Host "Disabling Game bar..." -ForegroundColor Blue
    reg.exe add "HKCU\Software\Microsoft\GameBar" /v 'ShowStartupPanel' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\GameBar" /v 'GamePanelStartupTipIndex' /t REG_DWORD /d 3 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\GameBar" /v 'UseNexusForGameBarEnabled' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\GameBar" /v 'AllowAutoGameMode' /t REG_DWORD /d 0 /f | Out-Null
    reg.exe add "HKCU\Software\Microsoft\GameBar" /v 'AutoGameModeEnabled' /t REG_DWORD /d 0 /f | Out-Null 
    reg.exe add "HKCU\Software\Microsoft\GameBar" /v 'GameBarEnabled' /t REG_DWORD /d 0 /f | Out-Null

Write-Host "Disabling Core Isolation..." -ForegroundColor Blue
    reg.exe add "HKLM\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v 'Enabled' /t REG_DWORD /d 0 /f | Out-Null

Write-Host "Disabling Live Tiles..." -ForegroundColor Blue
    reg.exe add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v 'NoTileApplicationNotification' /t REG_DWORD /d 1 /f | Out-Null

Write-Host "Disabling smooth scrolling" -ForegroundColor Blue
    reg.exe add "HKCU\Control Panel\Desktop" /v 'SmoothScroll' /t REG_DWORD /d 0 /f | Out-Null

Write-Host "Flushing Windows Explorer..." -ForegroundColor Blue
    Remove-Item "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags" /f
    reg.exe add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v 'FolderType' /t REG_SZ /d "NotSpecified" /f | Out-Null

Write-Host "Disabling fast user switching..." -ForegroundColor Blue
    reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v 'HideFastUserSwitching' /t REG_DWORD /d 1 /f | Out-Null

Write-Host "Disabling Windows Ink related features..." -ForegroundColor Blue
    reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v 'AllowWindowsInkWorkspace' /t REG_DWORD /d 0 /f | Out-Null