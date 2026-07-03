# Grabs tweaks and flags from json :P
$Tweaks = Get-Content 'C:\Users\Wybie\Documents\GitHub\KonOSRedone\Components\Setup\Data\Tweaks.json' -Raw | ConvertFrom-Json
#$Tweaks = Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/ki8y/KonOS/master/Components/Setup/Data/Tweaks.json'
#$Flags = (Get-Content -Path "$env:systemDrive\Kon OS\Setup\flags.json" | ConvertFrom-Json) 

# Handles different types of tweaks
$Handlers = @{

    Registry = {

        param($Job)

        #Write-Host "$($Job.key), $($Job.Value), $($Job.Data), $($Job.DataType)"

        if ($job.DataType -eq 3) {
            $job.Data = [byte[]]$Job.Data
        }

        #[Microsoft.Win32.Registry]::SetValue(
        #    $Job.Key,
        #    $Job.Value,
        #    $Job.Data,
        #    [Microsoft.Win32.RegistryValueKind]$Job.DataType
        #)
    }

    ScheduledTask = {

        param($Job)

        switch ($Job.State) {

            "Disabled" {
                #Write-Host "$($Job.TaskPath), $($Job.TaskName)"
                #    Disable-ScheduledTask `
                #        -TaskPath $Job.TaskPath `
                #        -TaskName $Job.TaskName
            }

            "Enabled" {
                #Write-Host "$($Job.TaskPath), $($Job.TaskName)"
                #    Enable-ScheduledTask `
                #        -TaskPath $Job.TaskPath `
                #        -TaskName $Job.TaskName
            }
        }
    }

    Command = {
        param($Job)

        foreach ($cmd in $Job.InvokeCommand) {
            #Invoke-Command -ScriptBlock {$cmd}
        }
    }

    BCD = {
        param($Job)

        switch ($job.Command) { 
            'Set' {
                #bcdedit /set $($job.id) $($job.value) $($job.data)
            }

            'DeleteValue' {
                #bcdedit /deletevalue $($job.id) $($job.value) $($job.data)
            }
        }
    }
}


# Actually apply the tweaks :P
foreach ($Category in $Tweaks.PSObject.Properties) {

    foreach ($Tweak in $Category.Value.Tweaks.PSObject.Properties) {

        $Jobs = $Tweak.Value.Apply

        Write-Host "[i] Applying $($Tweak.Value.Name)..." -ForegroundColor Cyan -NoNewline
        
        if ($Tweak.Value.MinBuild -and $Flags.Build -lt $Tweak.Value.MinBuild) {

            Write-Host "`r[!] Applying $($Tweak.Value.Name)..." -ForegroundColor Yellow
            Write-Host " » This tweak is made for a newer version of Windows, skipping..." -ForegroundColor Yellow

        }
        elseif ($Tweak.Value.MaxBuild -and $Flags.Build -gt $Tweak.Value.MaxBuild) {
            Write-Host "`r[!] Applying $($Tweak.Value.Name)..." -ForegroundColor Yellow
            Write-Host " » This tweak is made for an older version of Windows, skipping..." -ForegroundColor Yellow
        }
        else {
            if (-not $Tweak.Value.SkipByDefault) {
                foreach ($job in $jobs) {
                    $Handler = $Handlers[$Job.Type]
                    & $Handler $Job
                }
                Write-Host "`r[✓] Applying $($Tweak.Value.Name)... $($jobs.count)" -ForegroundColor Green
            }
        }
    }
}