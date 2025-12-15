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
    $i = 0

    $run = Start-Job -ScriptBlock $Action

    while ($run.State -eq 'Running') {
        Write-Host -NoNewline "`r[$($spinnything[$i])] $Message[?25l"
        Start-Sleep -Milliseconds 100
        $i = ($i + 1) % $spinnything.Length
    }
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

New-Item -Path "$env:SystemDrive\Kon OS\snd" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
$snds = "$($env:SystemDrive)\Kon OS\snd"
#$ver = "$($env:SystemDrive)\Kon OS"


Show-AWESOME-THROBBER -Message "Initializing...                  " {
    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/main/Components/Sounds/startup.wav" `
        -OutFile "$($using:snds)\startup.wav"

    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/main/Components/Sounds/shutdown.wav" `
        -OutFile "$($using:snds)\shutdown.wav"
        
    <#Invoke-WebRequest `
        "https://raw.githubusercontent.com/ki8y/KonOS/main/version.txt" `
        -OutFile "$($using:ver)\ver.txt"#>
    
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


}

# Exits Kon OS... duh?
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
    Write-Host @"
`e[91mSetup Cannot Continue:

`e[93mKon OS cannot be installed without administrator privileges.`nPlease run Kon OS with admin and try again.

`e[91m(NO PERMISSION)
`e[97mPress any key to exit setup...
"@
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
$sound.SoundLocation = "$env:systemDrive\Kon OS\snd\startup.wav"
$sound.Play()

function Setup {
    Clear-Host
    Write-Host @"
$accent╭─────────────────────────────────╮
│  💽 Downloading Kon OS Scripts  │
╰─────────────────────────────────╯
"@
    # Installs Requirement Checker.......duh? (its not working rn so oops...)
    $name = "Requirement Checker"
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
    1 { Setup }
    2 { exitKonOS }
}

