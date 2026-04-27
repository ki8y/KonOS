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
            <# Do nothing lol #>
        }
        Limited {
            Write-Host @(
                "Your version of Windows ($($Build.Name) $($Build.Version)) has limited support.`n",
                "While compatible, I don't work hard to maintain support for these versions of Windows.",
                "You may encounter bugs, errors, or other inconveniences. (If you do, report them please :D)`n",
		"Press any key to proceed anyway..."
            ) -Separator "`n" -ForegroundColor DarkYellow -NoNewline
            [System.Console]::ReadKey($true) | Out-Null
        }
        None {
            Write-Host @(
                "Your version of Windows ($($Build.Name) $($Build.Version)) is not supported.`n",
                "I will not maintain support for these versions of Windows, and I'd highly recommend installing a newer version of Windows.",
                "You may encounter bugs, errors, or other inconveniences.`n",
		"Press any key to proceed anyway..."
            ) -Separator "`n" -ForegroundColor Red -NoNewline
            [System.Console]::ReadKey($true) | Out-Null
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
