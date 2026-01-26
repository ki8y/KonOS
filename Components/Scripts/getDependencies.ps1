Import-Module "$env:systemDrive\Kon OS\Modules\Throbber.psm1"
Import-Module "$env:systemDrive\Kon OS\Modules\ColourCodes.psm1"

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

$KonOS="$($accent)Kon OS[97m"
$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "$env:systemDrive\Windows\Media\Windows Ding.wav"

function Install-Dependencies {
    Clear-Host
    New-Item -ItemType Directory "$env:systemDrive\Kon OS\temp" -ErrorAction SilentlyContinue | Out-Null

    # Chocolatey
    $filePath = "$env:systemDrive\ProgramData\chocolatey\bin\choco.exe"
    if (Test-Path -Path $filePath -PathType Leaf) {
        Write-Host "[$($KonOS)] Chocolatey is already installed. Skipping..."
    } else {
        Show-Throbber -Message "Installing Chocolatey..." {
    	[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 | Out-Null
    	Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) | Out-Null
	} }

    # Scoop
    $filepath = "$env:systemDrive\users\$env:Username\scoop"
    if (Test-Path -Path $filePath -PathType Container) {
        Write-Host "[$($KonOS)] Scoop is already installed. Skipping..."
    } else {
        Show-Throbber -Message "Installing Scoop..." {
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression | Out-Null
	} }

    # Nanazip (7-zip fork)
    $filepath = "$env:systemDrive\Users\$env:Username\AppData\Local\Microsoft\WindowsApps\NanaZip.exe"
    if (Test-Path -Path $filePath -PathType Leaf) {
        Write-Host "[$($KonOS)] NanaZip is already installed. Skipping..."
    } else {
        Show-Throbber -Message "Installing NanaZip (nanazip)..." {
        choco install nanazip --confirm | Out-Null 
    } }

    # Powershell 7
	$filePath = "$env:systemDrive\Program Files\PowerShell\7\pwsh.exe"
    if (Test-Path -Path $filePath -PathType Leaf) {
        Write-Host "[$($KonOS)] PowerShell 7 is already installed. Skipping..."
    } else {
        Show-Throbber -Message "Installing Powershell 7 (powershell-core)..." {
		choco install powershell-core --confirm | Out-Null
        New-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "POWERSHELL_TELEMETRY_OPTOUT" /t REG_SZ /d "1" /f | Out-Null
        New-ItemProperty -Path "HKEY_CLASSES_ROOT\SystemFileAssociations\.ps1\Shell\Windows.pwsh.Run" /v "MUIVerb" /t REG_SZ /d "Run With Powershell 7" /f | Out-Null
        New-ItemProperty -Path "HKEY_CLASSES_ROOT\SystemFileAssociations\.ps1\Shell\Windows.pwsh.Run\Command" | Out-Null
        New-ItemProperty -Path 'Registry::HKEY_CLASSES_ROOT\SystemFileAssociations\.ps1\Shell\Windows.pwsh.Run\Command' -Name '(Default)' -Value '"C:\Program Files\PowerShell\7\pwsh.exe" -NoExit -NoProfile -ExecutionPolicy Bypass -Command "$host.UI.RawUI.WindowTitle = ''PowerShell 7 (x64)''; & ''%1''"' -Force | Out-Null
        Write-Host "[$($KonOS)] Powershell-Core installed successfully."
    } }

    # PowerRun
    $filePath = "$env:systemDrive\Kon OS\PowerRun"
    if (Test-Path -Path $filePath -PathType Container) {
        Write-Host "[$($KonOS)] PowerRun is already installed. Skipping..."
    } else {
        Show-Throbber -Message "Installing PowerRun..." {
        $uri = "https://www.sordum.org/files/downloads.php?power-run" 
        $OutFile = "$env:systemDrive\Kon OS\PowerRun.zip"
        curl.exe -s -L "$uri" -o "$outfile"
        nanazipc x "$env:systemDrive\Kon OS\PowerRun.zip" -o"$env:systemDrive\Kon OS\" -y | Out-Null
        Remove-Item -Path "$env:systemDrive\Kon OS\PowerRun.zip" -Force | Out-Null
    } }

# Winget (PLS WORK, DIS ONES SUCH A BITCH)
    $filePath = "$env:systemDrive\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_1.27.460.0_x64__8wekyb3d8bbwe\winget.exe"
    if (Test-Path -Path $filePath -PathType Leaf) {
        Write-Host "[$($KonOS)] Winget is already installed. Skipping..." 
    } else {
        Write-Host "[$($KonOS)] Winget is not installed, running install process..."
            # Install Dependencies
            Show-Throbber -Message "Downloading Dependencies..." {
                $uri = "https://github.com/microsoft/winget-cli/releases/download/v1.12.460/DesktopAppInstaller_Dependencies.zip"
                $OutFile = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies.zip"
                curl.exe -s -L "$uri" -o "$OutFile"
            }
            Write-Host "[✓] Downloading Dependencies..." -ForegroundColor Green

            # Extract Zip FIles
            Show-Throbber -Message "Extracting files..." {
                nanazipc x "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies.zip" -o"$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\" -y | Out-Null
                Remove-Item "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x86" -Recurse
                Remove-Item "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\arm64" -Recurse
            }
            Write-Host "[✓] Extracting files..." -ForegroundColor Green

            # Download app installer (winget :P)
            Show-Throbber -Message "Downloading App Installer Files..." {
                $uri = "https://github.com/microsoft/winget-cli/releases/download/v1.12.460/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
                $OutFile = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\DesktopAppInstaller.msixbundle"
                curl.exe -s -L "$uri" -o "$OutFile"
            }
            Write-Host "[✓] Downloading App Installer Files..." -ForegroundColor Green

            # FINALLY, install winget...
            Show-Throbber -Message "Installing Winget..." {
                $dep1 = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64"
                $dep2 = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\Microsoft.VCLibs.140.00_14.0.33519.0_x64"
                $dep3 = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\Microsoft.WindowsAppRuntime.1.8_8000.616.304.0_x64"
                $winget = "$env:systemDrive\Kon OS\temp\DesktopAppInstaller_Dependencies\x64\DesktopAppInstaller.msixbundle"
                Add-AppxPackage -Path "$winget" -DependencyPath "$dep1","$dep2","$dep3" -AllowUnsigned
            }
            Write-Host "[✓] Installing Winget..." -ForegroundColor Green
        }

    # VCRedist Runtimes...
    Show-Throbber -Message "Installing VCRedist 2015-2022 Runtimes..." {
	choco install vcredist140 --confirm | Out-Null
    Write-Host "`r[$($KonOS)] VCRedist 2015-2022 Runtimes installed successfully." -NoNewLine
    } 
}

function SelectedNo {
    Clear-Host
    Write-Host "[91mSetup Cannot Continue:`n`n[93mKon OS cannot be installed without the required dependencies.`nPlease install the dependencies and try again.`n`n[91m(MISSING DEPENDENCIES)"
    Write-Host "Press any key to exit setup..." -ForegroundColor White -NoNewLine
    cmd.exe /c "pause >nul"
    [System.Environment]::Exit(0)
}

function PromptForDependencies {
    Clear-Host
    Write-Host "[$($KonOS)] Your computer is missing the files/applications that Kon OS depends on to run.`n`nInstall them now?`n[92m[Y]es [91m[N]o" -NoNewLine
    choice /c YN /n | Out-Null
    switch ($LASTEXITCODE) {
        1 { Install-Dependencies }
        2 { SelectedNo }
} }

<# Checks your Windows build to avoid complications. #>
Write-Host "Checking if you meet the operating system requirements..."
$Build = [System.Environment]::OSVersion.Version.Build

# Win11 25H2
if ($build -le 22600) {

    Write-Host @"
[33mWindows 11 25H2 Detected! ($Build)[97m

Windows 11 25H2 is an untested version of Windows 11. It should be similar enough to 24H2 to
run with minimal issues, but I haven't tested this myself. 
If you encounter any bugs during or after applying these tweaks, please let me know!
    
Press any key to continue...
"@
    $sound.Play()
    cmd.exe /c "pause >nul"
    PromptForDependencies
}

# Win11 24H2
if ($build -le 26100) { PromptForDependencies }

# Win11 23H2
if ($build -le 22631) {
    Write-Host @"
[31mWindows 11 22H2 Detected! ($Build)[97m

Kon OS was built for Windows 11 24H2. The version of Windows you're using is Windows 11 22H2.
While Kon OS can be installed on 22H2, I am not responsible for any potential damage caused to your computer.
Please do not DM me for any help regarding 22H2, I will not respond.

Continue the installation?
"@
    $sound.Play()
    cmd.exe /c "pause >nul"
    PromptForDependencies
}

# Win11 22H2
if ($build -le 22621) {
    Write-Host @"
[31mWindows 11 22H2 Detected! ($Build)[97m

Kon OS was built for Windows 11 24H2. The version of Windows you're using is Windows 11 22H2.
While Kon OS can be installed on 22H2, I am not responsible for any potential damage caused to your computer.
Please do not DM me for any help regarding 22H2, I will not respond.

Continue the installation?
"@
    $sound.Play()
    cmd.exe /c "pause >nul"
    PromptForDependencies
}

# Win11 21H2
if ($build -le 22000) {
$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "$env:systemDrive\Windows\Media\Windows Critical Stop.wav"

    Write-Host @"
[91mSetup Cannot Continue:

[93mWindows 11 21H2 is unsupported by Kon OS.
Please install a newer version of Windows 11 (ideally 24H2) and try again.

[91m(OUTDATED_WINDOWS_VERSION)

[97mPress any key to exit setup...
"@
    $sound.Play()
    cmd.exe /c "pause >nul"
    Remove-Item -Path "$env:systemDrive\Kon OS" -Recurse -Force -ErrorAction SilentlyContinue
    ExitSetup
}

# Windows 10 or lower...
if ($build -le 19045) {
$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "$env:systemDrive\Windows\Media\Windows Critical Stop.wav"

    Write-Host @"
[91mSetup Cannot Continue:

[93mWindows 10 is unsupported by Kon OS.
Please install Windows 11 (24H2 or newer) and try again.

[91m(OUTDATED_WINDOWS_VERSION)

[97mPress any key to exit setup...
"@
    $sound.Play()
    cmd.exe /c "pause >nul"
    Remove-Item -Path "$env:systemDrive\Kon OS" -Recurse -Force -ErrorAction SilentlyContinue
    ExitSetup
}

Clear-Host
Write-Host "[$($KonOS)] Successfully installed dependencies!" -ForegroundColor Green
Write-Host "`nPress any key to launch Kon OS..."
cmd /c "pause >nul"

try {
    Start-Process -FilePath "pwsh.exe" -ArgumentList @(
        "-NoProfile"
        "-ExecutionPolicy Bypass"
        "-Verb RunAs"
        "-File `"C:\Kon OS\KonOS.ps1`""
        "-ErrorAction Stop"
    )
} catch {
    Write-Host "PowerShell 7 could not be opened. If you recieved this error, please contact me."
    Write-host "`nDiscord: @ki8y"
}