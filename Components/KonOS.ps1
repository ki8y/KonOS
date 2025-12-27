Import-Module "$env:systemDrive\Kon OS\Modules\Throbber.psm1"

$accent = '[38;5;99m'
$global:ok = "[[92mOK[0m]"
$global:fail = "[[91mFAIL[0m]"

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
}
if ($ping.Status -eq 'TimedOut') {
    $StopCode = "Timed Out"
    Stop-Code-NoInternet
} if ($ping.Status -eq 'DestinationHostUnreachable') {
    $StopCode = "Host Unreachable"
} if ($ping.Status -eq '11050') {
    $StopCode = "GENERAL FAILURE: 11050"
    Stop-Code-NoInternet
}

New-Item -Path "$env:SystemDrive\Kon OS\snd" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
#$ver = "$($env:SystemDrive)\Kon OS"

Write-Host "Initializing..."
$filePath = "$env:systemDrive\Kon OS\snd"
if (Test-Path -Path $filePath -PathType Container) {
    Write-Host ("Welcome To" + $accent + " Kon OS`e[97m.") -ForegroundColor White
} else {
    Show-Throbber -Message "Downloading modules..." {
    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/main/Components/Sounds/startup.wav" `
        -OutFile "$env:systemDrive\Kon OS\snd\startup.wav"

    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/main/Components/Sounds/shutdown.wav" `
        -OutFile "$env:systemDrive\Kon OS\snd\shutdown.wav"
    
    <#Invoke-WebRequest `
    "https://raw.githubusercontent.com/ki8y/KonOS/main/version.txt" `
    -OutFile "$($using:ver)\ver.txt"#>
    }
}   

#Exits Kon OS... duh???
function Exit-KonOS {
    $host.UI.RawUI.WindowSize  = New-Object System.Management.Automation.Host.Size(80,10)
    $host.UI.RawUI.BufferSize  = New-Object System.Management.Automation.Host.Size(80,10)
    $Host.UI.RawUI.ForegroundColor = 'White'
    Clear-Host
    
    $sound = New-Object System.Media.SoundPlayer
    $sound.SoundLocation = "$env:systemDrive\Kon OS\snd\shutdown.wav"
    
    Show-Throbber -Message "Exiting Kon OS..." {
        Remove-Item -Path "$env:systemDrive\Kon OS\Setup" -Recurse -Force -ErrorAction SilentlyContinu
        Start-Sleep -Milliseconds 100
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
$sound.SoundLocation = "$env:systemDrive\Kon OS\snd\startup.wav"
$sound.Play()

function Start-Setup {
    Clear-Host
    Write-Host @"
$accent╭─────────────────────────────────╮
│  💽 Downloading Kon OS Scripts  │
╰─────────────────────────────────╯
"@
    # Installs Requirement Checker.......duh? (its not working rn so oops...)
    $name = "Requirement Checker"
    Show-Throbber -Message "Installing $name..." {
            $cdn = "https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/Scripts/requirementCheck.bat"
            $file = 'Microsoft.VCLibs.x64.14.00.Desktop.appx'
            $dir = "$env:SystemDrive\Kon OS\Setup\Winget"
            Invoke-WebRequest $cdn -OutFile "$dir\$file"  | Out-Null
        }
    Write-Host "`r$ok Installing $name..." -ForegroundColor White

        $name = "Other Example Stuff"
    Show-Throbber -Message "Installing $name..." {
            $cdn = "https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/Scripts/requirementCheck.bat"
            $file = 'Microsoft.VCLibs.x64.14.00.Desktop.appx'
            $dir = "$env:SystemDrive\Kon OS\Setup\Winget"
            Invoke-WebRequest $cdn -OutFile "$dir\$file" | Out-Null
        }
    Write-Host "`r$ok Installing $name..." -ForegroundColor White
    Write-Host "`nKon OS Demo Finished.`nStill a WIP ¯\_(ツ)_/¯"
    cmd.exe /c "pause >nul"
    [System.Environment]::Exit(0)

}
$Host.UI.RawUI.WindowTitle = "Kon OS Bootstrapper | Powershell Prototype 4"
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

