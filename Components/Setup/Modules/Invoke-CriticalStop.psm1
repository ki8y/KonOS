function Invoke-CriticalStop { # Exits setup if a critical error occurs. yea :P

    param(
        [string]$StopCode,
        [string]$Message,
        [int]$ExitCode = 0
    )

    Clear-Host
    Write-Host "[91mSetup Cannot Continue:"
    Write-Host @"

[93m$($Message)

[91m($($StopCode))
[97mPress any key to exit setup...[?25l
"@
    cmd /c 'pause >nul'
    Exit-Setup -ExitCode $ExitCode
}