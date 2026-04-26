param (
    [switch]$Test
)

$buildList = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/ki8y/KonOS/master/Components/Setup/Data/SupportedBuilds.json"
$BuildID = [System.Environment]::OSVersion.Version.Build | Out-String -NoNewline

$Build = $buildList | Select-Object -ExpandProperty $BuildID

switch ($Build.Support) {
    Full {
        Write-Host "Your version of Windows is supported!"
    }
    Limited {
        Write-Host "Your version of Windows has limited support."
    }
    None {
        Write-Host "FUCK YOUUUU"
    }
    Experimental {
        Write-Host "Your version of Windows is in experimental testing."
    }
    default {
        Write-Host "Your version of Windows is not whitelisted."
    }
}
# [System.Console]::ReadKey($true) | Out-Null

if ($Test) {
    Write-Host "Test is active!" # might use this to bypass windows build detection later if the user really really wants to.
}