<# If you need to contact me:
Discord Server: https://discord.gg/MdXtURScqX
Discord: @ki8y
TikTok: https://www.tiktok.com/@konpakulol #>

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
$Host.UI.RawUI.WindowTitle = "Kon OS Bootstrapper"
Clear-Host

# defines colours + that cool thing that says [Kon OS]
$global:White = '[97m'
$accent = '[38;5;99m'
$KonOS = "$($accent)Kon OS[97m"

# helpful for errors
function Exit-Setup {
    Write-Host "Exiting Kon OS setup..." -NoNewLine
    Remove-Item -Path "$env:systemDrive\Kon OS\Setup" -Recurse -Force -ErrorAction SilentlyContinue
    Start-Sleep -Milliseconds 500 # this doesnt do anything valuable it just looks cooler if it says "exiting kon os..."
    
    [System.Environment]::Exit(0) # sometimes powershell doesnt close with the regular exit command so i found this.
}

New-Item -ItemType Directory "$env:systemDrive\Kon OS\temp" -ErrorAction SilentlyContinue | Out-Null # yea :P




$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "$env:systemDrive\Windows\Media\Windows Ding.wav"

# Error code thing
function Stop-Code-NoInternet {
    Write-Host @"
[91mSetup Cannot Continue:

[93mYou can't install Kon OS without an internet connection.
Please connect to the internet and try again.

[91m($StopCode)

[97mPress any key to exit setup...
"@ -NoNewLine
    cmd.exe /c "pause" | Out-Null
    [System.Environment]::Exit(0)
}

# Checks for internet (if not detected, shows dat error code thing from earlier)
try {
    Write-Host "Checking internet availability..."
    $global:ping = Test-Connection -ComputerName 1.1.1.1 -Count 1 -ErrorAction Stop
    Clear-Host
} catch {
    $StopCode = "Ping Failed"
    Stop-Code-NoInternet
} if ($ping.Status -eq 'TimedOut') {
    $StopCode = "Timed Out"
    Stop-Code-NoInternet
} elseif ($ping.Status -eq 'DestinationHostUnreachable') {
    $StopCode = "Host Unreachable"
} elseif ($ping.Status -eq '11050') {
    $StopCode = "GENERAL FAILURE: 11050"
    Stop-Code-NoInternet
}
<#
68 lines
237 col
#>


<#
if ($env:WT_SESSION) {
    if (Test-File -FileType Leaf "$env:systemDrive\Kon OS\temp\wt_fullscreen.flag") {

    } else {
        WT --Fullscreen PowerShell -Command (Invoke-Expression ((Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/ki8y/KonOS/experimental/bomtest.ps1').TrimStart([char]0xFEFF)))
    }
} else {
    if (Test-File -FileType Leaf "$env:systemDrive\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.23.12811.0_x64__8wekyb3d8bbwe\wt.exe") {
        WT --Fullscreen PowerShell -Command (Invoke-Expression ((Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/ki8y/KonOS/experimental/bomtest.ps1').TrimStart([char]0xFEFF)))
    } else {
        Write-Host "$KonOS You don't have Windows Terminal installed. Install it now? (y/n)" -NoNewline
        choice /c YN /n | Out-Null
        switch ($LASTEXITCODE) {
        1 { Install-Terminal }
        2 { Deny-Terminal }
        }
    }
}#>

# ──Version String───────────────────────────────────

$commit = Invoke-RestMethod -Uri "https://api.github.com/repos/ki8y/KonOS/commits/master"
$version = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/ki8y/KonOS/master/version.txt"
$content = "   │  ⚙️ $($White)$($version.Substring(0,12)) ($($commit.sha.Substring(0,7)))  $accent│"
$VersionArt = @"
[38;5;99m   ╭─────────────────────────────╮
$content
[38;5;99m   ╰─────────────────────────────╯
"@

# Version indicator
$commit = Invoke-RestMethod -Uri "https://api.github.com/repos/ki8y/konos/commits/master" -UseBasicParsing
$version = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/ki8y/KonOS/master/version.txt" -UseBasicParsing

# Checks for admin
$adminState = ([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544'
if (-not $adminState) {
    Clear-Host
    Write-Host @"
[91mSetup Cannot Continue:

[93mKon OS cannot be installed without administrator privileges.`nPlease run Kon OS with admin and try again.

[91m(NO PERMISSION)
[97mPress any key to exit setup...[?25l
"@
    cmd /c 'pause >nul'
    exit
}

Write-Host "Welcome to $($accent)Kon OS![97m"
Write-Host "$($version.Substring(0,12)) ($($commit.sha.Substring(0,7)))`n"
New-Item -Path "$env:SystemDrive\Kon OS\Setup" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

# thing i made so i dont have to manually switch everything to curl.exe
function Invoke-SpeedRequest {
        param(
        [string]$uri,    
        [string]$outFile
    )
        curl.exe -s -L "$uri" -o "$OutFile"
}

Write-Host @"
WARNING: THIS IS A VERY EARLY ALPHA VERSION OF KON OS

If you somehow accidentally stumbled upon this tool, don't use it yet. Like... at all...
It's extremely unstable and unfinished. This is on github purely for testing.[?25l
"@ -ForegroundColor Red
Pause

# Checks your Windows build to avoid complications.
Write-Host "Checking if you meet the operating system requirements..."
$Build = [System.Environment]::OSVersion.Version.Build

# Win11 25H2
if ($build -le 22600) {

    Write-Host @"
[33mWindows 11 25H2 Detected! ($Build)[97m

Windows 11 25H2 is an untested version of Windows 11. It should be similar enough to 24H2 to
run with minimal issues, but I haven't tested this myself. 
If you encounter any bugs during or after applying these tweaks, please let me know!
    
Press any key to continue...
"@
    $sound.Play()
    cmd.exe /c "pause >nul"
    Exit-Setup
}

# Win11 24H2
if ($build -le 26100) { Clear-Host }

# Win11 23H2
if ($build -le 22631) {
    Write-Host @"
[31mWindows 11 22H2 Detected! ($Build)[97m

Kon OS was built for Windows 11 24H2. The version of Windows you're using is Windows 11 22H2.
While Kon OS can be installed on 22H2, I am not responsible for any potential damage caused to your computer.
Please do not DM me for any help regarding 22H2, I will not respond.

Continue the installation?
"@
    $sound.Play()
    cmd.exe /c "pause >nul"
    Exit-Setup
}

# Win11 22H2
if ($build -le 22621) {
    Write-Host @"
[31mWindows 11 22H2 Detected! ($Build)[97m

Kon OS was built for Windows 11 24H2. The version of Windows you're using is Windows 11 22H2.
While Kon OS can be installed on 22H2, I am not responsible for any potential damage caused to your computer.
Please do not DM me for any help regarding 22H2, I will not respond.

Continue the installation?
"@
    $sound.Play()
    cmd.exe /c "pause >nul"
    Exit-Setup
}

# Win11 21H2
if ($build -le 22000) {
$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "$env:systemDrive\Windows\Media\Windows Critical Stop.wav"

    Write-Host @"
[91mSetup Cannot Continue:

[93mWindows 11 21H2 is unsupported by Kon OS.
Please install a newer version of Windows 11 (ideally 24H2) and try again.

[91m(OUTDATED_WINDOWS_VERSION)

[97mPress any key to exit setup...
"@
    $sound.Play()
    cmd.exe /c "pause >nul"
    Remove-Item -Path "$env:systemDrive\Kon OS" -Recurse -Force -ErrorAction SilentlyContinue
    Exit-Setup
}

# Windows 10 or lower...
if ($build -le 19045) {
$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "$env:systemDrive\Windows\Media\Windows Critical Stop.wav"

    Write-Host @"
[91mSetup Cannot Continue:

[93mWindows 10 is unsupported by Kon OS.
Please install Windows 11 (24H2 or newer) and try again.

[91m(OUTDATED_WINDOWS_VERSION)

[97mPress any key to exit setup...
"@
    $sound.Play()
    cmd.exe /c "pause >nul"
    Remove-Item -Path "$env:systemDrive\Kon OS" -Recurse -Force -ErrorAction SilentlyContinue
    Exit-Setup
}

function Start-KonOS {
    Start-Process -FilePath "pwsh.exe" -Verb RunAs -ArgumentList @(
        "-NoProfile"
        "-ExecutionPolicy"
        "Bypass"
        "-File"
        "`"$env:systemDrive\Kon OS\KonOS.ps1`""
    )
}

# Restore Point Stuff...
Write-Host "[$($KonOS)] Create A Restore Point"
Write-Host "`nCreating a Restore Point will backup the current state of your Windows installation." 
Write-Host "This can save you from a huge headache if things go wrong."                 
Write-Host "`nCreate a restore point?"
Write-Host "`n[92m[Y] Yes [91m[N] No[37m[?25h" -NoNewLine

function Confirm-RestorePoint {
    Clear-Host
    Write-Host "[$($KonOS)] Creating Restore Point..."
    Try {
        New-ItemProperty `
            -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore' `
            -Name 'SystemRestorePointCreationFrequency' `
            -PropertyType DWord `
            -Value 0 `
            -Force -ErrorAction Stop | Out-Null
        Enable-ComputerRestore -Drive "$env:systemDrive\" -ErrorAction Stop | Out-Null
        Checkpoint-Computer -Description 'Pre-Kon OS Installation' -ErrorAction Stop
    } catch {
        Write-Host "WARNING: Could not create a restore point." -ForegroundColor White -BackgroundColor DarkRed
        Write-Host "`nTry creating a restore point manually (see github for tutorial)"
        Write-Host "Or, you could proceed through the installation without a restore point."
        Write-Host "`nContinue?"
        Write-Host "[92m[Y] Yes [91m[N] No[37m[?25h" -NoNewLine
        choice /c YN /n | Out-Null
        switch ($LASTEXITCODE) {
        1 { 
            Write-Host "Proceeding without restore point..."
            Start-Sleep -Seconds 1
        }
        2 { Exit-Setup }
        }
    }
}

function Deny-RestorePoint {
    Write-Host "[$($KonOS)] Are you sure you want to proceed without a restore point?"
    Write-Host "[92m[Y] Yes [91m[N] No[37m[?25h" -NoNewLine
}

choice /c YN /n | Out-Null
switch ($LASTEXITCODE) {
    1 { Confirm-RestorePoint }
    2 { Deny-RestorePoint }
}

# Path

function Start-Setup {
    New-Item -ItemType Directory "C:\Kon OS\Scripts" -ErrorAction SilentlyContinue | Out-Null
    New-Item -ItemType Directory "C:\Kon OS\Modules" -ErrorAction SilentlyContinue | Out-Null
    Invoke-SpeedRequest `
        -Uri "https://raw.githubusercontent.com/ki8y/KonOS/master/Components/KonOS.ps1" `
        -OutFile "$env:systemDrive\Kon OS\KonOS.ps1"

    Invoke-SpeedRequest `
        -Uri "https://raw.githubusercontent.com/ki8y/KonOS/master/Components/Modules/Throbber.psm1" `
        -OutFile "$env:systemDrive\Kon OS\Modules\Throbber.psm1"

    Invoke-SpeedRequest `
        -Uri "https://raw.githubusercontent.com/ki8y/KonOS/master/Components/Modules/ColourCodes.psm1" `
        -OutFile "$env:systemDrive\Kon OS\Modules\ColourCodes.psm1"

    Invoke-SpeedRequest `
        -Uri "https://raw.githubusercontent.com/ki8y/KonOS/master/Components/Modules/PsExec/PsExec64.exe"
        -OutFile "$env:systemDrive\Kon OS\Modules\PsExec\PsExec64.exe"

    Unblock-File -Path "$env:systemDrive\Kon OS\KonOS.ps1" 

    $filePath = "$env:SystemDrive\Kon OS\temp\dependenciesInstalled.flag"
    if (Test-Path -Path $filePath -PathType Leaf) {
        Start-KonOS
    } else {
        New-Item -ItemType Directory "C:\Kon OS\Scripts" -ErrorAction SilentlyContinue | Out-Null
        Invoke-SpeedRequest `
            -Uri "https://raw.githubusercontent.com/ki8y/KonOS/master/Components/Scripts/getDependencies.ps1" `
            -OutFile "$env:systemDrive\Kon OS\Scripts\checkForDependencies.ps1"
        PowerShell -ExecutionPolicy Bypass -NoProfile -File "$env:systemDrive\Kon OS\Scripts\checkForDependencies.ps1"
    }  
}

# SENTAI I KNOW U DONT KNOW HOW U HELPED ME BUT I SWEAR TO GOD UR THE GREATEST
$Host.UI.RawUI.WindowTitle = "Kon OS Bootstrapper | $($version.Substring(0,12)) ($($commit.sha.Substring(0,7)))"
Clear-Host
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
                                                                         
[32m                                                                                     ╭────────────╮[31m          ╭────────────╮
[32m                                                                                     │   ✅ [Y]   │[31m          │   ❎ [N]   │
[32m                                                                                     ╰────────────╯[31m          ╰────────────╯
$accent















$VersionArt
"@ -NoNewLine
choice /c YN /n | Out-Null
switch ($LASTEXITCODE) {
    1 { Start-Setup }
    2 { Exit-Setup }
}


# enjailor
# WOAH
# Look at the SIZE of those EASTER EGGS!!!