$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
$Host.UI.RawUI.WindowTitle = "Kon OS Bootstrapper"
Clear-Host

# Check for admin
$uacState = ([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544'
if (-not $uacState) {
    Write-Host "[!] Kon OS needs to be started with administrator privileges! Please relaunch PowerShell with administrator and try again." -ForegroundColor Red
    exit(99)
}

# Logs
New-Item -ItemType File -Path "$env:systemDrive\Kon OS\logs\log.txt" | Out-Null
"Initializing..." | Tee-Object -FilePath "$env:systemDrive\Kon OS\logs\log.txt"

# Setup files
New-Item -ItemType Directory "$env:systemDrive\Kon OS\Setup\Scripts"
New-Item -ItemType Directory "$env:systemDrive\Kon OS\Setup\Modules"
New-Item -ItemType Directory "$env:systemDrive\Kon OS\Setup\Sounds"
New-Item -ItemType Directory "$env:systemDrive\Kon OS\Setup\Data"

$BaseUrl = 'https://raw.githubusercontent.com/ki8y/KonOS/master'

$Files = @(
    @{
        Uri = "$($BaseUrl)/Components/Data/GlobalVariables.psm1"
        OutFile = "$env:systemDrive\Kon OS\Setup\Data\GlobalVariables.psm1"
    },
    @{
        Uri = "$($BaseUri)/Components/Universal/Sounds/startup.wav"
        OutFile = "$env:systemDrive\Kon OS\Sounds\Startup.wav"
    },
    @{
        Uri = "$($BaseUri)/Components/Setup/Scripts/Setup.ps1"
        OutFile = "$env:systemDrive\Kon OS\Setup\Setup.ps1"
    },
    @{
        Uri = "$($BaseUri)/Components/Setup/Scripts/getDependencies.ps1"
        OutFile = "$env:systemDrive\Kon OS\Setup\Script\getDependencies.ps1"
    },
    @{
        Uri = "$($BaseUri)/Components/Universal/Data/Colours.json"
        OutFile = "$env:systemDrive\Kon OS\Components\Universal\Data\Colours.json"
    }
)

$jobs = @()

foreach ($file in $files) {
    $jobs += Start-Job -ArgumentList $KonOS -Name $file.OutFile -ScriptBlock {
        
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 # Tls 1.2 :P
        
        $params = $Using:file
        Invoke-RestMethod @params
    }
}

Wait-Job -Job $jobs | Out-Null

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

- Make setup script
- Make this script point to the setup script
- Add checksums for each download
#>