<# KonOS.ps1
Built for Windows PowerShell 5.1 & PowerShell 7.6 (LTS)

This is basically just bootstrapper.ps1 but I split it up so it's easier for me to read. #>

# choice prompts for setup so u can go afk

$esc = ([char]27)

Import-Module "$HOME\Documents\GitHub\KonOS\Components\Setup\Modules\Read-Choice.psm1"
$KONOS = "$env:systemDrive\Kon OS"

Clear-Host
if ($env:WT_SESSION) { $WTSession = $true } else { $WTSession = $false }
Write-Host "How would you like to setup Kon OS?"
Write-Host @"
[1] Express installation - Automatically apply recommended setup settings
[2] Custom installation - Customize the installation to whatever you like
"@
choice.exe /c 12 /n | Out-Null
switch ($LASTEXITCODE) {
    1 { <#express installation#> }
    2 { <#Custom installation#> }
}
# ^^^^ this could probably be done with the confirmprefs variable but im in class so i gotta wrap this up for now LOL

do {

    # Import-Module "$KonOS\Setup\Modules\Read-Choice.psm1" (FINAL FOR SCRIPT)

    # Choices
    Write-Host "Create a restore point? [Y/N] $($ESC)[33m*HIGHLY Recommended*$($ESC)[97m"
    $CreateRP = Read-Choice

    if (-not $CreateRP) {
        Write-Host "`nAre you sure!? Not creating a restore point can complicate things if things go seriously wrong.`nPlease type `"I understand the risks`" to proceed without a restore point. Otherwise, press enter to continue.`n$($ESC)[94m» " -ForegroundColor Red -NoNewLine
        $ConfirmNoRP = Read-Host
        if ($ConfirmNoRP -notmatch "I understand the risks") {
            $CreateRP = $true
        }
    }

    Write-Host "`nUninstall Microsoft Edge? (You'll get to choose a browser) [Y/N]"
    $RemoveEdge = Read-Choice

    Write-Host "`nWould you like to uninstall Microsoft Store? [Y/N]"
    $RemoveWS = Read-Choice

    Write-Host "`nDisable Wi-Fi? [Y/N]"
    $DisableWifi = Read-Choice

    $setup = [PSCustomObject]@{
        "Flags" = [PSCustomObject]@{
            "WTSession" = $WTSession
        }
        "Prefs" = [PSCustomObject]@{
            "CreateRP"   = $CreateRP
            "RemoveEdge" = $RemoveEdge
            "RemoveWS"   = $RemoveWS
            "DisableWifi" = $DisableWifi
        }
    }

    Clear-Host
Write-Host @"
├────── These are your settings ──────┤

Create restore point    =  [$($CreateRP)]
Remove Microsoft Edge   =  [$($RemoveEdge)]
Remove Microsoft Store  =  [$($RemoveWS)]
Disable Wi-Fi           =  [$($DisableWifi)]
"@
    
    Write-Host "Is this okay? [Y/N]"
    $ConfirmPrefs = Read-Choice

} while (-not $ConfirmPrefs)

New-Item -ItemType File -Path "$KonOS\Setup\setupConfig.json" -Force -ErrorAction Stop | Out-Null
$setup | ConvertTo-Json | Set-Content -Path "$KONOS\Setup\setupConfig.json" -Encoding UTF8 # this does some pretty funny stuff on powershell 5.1. still works though so idc 🤷‍♂️

<#Write-Output "[Debug] Opening config file in text editor..."
start-process "notepad++" -ArgumentList "`"C:\Kon OS\Setup\setupConfig.json`""#>
