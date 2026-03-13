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

# defines path thing
$KONOS = "$env:systemDrive\Kon OS"

# logs
New-Item -ItemType File "$KONOS\setupLog.txt" -Force -ErrorAction SilentlyContinue | Out-Null # SUPA COOL LOGS!

Write-Output @"
Starting Kon OS Setup...

──Bootstrapper.ps1───────────────────────────────────

"@ | Add-Content -Path "$KonOS\setupLog.txt"

# initializes the windows error sound in case things go wrong.
$snd = New-Object System.Media.SoundPlayer
$snd.soundlocation = "$env:systemDrive\Windows\Media\Windows Foreground.wav" # (uses the windows error sound in case things go wrong.)

function Exit-Setup {
    param(
        [int]$exitCode = 0
    )
    
    # cleans stuff up and exits da flippin SETUP.
    Write-Output "Exiting setup..."
    Write-Host "[$($KonOS)] Cleaning setup files..."
    Remove-Item -Path "$KonOS\Setup" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    
    Write-Host "[$($KonOS)] Exiting setup..."
    Start-Sleep -Milliseconds 500 # just looks cooler if it says "exiting setup" lmfao

    Clear-Host
    if ($exitCode -ne 0) {
        Write-Host "Setup exited prematurely.`nError Code: $exitcode"
        Write-Output "Setup exited prematurely. Error Code: $exitcode" | Add-Content -Path "$KonOS\setupLog.txt"
    } else {
        Write-Output "Successfully cancelled setup." | Add-Content -Path "$KonOS\setupLog.txt"
    }
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

# Invoke-WebRequest is slow on PS5 but I didnt wanna switch everything to use curl.exe manually, so I made this. Invoke-SpeedRequest 😸😸
function Invoke-SpeedRequest { 
    param(
        [string]$uri,    
        [string]$outFile
    )
    curl.exe -s -L "$uri" -o "$OutFile"
}

Write-Output "Checking for admin..."

# Checks for admin (the script needs to run without elevated privileges at first because scoop is very picky.)
$uacState = ([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544'
if ($uacState) {
    Invoke-CriticalStop -StopCode "Elevated_Privileges_Detected" -Message "Kon OS needs to be initialized without administrator privileges.`nI know, it's not ideal. Blame the scoop devs."
}

# Checks windows build
$Build = [System.Environment]::OSVersion.Version.Build
if ($build -ge 26200) {

    Write-Host @"
[93mWindows 11 25H2 Detected! ($Build)[97m

Windows 11 25H2 is an untested version of Windows 11. It should be similar enough to 24H2 to
run with minimal issues, but I haven't tested this myself. 
If you encounter any bugs during or after applying these tweaks, please let me know!
    
Press any key to continue setup...
"@
    cmd /c "pause" | Out-Null
} elseif ($build -le 22631) {
Write-Host @"
[93mWindows 11 22H2 or older detected! ($Build)[97m

Kon OS was made for 23H2 (or newer). It SHOULD work on 22H2/21H2, but I
can't make any promises. If you recieve any bugs, you can report them but
please keep in mind that these bugs are a low priority.

Press any key to continue setup...
"@
    cmd /c "pause" | Out-Null
}

# ──Fun Stuff Begins Here────────────────────────────

Clear-Host
Write-Host "Initializing..."
New-Item -ItemType Directory "$KONOS\Setup\Scripts" -ErrorAction SilentlyContinue | Out-Null
New-Item -ItemType Directory "$KONOS\Setup\Modules" -ErrorAction SilentlyContinue | Out-Null
New-Item -ItemType Directory "$KONOS\Setup\temp" -ErrorAction SilentlyContinue | Out-Null
New-Item -ItemType Directory "$KONOS\Modules" -ErrorAction SilentlyContinue | Out-Null # Why two modules and scripts files? well one's just for the post installation interface... yep :cat_hi:
New-Item -ItemType Directory "$KONOS\Sounds" -ErrorAction SilentlyContinue | Out-Null
New-Item -ItemType Directory "$KONOS\Resources" -ErrorAction SilentlyContinue | Out-Null # this'll be used after the setup for configs nd stuff yeah
New-Item -ItemType File "$KONOS\Setup\flags.json" -ErrorAction SilentlyContinue | Out-Null # Flags for various stuffs and stuffs and... yes!

if ($env:WT_SESSION) { $WTSession = $true }
else { $WTSession = $false }

$flags = [PSCustomObject]@{
    "WTSession" = $WTSession

}

$flags | ConvertTo-Json | Set-Content -Path "$KONOS\Setup\flags.json"

Invoke-SpeedRequest `
    -Uri "https://raw.githubusercontent.com/ki8y/KonOS/master/Components/Modules/Throbber.psm1" `
    -OutFile "$KONOS\Modules\Throbber.psm1"

Invoke-SpeedRequest `
    -Uri "https://raw.githubusercontent.com/ki8y/KonOS/master/Components/Modules/ColourCodes.psm1" `
    -OutFile "$KONOS\Modules\ColourCodes.psm1"

Invoke-SpeedRequest `
    -Uri "https://raw.githubusercontent.com/ki8y/KonOS/master/Components/Scripts/getDependencies.ps1" `
    -OutFile "$KONOS\Setup\Scripts\checkForDependencies.ps1"   