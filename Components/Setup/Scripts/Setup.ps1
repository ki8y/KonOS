<# Setup.ps1
Built for PowerShell 7.6 (LTS)

This is basically just bootstrapper.ps1 but I split it up so it's easier for me to read. #>

# choice prompts for setup so u can go afk

$esc = ([char]27)
$KONOS = "$env:systemDrive\Kon OS"

Write-Output "──Setup.ps1──────────────────────────────────────────`n" | Add-Content -Path "$KonOS\setupLog.txt"

Import-Module "$KONOS\Setup\Modules\Read-Choice.psm1"
Import-Module "$KONOS\Setup\Modules\Invoke-CriticalStop.psm1"
Import-Module "$KONOS\Setup\Modules\Exit-Setup.psm1"
Import-Module "$KONOS\Setup\Modules\ColourCodes.psm1"

$flags = Get-Content "$KONOS\Setup\setupFlags.json" -Raw | ConvertFrom-Json
Pause
Clear-Host

if ($($PSVersionTable).PSVersion.Major -lt 7) {
    Invoke-CriticalStop -StopCode "Invalid_PowerShell_Detected" -Message @"
Setup.ps1 needs to be launched with PowerShell 7 or higher.

If you got this error, that means you either launched this script manually or I messed up somehow.
If the latter, please report this bug :(
"@ | Tee-Object -Path "$KonOS\setupLog.txt" -Append
}

Write-Output "Setup choice prompted, waiting for user response..." | Add-Content -Path "$KonOS\setupLog.txt"
Write-Host "How would you like to setup Kon OS?"
Write-Host @"
[1] Express installation - Automatically apply recommended setup settings
[2] Custom installation - Customize the installation to whatever you like
"@
choice.exe /c 12 /n | Out-Null
switch ($LASTEXITCODE) {
    1 { $ExpressInstall = $True }
    2 { $ExpressInstall = $False }
}
Clear-Host

if (-not $ExpressInstall) {
    Write-Output "Custom install selected." | Add-Content -Path "$KonOS\setupLog.txt"
    do {

        # Choices
        Write-Host "Create a restore point? [Y/N] $($ESC)[33m*HIGHLY Recommended*$($ESC)[97m"
        $CreateRP = Read-Choice

        if (-not $CreateRP) {
            Write-Host "`nAre you sure!? Not creating a restore point can complicate things if things go seriously wrong.`nPlease type `"I understand the risks`" to proceed without a restore point. Otherwise, press enter to continue.`n$($ESC)[94m» " -ForegroundColor Red -NoNewline
            $ConfirmNoRP = Read-Host
            if ($ConfirmNoRP -notmatch "I understand the risks") {
                $CreateRP = $true
            }
        }

        Write-Host "`nUninstall Microsoft Edge? (You'll get to choose a browser) [Y/N]"
        $RemoveEdge = Read-Choice

        Write-Host "`nWould you like to uninstall Microsoft Store? [Y/N]"
        $RemoveWS = Read-Choice

        Write-Host "`nDisable Wi-Fi? [Y/N]"
        $DisableWifi = Read-Choice

        $Prefs = [PSCustomObject]@{
            "CreateRP" = $True
            "RemoveEdge" = $True
            "RemoveWS" = $True
            "DisableWifi" = $False
        }

        Clear-Host
        Write-Host @"
├────── These are your settings ──────┤

Create restore point    =  [$($CreateRP)]
Remove Microsoft Edge   =  [$($RemoveEdge)]
Remove Microsoft Store  =  [$($RemoveWS)]
Disable Wi-Fi           =  [$($DisableWifi)]
"@
    
        Write-Host "Is this okay? [Y/N]"
        $ConfirmPrefs = Read-Choice

    } while (-not $ConfirmPrefs)
}
else {
    Write-Output "Express install selected." | Add-Content -Path "$KonOS\setupLog.txt"
    $Prefs = [PSCustomObject]@{
        "CreateRP" = $True
        "RemoveEdge" = $True
        "RemoveWS" = $True
        "DisableWifi" = $False
    }
}

Write-Output "Creating flag and config files..." | Add-Content -Path "$KonOS\setupLog.txt"
New-Item -ItemType File -Path "$KonOS\Setup\setupConfig.json" -Force -ErrorAction Stop | Out-Null
New-Item -ItemType File -Path "$KonOS\Setup\setupFlags.json" -Force -ErrorAction Stop | Out-Null
$prefs | ConvertTo-Json | Set-Content -Path "$KONOS\Setup\setupConfig.json" -Encoding UTF8
$flags | ConvertTo-Json | Set-Content -Path "$KONOS\Setup\setupFlags.json" -Encoding UTF8

#Write-Output "[Debug] Opening config file in text editor..."
#Start-Process "notepad++" -ArgumentList "`"C:\Kon OS\Setup\setupConfig.json`""

# ── UCPD Detection ─────────────────────────────────

Write-Output "Checking if the User Choice Protection Driver is running..." | Tee-Object -Path "$KONOS\setupLog.txt" -Append
if ( Get-Service -Name UCPD | Where-Object { $_.Status -match "Running" } ) {
    
    Write-Output "UCPD is running" | Tee-Object -Path "$KONOS\setupLog.txt" -Append
    $flags += @{ "ucpdWorkaround" = $true }

    # Deletes UCPD entirely from task scheduler, registry, and services
    Write-Output "Deleting UCPD..." | Tee-Object -Path "$KONOS\setupLog.txt" -Append
    Unregister-ScheduledTask -TaskPath "Microsoft\Windows\AppxDeploymentClient" -TaskName "UCPD velocity" -Confirm:$false
    reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\UCPD" /f # yea, i know about New-ItemProperty. i just trust reg.exe better.
    Remove-Service -Name UCPD

    # make script launch on logon
    $action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -NoProfile -File `"$KonOS\Setup\Setup.ps1`""
    $trigger = New-ScheduledTaskTrigger -AtLogOn
    $settings = New-ScheduledTaskSettingsSet -WakeToRun

    if (-not (Get-SchedueledTask -TaskName "UcpdWorkaround")) {
        Register-ScheduledTask -TaskName "UcpdWorkaround" -Action $action -Trigger $trigger -Settings $settings -User $env:USERNAME -RunLevel Highest -Force
    }

    # HOPEFULLY this all works and this restarts the pc.
    shutdown.exe /r /t 0 /f
    exit 0

}