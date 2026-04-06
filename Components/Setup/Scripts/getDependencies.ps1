Write-Output "──getDependencies.ps1────────────────────────────────`n" | Add-Content -Path "$KonOS\setupLog.txt"

Import-Module "$KONOS\Setup\Modules\Invoke-SpeedRequest.psm1"

function ErrorHandler {
    # This is basically just supposed to mimic -ErrorAction Stop, but for exe commands
    param(
        [string]$Message
    )

    if ($LASTEXITCODE -ne 0) {
        throw $message
    }
}

$Dependencies = [PSCustomObject]@(
    #[PSCustomObject]@{ Name = 'Scoop'; Path = "$env:systemDrive\users\$env:Username\scoop\shims\scoop.ps1"; Type = 'Leaf'; Installed = $null}, <# Scoop is no longer needed. #>
    [PSCustomObject]@{ Name = 'Chocolatey'; Path = "$env:systemDrive\ProgramData\chocolatey\bin\choco.exe"; Type = 'Leaf'; Installed = $null },
    [PSCustomObject]@{ Name = 'NanaZip'; Path = "$env:systemDrive\Users\$env:Username\AppData\Local\Microsoft\WindowsApps\NanaZip.exe"; Type = 'Leaf'; Installed = $null },
    [PSCustomObject]@{ Name = 'PowerShell-Core'; Path = "$env:systemDrive\Program Files\PowerShell\7\pwsh.exe"; Type = 'Leaf'; Installed = $null },
    [PSCustomObject]@{ Name = 'PowerRun'; Path = "$env:systemDrive\Kon OS\Modules\PowerRun\PowerRun_x64.exe"; Type = 'Leaf'; Installed = $null },
    [PSCustomObject]@{ Name = 'Visual Studio 2015 Runtimes'; Path = 'HKLM:\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64'; Type = 'Container'; Installed = $null }
)

$i = 0

foreach ($dep in $dependencies) {
    try {
        if (-not (Test-Path -Path $dep.Path -PathType $dep.Type)) { 
            throw "Missing $($dep.Name)!"
        }
        else { $dep.Installed = $true }
    }
    catch {
        $i = $i + 1
        Write-Output "$($_.Exception.Message)" | Add-Content -Path "$KonOS\setupLog.txt"
        $dep.Installed = $false
    }
}

# winget apps want to be different for SOME REASON...
try {
    $wingetpath = Get-Command winget.exe -ErrorAction Stop
    $Dependencies += [PSCustomObject]@(
        [PSCustomObject]@{ Name = 'Winget'; Path = "$wingetpath"; Installed = $true }
    )
}
catch {
    $i = $i + 1
    $Dependencies += [PSCustomObject]@(
        [PSCustomObject]@{ Name = 'Winget'; Installed = $false }
    )
    Write-Output "$($_.Exception.Message)" | Add-Content -Path "$KonOS\setupLog.txt"
}

# windows terminal also tryna be different ig
try {
    $wtpath = Get-Command winget.exe -ErrorAction Stop
    
    $Dependencies += [PSCustomObject]@(
        [PSCustomObject]@{ Name = 'Windows Terminal'; Path = "$wtpath"; Type = 'Container'; Installed = $true }
    )
}
catch {
    $i = $i + 1
    $Dependencies += [PSCustomObject]@(
        [PSCustomObject]@{ Name = 'Windows Terminal'; Installed = $false }
    )
}

# Visual studio runtimes ALSO wanna be DIFFERENT FOR SOMEEE REASON...
$VSRuntimeRegKey = "Registry::HKLM\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64"
try {
    if ((Test-Path -Path "$VSRuntimeRegKey" -PathType Container)) {
        if (-not (Get-ItemProperty $VSRuntimeRegKey).Installed -eq 1) {
            # sometimes the key exists but the vs runtimes still arent installed, so this checks if its installed. if not, then yk the rest.
            throw "Missing Visual Studio 2015 Runtimes!"
        }
    }
    else {
        throw "Missing Visual Studio 2015 Runtimes!"
    }
}
catch {
    $i = $i + 1
    Write-Output "$($_.Exception.Message)" | Add-Content -Path "$KonOS\setupLog.txt"
}

function Install-AllMissingDependencies {

    Write-Output "`nInstalling all missing dependencies..." | Add-Content -Path "$KonOS\setupLog.txt"

    function Install-Dependency {
        param(
            [string]$MissingDep
        )

        switch ($MissingDep) {

            chocolatey {
                [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 # tls 1.2, aka more secure :P (noted cuz i forget what this does all the time, chocolatey includes it so i include it too.)
                Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) # runs the chocolatey installer and stuff yea uh yes
            }

            winget {

                try {   
                    Write-Output "Pulling up-to-date assets from github..." | Add-Content -Path "$KONOS\setupLog.txt"
                    $KonOS = "$env:systemDrive\Kon OS"
                    $Winget = Invoke-RestMethod https://api.github.com/repos/microsoft/winget-cli/releases/latest

                    $Dependencies = ($Winget.Assets.Name | Where-Object { $_ -like "*Dependencies.zip" })
                    $DesktopAppInstaller = ($Winget.Assets.Name | Where-Object { $_ -like "*DesktopAppInstaller*.msixbundle" })

                    Write-Output "Downloading files..." | Add-Content -Path "$KONOS\setupLog.txt"
                    $Files = @(
                        @{
                            Uri = ($Winget.Assets.browser_download_url | Where-Object { $_ -like "*Dependencies.zip" })
                            OutFile = "$KONOS\Setup\temp\$Dependencies"
                        }
                        @{
                            Uri = ($Winget.Assets.browser_download_url | Where-Object { $_ -like "*DesktopAppInstaller*.msixbundle" })
                            OutFile = "$KONOS\Setup\temp\$DesktopAppInstaller"
                        }
                    )

                    $jobs = @()

                    foreach ($file in $files) {
                        $jobs += Start-Job -InitializationScript { Import-Module "$KONOS\Setup\Modules\Invoke-SpeedRequest.psm1" } -ArgumentList $KonOS -Name $file.OutFile -ScriptBlock {
                            $params = $Using:file
                            Invoke-SpeedRequest @params
                            if ($LASTEXITCODE -ne 0) { throw "Failed to install $($dependency): Failed to download files. ($($LASTEXITCODE))" } 
                        }
                    }

                    Wait-Job -Job $jobs | Out-Null

                    Write-Output "Extracting files..." | Add-Content -Path "$KONOS\setupLog.txt"
                    Expand-Archive -Path "$KonOS\Setup\Temp\$Dependencies" -DestinationPath "$KonOS\Setup\Temp\DesktopAppInstaller_Dependencies\" -Force

                    Write-Output "Installing winget..." | Add-Content -Path "$KONOS\setupLog.txt"
                    $params = @{
                        Path = "$env:systemDrive\Kon OS\Setup\temp\$DesktopAppInstaller"
                        DependencyPath = (Get-ChildItem "$KonOS\Setup\Temp\DesktopAppInstaller_Dependencies\x64" | Select-Object -ExpandProperty FullName)
                        AllowUnsigned = $true
                        ForceApplicationShutdown = $true
                    }

                    Add-AppxPackage @params -ErrorAction Stop
                    Write-Output "Updating winget sources..." | Add-Content -Path "$KONOS\setupLog.txt"
                    winget source update --disable-interactivity | Out-Null
                }
                catch {
                    Write-Host "$($_.Exception.Message)" -ForegroundColor Red
                    Write-Output "$($_.Exception.Message)" | Add-Content -Path $KonOS\setupLog.txt
                }
                finally {
                    Write-Output "Cleaning up winget setup files..." | Add-Content -Path "$KONOS\setupLog.txt"
                    Remove-Item "$KonOS\Setup\temp\DesktopAppInstaller_Dependencies" -Recurse -Force | Out-Null
                    Remove-Item "$KonOS\Setup\temp\$Dependencies" -Recurse -Force | Out-Null
                    Remove-Item "$KonOS\Setup\temp\$DesktopAppInstaller" -Recurse -Force | Out-Null
                }
            }

            nanazip {
                winget install -e --id M2Team.NanaZip --silent --accept-package-agreements --accept-source-agreements --force | Out-Null
            }

            powershell-core {
                winget install --id Microsoft.PowerShell --silent --accept-package-agreements --accept-source-agreements --force | Out-Null
            }
    
            powerrun {
                Write-Output "Downloading PowerRun files..." | Add-Content -Path "$KONOS\setupLog.txt"
                $params = @{
                    uri = "https://www.sordum.org/files/downloads.php?power-run" 
                    OutFile = "$env:systemDrive\Kon OS\setup\temp\PowerRun.zip"
                    Silent = $True
                }
                Invoke-SpeedRequest @params

                Write-Output "Extracting PowerRun files..." | Add-Content -Path "$KONOS\setupLog.txt"
                Expand-Archive -Path "$env:systemDrive\Kon OS\setup\temp\PowerRun.zip" -DestinationPath "$env:systemDrive\Kon OS\Modules\" -Force | Out-Null
                Write-Output "Cleaning PowerRun temporary files..." | Add-Content -Path "$KONOS\setupLog.txt"
                Remove-Item -Path "$env:systemDrive\Kon OS\setup\temp\PowerRun.zip" -Force | Out-Null
        
            }
            'Windows Terminal' {
                Write-Output "Installing Windows Terminal..." | Add-Content -Path "$KONOS\setupLog.txt"
                winget install --exact --id Microsoft.WindowsTerminal --silent --accept-package-agreements --accept-source-agreements --force | Out-Null
            }

            'Visual Studio 2015 Runtimes' {
                Write-Output "Installing Visual Studio 2015 Runtimes..." | Add-Content -Path "$KONOS\setupLog.txt"
                winget install --exact --id Microsoft.VCRedist.2015+.x64 --accept-package-agreements --accept-source-agreements --force | Out-Null
            }
        }
    }

    $Dependencies | Where-Object { -not $_.Installed } | ForEach-Object {
        if (-not $_.Installed) {
            Write-Host "[i] Installing $($_.Name)..." -NoNewline
            Write-Output "Installing $($_.Name)..." | Add-Content -Path "$KonOS\setupLog.txt"

            Install-Dependency -MissingDep "$($_.Name)"
            Write-Host "`r[✓] Installing $($_.Name)..." -ForegroundColor Green
        }
    }
}

Clear-Host
if ($i -ne 0) {
    Write-Host "You have [91m$($i)[33m dependency(s) missing. `n" -ForegroundColor DarkYellow

    Write-Host "[33mMissing dependencies: [93m$((($dependencies | Where-Object {-not $_.Installed}).Name) -join ', ')"

    Write-Host "Install them now? [Y]es [N]o"

    choice.exe /c YN /n | Out-Null
    switch ($LASTEXITCODE) {
        1 { Install-AllMissingDependencies }
        2 { Exit-Setup }
    }
}
elseif ($i -eq 0) {
    
    exit
}

function Install-KonOS {

}


<# stop code stuff i might use in the future maybe idk
                    $param = @(
                        Message = @"
[91mSetup Cannot Continue:

[93mKon OS cannot be installed without administrator privileges.
Please run Kon OS with admin and try again.
"@
                        StopCode = "ELEVATED_PRIVILEGES_DENIED"
                    )
                    Invoke-CriticalStop @param
#>