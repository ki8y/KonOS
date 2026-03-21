Write-Output "──getDependencies.ps1────────────────────────────────`n" | Add-Content -Path "$KonOS\setupLog.txt"

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
    [PSCustomObject]@{ Name = 'PowerRun'; Path = "$env:systemDrive\Kon OS\PowerRun\PowerRun_x64.exe"; Type = 'Leaf'; Installed = $null },
    [PSCustomObject]@{ Name = 'Visual Studio 2015 Runtimes'; Path = 'HKLM:\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64'; Type = 'Container'; Installed = $null }
    
)

$i = 0

foreach ($dep in $dependencies) {
    Try {
        if (-not (Test-Path -Path $dep.Path -PathType $dep.Type)) { 
            throw "Missing $($dep.Name)!"
        } else { $dep.Installed = $true }
    } Catch {
        $i = $i+1
        Write-Output "$($_.Exception.Message)" | Add-Content -Path "$KonOS\setupLog.txt"
        $dep.Installed = $false
    }
}

# winget apps want to be different for SOME REASON...
Try {
    Winget --version | Out-Null; ErrorHandler -Message "Missing Winget!"
    $wingetpath = where.exe winget; ErrorHandler -Message "Missing Winget!"
    $Dependencies += [PSCustomObject]@(
        [PSCustomObject]@{ Name = 'Winget'; Path = "$wingetpath"; Installed = $true }
    )
} Catch {
    $i = $i+1
    $Dependencies += [PSCustomObject]@(
        [PSCustomObject]@{ Name = 'Winget'; Installed = $false }
    )
    Write-Output "$($_.Exception.Message)" | Add-Content -Path "$KonOS\setupLog.txt"
}

# windows terminal also tryna be different ig
Try {
    $wtpath = where.exe wt.exe; ErrorHandler -Message "Missing Windows Terminal!"
    
    $Dependencies += [PSCustomObject]@(
        [PSCustomObject]@{ Name = 'Windows Terminal'; Path = "$wtpath"; Type = 'Container'; Installed = $true }
    )
} catch {
    $i = $i+1
    $Dependencies += [PSCustomObject]@(
        [PSCustomObject]@{ Name = 'Windows Terminal'; Installed = $false }
    )
}

# Visual studio runtimes ALSO wanna be DIFFERENT FOR SOMEEE REASON...
$VSRuntimeRegKey = "Registry::HKLM\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64"
Try {
    if ((Test-Path -Path "$VSRuntimeRegKey" -PathType Container)) {
        if (-not (Get-ItemProperty $VSRuntimeRegKey).Installed -eq 1) { # sometimes the key exists but the vs runtimes still arent installed, so this checks if its installed. if not, then yk the rest.
            throw "Missing Visual Studio 2015 Runtimes!"
        }
    } else {
        throw "Missing Visual Studio 2015 Runtimes!"
    }
} Catch {
    $i = $i+1
    Write-Output "$($_.Exception.Message)" | Add-Content -Path "$KonOS\setupLog.txt"
}

function Install-AllMissingDependencies {

Write-Output "`nInstalling all missing dependencies..." | Add-Content -Path "$KonOS\setupLog.txt"
$uacState = ([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544' # checks if admin is running, needed for some stuff
Write-Output "UAC State: $uacState" | Add-Content -Path "$KonOS\setupLog.txt"

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
                    throw "Failed to install $($dependency):  You need to run this with admin privileges"
                }
            } catch {
                Write-Host "$($_.Exception.Message)" -ForegroundColor Red
                Write-Host "`n`nRelaunch this script with administrator privileges?"
                Write-Host "[Y]es [N]o"
                choice.exe /c YN /n
                switch ($LASTEXITCODE) {
                    1 {
                        
                        Start-Process -FilePath "pwsh.exe" `
                            -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" `
                            -Verb RunAs `
                            -ErrorAction Stop

                        [System.Environment]::Exit(0) # This specific exit command makes sure it closes the window aswell
                    }
                    2 {Write-Host "you put no"}
                }
            }

            try {
		    
                # Downloads winget dependencies
                $uri = "https://github.com/microsoft/winget-cli/releases/download/v1.12.460/DesktopAppInstaller_Dependencies.zip"
                $OutFile = "$env:systemDrive\Kon OS\Setup\temp\DesktopAppInstaller_Dependencies.zip"
                curl.exe -s -L "$uri" -o "$OutFile"
                if ($LASTEXITCODE -ne 0) { throw "Failed to install $($dependency): Failed to download files. ($($LASTEXITCODE))"}

                # Extracts da files
                Expand-Archive -Path "$env:systemDrive\Kon OS\Setup\temp\DesktopAppInstaller_Dependencies.zip" -DestinationPath "$env:systemDrive\Kon OS\Setup\temp\DesktopAppInstaller_Dependencies\" -Force | Out-Null
                Remove-Item "$env:systemDrive\Kon OS\Setup\temp\DesktopAppInstaller_Dependencies\x86" -Recurse
                Remove-Item "$env:systemDrive\Kon OS\Setup\temp\DesktopAppInstaller_Dependencies\arm64" -Recurse

                # Downloads app installer (which contains winget blah blah)
                $uri = "https://github.com/microsoft/winget-cli/releases/download/v1.12.460/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
                $OutFile = "$env:systemDrive\Kon OS\Setup\temp\DesktopAppInstaller_Dependencies\x64\DesktopAppInstaller.msixbundle"

                curl.exe -s -L "$uri" -o "$OutFile"
                if ($LASTEXITCODE -ne 0) { throw "Failed to install $($dependency): Failed to download files. ($($LASTEXITCODE))"}

                # installs app installer and winget, dai jus stands for desktop app installer lmfao
                $DAI = [PSCustomObject]@{
                    D1 = "$env:systemDrive\Kon OS\Setup\temp\DesktopAppInstaller_Dependencies\x64\Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64.appx";
                    D2 = "$env:systemDrive\Kon OS\Setup\temp\DesktopAppInstaller_Dependencies\x64\Microsoft.VCLibs.140.00_14.0.33519.0_x64.appx";
                    D3 = "$env:systemDrive\Kon OS\Setup\temp\DesktopAppInstaller_Dependencies\x64\Microsoft.WindowsAppRuntime.1.8_8000.616.304.0_x64.appx";
                    winget = "$env:systemDrive\Kon OS\Setup\temp\DesktopAppInstaller_Dependencies\x64\DesktopAppInstaller.msixbundle"
                }

                Add-AppxPackage -Path "$($DAI.winget)" -DependencyPath "$($DAI.D1)","$($DAI.D2)","$($DAI.D3)" -AllowUnsigned -ForceApplicationShutdown -ErrorAction Stop
                winget source update all --disable-interactivity | Out-Null
                winget update -e --id Microsoft.AppInstaller --silent --accept-package-agreements --accept-source-agreements --force | Out-Null

            } catch {
                Write-Host "$($_.Exception.Message)" -ForegroundColor Red
            }
        }

        $local:Dependency = "NanaZip"
        If ("$MissingDep" -Match "$Dependency") {
            winget install -e --id M2Team.NanaZip --silent --accept-package-agreements --accept-source-agreements --force | Out-Null
	    }

        $local:Dependency = "PowerShell-Core"
        If ("$MissingDep" -Match "$Dependency") {
            winget install --id Microsoft.PowerShell --silent --accept-package-agreements --accept-source-agreements --force | Out-Null
        }

        $local:Dependency = "PowerRun"
        If ("$MissingDep" -Match "$Dependency") {
            $uri = "https://www.sordum.org/files/downloads.php?power-run" 
            $OutFile = "$env:systemDrive\Kon OS\setup\temp\PowerRun.zip"
            curl.exe -s -L "$uri" -o "$outfile"

            Expand-Archive -Path "$env:systemDrive\Kon OS\setup\temp\PowerRun.zip" -DestinationPath "$env:systemDrive\Kon OS\" -Force | Out-Null
            Remove-Item -Path "$env:systemDrive\Kon OS\setup\temp\PowerRun.zip" -Force | Out-Null
	    }

        $local:Dependency = "Windows Terminal"
        If ("$MissingDep" -Match "$Dependency") {
            winget install --exact --id Microsoft.WindowsTerminal --silent --accept-package-agreements --accept-source-agreements --force | Out-Null
        }

        $local:Dependency = "Visual Studio 2015 Runtimes"
        If ("$MissingDep" -Match "$Dependency") {
            winget install --exact --id Microsoft.VCRedist.2015+.x64 --accept-package-agreements --accept-source-agreements --force | Out-Null
        }

    }

    $Dependencies | Where-Object {-not $_.Installed} | ForEach-Object {
        if (-not $_.Installed) {
            Write-Host "[ℹ️] Installing $($_.Name)..." -NoNewLine
            Write-Output "Installing $($_.Name)..." | Add-Content -Path "$KonOS\setupLog.txt"

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