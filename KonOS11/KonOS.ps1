$accent = '[38;5;99m'
$global:ok = "[[92mOK[0m]"
$global:fail = "[[91mFAIL[0m]"

$host.UI.RawUI.WindowSize  = New-Object System.Management.Automation.Host.Size(80,10)
$host.UI.RawUI.BufferSize  = New-Object System.Management.Automation.Host.Size(80,10)

# SUPER KICKASS LOADING LABEL THING.
$Host.UI.RawUI.WindowTitle = "Kon OS | Loading..."
function Show-AWESOME-THROBBER {
    param(
        [string]$Message,
        [scriptblock]$Action
    )

    $spinnything = @('\','|','/','|')
    # $spinnything = @('⢿','⣻','⣽','⣾','⣷','⣯','⣟','⡿')
    $i = 0

    $run = Start-Job -ScriptBlock $Action

    while ($run.State -eq 'Running') {
        Write-Host -NoNewline "`r[$($spinnything[$i])] $Message[?25l"
        Start-Sleep -Milliseconds 100
        $i = ($i + 1) % $spinnything.Length
    }

    # Receive-Job $job | Out-Null
    # Remove-Job $job
}

<# Check For Wifi #>
try {
    Write-Host "Checking internet availability..."
    $global:ping = Test-Connection -TargetName 1.1.1.1 -Count 1 -ErrorAction Stop
    Clear-Host
        } catch {
            Write-Host "`e[91mSetup Cannot Continue:`n`n`e[93mYou can't install Kon OS without an internet connection.`nPlease connect to the internet and try again.`n`n`e[91m(PING FAILED)"
            Write-Host "`Press any key to exit setup..." -ForegroundColor White -NoNewLine
            cmd.exe /c "pause >nul"
            exit
    }
    if ($ping.Status -eq 'TimedOut') {
        Write-Host "`e[91mSetup Cannot Continue:`n`n`e[93mYou can't install Kon OS without an internet connection.`nPlease connect to the internet and try again.`n`n`e[91m(TIMED OUT)"
        Write-Host "`nPress any key to exit setup..." -ForegroundColor White -NoNewLine
        cmd.exe /c "pause >nul"
        exit
    } if ($ping.Status -eq 'DestinationHostUnreachable') {
        Write-Host "`e[91mSetup Cannot Continue:`n`n`e[93mYou can't install Kon OS without an internet connection.`nPlease connect to the internet and try again.`n`n`e[91m(HOST UNREACHABLE)"
        Write-Host "`nPress any key to exit setup..." -ForegroundColor White -NoNewLine
        cmd.exe /c "pause >nul"
        exit
    } if ($ping.Status -eq '11050') {
        Write-Host "`e[91mSetup Cannot Continue:`n`n`e[93mYou can't install Kon OS without an internet connection.`nPlease connect to the internet and try again.`n`n`e[91m(GENERAL FAILURE: 11050)"
        Write-Host "`nPress any key to exit setup..." -ForegroundColor White -NoNewLine
        cmd.exe /c "pause >nul"
        exit
    }

function exitKonOS {
    $host.UI.RawUI.WindowSize  = New-Object System.Management.Automation.Host.Size(80,10)
    $host.UI.RawUI.BufferSize  = New-Object System.Management.Automation.Host.Size(80,10)

    $Host.UI.RawUI.ForegroundColor = 'White'
    Clear-Host
    $sound = New-Object System.Media.SoundPlayer
    $sound.SoundLocation = "$env:systemDrive\Kon OS\snd\shutdown.wav"
    Show-AWESOME-THROBBER -Message "Exiting Kon OS..." {
        Remove-Item -Path "$env:systemDrive\Kon OS\Setup" -Recurse -Force -ErrorAction SilentlyContinu
        Start-Sleep -Milliseconds 100
    }
    Write-Host "`r[[92mOK[0m] Exiting Kon OS..."
    Write-Host "See you later!" -ForegroundColor Cyan
    $sound.PlaySync()
    exit
}

New-Item -Path "$env:SystemDrive\Kon OS\snd" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
# $setup    = "$env:SystemDrive\Kon OS\snd"
$snds = "$($env:SystemDrive)\Kon OS\snd"
$ver = "$($env:SystemDrive)\Kon OS"


Show-AWESOME-THROBBER -Message "Initializing...                  " {
    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/main/General/sounds/startup.wav" `
        -OutFile "$($using:snds)\startup.wav"

    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/main/General/sounds/shutdown.wav" `
        -OutFile "$($using:snds)\shutdown.wav"
        
    Invoke-WebRequest `
        "https://raw.githubusercontent.com/ki8y/KonOS/refs/heads/main/KonOS11/versionCheck.txt" `
        -OutFile "$($using:ver)\ver.txt"
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
    exit
    } catch {
        noAdmin
    }
}

function noAdmin {
    Clear-Host
    Write-Host "Without admin privileges, the setup cannot continue.`n" -ForegroundColor Red
    Write-Host "Press any key to exit..."
    cmd.exe /c "pause >nul"
    exitKonOS
}

choice /c YN /n | Out-Null
switch ($LASTEXITCODE) {
    1 { runAdmin }
    2 { noAdmin }
}


exit
}

$host.UI.RawUI.BufferSize  = New-Object System.Management.Automation.Host.Size(120,30)
$host.UI.RawUI.WindowSize  = New-Object System.Management.Automation.Host.Size(120,30)
$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "c:\Kon OS\snd\startup.wav"
$sound.Play()

$Host.UI.RawUI.WindowTitle = "Kon OS Bootstrapper | Powershell Prototype 3"
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
Write-Host $(Get-Content "$env:systemDrive\Kon OS\ver.txt"| Out-String) "[32m" -NoNewLine

function Setup {
    Clear-Host
    Write-Host @"
$accent╭─────────────────────────────────╮
│  💽 Downloading Kon OS Scripts  │
╰─────────────────────────────────╯
"@
    # Installs Chocolatey
    $name = "Chocolatey"
    Show-AWESOME-THROBBER -Message "Installing $name..." {
        Set-ExecutionPolicy Bypass -Scope Process -Force | Out-Null
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 | Out-Null
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) | Out-Null
    }
    Write-Host "`r$ok Installing $name..." -ForegroundColor White

    # Installs Defender Control
    $name = "Defender Control"
    Show-AWESOME-THROBBER -Message "Installing $name..." {
            $cdn = "https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/Scripts/requirementCheck.bat"
            $file = 'Microsoft.VCLibs.x64.14.00.Desktop.appx'
            $dir = "$env:SystemDrive\Kon OS\Setup\Winget"
            Invoke-WebRequest $cdn -OutFile "$dir\$file"  | Out-Null
        }
    Write-Host "`r$ok Installing $name..." -ForegroundColor White

        $name = "Other Example Stuff"
    Show-AWESOME-THROBBER -Message "Installing $name..." {
            $cdn = "https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/Scripts/requirementCheck.bat"
            $file = 'Microsoft.VCLibs.x64.14.00.Desktop.appx'
            $dir = "$env:SystemDrive\Kon OS\Setup\Winget"
            Invoke-WebRequest $cdn -OutFile "$dir\$file" | Out-Null
        }
    Write-Host "`r$ok Installing $name..." -ForegroundColor White
    Write-Host "`nKon OS Demo Finished.`nStill a WIP ¯\_(ツ)_/¯"
    cmd.exe /c "pause >nul"
    exit

}

function Unsetup {
    Clear-Host
    Write-Host "Bye then :P"
    $sound = New-Object System.Media.SoundPlayer
    $sound.SoundLocation = "c:\Kon OS\snd\shutdown.wav"
    $sound.PlaySync()
    pause
    exit
}

function WOAH {
    Clear-Host
    $sound = New-Object System.Media.SoundPlayer
    $sound.SoundLocation = "c:\Kon OS\snd\WOAH.wav"
    $sound.Play()
    start-sleep -milliseconds 200
    Write-Host "*CRASH* *BANG*"
    start-sleep -milliseconds 400
    Write-Host "Looks like you've been in a crash."
    start-sleep -milliseconds 1130
    Write-Host "iPhone will trigger Emergency S.O.S if you don't--"
    start-sleep -milliseconds 2100
    Write-Host "🗣️ WHAAAAAAAAAAAT?"
    start-sleep -milliseconds 1200
    Write-Host "🚨🚨🚨"
    start-sleep -milliseconds 1000
    Write-Host "WOAHHHHHHHHHHHHHHHHH"
    start-sleep -milliseconds 1010
    Write-Host "🚨🚨🚨"
    start-sleep -milliseconds 390
    Write-Host "WOAHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
    start-sleep -milliseconds 1900
    Write-Host "OHH MY GODDDD"
    start-sleep -milliseconds 1040
    Write-Host "🚨🚨🚨"
    start-sleep -milliseconds 458
    Write-Host "WOAH..."
    start-sleep -milliseconds 490
    Write-Host "🚨🚨🚨🚨🚨🚨🚨"
    start-sleep -milliseconds 530
    Write-Host "⚠️⚠️⚠️🚨🚨🚨🚨🚨🚑🚑🚑🚑"
    start-sleep -milliseconds 190    
    Write-Host "(AHHHHHHHHHHHHHHHHH)"
    start-sleep -milliseconds 650
    Write-Host "WOAHHH..."

    cmd.exe /c "pause >nul"
    exit
}

choice /c YN /n | Out-Null
switch ($LASTEXITCODE) {
    1 { Setup }
    2 { exitKonOS }
}

    <#

    UNUSED BECAUSE ITS BROKEN AND IDC ABOUT WINGET ANYMORE

    # Installs Winget
    $name = "Winget Dependencies"
    Show-AWESOME-THROBBER -Message "Downloading $name... (1/4)" {

        New-Item -Path "$env:SystemDrive\Kon OS\Setup\Winget\Dependencies" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
            $cdn = 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'
            $file = 'Microsoft.VCLibs.x64.14.00.Desktop.appx'
            $dir = "$env:SystemDrive\Kon OS\Setup\Winget\Dependencies"
            Invoke-WebRequest $cdn -OutFile "$dir\$file" | Out-Null
        }
    Write-Host "`r$ok Downloading $name..." -ForegroundColor White

    $name = "Winget Dependencies"
    Show-AWESOME-THROBBER -Message "Installing $name... (2/4)" {
            Add-AppxPackage "$env:SystemDrive\Kon OS\Setup\Winget\Dependencies\Microsoft.VCLibs.x64.14.00.Desktop.appx"
        }
    Write-Host "`r$ok Installing $name..." -ForegroundColor White

    $name = "Winget Bundle"
    Show-AWESOME-THROBBER -Message "Downloading $name... (3/4)" {
        New-Item -Path "$env:SystemDrive\Kon OS\Setup\Winget\Bin" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
        $cdn = 'https://github.com/microsoft/winget-cli/releases/download/v1.12.350/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
        $file = 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
        $cdnl = 'https://github.com/microsoft/winget-cli/releases/download/v1.12.350/e53e159d00e04f729cc2180cffd1c02e_License1.xml'
        $filel = 'e53e159d00e04f729cc2180cffd1c02e_License1.xml'
        $dir = "$env:systemDrive\Kon OS\Setup\Winget\Bin"
        Invoke-WebRequest $cdn -OutFile "$dir\$file" | Out-Null
        Invoke-WebRequest $cdnl -OutFile "$dir\$filel" | Out-Null
        }
    Write-Host "`r$ok Downloading $name..." -ForegroundColor White

    $name = "Winget Bundle"
    Show-AWESOME-THROBBER -Message "Installing $name... (4/4)" {
        Add-AppxPackage -Path "$env:systemDrive\Kon OS\Winget\Bin\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -LicensePath "$env:systemDrive\Kon OS\Winget\Bin\License1.xml"
        }
    Write-Host "`r$ok Downloading $name..." -ForegroundColor White
#>
