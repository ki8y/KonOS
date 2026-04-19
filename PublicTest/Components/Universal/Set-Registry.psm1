# Very simple module that reliably changes registry keys :)
function Set-Registry {
    param(
        [Parameter(Mandatory = $true)]  
        [string]$Path,

        [Parameter(Mandatory = $true)]  
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [string]$PropertyType,

        [Parameter(Mandatory = $true)]
        [string]$Value,

        [switch]$WhatIf,
        [switch]$Force,
        [switch]$Confirm

    )
    switch ((Test-Path -PathType Any -Path "Registry::$($Path)")) {
        $True {
            Set-ItemProperty -Path "Registry::$($Path)" -Name "$Name" -PropertyType "$PropertyType" -Value "$Value" -Force:$Force -Confirm:$Confirm -WhatIf:$WhatIf -ErrorAction Stop
        }
        $False {
            New-Item -Path "Registry::$Path" -ErrorAction SilentlyContinue
            New-ItemProperty -Path "Registry::$($Path)" -Name "$Name" -PropertyType "$PropertyType" -Value "$Value" -Force:$Force -Confirm:$Confirm -WhatIf:$WhatIf -ErrorAction Stop
        }
        
        
        try {
        
        }
        catch {
            <#Do this if a terminating exception happens#>
        }
    }
}