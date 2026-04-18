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
$global:White = "$($esc)[97m"
$accent = "$($esc)[38;5;99m"

# 255, 218, 233

# Console Width nd stuff
$conWidth = (Get-Host).UI.RawUI.WindowSize.Width
$conHeight = (Get-Host).UI.RawUI.WindowSize.Height

if ($env:WT_SESSION) {
    $Flags += @{
        "WTSession" = $true
    }
}

if ($conWidth -lt 64 -or $conHeight -lt 19) {
    if (-not $env:WT_SESSION) {
        # make sure the script doesnt completely break if the user isnt using windows terminal
        try {
            $wtlocation = (Get-Command wt.exe | Select-Object -ExpandProperty Source -ErrorAction Stop)
            Start-Process -Verb RunAs -FilePath "$wtlocation" -ArgumentList "--size 120,30 Powershell.exe -NoLogo -NoExit -NoProfile -Command Invoke-Expression ((Invoke-RestMethod https://raw.githubusercontent.com/ki8y/KonOS/master/NEWERbootstrapper.ps1).TrimStart([char]0xFEFF))"
            [System.Environment]::Exit(0)
        }
        catch {
            throw "Windows Terminal is not installed. Falling back to conhost.exe..."
            cmd.exe /c "mode con: cols=120 lines=30"
        }
    }
    else {
        $wtlocation = (Get-Command wt.exe | Select-Object -ExpandProperty Source)
        Start-Process -Verb RunAs -FilePath "$wtlocation" -ArgumentList "--size 120,30 Powershell.exe -NoLogo -NoExit -NoProfile -Command Invoke-Expression ((Invoke-RestMethod https://raw.githubusercontent.com/ki8y/KonOS/master/NEWERbootstrapper.ps1).TrimStart([char]0xFEFF))"
        [System.Environment]::Exit(0)
    }
}

# defines path thing
$KONOS = "$env:systemDrive\Kon OS"

# logs
New-Item -ItemType File "$KONOS\setupLog.txt" -Force -ErrorAction SilentlyContinue | Out-Null # SUPA COOL LOGS!

Write-Output @"
Starting Kon OS Setup...

──Bootstrapper.ps1───────────────────────────────────

"@ | Add-Content -Path "$KonOS\setupLog.txt"

# Uri thing, meant to make downloading files easier for me :P
$BaseUri = 'https://raw.githubusercontent.com/ki8y/KonOS/master'

# Checks for admin
Write-Output "Checking for admin..." | Tee-Object "$KonOS\setupLog.txt" -Append
$uacState = ([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544'
if (-not $uacState) {
    Write-Output "[Error] Missing administrator privileges! Prompting user to restart..." | Add-Content -Path "$KonOS\setupLog.txt"

    Write-Host "[!] Kon OS needs to be started with administrator privileges! `n`nRestart with administrator privileges?" -ForegroundColor DarkYellow
    Write-Host "[Y]es // [N]o"

    Write-Host "» " -ForegroundColor Blue -NoNewline
    choice /c YN /n | Out-Null
    switch ($LASTEXITCODE) {
        1 { 
            Write-Host "Yes"
            <# Launch windows terminal, unless it doesnt exist #>
        }
        2 {
            Write-Host "No"
            <# Tell user that the script can't continue #>
        }
    }
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
New-Item -ItemType File -Path "$KonOS\Setup\setupFlags.json" -Force -ErrorAction Stop | Out-Null
$flags | ConvertTo-Json | Set-Content -Path "$KONOS\Setup\setupFlags.json" -Encoding UTF8

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
        Uri = "$($BaseUri)/Components/Setup/Modules/Exit-Setup.psm1"
        OutFile = "$KonOS\Setup\Modules\Exit-Setup.psm1"
    }
    @{
        Uri = "$($BaseUri)/Components/Setup/Modules/Read-Choice.psm1"
        OutFile = "$KonOS\Setup\Modules\Read-Choice.psm1"
    }
    @{
        Uri = "$($BaseUri)/Components/Universal/Modules/Write-Box.psm1"
        OutFile = "$KonOS\Modules\Write-Box.psm1"
    }
    @{
        Uri = "$($BaseUri)/Components/Setup/Modules/Invoke-SpeedRequest.psm1"
        OutFile = "$KonOS\Setup\Modules\Invoke-SpeedRequest.psm1"
    }
    @{
        Uri = "$($BaseUri)/Components/Universal/Sounds/startup.wav"
        OutFile = "$KonOS\Sounds\Startup.wav"
    }
    @{
        Uri = "$($BaseUri)/Components/Setup/Scripts/Setup.ps1"
        OutFile = "$KonOS\Setup\Setup.ps1"
    }
    @{
        Uri = "$($BaseUri)/Components/Setup/Scripts/getDependencies.ps1"
        OutFile = "$KonOS\Setup\Script\getDependencies.ps1"
    }
)

$jobs = @()

foreach ($file in $files) {
    $jobs += Start-Job -ArgumentList $KonOS -Name $file.OutFile -ScriptBlock {
        
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 # Tls 1.2 :P
        
        $params = $Using:file
        Invoke-RestMethod @params # Yea, technically its wrong to use Invoke-RestMethod to download stuff and you should use Invoke-WebRequest instead but that cmdlet SUCKS on ps 5.1, so here we are.
    }
}

Wait-Job -Job $jobs | Out-Null

# Initialize startup sound :P
$bootSnd = New-Object System.Media.SoundPlayer
$bootSnd.SoundLocation = "$env:systemDrive\Kon OS\Sounds\Startup.wav"

Import-Module "$KonOS\Setup\Modules\ColourCodes.psm1"
Import-Module "$KonOS\Setup\Modules\Invoke-CriticalStop.psm1"
Import-Module "$KonOS\Setup\Modules\Exit-Setup.psm1"
Import-Module "$KonOS\Modules\Write-Box.psm1"

# Title Screen :D (It looks like this so it fits in any terminal size)
$TitleIndent = [Math]::Max(0, [Math]::Floor(($conWidth - 48) / 2 - 1)) # -48 because thats how big the kon os logo is in columns
$SubtitleIndent = [Math]::Max(0, [Math]::Floor(($conWidth - 62) / 2 - 1)) # -62 because thats how big the subtitle is in columns
$ButtonIndent = [Math]::Max(0, [Math]::Floor(($conWidth - 38) / 2 - 1)) # the buttons are 38 columns wide
$LineIndent = [Math]::Max(0, [Math]::Floor(($ConHeight - 6) / 2 - 3)) # the kon os ansi logo is 6 lines tall, i dont include the others cause i want the kon os logo to be the center.
$LineIndent2 = [Math]::Max(0, [Math]::Floor((($ConHeight - $LineIndent) - 14) - 3) - 2   ) # For the version indicator, I feel like this is gonna be the hardest one

# title lines = 14

$Offset = " " * $TitleIndent
$Offset2 = " " * $SubtitleIndent
$Offset3 = " " * $ButtonIndent 
$LineOffset = "`n" * $LineIndent
$LineOffset2 = "`n" * $LineIndent2

# Pull Kon OS version :P
$Commit = Invoke-RestMethod -Uri "https://api.github.com/repos/ki8y/KonOS/commits/master"
$Ver = Invoke-RestMethod -Uri "$($BaseURI)\version.json"
$VerString = "$($Ver.Major).$($Ver.Minor).$($Ver.Patch) $($Ver.PreReleaseLabel) ($($commit.sha.Substring(0,7)))"

Clear-Host
$Host.UI.RawUI.WindowTitle = "Kon OS Bootstrapper"

$bootSnd.Play()

Write-Host @"
$LineOffset $Accent
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
$offset3 $($esc)[32m│   ☑️ [Y]   │$($esc)[31m          │   ✖️ [N]   │
$offset3 $($esc)[32m╰────────────╯$($esc)[31m          ╰────────────╯
$($LineOffset2)
"@
Write-Box -Text "⚙️ $VerString" -Border Round -Color Accent -HighlightText -Padding 2 -Indent 0 -NoNewLine 

choice /c YN /n | Out-Null
switch ($LASTEXITCODE) {
    1 { PowerShell.exe -ExecutionPolicy Bypass -NoProfile -NoLogo -File "$KonOS\Setup\Modules\Setup.ps1" }
    2 { Exit-Setup }
}



# miaw :cat_hi: