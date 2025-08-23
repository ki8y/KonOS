Write-Host "Importing Gavot's Endgame power plan..." -ForegroundColor Blue

# powerplan name
$Name = "Endgame Performance"

# Import the plan
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$modulesRoot = Split-Path -Parent $scriptRoot
$powerPlanPath = Join-Path $modulesRoot "Power Plans\Gavot Performance.pow"
powercfg -import $powerPlanPath

# buffer cuz idk if it imports correctly without this
Start-Sleep -Milliseconds 500

# makes sure the power plan applies
$plans = powercfg /list
$guidLine = $plans | Where-Object { $_ -like "*$Name*" }
# chatgpt helped me a little here..
if ($guidLine -match "Power Scheme GUID:\s+([a-fA-F0-9\-]+)") {
    $guid = $matches[1]
    powercfg -setactive $guid
    Write-Host "`nPower plan optimized. GUID: $guid" -Backgroundcolor DarkGreen
} else {
    Write-Host "`nUnable to find the power plan named '$Name'. Please check manually." -Backgroundcolor Red
}

Write-Host "`nCurrent active plan:"
powercfg /getactivescheme
Write-Host "`n"
Start-Sleep -Milliseconds 1000


# Old Unused Code..

#Write-Host "Importing Gavot's Endgame power plan..." -ForegroundColor Blue

## Import the power plan
#powercfg -import "C:\Users\Wybie\Desktop\tests\KonOS\Power Plans\Gavot Performance.pow"

## Get the most recent (last) added plan GUID
#$plans = powercfg /list
#$lastGuid = ($plans | Select-String "Power Scheme GUID" | Select-Object -Last 1) -replace '.*GUID:\s*([a-fA-F0-9\-]+).*','$1'

## Rename it so it's not blank
#$customName = "Gavot's Endgame Performance"
#powercfg -changename $lastGuid "$customName"

## Apply it
#powercfg -setactive $lastGuid

#Write-Host "'$customName' applied. ($lastGuid)" -BackgroundColor DarkGreen
