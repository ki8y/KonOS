# Applies All Registry tweaks in RegistryTweaks.json
$Tweaks = Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/ki8y/KonOS/master/Components/Setup/Data/RegistryTweaks.json'
$Flags = (Get-Content -Path "$env:systemDrive\Kon OS\Setup\flags.json" | ConvertFrom-Json) 

foreach ($Category in $Tweaks.GeneralTweaks.PSObject.Properties) {

    foreach ($Tweak in $Category.Value.PSObject.Properties) {

        $Jobs = $Tweak.Value.Registry

        Write-Host "[i] Applying $($Tweak.Name) in registry..." -ForegroundColor Blue
        
        if ($Tweak.Value.MinBuild -gt $Flags.Build) {
            Write-Host "  This tweak is made for a newer version of Windows, skipping..." -ForegroundColor Red
        }
        else {
            foreach ($job in $jobs) {
                Write-Host "$($Job.key), $($Job.Value), $($Job.Data), (Type):$($Job.Type) $($Tweak.Value.MinBuild)"
                #[Microsoft.Win32.Registry]::SetValue($($Job.key), $($Job.Value), $($Job.Data), $($Job.Type))
            }
        }

    }
}