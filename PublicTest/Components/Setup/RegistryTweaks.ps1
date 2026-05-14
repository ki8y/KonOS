# Applies All Registry tweaks in RegistryTweaks.json
$Tweaks = Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/ki8y/KonOS/master/Components/Setup/Data/RegistryTweaks.json'
$Flags = (Get-Content -Path "$env:systemDrive\Kon OS\Setup\flags.json" | ConvertFrom-Json) 

foreach ($Category in $Tweaks.GeneralTweaks.PSObject.Properties) {

    foreach ($Tweak in $Category.Value.Tweaks.PSObject.Properties) {

        switch ($Tweak.Value.Default) {
            Enabled { $Jobs = $Tweak.Value.Enabled }
            Disabled { $Jobs = $Tweak.Value.Enabled }
        }
        

        Write-Host "[i] Applying $($Tweak.Value.Name) in registry..." -ForegroundColor Cyan -NoNewline
        
        if (
            $null -ne $Tweak.Value.MinBuild -and
            $Flags.Build -lt $Tweak.Value.MinBuild
        ) {
            Write-Host "`r[!] Applying $($Tweak.Value.Name) in registry..." -ForegroundColor Yellow
            Write-Host " » This tweak is made for a newer version of Windows, skipping..." -ForegroundColor Yellow
        }
        elseif (
            $null -ne $Tweak.Value.MaxBuild -and
            $Flags.Build -gt $Tweak.Value.MaxBuild
        ) {
            Write-Host "`r[!] Applying $($Tweak.Value.Name) in registry..." -ForegroundColor Yellow
            Write-Host " » This tweak is made for an older version of Windows, skipping..." -ForegroundColor Yellow
        }
        else {
            foreach ($job in $jobs) {
                #Write-Host "$($Job.key), $($Job.Value), $($Job.Data), (Type):$($Job.DataType) $($Tweak.Value.MinBuild)$($Tweak.Value.MaxBuild) "
                #[Microsoft.Win32.Registry]::SetValue($($Job.key), $($Job.Value), $($Job.Data), $($Job.Type))
            }
            Write-Host "`r[✓] Applying $($Tweak.Value.Name) in registry..." -ForegroundColor Green
        }
    }
}