$Tweaks = Invoke-RestMethod -Uri 'https://This-Link-Doesnt-Exist-Yet.Lol'
foreach ($Category in $Tweaks.GeneralTweaks.PSObject.Properties) {

    foreach ($Tweak in $Category.Value.PSObject.Properties) {

        $Jobs = $Tweak.Value

        Write-Host "[i] Applying $($Tweak.Name) in registry..." -ForegroundColor Blue
        foreach ($job in $jobs) {
            Write-Host "$($Job.key), $($Job.Value), $($Job.Data), (Type):$($Job.Type)"
            #[Microsoft.Win32.Registry]::SetValue($($Job.key), $($Job.Value), $($Job.Data), $($Job.Type))
        }
    }
}