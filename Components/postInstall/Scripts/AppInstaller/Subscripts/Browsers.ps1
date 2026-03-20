<#
PLANS:

- Add info screen
- Add choice to pick between different release channels
- Ability to remove packages (right now if u pick one, you can't unpick one)
#>

$host.UI.RawUI.WindowSize  = New-Object System.Management.Automation.Host.Size(50,30)
$host.UI.RawUI.BufferSize  = New-Object System.Management.Automation.Host.Size(50,30)
Clear-Host

# Initialize packages variable, later this should be done by converting from the JSON file. 


function Add-Package {
    # Helper function that adds stuff and stuff yeah. yes!
    param(
        [string]$Name,
        [string]$PkgID
    )

    $Packages.Browsers += [PSCustomObject]@{
        Name = "$Name";
        Id = "$PkgID"
    }
}

# ui thing
Write-Host @"
                 
                 
                 Pick a browser.

                [1] Zen Browser*
                [2] Firefox
                [3] Librewolf
                [4] Brave
                [5] Google Chrome
                [6] Microsoft Edge

                [0] Back
"@
choice.exe /c 1234560 /n
switch ($LASTEXITCODE) {
    1 {
        Add-Package -Name "Zen Browser" -PkgID "Zen-Team.Zen-Browser" # Stable
    }
    2 {
        Add-Package -Name "Mozilla Firefox" -PkgID "Mozilla.Firefox" # Stable
    }
    3 {
        Add-Package -Name "Librewolf" -PkgID "LibreWolf.LibreWolf" # Stable
    }
    4 {
        Add-Package -Name "Brave" -PkgID "Brave.Brave" # Stable
    }
    5 {
        Add-Package -Name "Google Chrome" -PkgID "Google.Chrome" # Stable........ LMFAO
    }
    6 {
        Add-Package -Name "Microsoft Edge" -PkgID "Microsoft.Edge" # Stable (:skull:)
    }
    7 {
        $Packages | ConvertTo-Json
        Exit
    }
}
