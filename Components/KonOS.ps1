Import-Module "$env:systemDrive\Kon OS\Modules\Throbber.psm1"
Import-Module "$env:systemDrive\Kon OS\Modules\ColourCodes.psm1"

$host.UI.RawUI.WindowSize  = New-Object System.Management.Automation.Host.Size(80,10)
$host.UI.RawUI.BufferSize  = New-Object System.Management.Automation.Host.Size(80,10)
$Host.UI.RawUI.WindowTitle = "Kon OS | Loading..."

New-Item -Path "$env:SystemDrive\Kon OS\Modules\snd" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

Write-Host "Initializing..."
$filePath = "$env:systemDrive\Kon OS\snd"
if (Test-Path -Path $filePath -PathType Container) {
    Write-Host ("Welcome To" + $accent + " Kon OS`e[97m.") -ForegroundColor White
} else {
    Show-Throbber -Message "Downloading modules..." {
    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/master/Components/Sounds/startup.wav" `
        -OutFile "$env:systemDrive\Kon OS\Modules\snd\startup.wav"

    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/master/Components/Sounds/shutdown.wav" `
        -OutFile "$env:systemDrive\Kon OS\Modules\snd\shutdown.wav"
    
    }
}   

# Exits Kon OS... duh???
function Exit-KonOS {
    $host.UI.RawUI.WindowSize  = New-Object System.Management.Automation.Host.Size(80,10)
    $host.UI.RawUI.BufferSize  = New-Object System.Management.Automation.Host.Size(80,10)
    $Host.UI.RawUI.ForegroundColor = 'White'
    Clear-Host
    
    $sound = New-Object System.Media.SoundPlayer
    $sound.SoundLocation = "$env:systemDrive\Kon OS\Modules\snd\shutdown.wav"
    
    Show-Throbber -Message "Exiting Kon OS setup..." {
        Remove-Item -Path "$env:systemDrive\Kon OS\Setup" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item -Path "$env:systemDrive\Kon OS\Scripts" -Recurse -Force -ErrorAction SilentlyContinue
    }
    Write-Host "`r[`e[92mOK`e[39m] Exiting Kon OS..."
    Write-Host "See you later!" -ForegroundColor Cyan
    $sound.PlaySync()
    [System.Environment]::Exit(0)
}

# ──Version String───────────────────────────────────

New-Item -ItemType File "$env:systemDrive\Kon OS\ver.txt" -ErrorAction SilentlyContinue
$commit = Invoke-RestMethod -Uri "https://api.github.com/repos/ki8y/KonOS/commits/master"
$version = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/ki8y/KonOS/master/version.txt"
$content = "   │  ⚙️ $($White)$($version.Substring(0,12)) ($($commit.sha.Substring(0,7)))  $accent│"
Set-Content "$env:systemDrive\Kon OS\ver.txt" `
@"
[38;5;99m   ╭─────────────────────────────╮
$content
[38;5;99m   ╰─────────────────────────────╯
"@ -NoNewLine

$host.UI.RawUI.BufferSize  = New-Object System.Management.Automation.Host.Size(120,30)
$host.UI.RawUI.WindowSize  = New-Object System.Management.Automation.Host.Size(120,30)
$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'

function Start-Setup {
    Clear-Host

    # Checks if Windows Defender is enabled.
    $defenderService = Get-Service -Name 'WinDefend'
    if ($defenderService.Status -eq "Running") { 
        Write-Host "Windows Defender is running, adding Kon OS to exclusion zone..." -ForegroundColor Yellow
        try {
            # Add-MpPreference -ExclusionPath "$env:systemDrive\Kon OS" -Force -ErrorAction Stop
            Write-Error "" -ErrorAction Stop
        } catch {
            Write-Host "Error: Kon OS could not be added to the defender exclusion zone. `nPlease read the following instructions for disabling Windows Defender manually to continue." -ForegroundColor Red
            Write-Host "`nPress any key to open Windows Security..."
            cmd.exe /c "pause" | Out-Null
            Write-Host "`nOpening Windows Security panel..." -ForegroundColor Blue
            Start-Process 'windowsdefender://'
            Write-Host "Step 1: Click `"Virus and threat protection`" > `"Manage Settings`""
            Write-Host "Step 2: Disable real time protection and tamper protection."
            Write-Host "Step 3: Close Windows Security"
            Write-Host "`nPress any key to continue after you've completed these steps."
            cmd.exe /c "pause" | Out-Null
        }
    } else {
        Write-Host "Windows Defender is not running."
    }

    # Checks for UCPD (in powershell 5.1 cause in 7.5 trying to set the service returns a permissions error)
    PowerShell -NoProfile -Command @'
    $ucpdService = Get-Service -Name "ucpd"
    if ($ucpdService.Status -eq "Running") { 
        Write-Host "`n[!] The User Choice Protection Driver (UCPD) is running." -ForegroundColor Red
        Write-Host "Disabling UCPD...`n" -ForegroundColor Yellow
            Disable-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "UCPD velocity" | Out-Null
            Set-ItemProperty -Path "Registry::HKLM\SYSTEM\CurrentControlSet\Services\UCPD" -Name 'Start' -Value '4' -Force | Out-Null
            Set-Service -Name "UCPD" -StartupType Disabled | Out-Null
        
        Write-Host "UCPD has been disabled, however you'll need to restart your PC for changes to take effect." -ForegroundColor Yellow
        Write-Host "Press any key to restart your pc..."
        cmd /c "pause" | Out-Null
        
        Write-Host "`n[38;5;46mRestarting in 5..." -NoNewLine
        Start-Sleep 1
        Write-Host "`r[38;5;154mRestarting in 4..." -NoNewLine
        Start-Sleep 1
        Write-Host "`r[38;5;220mRestarting in 3..." -NoNewLine
        Start-Sleep 1
        Write-Host "`r[38;5;202mRestarting in 2..." -NoNewLine
        Start-Sleep 1
        Write-Host "`r[38;5;196mRestarting in 1..."
        Start-Sleep 1
        
        Write-Host "Restarting..."
        shutdown -r -t 0
    } else {
        Write-Host "UCPD is not running."
    }
'@

    # Downloads scripts...
    Write-Host @"
    $accent
                                              ╭──────────────────────────╮
                                              │  💽 Downloading Scripts  │
                                              ╰──────────────────────────╯
"@
    $name = "generalTweaks.ps1"
    Show-Throbber -Message "Downloading $($Cyan)$name..." {
        Invoke-WebRequest `
        -Uri 'https://github.com/ki8y/KonOS/raw/master/Components/Scripts/generalTweaks.ps1' `
        -OutFile "$env:systemDrive\Kon OS\Scripts\$name" | Out-Null
    }
    Write-Host "`r[✓] Installing $name...        " -ForegroundColor Green

    $name = "serviceControl.ps1"
    Show-Throbber -Message "Downloading $($Cyan)$name..." {
        Invoke-WebRequest `
        -Uri 'https://raw.githubusercontent.com/ki8y/KonOS/raw/master/Components/Scripts/serviceControl.ps1' `
        -OutFile "$env:systemDrive\Kon OS\Scripts\$name" | Out-Null
    }
    Write-Host "`r[✓] Installing $name...        " -ForegroundColor Green
    Write-Host "`nKon OS Demo Finished.`nSTILL after EVERYTHING, a WIP ¯\_(ツ)_/¯"
    cmd.exe /c "pause >nul"
    [System.Environment]::Exit(0)

}

$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "$env:systemDrive\Kon OS\Modules\snd\startup.wav"
$sound.Play()

$Host.UI.RawUI.WindowTitle = "Kon OS Bootstrapper | Alpha 0.5"
Write-Host @"
$accent
[?25l







 
                                    ██╗  ██╗ ██████╗ ███╗   ██╗     ██████╗ ███████╗
                                    ██║ ██╔╝██╔═══██╗████╗  ██║    ██╔═══██╗██╔════╝
                                    █████╔╝ ██║   ██║██╔██╗ ██║    ██║   ██║███████╗
                                    ██╔═██╗ ██║   ██║██║╚██╗██║    ██║   ██║╚════██║
                                    ██║  ██╗╚██████╔╝██║ ╚████║    ╚██████╔╝███████║
                                    ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚══════╝

                             ╔════════════════════════════════════════════════════════════╗
                             ║                        [97mBegin Setup?$accent                        ║
                             ╚════════════════════════════════════════════════════════════╝

[32m                                         ╭────────────╮[31m          ╭────────────╮
[32m                                         │   ✅ [Y]   │[31m          │   ❎ [N]   │
[32m                                         ╰────────────╯[31m          ╰────────────╯
$accent

"@
Write-Host $(Get-Content "$env:systemDrive\Kon OS\ver.txt" | Out-String) -NoNewLine "[37m"

choice /c YN /n | Out-Null
switch ($LASTEXITCODE) {
    1 { Start-Setup }
    2 { Exit-KonOS }
}

<#


# Administrator Check
$Admin = ([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544'

if (-not $Admin) {
$Host.UI.RawUI.WindowTitle = "Kon OS | Superuser not detected!"
$host.UI.RawUI.BufferSize  = New-Object System.Management.Automation.Host.Size(100,19)
$host.UI.RawUI.WindowSize  = New-Object System.Management.Automation.Host.Size(100,19)
Clear-Host    
Write-Host @"





                                    ╭──────────────────────────╮
                                    │ [33m⚠  [0mMissing Privileges [33m⚠[0m  │
                                    ╰──────────────────────────╯

                  To install Kon OS, you'll need to escalate to admin privileges.[?25l

                                      Run with administrator?

[92m                               ╭────────────╮[91m          ╭────────────╮
[92m                               │   ✅ [Y]   │[91m          │   ❎ [N]   │
[92m                               ╰────────────╯[91m          ╰────────────╯
"@
function runAdmin {
try {
    Start-Process -FilePath "pwsh.exe" `
        -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" `
        -Verb RunAs `
        -ErrorAction Stop
    
    [System.Environment]::Exit(0)
    } catch {
        noAdmin
    }
}

function noAdmin {
    Clear-Host
    Write-Host @"
`e[91mSetup Cannot Continue:

`e[93mKon OS cannot be installed without administrator privileges.`nPlease run Kon OS with admin and try again.

`e[91m(NO PERMISSION)
`e[97mPress any key to exit setup...
"@
    cmd.exe /c "pause >nul"
    Exit-KonOS
}

choice /c YN /n | Out-Null
switch ($lastExitCode) {
    1 { runAdmin }
    2 { noAdmin }
}
[System.Environment]::Exit(0)
}
#>