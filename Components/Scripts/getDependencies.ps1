Import-Module "$env:systemDrive\Kon OS\Modules\Throbber.psm1"

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

$KonOS='[97m[[38;5;99mKon OS[97m][97m'
$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "$env:systemDrive\Windows\Media\Windows Ding.wav"

function Install-Dependencies {
    Clear-Host
	
    # Chocolatey
    $filePath = "$env:systemDrive\ProgramData\chocolatey\bin\choco.exe"
    if (Test-Path -Path $filePath -PathType Leaf) {
        Write-Host "$KonOS Chocolatey is already installed. Skipping..."
    } else {
        Show-Throbber -Message "Installing Chocolatey..." {
    	[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 | Out-Null
    	Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) | Out-Null
	} }


    # Scoop
    $filepath = "$env:systemDrive\users\$env:Username\scoop"
    if (Test-Path -Path $filePath -PathType Container) {
        Write-Host "$KonOS Scoop is already installed. Skipping..."
    } else {
        Show-Throbber -Message "Installing Scoop..." {
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression | Out-Null
	} }

    # Nanazip (7-zip fork)
    $filepath = "$env:systemDrive\Users\$env:Username\AppData\Local\Microsoft\WindowsApps\NanaZip.exe"
    if (Test-Path -Path $filePath -PathType Leaf) {
        Write-Host "$KonOS NanaZip is already installed. Skipping..."
    } else {
        Show-Throbber -Message "Installing NanaZip (nanazip)..." {
        choco install nanazip --confirm | Out-Null 
    } }

    # Powershell 7
	$filePath = "$env:systemDrive\Program Files\PowerShell\7\pwsh.exe"
    if (Test-Path -Path $filePath -PathType Leaf) {
        Write-Host "$KonOS PowerShell 7 is already installed. Skipping..."
    } else {
        Show-Throbber -Message "Installing Powershell 7 (powershell-core)..." {
		choco install powershell-core --confirm | Out-Null
        New-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "POWERSHELL_TELEMETRY_OPTOUT" /t REG_SZ /d "1" /f | Out-Null
        New-ItemProperty -Path "HKEY_CLASSES_ROOT\SystemFileAssociations\.ps1\Shell\Windows.pwsh.Run" /v "MUIVerb" /t REG_SZ /d "Run With Powershell 7" /f | Out-Null
        New-ItemProperty -Path "HKEY_CLASSES_ROOT\SystemFileAssociations\.ps1\Shell\Windows.pwsh.Run\Command" | Out-Null
        New-ItemProperty -Path 'Registry::HKEY_CLASSES_ROOT\SystemFileAssociations\.ps1\Shell\Windows.pwsh.Run\Command' -Name '(Default)' -Value '"C:\Program Files\PowerShell\7\pwsh.exe" -NoExit -NoProfile -ExecutionPolicy Bypass -Command "$host.UI.RawUI.WindowTitle = ''PowerShell 7 (x64)''; & ''%1''"' -Force | Out-Null
        Write-Host "$KonOS Powershell-Core installed successfully."
    } }

    # PowerRun
    $filePath = "$env:systemDrive\Kon OS\PowerRun"
    if (Test-Path -Path $filePath -PathType Container) {
        Write-Host "$KonOS PowerRun is already installed. Skipping..."
    } else {
        Show-Throbber -Message "Installing PowerRun..." {
        Invoke-WebRequest "https://www.sordum.org/files/downloads.php?power-run" -OutFile "$env:systemDrive\Kon OS\PowerRun.zip" -UseBasicParsing | Out-Null
        nanazipc x "$env:systemDrive\Kon OS\PowerRun.zip" -o"$env:systemDrive\Kon OS\" -y | Out-Null
        Remove-Item -Path "$env:systemDrive\Kon OS\PowerRun.zip" -Force | Out-Null
    } }

    # VCRedist Runtimes...
    Show-Throbber -Message "Installing VCRedist 2015-2022 Runtimes..." {
	choco install vcredist140 --confirm | Out-Null
    Write-Host "`r$KonOS VCRedist 2015-2022 Runtimes installed successfully." -NoNewLine
} }

function SelectedNo {
    Clear-Host
    Write-Host "[91mSetup Cannot Continue:`n`n[93mKon OS cannot be installed without the required dependencies.`nPlease install the dependencies and try again.`n`n[91m(MISSING DEPENDENCIES)"
    Write-Host "Press any key to exit setup..." -ForegroundColor White -NoNewLine
    cmd.exe /c "pause >nul"
    exit
}

function PromptForDependencies {
    Clear-Host
    Write-Host "$KonOS Your computer is missing the files/applications that Kon OS depends on to run.`n`nInstall them now?`n[92m[Y]es [91m[N]o" -NoNewLine
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
Write-Host "$KonOS Successfully installed dependencies!" -ForegroundColor Green
Write-Host "`nPress any key to launch Kon OS..."
cmd /c "pause >nul"
Start-Process -FilePath "pwsh.exe" -ArgumentList @(
    "-NoProfile"
    "-File"
    "`"C:\Kon OS\KonOS.ps1`""
)