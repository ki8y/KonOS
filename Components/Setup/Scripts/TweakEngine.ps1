enum StartupType {
    Boot = 0
    System = 1
    Automatic = 2
    Manual = 3
    Disabled = 4
}

function Get-OnlineProvisionedPackage { # because the native powershell cmdlet SUCKS.
    
    $uacState = (([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544')
    if (-not $uacState) {
        Write-Error "Elevated permissions are required to run DISM.`nUse an elevated PowerShell session to complete these tasks." -ErrorAction Stop
        return
    }
    
    $DismOutput = dism.exe /Online /Get-ProvisionedAppxPackages

    $DisplayName = $null
    $Version = $null
    $Architecture = $null
    $ResourceID = $null
    $PackageName = $null

    foreach ($line in $DismOutput) {
        if ($line -like "*DisplayName : *") {
            $DisplayName = $line.Split(":", 2)[1].Trim()
        }
        if ($line -like "*Version : *") {
            $Version = $line.Split(":", 2)[1].Trim()
        }
        if ($line -like "*Architecture : *") {
            $Architecture = $line.Split(":", 2)[1].Trim()
        }
        if ($line -like "*ResourceID : *") {
            $ResourceID = $line.Split(":", 2)[1].Trim()
        }
        if ($line -like "*PackageName : *") {
            $PackageName = $line.Split(":", 2)[1].Trim()
        }

        if ($line -like "*Regions : *") {
            $Regions = $line.Split(":", 2)[1].Trim()

            [PSCustomObject]@{
                DisplayName  = $DisplayName
                Version      = $Version
                Architecture = $Architecture
                ResourceID   = $ResourceID
                PackageName  = $PackageName
                Regions      = $Regions
            }

            $DisplayName = $null
            $Version = $null
            $Architecture = $null
            $ResourceID = $null
            $PackageName = $null
        }
    }
}
function Remove-OnlineProvisionedPackage {  # because the native powershell cmdlet SUCKS.
    param(
        [Parameter(Mandatory = $true)]
        [string]$PackageName
    )
    [void](dism.exe /Online /Remove-ProvisionedAppxPackage /PackageName:$PackageName)
}


# Get all installed packages
$InstalledApps = (Get-AppxPackage -AllUsers).Name
$Provisioned = Get-OnlineProvisionedPackage

# Grabs tweaks and flags from json :P
[string]$JsonRaw = Get-Content "C:\Users\Wybie\Downloads\TestTweaks.json" -Raw
$Tweaks = ConvertFrom-Json -InputObject $JsonRaw

# Handles different types of tweaks
$Handlers = @{

    Registry = {

        param($Job)

        if ($job.DataType -eq 3 -or $job.DataType -eq 'Binary') {
            $job.Data = [byte[]]$Job.Data
        }

        [Microsoft.Win32.Registry]::SetValue(
            $Job.Key,
            $Job.Value,
            $Job.Data,
            [Microsoft.Win32.RegistryValueKind]$Job.DataType
        )
        
    }

    ScheduledTask = {

        param($Job)

        switch ($Job.State) {

            "Disabled" {
                Disable-ScheduledTask `
                    -TaskPath $Job.TaskPath `
                    -TaskName $Job.TaskName
            }

            "Enabled" {
                Enable-ScheduledTask `
                    -TaskPath $Job.TaskPath `
                    -TaskName $Job.TaskName
            }
        }
    }

    CustomScript = {
        param($Job)

        if ($Job.PassThru) {
            . $Job.ScriptPath
        }
        else {
            & $Job.ScriptPath
        }
        
    }

    BCD = {
        param($Job)

        switch ($job.Command) { 
            'Set' {
                [void](bcdedit /set "$($job.id)" "$($job.value)" "$($job.data)") 
            }

            'DeleteValue' {
                [void](bcdedit /deletevalue "$($job.id)" "$($job.value)" "$($job.data)")
            }
        }
    }

    RemovePackage = {
        
        if ($job.Name -in $InstalledApps) {
            
            $Package = Get-AppXPackage -Name $job.Name -AllUsers
            if ($Package) {
                [void](Remove-AppxPackage -Package $Package -AllUsers)
            }
            
            foreach ($ProvApp in $Provisioned) {
                if ($ProvApp.DisplayName -match $Job.Name) {
                    [void](Remove-OnlineProvisionedPackage -PackageName $ProvApp.PackageName)
                }
            }

        }
    
    }

    Service = {
        param($job)
        [Microsoft.Win32.Registry]::SetValue(
            "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\$($Job.Name)",
            "Start",
            [StartupType]$Job.StartupType,
            [Microsoft.Win32.RegistryValueKind]4
        )
    }

}

foreach ($Category in $tweaks) {

    foreach ($Tweak in $Category.Tweaks) {
        Write-Host "[i] Applying $($Tweak.Label)... 0/$($Tweak.Apply.Count)" -ForegroundColor Cyan -NoNewline
        
        $i = 0
        foreach ($Job in $Tweak.Apply) {
            $Handler = $Handlers[$Job.Type]
            & $Handler $Job
            $i++
            Write-Host "`r[i] Applying $($Tweak.Label)... $i/$($Tweak.Apply.Count)" -ForegroundColor Cyan -NoNewline
        }
        Write-Host "`r[i] Applying $($Tweak.Label)... $($Tweak.Apply.Count)/$($Tweak.Apply.Count)" -ForegroundColor Green
    }
}