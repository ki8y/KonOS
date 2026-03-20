# the plan: Ngl, this looks like it might be a pretty big script. I might split these app categories into separate scripts so that it's a little easier on my head.

$host.UI.RawUI.WindowSize  = New-Object System.Management.Automation.Host.Size(50,30)
$host.UI.RawUI.BufferSize  = New-Object System.Management.Automation.Host.Size(50,30)

$Host.UI.RawUI.WindowTitle = "App Installer Prototype :)"


$guid = New-Guid
$Packages = [PSCustomObject]@{
    "Session GUID" = "{$guid}"
}

if (-Not (Test-Path -Type Leaf -Path "$env:KonOS\Temp\PackagesToInstall.json")) {
    
    New-Item -ItemType File "$env:KonOS\Temp\PackagesToInstall.json" -ErrorAction SilentlyContinue
    $Packages | ConvertTo-Json | Set-Content -Path "$env:KonOS\temp\PackagesToInstall.json"

} else {

    $json = Get-Content -Path "$env:KonOS\Temp\PackagesToInstall.json" -Raw | ConvertFrom-Json
    
    if (-Not ($json | Select-Object "Session GUID") -Match $guid) {
        Write-Host "GUID did not match."
        New-Item -ItemType File "$env:KonOS\Temp\PackagesToInstall.json" -Force -ErrorAction SilentlyContinue
        $Packages | ConvertTo-Json | Set-Content "$env:KonOS\temp\PackagesToInstall.json" -Force
    }

}



Write-Host @"
                 
                 
                 Pick some apps.

                [1] Browsers
                [2] Communication
                [3] For Developers
                [4] Office Apps
                [5] Games
                [6] Misc

                [0] Exit
"@
choice.exe /c YN /n
switch ($LASTEXITCODE) {
    1 {Show-Browsers}
    2 {Show-Communication}
    3 {Show-ForDevs}
    4 {Show-OfficeApps}
    5 {Show-Games}
    6 {Show-Misc}
    7 {Exit}
}

switch ($LASTEXITCODE) {
    1 {Write-Host "you put yes"}
    2 {Write-Host "you put no"}
}

$Packages = $null

switch ($LASTEXITCODE) {
    1 {Write-Host "you put yes"}
    2 {Write-Host "you put no"}
}

