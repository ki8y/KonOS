Import-Module "$env:systemDrive\KonOS\Data\Variables.psm1"
$Flags = Get-Content "$KonOS\"

# Enumeration for user flags
enum UserServiceFlags {
    Disabled = 0
    NoInheritance = 1
    NoStart = 2
    Enabled = 3
}

enum StartupType {
    Boot = 0
    System = 1
    Automatic = 2
    Manual = 3
    Disabled = 4
}

# Get every service on Windows, including drivers and the templates for Per-User services.
# Unfortunately I can't get the status or the description without compromising speed. I'll see what I can do later, but for now this command is very fast.
function Get-AllServices {

    # Get all services and properties
    $Hive = [Microsoft.Win32.Registry]::LocalMachine
    $Key = $Hive.OpenSubKey("SYSTEM\CurrentControlSet\Services")

    foreach ($svc in $Key.GetSubkeyNames()) {
        $SubKey = $Key.OpenSubKey($svc)
        if ($SubKey) {

            # hashtable :P
            $svcInfo = @{
                Name             = $svc
                Start            = $SubKey.GetValue("Start")
                Type             = $SubKey.GetValue("Type")
                UserServiceFlags = $SubKey.GetValue("UserServiceFlags")
                AutoDelayed      = $SubKey.GetValue("DelayedAutoStart")
                Dependencies     = $SubKey.GetValue("DependOnService")
            }
            $SubKey.Close()

            if (
                $null -eq $svcInfo['Type'] -and
                $null -eq $svcInfo['Start']
            ) {
                Write-Verbose "$($svcInfo['Name']) is a generated Per-User service. Skipping..."
                continue
            }

            # ANNIHILATE per-user services from the list
            if ($svcInfo.Type -in 208, 224, 240) {
                continue
            }

            # get dependency services
            if ($null -eq $svcInfo['Dependencies']) {
                $Dependencies = "None"
            }
            else {
                $Dependencies = $svcInfo.Dependencies
            }

            if ($null -eq $svcinfo['UserServiceFlags']) {
                $UserFlags = "N/A"
            }
            else {
                $UserFlags = [UserServiceFlags]$svcinfo['UserServiceFlags']
            }

            [PSCustomObject]@{
                Name             = $svcInfo['Name']
                IsTemplate       = ($svcInfo['Type'] -in 80, 96)
                KernelDriver     = ($svcInfo['Type'] -in 1, 2)
                KernelDriverType = if ($svcInfo['Type'] -in 1, 2) {
                    $svcInfo['Type']
                }
                else {
                    "N/A"
                }
                StartupType      = [StartupType]$svcinfo['Start']
                DelayedStart     = ($svcInfo['DelayedAutoStart'] -eq 1)
                UserFlags        = $UserFlags
                Dependencies     = $Dependencies
            }
        }
    }
    $Key.Close()
}


$Tweaks = Invoke-RestMethod -Uri 'https://github.com/ki8y/KonOS/raw/refs/heads/KonOS-Rewrite/Components/Setup/Data/Tweaks.json'
$Services = Get-AllServices

foreach ($Category in $Tweaks.PSObject.Properties) {

    foreach ($Tweak in $Category.Value.Tweaks.PSObject.Properties) {

        $Jobs = $Tweak.Value.Apply

        Write-Host "[i] Applying $($Tweak.Value.Name)..." -ForegroundColor Cyan -NoNewline
        
        if ($Tweak.Value.MinBuild -and $Flags.Build -lt $Tweak.Value.MinBuild) {

            Write-Host "`r[!] Applying $($Tweak.Value.Name)..." -ForegroundColor Yellow
            Write-Host " » This tweak is made for a newer version of Windows, skipping..." -ForegroundColor Yellow
            continue

        }
        elseif ($Tweak.Value.MaxBuild -and $Flags.Build -gt $Tweak.Value.MaxBuild) {
            Write-Host "`r[!] Applying $($Tweak.Value.Name)..." -ForegroundColor Yellow
            Write-Host " » This tweak is made for an older version of Windows, skipping..." -ForegroundColor Yellow
            continue
        }
        else {
            if (-not $Tweak.Value.SkipByDefault) {
                foreach ($job in $jobs) {
                    if ($job.Name -in $Services.Name) {
                        Set-Service -Name $job.Name -StartupType $job.StartupType
                    }
                }
                Write-Host "`r[✓] Applying $($Tweak.Value.Name)..." -ForegroundColor Green
            }
        }
    }
}
