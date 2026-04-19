<#
.SYNOPSIS
    Handle sessions, crashes, and logs for AppInstaller.ps1

.DESCRIPTION
    AppInstaller.ps1 handles a bunch of delicate json files and stuff, so if the script closes unexpectedly, that's no good.
    This script opens up in the background and basically acts as a crash handler while also giving the script a session id, yada yada.

Built for Powershell 5.1
#>

<# Todo:
[] - Create session id json
[] - Create cleanup script nd stuffs ahgashaiusdoasd

#>
$uacState = ([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544'
if ($uacState) {
    Write-Output "[Error] Missing administrator privileges! Prompting user to restart..." | Add-Content -Path "$KonOS\setupLog.txt"

    Write-Host "[!] Kon OS needs to be started with administrator privileges! `n`nRestart with administrator privileges?" -ForegroundColor DarkYellow
    Write-Host "[Y]es // [N]o"

    Write-Host "» " -ForegroundColor Blue -NoNewline
    choice /c YN /n | Out-Null
    switch ($LASTEXITCODE) {
        1 { 
            Write-Host "Yes"
            <# Launch windows terminal, unless it doesnt exist #>
        }
        2 {
            Write-Host "No"
            <# Tell user that the script can't continue #>
        }
    }
}

# make log file
$guid = New-Guid | Select-Object -ExpandProperty Guid
$Packages = [PSCustomObject]@{
    "Session GUID" = "{$guid}"
}

$shortGuid = $($guid.Substring(0,7))
$logFile = New-Item -ItemType File -Path "$env:KonOS\Logs\AppInstaller Log ($shortGuid).txt" -Force -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name

Write-Output ("Starting AppInstaller at: " + (Get-Date).ToString("yy/MM/dd HH:mm:ss")) | Add-Content -Path "$logFile" -Encoding UTF8

# Make json file 
if (-Not (Test-Path -Type Leaf -Path "$env:KonOS\Temp\PackagesToInstall.json")) {
    New-Item -ItemType File "$env:KonOS\Temp\PackagesToInstall.json" -ErrorAction SilentlyContinue
    $Packages | ConvertTo-Json | Set-Content -Path "$env:KonOS\temp\PackagesToInstall.json" -Encoding UTF8
}

$process = Start-Process -FilePath "powershell.exe -ExecutionPolicy Bypass -File `"$env:KonOS\`"" -Wait -PassThru

if ($process.ExitCode -eq 0) {
    Write-Output "The program executed successfully."
} else {
     Write-Output "The program failed with exit code: $($process.ExitCode)"
}