# Winget (PLS WORK, DIS ONES SUCH A BITCH)
    New-Item -ItemType Directory "$env:systemDrive\Kon OS\Temp" -Force
    $filePath = "$env:systemDrive\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_1.27.460.0_x64__8wekyb3d8bbwe\winget.exe"
    if (Test-Path -Path $filePath -PathType Leaf) {
        Write-Host "[$($KonOS)] Winget is already installed. Skipping..." 
    } else {
        Write-Host "[$($KonOS)] Winget is not installed, running install process..."
            # Install Dependencies
            $uri = "https://github.com/microsoft/winget-cli/releases/download/v1.12.460/DesktopAppInstaller_Dependencies.zip"
            $OutFile = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies.zip"
            curl.exe -s -L "$uri" -o "$OutFile"

            # Extract Zip FIles
            nanazipc x "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies.zip" -o"$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\" -y | Out-Null
            Remove-Item "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x86" -Recurse
            Remove-Item "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\arm64" -Recurse

            # Download app installer (winget :P)
            $uri = "https://github.com/microsoft/winget-cli/releases/download/v1.12.460/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
            $OutFile = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\DesktopAppInstaller.msixbundle"
            curl.exe -s -L "$uri" -o "$OutFile"

            # FINALLY, install winget...
            $dep1 = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64.appx"
            $dep2 = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\Microsoft.VCLibs.140.00_14.0.33519.0_x64.appx"
            $dep3 = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\Microsoft.WindowsAppRuntime.1.8_8000.616.304.0_x64.appx"
            $winget = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\DesktopAppInstaller.msixbundle"
            Add-AppxPackage -Path "$winget" -DependencyPath "$dep1","$dep2","$dep3" -AllowUnsigned

            try {
                winget --version | Out-Null
                Write-Host "IT WORKSS YAYYYY"
            } catch {
                Write-Host "It didnt work, I hate my life."
            
        }
    }
