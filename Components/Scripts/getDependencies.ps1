Write-Output "──getDependencies.ps1────────────────────────────────"

$Dependencies = [PSCustomObject]@(
    #[PSCustomObject]@{ Name = 'Scoop'; Path = "$env:systemDrive\users\$env:Username\scoop\shims\scoop.ps1"; Type = 'Leaf'; Installed = $null}, <# Scoop is no longer needed. #>
    [PSCustomObject]@{ Name = 'Chocolatey'; Path = "$env:systemDrive\ProgramData\chocolatey\bin\choco.exe"; Type = 'Leaf'; Installed = $null },
    [PSCustomObject]@{ Name = 'Winget'; Path = "$env:systemDrive\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_1.27.460.0_x64__8wekyb3d8bbwe\winget.exe"; Type = 'Leaf'; Installed = $null},
    [PSCustomObject]@{ Name = 'NanaZip'; Path = "$env:systemDrive\Users\$env:Username\AppData\Local\Microsoft\WindowsApps\NanaZip.exe"; Type = 'Leaf'; Installed = $null },
    [PSCustomObject]@{ Name = 'PowerShell-Core'; Path = "$env:systemDrive\Program Files\PowerShell\7\pwsh.exe"; Type = 'Leaf'; Installed = $null },
    [PSCustomObject]@{ Name = 'PowerRun'; Path = "$env:systemDrive\Kon OS\Modules\PowerRun\PowerRun_x64.exe"; Type = 'Leaf'; Installed = $null },
    [PSCustomObject]@{ Name = 'Visual Studio 2015 Runtimes'; Path = 'HKLM:\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64'; Type = 'Container'; Installed = $null },
    [PSCustomObject]@{ Name = 'Windows Terminal'; Path = "$env:systemDrive\Program Files\WindowsApps\Microsoft.WindowsTerminal*"; Type = 'Container'; Installed = $null }
)

$i = 0

foreach ($dep in $dependencies) {
    Try {
        if (-not (Test-Path -Path $dep.Path -PathType $dep.Type)) { 
            throw "Missing $($dep.Name)!"
        } else { $dep.Installed = $true }
    } Catch {
        $i = $i + 1
        # Write-Host "$($_.Exception.Message)" -ForegroundColor DarkRed <#This is unused now because uhhhhhhhhhhhhhh yea#>
        $dep.Installed = $false
    }
}

# winget wants to be different for SOME REASON...
Try {
    Winget --version | Out-Null
} Catch {
    $i = $i + 1
    # Write-Host "Missing winget.exe!" -ForegroundColor DarkRed
}

# Visual studio runtimes ALSO wanna be DIFFERENT FOR SOMEEE REASON...
$VSRuntimeRegKey = "Registry::HKLM\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64"
Try {
    if ((Test-Path -Path "$VSRuntimeRegKey" -PathType Container)) {
        if (-not (Get-ItemProperty $VSRuntimeRegKey).Installed -eq 1) { throw "Missing Visual Studio 2015 Runtimes!" } # sometimes the key exists but the vs runtimes still arent installed, so this checks if its installed. if not, then yk the rest.
    } else { throw "Missing Visual Studio 2015 Runtimes!" }
} Catch {
    $i = $i + 1
}

<#function Exit-Setup {
    function Exit-Setup { # cleans stuff up and exits da flippin SETUP.
    Write-Host "[$($KonOS)] Cleaning setup files..."
    Remove-Item -Path "$env:systemDrive\Kon OS" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    
    Write-Host "[$($KonOS)] Exiting setup..."
    Start-Sleep -Milliseconds 500 # just looks cooler if it says "exiting setup" lmfao

    Clear-Host
    Exit
}
}#>

function Install-AllMissingDependencies {

$uacState = ([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544' # checks if admin is running, needed for some stuff

    function Install-Dependency {
        param(
            [string]$MissingDep
        )

        $local:Dependency = "chocolatey"
        If ("$MissingDep" -Match "$Dependency") {
            try {
                if (-not $uacState) { 
                    throw "Failed to install $($dependency): You need to run this with admin privileges`nI know, it's not ideal. Blame the scoop devs."
                }
                [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 # tls 1.2, aka more secure :P (noted cuz i forget what this does all the time, chocolatey includes it so i include it too.)
                Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) # runs the chocolatey installer and stuff yea uh yes
            } catch {
                Write-Host "$($_.Exception.Message)" -ForegroundColor Red
                Write-Host "`n`nRelaunch this script with administrator privileges?"
                Write-Host "[Y]es [N]o"
                choice /c YN /n | Out-Null
                switch ($LASTEXITCODE) {
                    1 {
                        Start-Process -FilePath "pwsh.exe" -Verb RunAs -ArgumentList @(
                            "-NoProfile"
                            "-ExecutionPolicy"
                            "Bypass"
                            "-File"
                            "`"$env:systemDrive\Kon OS\KonOS.ps1`""
                            )
                    } 2 {
                        SelectedNo
                        }
                }
            }
        }

        $local:Dependency = "winget"
        If ("$MissingDep" -Match "$Dependency") {
            try {
                if (-not $uacState) { 
                    throw "Failed to install $($dependency):  You need to run this with admin privileges`nI know, it's not ideal. Blame the scoop devs."
                }

                # Downloads winget dependencies
                $uri = "https://github.com/microsoft/winget-cli/releases/download/v1.12.460/DesktopAppInstaller_Dependencies.zip"
                $OutFile = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies.zip"
                curl.exe -s -L "$uri" -o "$OutFile"
                if ($LASTEXITCODE -gt 0) { throw "Failed to install $($dependency): Failed to download files. ($($LASTEXITCODE))"}

                # Extracts da files
                Expand-Archive -Path "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies.zip" -DestinationPath "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\" -Force | Out-Null
                Remove-Item "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x86" -Recurse
                Remove-Item "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\arm64" -Recurse

                # Downloads app installer (which contains winget blah blah)
                $uri = "https://github.com/microsoft/winget-cli/releases/download/v1.12.460/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
                $OutFile = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\DesktopAppInstaller.msixbundle"

                curl.exe -s -L "$uri" -o "$OutFile"
                if ($LASTEXITCODE -gt 0) { throw "Failed to install $($dependency): Failed to download files. ($($LASTEXITCODE))"}

                # installs app installer and winget, dai jus stands for desktop app installer lmfao
                $DAI = [PSCustomObject]@{
                    D1 = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64.appx";
                    D2 = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\Microsoft.VCLibs.140.00_14.0.33519.0_x64.appx";
                    D3 = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\Microsoft.WindowsAppRuntime.1.8_8000.616.304.0_x64.appx";
                    winget = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\DesktopAppInstaller.msixbundle"
                }

                Add-AppxPackage -Path "$($DAI.winget)" -DependencyPath "$($DAI.D1)","$($DAI.D2)","$($DAI.D3)" -AllowUnsigned -ForceApplicationShutdown
                winget source update --accept-source-agreements
                winget update -e --id Microsoft.AppInstaller --accept-package-agreements --accept-source-agreements --force

            } catch {
                Write-Host "$($_.Exception.Message)" -ForegroundColor Red
                Write-Host "`n`nRelaunch this script with administrator privileges?"
                Write-Host "[Y]es [N]o (NON-FUNCTIONAL)"
                pause
            }
        }

        $local:Dependency = "NanaZip"
        If ("$MissingDep" -Match "$Dependency") {
            winget install -e --id M2Team.NanaZip --accept-package-agreements --accept-source-agreements --force | Out-Null
	    }

        $local:Dependency = "PowerShell-Core"
        If ("$MissingDep" -Match "$Dependency") {
            winget install --id Microsoft.PowerShell --accept-package-agreements --accept-source-agreements --force | Out-Null
        }

        $local:Dependency = "PowerRun"
        If ("$MissingDep" -Match "$Dependency") {
            $uri = "https://www.sordum.org/files/downloads.php?power-run" 
            $OutFile = "$env:systemDrive\Kon OS\temp\PowerRun.zip"
            curl.exe -s -L "$uri" -o "$outfile"

            Expand-Archive -Path "$env:systemDrive\Kon OS\temp\PowerRun.zip" -DestinationPath "$env:systemDrive\Kon OS\" -Force | Out-Null
            Remove-Item -Path "$env:systemDrive\Kon OS\temp\PowerRun.zip" -Force | Out-Null
	    }

        $local:Dependency = "Windows Terminal"
        If ("$MissingDep" -Match "$Dependency") {
            winget install --exact --id Microsoft.WindowsTerminal --accept-package-agreements --accept-source-agreements --force | Out-Null
        }

        $local:Dependency = "Visual Studio 2015 Runtimes"
        If ("$MissingDep" -Match "$Dependency") {
            winget install --exact --id Microsoft.VCRedist.2015+.x64 --accept-package-agreements --accept-source-agreements --force | Out-Null
        }

    }

    <#foreach ($depe in ($dependencies | Select-Object Name,Installed | Where-Object { $_.Installed -eq $false})) {
        Install-Dependency -MissingDep "$($depe.Name)"
        Write-Host "$($Depe.Name)"
    }#>
    $Dependencies | Where-Object {-not $_.Installed} | ForEach-Object {
        if (-not $_.Installed) {
            Write-Host "[ℹ️] Installing $($_.Name)..." -NoNewLine
            Install-Dependency -MissingDep "$($_.Name)"    
            Write-Host "`r[✓] Installing $($_.Name)..." -ForegroundColor Green
        }
    }
    $Dependencies
}

clear-host
if ($i -ne 0) {
    Write-Host "You have [91m$($i)[33m dependencie(s) missing. `n" -ForegroundColor DarkYellow

    Write-Host "[33mMissing dependencies: [93m$((($dependencies | Where-Object {-not $_.Installed}).Name) -join ', ')"
    #foreach ($dep in ($dependencies | Select-Object Name,Installed | Where-Object { $_.Installed -eq $false})) {
    #    Write-Host "$($dep.Name)" -ForegroundColor Yellow
    #}

    Write-Host "Install them now? [Y]es [N]o"

    choice.exe /c YN /n 
    switch ($LASTEXITCODE) {
        1 { Install-AllMissingDependencies }
        2 { Exit-Setup }
    }
} elseif ($i -eq 0) {
    
    exit
}


function Install-KonOS {

}