$KonOS='[97m[[38;5;99mKon OS[97m][0m'

function Install-Dependencies {
    Clear-Host
	
    # Chocolatey
    $filePath = "$env:systemDrive\ProgramData\chocolatey"
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
    Write-Host "`Press any key to exit setup..." -ForegroundColor White -NoNewLine
    cmd.exe /c "pause >nul"
    exit
}

Write-Host "$KonOS Your computer is missing the files/applications that Kon OS depends on to run.`n`nInstall them now?`n[92m[Y]es [91m[N]o" -NoNewLine
choice /c YN /n | Out-Null
switch ($LASTEXITCODE) {
    1 { Install-Dependencies }
    2 { SelectedNo }
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
