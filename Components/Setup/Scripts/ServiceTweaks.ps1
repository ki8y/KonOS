function Get-AllServices {
    
    # Get all services and properties
    $regServices = Get-ChildItem "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services"

    # Get descriptions, statuses, display names, and other data
    $Services = Get-Service | Select-Object Description, DisplayName, Status, Name | Group-Object -Property Name -AsHashTable -AsString

    $ServicesList = @()
    foreach ($svc in $regServices) {
    
        $svcInfo = Get-ItemProperty "Registry::$svc" | Select-Object Start, Type, UserServiceFlags, DelayedAutoStart, DependOnService
    
        if (
            $null -eq $svcInfo.Type -and
            $null -eq $svcInfo.Start
        ) {
            continue
        }

        $svcName = $svc.PSChildName
        if ($svcInfo.Type -in 208, 224, 240) {
            continue
        } 

        # deserialize user flags
        switch ($svcInfo.UserServiceFlags) {
            0 { $UserFlags = "Disabled" }
            1 { $UserFlags = "NoInheritance" }
            2 { $UserFlags = "NoStart" }
            3 { $UserFlags = "Enabled" }
            ($null) { $UserFlags = "null" }
            default { $UserFlags = "Unknown" }
        }

        # deserialize startup types
        switch ($svcInfo.Start) {
            0 { $Start = "Boot" }
            1 { $Start = "System" }
            2 { $Start = "Automatic" }
            3 { $Start = "Manual" }
            4 { $Start = "Disabled" }
            ($null) { $Start = "null" }
            default { $Start = "Corrupted" }
        }

        if ($null -eq $svcInfo.DependOnService) {
            $Dependencies = "None"
        }
        else {
            $Dependencies = $svcInfo.DependOnService
        }

        # get display name
        if ($null -eq $Services[$svcName].DisplayName) {
            $DisplayName = "No Display Name"
        }
        else {
            $DisplayName = $Services[$svcName].DisplayName
        }

        # get status
        if ($null -eq $Services[$svcName].Status) {
            $Status = "Unknown"
        }
        else {
            $Status = $Services[$svcName].Status
        }

        # get description
        if ($null -eq $Services[$svcName].Description) {
            $Description = "No description available."
        }
        else {
            $Description = $Services[$svcName].Description
        }

        $ServicesList += [PSCustomObject]@{
            ServiceName      = $svcName
            DisplayName      = $DisplayName
            Status           = $Status
            IsTemplate       = ($svcInfo.Type -in 80, 96)
            KernelDriver     = ($svcInfo.Type -in 1, 2) 
            Start            = $Start
            UserServiceFlags = $UserFlags
            Dependencies     = $Dependencies
            DelayedStart     = ($svcInfo.DelayedAutoStart -eq 1)
            Description      = $Description
        }
    }
    return $ServicesList
}

$Services = Get-AllServices
$Tweaks = Get-Content -Path "C:\Users\Wybie\Documents\GitHub\KonOSRedone\Components\Setup\Data\Services.json" -Raw | ConvertFrom-Json

foreach ($Category in $Tweaks.PSObject.Properties) {

    foreach ($Tweak in $Category.Value.Tweaks.PSObject.Properties) {

        $Jobs = $Tweak.Value.Apply

        Write-Host "[i] Applying $($Tweak.Value.Name)..." -ForegroundColor Cyan -NoNewline
        
        if ($Tweak.Value.MinBuild -and $Flags.Build -lt $Tweak.Value.MinBuild) {

            #Write-Host "`r[!] Applying $($Tweak.Value.Name)..." -ForegroundColor Yellow
            #Write-Host " » This tweak is made for a newer version of Windows, skipping..." -ForegroundColor Yellow
            #continue

        }
        elseif ($Tweak.Value.MaxBuild -and $Flags.Build -gt $Tweak.Value.MaxBuild) {
            #Write-Host "`r[!] Applying $($Tweak.Value.Name)..." -ForegroundColor Yellow
            #Write-Host " » This tweak is made for an older version of Windows, skipping..." -ForegroundColor Yellow
            #continue
        }
        else {
            if (-not $Tweak.Value.SkipByDefault) {
                foreach ($job in $jobs) {
                    if ($job.Name -in $ServicesList.ServiceName) {
                        Set-Service -Name $job.Name -StartupType $job.StartupType
                    }
                }
                Write-Host "`r[✓] Applying $($Tweak.Value.Name)..." -ForegroundColor Green
            }
        }
    }
}








<#
█▀▀▀▀▀▀▀▀▀▀▀▀▄        ▄▄▀▀▀▄▄      ▀█▀▀▄▀▀▀▀▄▄           ▄▄▀▀▀▄▄      
█             █▄    ▄▀       ▀▄▄    ▐▌   ▄▄   ▀▄       ▄▀       ▀▄▄   
▀▓▓█▌  █▄▄▄▄▄▄█▓░  █   ▄▄▀▄   ▐▓▒   ▐▌  █▓█▄▄   █▄    █   ▄▄▀▄   ▐▓▒  
  ░▐▌  █▒░▒░▒▓▒▒▓▌▐▌  ▐▐▓▒▐▌  ▐▓▓   █   ██▓▒▒▌  ▐▐▓  ▐▌  ▐▐▓▒▐▌  ▐▓▓  
   ▐▌  █▓▒░ ▀▒▓▓▀ █   ██▒░ █   █▓▓  █   ██▒░░█   █▓▓ █   ██▒░ █   █▓▓ 
   ▐▌  █▓▒░       ▐   ██▒░ █   █▒▓▌ █   ██▒░░█   █▒▓▌▐   ██▒░ █   █▒▓▌
   ▐▌  █▓▒░░      ▐▌  ▐▐▓▒▐▌  ▐ ░░▌ █   ██▓▒▄▀  ▐ ░░▌▐▌  ▐▐▓▒▐▌  ▐ ░░▌
   ▐▌  █▌▓░░       ▀▄  ▀▀▄▀  ▄▄▓░█ ▐▌  ▀ ▀▀▀   ▄▄▓░█  ▀▄  ▀▀▄▀  ▄▄▓░█ 
   ▐███▄▓██░         ▄ ▄▄▄▄▄▄█▓▒░▀ █▄▄▄▀▄▄▄▄▄▄▄█▓▒░▀    ▄ ▄▄▄▄▄▄█▓▒░▀ 
    ▀▄ ░▒▓▀▀          ▀▄░░▒▒▓██▀        ▀▄░░▒▒▓██▀       ▀▄░░▒▒▓██▀   
      ▀▀▀▀▀              ▀▀▀▀              ▀▀▀▀             ▀▀▀▀      
- Make script actually edit services
- Add option to stop services


$Services = Get-CimInstance -ClassName Win32_Service
#>