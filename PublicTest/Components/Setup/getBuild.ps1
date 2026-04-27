param (
    [switch]$BypassVersionCheck
)

$buildList = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/ki8y/KonOS/master/Components/Setup/Data/SupportedBuilds.json"
$BuildID = [System.Environment]::OSVersion.Version.Build | Write-Output

$Build = $buildList | Select-Object -ExpandProperty $BuildID

if ($BypassVersionCheck) {
    Write-Host "Skipping version check..." # might use this to bypass windows build detection later if the user really really wants to.
}
else {
    switch ($Build.Support) {
        Full {
            
        }
        Limited {
            Write-Host "Your version of Windows has limited support."
        }
        None {
            Write-Host "Your version of Windows is not supported."
        }
        Experimental {
            Write-Host "Your version of Windows is in experimental testing."
        }
        default {
            Write-Host "Your version of Windows is not whitelisted."
        }
    }
}

[System.Console]::ReadKey($true) | Out-Null