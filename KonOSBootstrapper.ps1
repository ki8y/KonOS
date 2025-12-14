<# Hi, plz dont judge my bad code... Thanks for installing Kon OS btw :D 
If you need to contact me:
Discord Server: https://discord.gg/MdXtURScqX
Discord: @ki8y
TikTok: https://www.tiktok.com/@konpakulol #>

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host
$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "$env:systemDrive\Windows\Media\Windows Ding.wav"
$Host.UI.RawUI.WindowTitle = "Kon OS Prerequisites"
Write-Host "Starting Kon OS..."
New-Item -Path "$env:SystemDrive\Kon OS\Setup" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

function ExitSetup {
    Write-Host "Exiting Kon OS..." -NoNewLine
    Remove-Item -Path "$env:systemDrive\Kon OS\Setup" -Recurse -Force -ErrorAction SilentlyContinue
    Start-Sleep -Milliseconds 500
    exit
}

Write-Host @"
WARNING: THIS IS A VERY EARLY ALPHA VERSION OF KON OS

If you somehow accidentally stumbled upon this tool, don't use it for personal use yet.
It's extremely unstable and unfinished. This is on github purely for testing.
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
    PromptForDependencies
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
    PromptForDependencies
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
    PromptForDependencies
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
    ExitSetup
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
    ExitSetup
}

function Start-KonOS {
    Unblock-File -Path "$env:systemDrive\Kon OS\KonOS.ps1" 
    Start-Process -FilePath "pwsh.exe" -ArgumentList @(
    "-NoProfile"
    "-ExecutionPolicy"
    "Bypass"
    "-File"
    "`"$env:systemDrive\Kon OS\KonOS.ps1`""
    )
}

# install stuff :P
cmd /c 'curl -s -L "https://raw.githubusercontent.com/ki8y/KonOS/main/Components/Scripts/getDependencies.ps1" -o "%systemDrive%\Kon OS\Dependencies\CheckForDependencies.ps1"'
cmd /c 'curl -s -L "https://raw.githubusercontent.com/ki8y/KonOS/main/Components/KonOS.ps1" -o "%systemDrive%\Kon OS\Setup\KonOS.ps1"'

# Path
$filePath = "$env:SystemDrive\Kon OS\Dependencies"
if (Test-Path -Path $filePath -PathType Container) {
    Start-KonOS
} else {
    PowerShell -ExecutionPolicy Bypass -NoProfile -File "$env:systemDrive\Kon OS\Dependencies\CheckForDependencies.ps1"
}