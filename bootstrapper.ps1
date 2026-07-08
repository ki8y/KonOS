$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
$Host.UI.RawUI.WindowTitle = "KonOS Bootstrapper"
Clear-Host

# Check for admin
$uacState = ([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544'
if (-not $uacState) {
    Write-Host "[!] KonOS needs to be started with administrator privileges! Please relaunch PowerShell with administrator and try again." -ForegroundColor Red
    exit(99)
}

# Logs
New-Item -ItemType File -Path "$env:systemDrive\KonOS\logs\log.txt" | Out-Null
"Initializing..." | Tee-Object -FilePath "$env:systemDrive\KonOS\logs\log.txt"

# Setup files
New-Item -ItemType Directory "$env:systemDrive\KonOS\Setup\Scripts"
New-Item -ItemType Directory "$env:systemDrive\KonOS\Setup\Modules"
New-Item -ItemType Directory "$env:systemDrive\KonOS\Setup\Sounds"
New-Item -ItemType Directory "$env:systemDrive\KonOS\Setup\Data"

$BaseURL = 'https://raw.githubusercontent.com/ki8y/KonOS/KonOS-Rewrite'

$Files = @(
    @{
        Uri     = "$($BaseURL)/Components/Universal/Data/Variables.psm1"
        OutFile = "$env:systemDrive\KonOS\Setup\Data\Variables.psm1"
    },
    @{
        Uri     = "$($BaseURL)/Components/Universal/Sounds/startup.wav"
        OutFile = "$env:systemDrive\KonOS\Setup\Sounds\Startup.wav"
    },
    @{
        Uri     = "$($BaseURL)/Components/Setup/Scripts/Setup.ps1"
        OutFile = "$env:systemDrive\KonOS\Setup\Setup.ps1"
    },
    <#
    Unfinished
    @{
        Uri     = "$($BaseURL)/Components/Setup/Scripts/Get-Dependencies.ps1"
        OutFile = "$env:systemDrive\KonOS\Setup\Scripts\Get-Dependencies.ps1"
    },#>
    @{
        Uri     = "$($BaseURL)/Components/Universal/Data/Colours.json"
        OutFile = "$env:systemDrive\KonOS\Setup\Data\Colours.json"
    },
    @{
        Uri     = "$($BaseURL)/Components/Universal/Data/Tweaks.json"
        OutFile = "$env:systemDrive\KonOS\Setup\Data\Colours.json"
    },
    @{
        Uri     = "$($BaseURL)/Components/Universal/Data/Services.json"
        OutFile = "$env:systemDrive\KonOS\Setup\Data\Services.json"
    },
    @{
        Uri     = "$($BaseURL)/Components/Setup/Scripts/RegistryTweaks.ps1"
        OutFile = "$env:systemDrive\KonOS\Setup\Scripts\RegistryTweaks.ps1"
    },
    @{
        Uri     = "$($BaseURL)/Components/Universal/Modules/Write-Box.psm1"
        OutFile = "$env:systemDrive\KonOS\Setup\Modules\Write-Box.psm1"
    }

)

$jobs = @()
foreach ($file in $files) {
    $jobs += Start-Job -ArgumentList $KonOS -Name $file.OutFile -ScriptBlock {
        
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 # Tls 1.2 :P
        
        $params = $Using:file
        Invoke-RestMethod @params -UseBasicParsing
    }
}

Wait-Job -Job $jobs | Out-Null

try {
    Start-Process powershell.exe -ArgumentList "-File `"$env:systemDrive\KonOS\Setup\Scripts\Setup.ps1`""
}
finally {
    exit 0
}

<#
█▀▀▀▀▀▀▀▀▀▀▀▀▄        ▄▄▀▀▀▄▄      ▀█▀▀▄▀▀▀▀▄▄           ▄▄▀▀▀▄▄      
█             █▄    ▄▀       ▀▄▄    ▐▌   ▄▄   ▀▄       ▄▀       ▀▄▄   
▀▓▓█▌  █▄▄▄▄▄▄█▓░  █   ▄▄▀▄   ▐▓▒   ▐▌  █▓█▄▄   █▄    █   ▄▄▀▄   ▐▓▒  
  ░▐▌  █▒░▒░▒▓▒▒▓▌▐▌  ▐▐▓▒▐▌  ▐▓▓   █   ██▓▒▒▌  ▐▐▓  ▐▌  ▐▐▓▒▐▌  ▐▓▓  
   ▐▌  █▓▒░ ▀▒▓▓▀ █   ██▒░ █   █▓▓  █   ██▒░░█   █▓▓ █   ██▒░ █   █▓▓ 
   ▐▌  █▓▒░       ▐   ██▒░ █   █▒▓▌ █   ██▒░░█   █▒▓▌▐   ██▒░ █   █▒▓▌
   ▐▌  █▓▒░░      ▐▌  ▐▐▓▒▐▌  ▐ ░░▌ █   ██▓▒▄▀  ▐ ░░▌▐▌  ▐▐▓▒▐▌  ▐ ░░▌
   ▐▌  █▌▓░░       ▀▄  ▀▀▄▀  ▄▄▓░█ ▐▌  ▀ ▀▀▀   ▄▄▓░█  ▀▄  ▀▀▄▀  ▄▄▓░█ 
   ▐███▄▓██░         ▄ ▄▄▄▄▄▄█▓▒░▀ █▄▄▄▀▄▄▄▄▄▄▄█▓▒░▀    ▄ ▄▄▄▄▄▄█▓▒░▀ 
    ▀▄ ░▒▓▀▀          ▀▄░░▒▒▓██▀        ▀▄░░▒▒▓██▀       ▀▄░░▒▒▓██▀   
      ▀▀▀▀▀              ▀▀▀▀              ▀▀▀▀             ▀▀▀▀      

All done! For now...
#>