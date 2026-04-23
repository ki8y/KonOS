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
        [switch]$Confirm,
        [switch]$Silent
    )

    

    <#switch ((Test-Path -PathType Any -Path "Registry::$($Path)")) {
        $True {
            Set-ItemProperty -Path "Registry::$($Path)" -Name "$Name" -PropertyType "$PropertyType" -Value "$Value" -Force:$Force -Confirm:$Confirm -WhatIf:$WhatIf -ErrorAction Stop
        }
        $False {
            New-Item -Path "Registry::$Path" -ErrorAction SilentlyContinue
            
        }
    }#>
    

        
    try {
        Get-ItemProperty -Path "Registry::$($Path)" -Name $Name -ErrorAction Stop | Out-Null
        
        if (-not $Silent) {
            Write-Host " Setting $Name in $Path to $Value"
            try {
                Set-ItemProperty -Path "Registry::$($Path)" -Name "$Name" -PropertyType "$PropertyType" -Value "$Value" -Force:$Force -Confirm:$Confirm -WhatIf:$WhatIf -ErrorAction Stop
                Write-Host "[] Setting $Name in $Path to $Value" -ForegroundColor Green
            }
            catch {
                Write-Host "[] Setting $Name in $Path to $Value" -ForegroundColor Red
                New-ItemProperty -Path "Registry::$($Path)" -Name "$Name" -PropertyType "$PropertyType" -Value "$Value" -Force:$Force -Confirm:$Confirm -WhatIf:$WhatIf -ErrorAction Stop
            }
            
        }
    }
    catch {
        Write-Host "This key does not exist."
    }

}