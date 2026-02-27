<# Bootstrapper.ps1 
Built for Windows PowerShell 5.1

This script basically just downloads all the other scripts and runs them.
plz dont judge my bad code ;-; #>

# Sets the background for powershell since for some reason it looooves to be blue and i think thats ugly.
$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
$Host.UI.RawUI.WindowTitle = "Kon OS Bootstrapper"
Clear-Host

# defines colours + that cool thing that says [Kon OS]
$global:White = '[97m'
$accent = '[38;5;99m'
$KonOS = "$($accent)Kon OS[97m"

# initializes the windows error sound in case things go wrong.
$snd = New-Object System.Media.SoundPlayer
$snd.soundlocation = "$env:systemDrive\Windows\Media\Windows Foreground.wav" # (uses the windows error sound in case things go wrong.)

function Exit-Setup { # cleans stuff up and exits da flippin SETUP.
    Write-Host "[$($KonOS)] Cleaning setup files..."
    Remove-Item -Path "$env:systemDrive\Kon OS" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    
    Write-Host "[$($KonOS)] Exiting setup..."
    Start-Sleep -Milliseconds 500 # just looks cooler if it says "exiting setup" lmfao

    Clear-Host
    Exit
}

function Invoke-CriticalStop { # Exits setup if a critical error occurs. yea :P
    param(
        [string]$StopCode,
        [string]$Message
    )
    $snd.Play()
    Clear-Host
    Write-Host "[91mSetup Cannot Continue:"
    Write-Host @"

[93m$($Message)

[91m($($StopCode))
[97mPress any key to exit setup...[?25l
"@
    cmd /c 'pause >nul'
    Exit-Setup
}

# Checks for admin (the script needs to run without elevated privileges at first because scoop is very picky.)
$uacState = ([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544'
if ($uacState) {
    Invoke-CriticalStop -StopCode "Elevated_Privileges_Detected" -Message "Kon OS needs to be initialized without administrator privileges.`nI know, it's not ideal. Blame the scoop devs."
}

# Checks your windows build
if ($build -ge 22600) {

    Write-Host @"
[93mWindows 11 25H2 Detected! ($Build)[97m

Windows 11 25H2 is an untested version of Windows 11. It should be similar enough to 24H2 to
run with minimal issues, but I haven't tested this myself. 
If you encounter any bugs during or after applying these tweaks, please let me know!
    
Press any key to continue...
"@
    cmd /c "pause" | Out-Null
} elseif ($build -le 22631.6060) {
Write-Host @"
[93mWindows 11 22H2 or older detected! ($Build)[97m

Windows 11 25H2 is an untested version of Windows 11. It should be similar enough to 24H2 to
run with minimal issues, but I haven't tested this myself. 
If you encounter any bugs during or after applying these tweaks, please let me know!
    
Press any key to continue...
"@
}
New-Item -ItemType Directory "$env:systemDrive\Kon OS\temp" -ErrorAction SilentlyContinue | Out-Null # yea :P
