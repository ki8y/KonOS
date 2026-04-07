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
$BaseUri = 'https://raw.githubusercontent.com/ki8y/KonOS/master'

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
        Uri = "$($BaseUri)/Components/Setup/Modules/ColourCodes.psm1"
        OutFile = "$KonOS\Setup\Modules\ColourCodes.psm1"
    }
    @{
        Uri = "$($BaseUri)/Components/Setup/Modules/Invoke-CriticalStop.psm1"
        OutFile = "$KonOS\Setup\Modules\Invoke-CriticalStop.psm1"
    }
    @{
        Uri = "$($BaseUri)/Components/Setup/Modules/Invoke-SpeedRequest.psm1"
        OutFile = "$KonOS\Setup\Modules\Invoke-SpeedRequest.psm1"
    }
    @{
        Uri = "$($BaseUri)/Components/Setup/Modules/Exit-Setup.psm1"
        OutFile = "$KonOS\Setup\Modules\Exit-Setup.psm1"
    }
    @{
        Uri = "$($BaseUri)/Components/Setup/Modules/Read-Choice.psm1"
        OutFile = "$KonOS\Setup\Modules\Read-Choice.psm1"
    }
        @{
        Uri = "$($BaseUri)/Components/Setup/Modules/Write-Box.psm1"
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

$TitleIndent = [Math]::Max(0, [Math]::Floor(($conWidth - 48) / 2 - 1)) # -48 because thats how big the kon os logo is in columns
$SubtitleIndent = [Math]::Max(0, [Math]::Floor(($conWidth - 62) / 2 - 1)) # -62 because thats how big the subtitle is in columns
$ButtonIndent = [Math]::Max(0, [Math]::Floor(($conWidth - 38) / 2 - 1)) # the buttons are 38 columns wide
$LineIndent = [Math]::Max(0, [Math]::Floor(($ConHeight - 6) / 2 - 3)) # the kon os ansi logo is 6 lines tall, i dont include the others cause i want the kon os logo to be the center.
$LineIndent2 = [Math]::Max(0, [Math]::Floor(($ConHeight - $LineIndent) - 3)) # For the version indicator, I feel like this is gonna be the hardest one

# title lines = 14

$Offset = " " * $TitleIndent
$Offset2 = " " * $SubtitleIndent
$Offset3 = " " * $ButtonIndent 
$LineOffset = "`n" * $LineIndent
$LineOffset2 = "`n" * $LineIndent2

<#
fun fact about this section: I was working on this at school and the version url wasnt working, so I was trying to figure out why and found that
for some reason my school wifi blocked githubusercontent.com, NOT github.com, only githubusercontent.com. Thanks school :)

And before anyone judges me for working on Kon OS in school, yes you're probably right I shouldn't be doing this but
I'm bored and I want to think of cool things instead.
#>
$Version = Invoke-RestMethod -Uri "$($BaseUri)/version.json"
$Commit = Invoke-RestMethod -Uri "https://api.github.com/repos/ki8y/KonOS/commits/master"
$VerIndicator = "$($Version.Major).$($Version.Minor).$($Version.Patch) $($Version.PreReleaseLabel) ($($($commit.sha.Substring(0,7))))"

Write-Host @"
$LineOffset
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
$LineIndent2
"@
Write-Box -Text "$VerIndicator" -Centered -Border Round -Color Blue

choice /c YN /n | Out-Null
switch ($LASTEXITCODE) {
    1 { PowerShell.exe -ExecutionPolicy Bypass -NoProfile -NoLogo -File "$KonOS\Setup\Modules\Setup.ps1" }
    2 { Exit-Setup }
}