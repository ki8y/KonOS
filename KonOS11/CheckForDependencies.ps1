$KonOS='[97m[[38;5;99mKon OS[97m][0m'

function Install-Dependencies {
    Clear-Host
    $filePath = "$env:systemDrive\Program Files\PowerShell\7\pwsh.exe"
    if (Test-Path -Path $filePath -PathType Leaf) {
        Write-Host "$KonOS Powershell 7 is installed. Skipping..."
	    cmd /c "pause >nul"
    } else {
        Write-Host "$KonOS Powershell 7 is not installed. Installing it now..." -NoNewLine
	    New-Item -Path "$env:SystemDrive\Kon OS\Setup\pwsh" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
        cmd /c 'curl -s -L "https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/PowerShell-7.5.4-win-x64.msi" -o "%systemDrive%\Kon OS\Setup\pwsh\PowerShell-7.5.4.msi"' | Out-Null
        cmd /c 'msiexec /i "%systemDrive%\Kon OS\Setup\pwsh\PowerShell-7.5.4.msi" /q USE_MU=0 ENABLE_MU=0 ALLUSERS=1 /norestart' | Out-Null
        reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "POWERSHELL_TELEMETRY_OPTOUT" /t REG_SZ /d "1" /f | Out-Null
        reg.exe add "HKEY_CLASSES_ROOT\SystemFileAssociations\.ps1\Shell\Windows.pwsh.Run" /v "MUIVerb" /t REG_SZ /d "Run With Powershell 7" /f | Out-Null
        New-ItemProperty -Path 'Registry::HKEY_CLASSES_ROOT\SystemFileAssociations\.ps1\Shell\Windows.pwsh.Run\Command' -Name '(Default)' -Value '"C:\Program Files\PowerShell\7\pwsh.exe" -NoExit -NoProfile -ExecutionPolicy Bypass -Command "$host.UI.RawUI.WindowTitle = ''PowerShell 7 (x64)''; & ''%1''"' -Force | Out-Null
        Write-Host "`r$KonOS Powershell 7 installed successfully.`nPress any key to continue..."
    cmd /c "pause >nul"

    Clear-Host
    Write-Host "$KonOS Successfully installed dependencies!" -ForegroundColor Green
    Write-Host "`nPress any key to launch Kon OS..."
    cmd /c "pause >nul"
    Start-Process -FilePath "pwsh.exe" -ExecutionPolicy Bypass -File "C:\Kon OS\KonOS.ps1"
} }

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
