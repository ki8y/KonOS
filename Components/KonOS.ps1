Import-Module "$env:systemDrive\Kon OS\Modules\Throbber.psm1"
Import-Module "$env:systemDrive\Kon OS\Modules\ColourCodes.psm1"

$host.UI.RawUI.WindowSize  = New-Object System.Management.Automation.Host.Size(80,10)
$host.UI.RawUI.BufferSize  = New-Object System.Management.Automation.Host.Size(80,10)
$Host.UI.RawUI.WindowTitle = "Kon OS | Loading..."

# Error code thing
function Stop-Code-NoInternet {
    Write-Host @"
`e[91mSetup Cannot Continue:

`e[93mYou can't install Kon OS without an internet connection.
Please connect to the internet and try again.

`e[91m($StopCode)

`e[97mPress any key to exit setup...
"@ -NoNewLine
    cmd.exe /c "pause >nul"
    [System.Environment]::Exit(0)
}

# Checks for internet (if not detected, shows dat error code thing from earlier)
try {
    Write-Host "Checking internet availability..."
    $global:ping = Test-Connection -TargetName 1.1.1.1 -Count 1 -ErrorAction Stop
    Clear-Host
} catch {
    $StopCode = "Ping Failed"
    Stop-Code-NoInternet
} if ($ping.Status -eq 'TimedOut') {
    $StopCode = "Timed Out"
    Stop-Code-NoInternet
} if ($ping.Status -eq 'DestinationHostUnreachable') {
    $StopCode = "Host Unreachable"
} if ($ping.Status -eq '11050') {
    $StopCode = "GENERAL FAILURE: 11050"
    Stop-Code-NoInternet
}

New-Item -Path "$env:SystemDrive\Kon OS\Modules\snd" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

Write-Host "Initializing..."
$filePath = "$env:systemDrive\Kon OS\snd"
if (Test-Path -Path $filePath -PathType Container) {
    Write-Host ("Welcome To" + $accent + " Kon OS`e[97m.") -ForegroundColor White
} else {
    Show-Throbber -Message "Downloading modules..." {
    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/main/Components/Sounds/startup.wav" `
        -OutFile "$env:systemDrive\Kon OS\Modules\snd\startup.wav"

    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/main/Components/Sounds/shutdown.wav" `
        -OutFile "$env:systemDrive\Kon OS\Modules\snd\shutdown.wav"
    
    }
}   

# ──Version String───────────────────────────────────

New-Item -ItemType File "$env:systemDrive\Kon OS\ver.txt" -ErrorAction SilentlyContinue
$commit = Invoke-RestMethod -Uri "https://api.github.com/repos/ki8y/konos/commits/main"
$version = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/ki8y/KonOS/main/version.txt"
$content = "   │  ⚙️ [97m$($version.Substring(0,12)) ($($commit.sha.Substring(0,7)))  [38;5;99m│"
Set-Content "$env:systemDrive\Kon OS\ver.txt" `
@"
[38;5;99m   ╭─────────────────────────────╮
$content
[38;5;99m   ╰─────────────────────────────╯
"@ -NoNewLine

#Exits Kon OS... duh???
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
    Write-Host "`r[[92mOK[0m] Exiting Kon OS..."
    Write-Host "See you later!" -ForegroundColor Cyan
    $sound.PlaySync()
    [System.Environment]::Exit(0)
}

<# Administrator Check #>
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

$host.UI.RawUI.BufferSize  = New-Object System.Management.Automation.Host.Size(120,30)
$host.UI.RawUI.WindowSize  = New-Object System.Management.Automation.Host.Size(120,30)
$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "$env:systemDrive\Kon OS\Modules\snd\startup.wav"
$sound.Play()

function Start-Setup {
    Clear-Host
    Write-Host @"
$accent
                                              ╭──────────────────────────╮
                                              │  💽 Downloading Scripts  │
                                              ╰──────────────────────────╯
"@
    $name = "generalTweaks.ps1"
    Show-Throbber -Message "Downloading $($Cyan)$name..." {
        Invoke-WebRequest `
        -Uri 'https://github.com/ki8y/KonOS/raw/main/Components/Scripts/generalTweaks.ps1' `
        -OutFile "$env:systemDrive\Kon OS\Scripts\$name" | Out-Null
    }
    Write-Host "`r[✓] Installing $name...        " -ForegroundColor Green

    $name = "serviceControl.ps1"
    Show-Throbber -Message "Downloading $($Cyan)$name..." {
        Invoke-WebRequest `
        -Uri 'https://raw.githubusercontent.com/ki8y/KonOS/raw/main/Components/Scripts/serviceControl.ps1' `
        -OutFile "$env:systemDrive\Kon OS\Scripts\$name" | Out-Null
    }
    Write-Host "`r[✓] Installing $name...        " -ForegroundColor Green
    Write-Host "`nKon OS Demo Finished.`nSTILL after EVERYTHING, a WIP ¯\_(ツ)_/¯"
    cmd.exe /c "pause >nul"
    [System.Environment]::Exit(0)

}
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

