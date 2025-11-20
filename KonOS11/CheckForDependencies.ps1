$KonOS='[97m[[38;5;99mKon OS[97m][0m'
$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "$env:systemDrive\Windows\Media\Windows Ding.wav"

<# Checks your Windows build to avoid complications. #>
Write-Host "Checking if you meet the operating system requirements..."
$Build = [System.Environment]::OSVersion.Version.Build

# Win11 25H2
if ($build -ge 22600) {

    Write-Host @"
[33mWindows 11 25H2 Detected! ($Build)[0m

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
if ($build -ge 26100) { PromptForDependencies }

# Win11 23H2
if ($build -ge 22631) {
    Write-Host @"
[31mWindows 11 22H2 Detected! ($Build)[0m

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
if ($build -ge 22621) {
    Write-Host @"
[31mWindows 11 22H2 Detected! ($Build)[0m

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
if ($build -ge 22000) {
$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "$env:systemDrive\Windows\Media\Windows Critical Stop.wav"

    Write-Host @"
[91mSetup Cannot Continue:

[93mWindows 11 21H2 is unsupported by Kon OS.
Please install a newer version of Windows 11 (ideally 24H2) and try again.

[91m(OUTDATED_WINDOWS_VERSION)

[0mPress any key to exit setup...
"@
    $sound.Play()
    cmd.exe /c "pause >nul"
    exit
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

[0mPress any key to exit setup...
"@
    $sound.Play()
    cmd.exe /c "pause >nul"
    exit
}

function Install-Dependencies {
    Clear-Host
	
    # Chocolatey
    $filePath = "$env:systemDrive\ProgramData\chocolatey\bin\choco.exe"
    if (Test-Path -Path $filePath -PathType Leaf) {
        Write-Host "$KonOS Chocolatey is already installed. Skipping..."
    } else {
        Write-Host "$KonOS Installing Chocolatey..." -NoNewLine
			Set-ExecutionPolicy Bypass -Scope Process -Force | Out-Null
    		[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 | Out-Null
    		Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) | Out-Null
	}

    # Powershell 7
	$filePath = "$env:systemDrive\Program Files\PowerShell\7\pwsh.exe"
    if (Test-Path -Path $filePath -PathType Leaf) {
        Write-Host "$KonOS PowerShell 7 is already installed. Skipping..."
    } else {
        Write-Host "$KonOS Installing PowerShell-Core..." -NoNewLine
		choco install powershell-core --confirm | Out-Null
    }

    # .Net Framework 4.8
    Write-Host "$KonOS Installing VCRedist 2015-2022 Runtimes..." -NoNewLine
	choco install vcredist140 --confirm | Out-Null
}

function SelectedNo {
    Clear-Host
    Write-Host "[91mSetup Cannot Continue:`n`n[93mKon OS cannot be installed without the required dependencies.`nPlease install the dependencies and try again.`n`n[91m(MISSING DEPENDENCIES)"
    Write-Host "Press any key to exit setup..." -ForegroundColor White -NoNewLine
    cmd.exe /c "pause >nul"
    exit
}

function PromptForDependencies {
    Write-Host "$KonOS Your computer is missing the files/applications that Kon OS depends on to run.`n`nInstall them now?`n[92m[Y]es [91m[N]o" -NoNewLine
    choice /c YN /n | Out-Null
    switch ($LASTEXITCODE) {
        1 { Install-Dependencies }
        2 { SelectedNo }
} }

Clear-Host
Write-Host "$KonOS Successfully installed dependencies!" -ForegroundColor Green
Write-Host "`nPress any key to launch Kon OS..."
cmd /c "pause >nul"
Start-Process -FilePath "pwsh.exe" -ArgumentList @(
    "-NoProfile"
    "-File"
    "`"C:\Kon OS\KonOS.ps1`""
)
