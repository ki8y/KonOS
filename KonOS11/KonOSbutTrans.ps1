$accent = '[38;5;99m'
$global:ok = "[[92mOK[0m]"
$global:fail = "[[91mFAIL[0m]"


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
function exitKonOS {
    $Host.UI.RawUI.ForegroundColor = 'White'
    Clear-Host
    $sound = New-Object System.Media.SoundPlayer
    $sound.SoundLocation = "$env:systemDrive\Kon OS\snd\shutdown.wav"
    Show-AWESOME-THROBBER -Message "Exiting Kon OS..." {
        Remove-Item -Path "$env:systemDrive\Kon OS\Setup" -Recurse -Force -ErrorAction SilentlyContinu
        Start-Sleep -Milliseconds 100d
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


Show-AWESOME-THROBBER -Message "Initializing..." {
    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/main/General/sounds/startup.wav" `
        -OutFile "$($using:snds)\startup.wav" `
        -UseBasicParsing

    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/main/General/sounds/shutdown.wav" `
        -OutFile "$($using:snds)\shutdown.wav" `
        -UseBasicParsing
    
        
    Invoke-WebRequest `
        "https://raw.githubusercontent.com/ki8y/KonOS/refs/heads/main/KonOS11/versionCheck.txt" `
        -OutFile "$($using:ver)\ver.txt" `
        -UseBasicParsing
}

[System.Console]::SetWindowSize(120, 30)
$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host
$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "c:\Kon OS\snd\startup.wav"
$sound.Play()

$TransCol1 = "[38;2;107;214;250m" # 107, 214, 250
$TransCol2 = "[38;2;246;169;184m" # 255, 169, 184
$TransCol3 = "[38;2;255;255;255m" # 255, 240, 240

$Host.UI.RawUI.WindowTitle = "Kon OS Bootstrapper | Powershell Prototype 2"
Write-Host @"
$accent
[?25l







 
$TransCol1                                    ██╗  ██╗ ██████╗ ███╗   ██╗     ██████╗ ███████╗
$TransCol2                                    ██║ ██╔╝██╔═══██╗████╗  ██║    ██╔═══██╗██╔════╝
$TransCol3                                    █████╔╝ ██║   ██║██╔██╗ ██║    ██║   ██║███████╗
$TransCol3                                    ██╔═██╗ ██║   ██║██║╚██╗██║    ██║   ██║╚════██║
$TransCol2                                    ██║  ██╗╚██████╔╝██║ ╚████║    ╚██████╔╝███████║
$TransCol1                                    ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚══════╝

                             $TransCol1╔═══════════$TransCol2════════════$TransCol3══════════════$TransCol2════════════$TransCol1═══════════╗
                             $TransCol1║                        [97mBegin Setup?$TransCol1                        ║
                             $TransCol1╚═══════════$TransCol2════════════$TransCol3══════════════$TransCol2════════════$TransCol1═══════════╝

[32m                                         ╭────────────╮[31m          ╭────────────╮
[32m                                         │   ✅ [Y]   │[31m          │   ❎ [N]   │
[32m                                         ╰────────────╯[31m          ╰────────────╯

"@
Write-Host $(Get-Content "$env:systemDrive\Kon OS\ver.txt"| Out-String) "[32m" -NoNewLine

function Setup {
    Clear-Host
    Write-Host @"
    $accent`r
     ╭─────────────────────────────────╮
     │  [97m💽 Downloading Kon OS Scripts$accent  │
     ╰─────────────────────────────────╯
"@

    # Installs stuff :D

    $Host.UI.RawUI.ForegroundColor = "blue"
    
    # Installs Winget
    $name = "Winget"
    Show-AWESOME-THROBBER -Message "Installing $name..." {

        New-Item -Path "$env:SystemDrive\Kon OS\Setup\Winget" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
            $cdn = 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'
            $file = 'Microsoft.VCLibs.x64.14.00.Desktop.appx'
            $dir = "$env:SystemDrive\Kon OS\Setup\Winget"
            Invoke-WebRequest $cdn -OutFile "$dir\$file" -UseBasicParsing | Out-Null
        }
    Write-Host "`r$ok Installing $name..." -ForegroundColor White

    # Installs Defender Control
    $name = "Defender Control"
    Show-AWESOME-THROBBER -Message "Installing $name..." {
            $cdn = "https://raw.githubusercontent.com/ki8y/KonOS/main/KonOS11/Scripts/requirementCheck.bat"
            $file = 'Microsoft.VCLibs.x64.14.00.Desktop.appx'
            $dir = "$env:SystemDrive\Kon OS\Setup\Winget"
            Invoke-WebRequest $cdn -OutFile "$dir\$file" -UseBasicParsing | Out-Null
        }
    Write-Host "`r$ok Installing $name..." -ForegroundColor White
    
    Write-Host "Kon OS Demo Finished."
    pause
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