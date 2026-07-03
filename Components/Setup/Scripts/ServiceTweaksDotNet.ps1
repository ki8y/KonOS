# Load .net assemblies incase they havent been loaded already
Add-Type -AssemblyName System.ServiceProcess -ErrorAction Stop

# Enumeration for user flags
enum UserServiceFlags {
    Disabled = 0
    NoInheritance = 1
    NoStart = 2
    Enabled = 3
}

enum StartupType {
    Disabled = 4
    Manual = 3
    Automatic = 2
    System = 1
    Boot = 0
}

function Get-AllServices {
    # Get all services and properties
    $Hive = [Microsoft.Win32.Registry]::LocalMachine
    $Key = $Hive.OpenSubKey("SYSTEM\CurrentControlSet\Services")

    # Create the list
    $ServiceList = @()
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
            if ($null -eq $svcInfo['Dependencies']) { $Dependencies = "None" }
            else { $Dependencies = $svcInfo.Dependencies }

            if ($null -eq $svcinfo['UserServiceFlags']) { $UserFlags = "N/A" }
            else { $UserFlags = $svcinfo['UserServiceFlags'] }
            
            $ServiceList += [PSCustomObject]@{
                Name         = $svcInfo['Name']
                IsTemplate   = ($svcInfo['Type'] -in 80, 96)
                KernelDriver = ($svcInfo['Type'] -in 1, 2)
                StartupType  = [StartupType]$svcinfo['Start']
                DelayedStart = ($svcInfo['DelayedAutoStart'] -eq 1)
                UserFlags    = $UserFlags
                Dependencies = $Dependencies
            }
        }
    }
    $Key.Close()
    return $ServiceList
}