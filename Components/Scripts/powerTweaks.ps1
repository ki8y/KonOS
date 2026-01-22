Import-Module "$env:systemDrive\Kon OS\Modules\Throbber.psm1"
Import-Module "$env:systemDrive\Kon OS\Modules\ColourCodes.psm1"

$i = 0
while ($i -lt 1) {
    Write-Progress -Activity "Applying Power Tweaks..." -Status "$i" -PercentComplete ($i * 1)
    if (Test-Path -PathType Container "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power") {
        Write-Host "Registry Key HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power already exists, continuing..."
    } else {
        Write-Host "Registry Key HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power does not exist yet, creating it now..." -ForegroundColor Yellow
        New-Item -ItemType Directory "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Force | Out-Null
    }
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Power" -Name "ExitLatency" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Power" -Name "ExitLatencyCheckEnabled" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Power" -Name "Latency" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Power" -Name "LatencyToleranceDefault" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Power" -Name "LatencyToleranceFSVP" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Power" -Name "LatencyTolerancePerfOverride" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Power" -Name "LatencyToleranceScreenOffIR" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Power" -Name "LatencyToleranceVSyncEnabled" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\Power" -Name "RtlCapabilityCheckLatency" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultD3TransitionLatencyActivelyUsed" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultD3TransitionLatencyIdleLongTime" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultD3TransitionLatencyIdleMonitorOff" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultD3TransitionLatencyIdleNoContext" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultD3TransitionLatencyIdleShortTime" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultD3TransitionLatencyIdleVeryLongTime" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultLatencyToleranceIdle0" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultLatencyToleranceIdle0MonitorOff" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultLatencyToleranceIdle1" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultLatencyToleranceIdle1MonitorOff" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultLatencyToleranceMemory" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultLatencyToleranceNoContext" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultLatencyToleranceNoContextMonitorOff" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultLatencyToleranceOther" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultLatencyToleranceTimerPeriod" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultMemoryRefreshLatencyToleranceActivelyUsed" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultMemoryRefreshLatencyToleranceMonitorOff" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "DefaultMemoryRefreshLatencyToleranceNoContext" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "Latency" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "MaxIAverageGraphicsLatencyInOneBucket" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "MiracastPerfTrackGraphicsLatency" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "MonitorLatencyTolerance" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "MonitorRefreshLatencyTolerance" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    New-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" -Name "TransitionLatency" -PropertyType Dword -Value 1 -Force -WhatIf | Out-Null
    Start-Sleep 3
    $i++
}#>
Write-Progress -Completed






<#
# ──Power Plan───────────────────────────────────────

New-Item -ItemType Directory "$env:systemDrive\Kon OS\Components\Modules\powerPlans" -Force -ErrorAction SilentlyContinue | Out-Null
Invoke-WebRequest `
    -Uri "https://github.com/ki8y/KonOS/raw/master/Components/Modules/powerPlans/highPerformance.pow" `
    -OutFile "$env:systemDrive\Kon OS\Components\Modules\powerPlans\Kon OS High Performance.pow" `
    -UseBasicParsing

$guid = "815641e7-52ff-46f3-beec-16ac0f774a85"

Show-Throbber -Colour "$Blue" -Message "Importing Kon OS High Performance power plan..." {
    $powerPlanPath = "$env:systemDrive\Kon OS\Components\Modules\powerPlans\Kon OS High Performance.pow"
    Write-Output "hi"
    powercfg -import $powerPlanPath $guid
}
Write-Host "`r[✓] Importing Kon OS High Performance power plan..." -ForegroundColor Green

Write-Host "Current active plan:" -NoNewLine
    powercfg /getactivescheme
Write-Host "`n"

# Rename it so it's not blank (juuust in case it imports wrong somehow)
$customName = "Kon OS High Performance"
powercfg -changename $guid "$customName" "High performance power plan optimal for gaming."

# Apply it
powercfg -setactive $guid

Write-Host "$customName applied. ($guid)`e[0m" -BackgroundColor DarkGreen#>