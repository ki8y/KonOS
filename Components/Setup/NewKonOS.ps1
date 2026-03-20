

$Host.UI.RawUI.WindowTitle = "Kon OS Bootstrapper | $($version.Substring(0,12)) ($($commit.sha.Substring(0,7)))"
Clear-Host
Write-Host @"
$accent
[?25l







 
                                    ██╗  ██╗ ██████╗ ███╗   ██╗     ██████╗ ███████╗
                                    ██║ ██╔╝██╔═══██╗████╗  ██║    ██╔═══██╗██╔════╝
                                    █████╔╝ ██║   ██║██╔██╗ ██║    ██║   ██║███████╗
                                    ██╔═██╗ ██║   ██║██║╚██╗██║    ██║   ██║╚════██║
                                    ██║  ██╗╚██████╔╝██║ ╚████║    ╚██████╔╝███████║
                                    ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚══════╝

                             ╔════════════════════════════════════════════════════════════╗
                             ║                        [97mBegin Setup?$accent                        ║
                             ╚════════════════════════════════════════════════════════════╝

[32m                                         ╭────────────╮[31m          ╭────────────╮
[32m                                         │   ✅ [Y]   │[31m          │   ❎ [N]   │
[32m                                         ╰────────────╯[31m          ╰────────────╯
$accent

$versionArt
"@ -NoNewLine
choice /c YN /n | Out-Null
switch ($LASTEXITCODE) {
    1 { Start-Setup }
    2 { Exit-Setup }
}

# Lotsa choices :cat_hi:
Write-Host "Would you like to create a restore point? (Y/N)"
choice /c YN /n | Out-Null
switch ($LASTEXITCODE) {
    1 { $createRP = $true }
    2 { $createRP = $false }
}

Write-Host "Would you like uninstall Microsoft Edge? (Y/N)"
choice /c YN /n | Out-Null
switch ($LASTEXITCODE) {
    1 { $RemoveEdge = $true }
    2 { $RemoveEdge = $false }
}

Write-Host "Would you like to uninstall Microsoft Store? (Y/N)"
choice /c YN /n | Out-Null
switch ($LASTEXITCODE) {
    1 { $RemoveWS = $true }
    2 { $RemoveWS = $false }
}

# create the json file
$prefs = [PSCustomObject]@{
    CreateRP   = $CreateRP
    RemoveEdge = $RemoveEdge
    RemoveWS   = $RemoveWS
}
New-Item -ItemType File "$env:systemDrive\Kon OS\config.json"
$prefs | ConvertTo-JSON | Set-Content "$env:systemDrive\Kon OS\config.json" -Encoding UTF8