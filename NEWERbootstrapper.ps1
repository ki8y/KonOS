<# Bootstrapper.ps1 
Built for Windows PowerShell 5.1

This script basically just downloads all the other scripts and runs them.
plz dont judge my bad code ;-; #>

# Sets the background for powershell since for some reason it looooves to be blue and i think thats ugly.
$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
$Host.UI.RawUI.WindowTitle = "Kon OS Bootstrapper"
Clear-Host

# ESC code
$esc = ([char]27)

# Colours
$global:White = '$($esc)[97m'
$accent = '$($esc)[38;5;99m'

255, 218, 233

# Console Width nd stuff
$conWidth = (Get-Host).UI.RawUI.WindowSize.Width
$conHeight = (Get-Host).UI.RawUI.WindowSize.Height

if ($conWidth -lt 64 -or $conHeight -lt 19) {
    if (-not $env:WT_SESSION) {
        # make sure the script doesnt completely break if the user isnt using windows terminal
        try {
            $wtlocation = (Get-Command wt.exe | Select-Object -ExpandProperty Source -ErrorAction Stop)
            Start-Process -FilePath "$wtlocation" -ArgumentList "--size 120,30 Powershell.exe -NoLogo -NoExit -NoProfile -File C:\Users\Wybie\Downloads\centertextTest.ps1"
            [System.Environment]::Exit(0)
        }
        catch {
            throw "Windows Terminal is not installed. Falling back to conhost.exe..." | 
            cmd.exe /c "mode con: cols=120 lines=30"
        }
    }
    else {
        $wtlocation = (Get-Command wt.exe | Select-Object -ExpandProperty Source)
        Start-Process -FilePath "$wtlocation" -ArgumentList "--size 120,30 Powershell.exe -NoLogo -NoExit -NoProfile -File C:\Users\Wybie\Downloads\centertextTest.ps1"
        [System.Environment]::Exit(0)
    }
}

# defines path thing
$KONOS = "$env:systemDrive\Kon OS"

# logs
New-Item -ItemType File "$KONOS\setupLog.txt" -ErrorAction SilentlyContinue | Out-Null # SUPA COOL LOGS!

Write-Output @"
Starting Kon OS Setup...

──Bootstrapper.ps1───────────────────────────────────

"@ | Add-Content -Path "$KonOS\setupLog.txt"

# Uri thing, meant to make downloading files easier for me :P
$BaseUri = 'https://raw.githubusercontent.com/ki8y/KonOS/master/Components'

# Checks for admin (the script needs to run without elevated privileges at first because scoop is very picky.)
Write-Output "Checking for admin..."
$uacState = ([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544'
if (-not $uacState) {
    Invoke-CriticalStop -StopCode "Elevated_Privileges_Detected" -Message "Kon OS needs to be initialized without administrator privileges.`nI know, it's not ideal. Blame the scoop devs."
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


$Files = @(
    @{
        Uri = "$($BaseUri)/Setup/Modules/ColourCodes.psm1"
        OutFile = "$KonOS\Setup\Modules\ColourCodes.psm1"
    }
    @{
        Uri = "$($BaseUri)/Setup/Modules/Invoke-CriticalStop.psm1"
        OutFile = "$KonOS\Setup\Modules\Invoke-CriticalStop.psm1"
    }
    @{
        Uri = "$($BaseUri)/Setup/Modules/Invoke-SpeedRequest.psm1"
        OutFile = "$KonOS\Setup\Modules\Invoke-SpeedRequest.psm1"
    }
    @{
        Uri = "$($BaseUri)/Setup/Modules/Exit-Setup.psm1"
        OutFile = "$KonOS\Setup\Modules\Exit-Setup.psm1"
    }
    @{
        Uri = "$($BaseUri)/Setup/Modules/Read-Choice.psm1"
        OutFile = "$KonOS\Setup\Modules\Read-Choice.psm1"
    }
)

$jobs = @()

foreach ($file in $files) {
    $jobs += Start-Job -InitializationScript { Import-Module "$KONOS\Setup\Modules\Invoke-SpeedRequest.psm1" } -ArgumentList $KonOS -Name $file.OutFile -ScriptBlock {
        $params = $Using:file
        Invoke-SpeedRequest @params
        Write-Host "$Params"
    }
}

Wait-Job -Job $jobs | Out-Null

Import-Module -Path "$KonOS\Setup\Modules\ColourCodes.psm1"
Import-Module -Path "$KonOS\Setup\Modules\Invoke-CriticalStop.psm1"
Import-Module -Path "$KonOS\Setup\Modules\Exit-Setup.psm1"
Import-Module -Path "$KonOS\Setup\Modules\Read-Choice.psm1"
Import-Module -Path "$KonOS\Setup\Modules\Invoke-SpeedRequest.psm1"

# Title Screen :D (It looks like this so it fits in any terminal size)

$TitleIndent = [Math]::Max(0, [Math]::Floor(($conWidth - 48) / 2 - 1))
$SubtitleIndent = [Math]::Max(0, [Math]::Floor(($conWidth - 62) / 2 - 1))
$ButtonIndent = [Math]::Max(0, [Math]::Floor(($conWidth - 38) / 2 - 1))
$LineIndent = [Math]::Max(0, [Math]::Floor(($ConHeight - 6) / 2 - 3))

$Offset = " " * $TitleIndent
$Offset2 = " " * $SubtitleIndent
$Offset3 = " " * $ButtonIndent 
$Offset4 = "`n" * $LineIndent

Write-Host @"
$Offset4
$offset ██╗  ██╗ ██████╗ ███╗   ██╗     ██████╗ ███████╗
$offset ██║ ██╔╝██╔═══██╗████╗  ██║    ██╔═══██╗██╔════╝
$offset █████╔╝ ██║   ██║██╔██╗ ██║    ██║   ██║███████╗
$offset ██╔═██╗ ██║   ██║██║╚██╗██║    ██║   ██║╚════██║
$offset ██║  ██╗╚██████╔╝██║ ╚████║    ╚██████╔╝███████║
$offset ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚══════╝

$offset2 ╔════════════════════════════════════════════════════════════╗
$offset2 ║                        $($esc)[97mBegin Setup?$accent                        ║
$offset2 ╚════════════════════════════════════════════════════════════╝

$offset3 $($esc)[32m╭────────────╮$($esc)[31m          ╭────────────╮
$offset3 $($esc)[32m│   ✅ [Y]   │$($esc)[31m          │   ❎ [N]   │
$offset3 $($esc)[32m╰────────────╯$($esc)[31m          ╰────────────╯
"@

choice /c YN /n | Out-Null
switch ($LASTEXITCODE) {
    1 { PowerShell.exe -ExecutionPolicy Bypass -NoProfile -NoLogo -File "$KonOS\Setup\Modules\Setup.ps1" }
    2 { Exit-Setup }
}