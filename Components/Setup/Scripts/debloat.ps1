$prefs = Get-Content "$env:systemDrive\Kon OS\temp\config.json" -Raw | ConvertFrom-Json

# List of app package names or names to match
$Apps = @(
    "Microsoft.549981C3F5F10",	# cortana
	"Clipchamp",
	"Microsoft.People",
    "Microsoft.Microsoft3DViewer",
    "Microsoft.Todos",
    "Microsoft.MixedReality.Portal",
    "Microsoft.Getstarted",
    "Microsoft.YourPhone",
    "Getstarted",
    "Bing",
    "Microsoft.ParentalControls",
	"Microsoft.RemoteDesktop",
    "Microsoft.BingWeather",
    "Microsoft.BingNews",
    "Microsoft.BingSearch",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.Microsoft3DViewer",
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.OneConnect",
    "Microsoft.MicrosoftStickyNotes",
    "Microsoft.AutoSuperResolution",
    "Microsoft.Messaging",
    "Microsoft.Journal",
    "Microsoft.MSPaint",
    "Microsoft.Office.OneNote",
    "Microsoft.OneConnect",
    "Microsoft.People",
    "Microsoft.SkypeApp",
    "Microsoft.Wallet",
    "Microsoft.Whiteboard",
    "Microsoft.WindowsAlarms",
    "Microsoft.WindowsCamera",
    "Microsoft.WindowsMaps",
    "Microsoft.WindowsSoundRecorder",
    "Microsoft.WindowsCalculator",
    "MicrosoftCorporationII.QuickAssist",
    "MicrosoftWindows.CrossDevice",
    "MicrosoftPCManager",
    "Microsoft.Xbox.TCUI",
    "Microsoft.XboxApp",
    "Microsoft.XboxGameOverlay",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.Xbox.GamingAI.Companion.Host"
    "Microsoft.GamingServices"
    "Microsoft.GamingApp",
    "Microsoft.YourPhone",
    "Microsoft.OneDriveSync"
    "HPAudioControl", # thx sora
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo",
    "Microsoft.WindowsCommunicationsApps",
    "Microsoft.ScreenSketch",
    "Microsoft.WindowsFeedbackHub",
	"Microsoft.Copilot",
    "Microsoft.BingFinance",
    "Microsoft.XboxLive",
    "Microsoft.Services.Store.Engagement",
    "MSTeams",
    "ArtGroup",
    "Microsoft.Ink"
)

foreach ($app in $apps) {
    $ProgressPreference = 'SilentlyContinue'
    if (Get-AppxPackage -Name "*$app*") {
        try {
            Remove-AppxPackage $($app)* -AllUsers -ErrorAction Stop
            Write-Host "`r                         ────────────────────────────────────────────────────────────────────────────────────────── [[92mok[97m]" -NoNewLine
            Write-Host ("`r[92m*[97m Removing $app... ─────────────────────────")
        } catch {
            Write-Host "                         ──────────────────────────────────────────────────────────────────────────────────────── [[91mfail[97m]" -NoNewLine
            Write-Host ("`r[91m*[97m Removing $app... ─────────────────────────")
        }
    } else {
        Write-Host "`r                         ──────────────────────────────────────────────────────────────────────────────────────── [[93mskipped[97m]" -NoNewLine
        Write-Host "`r[93m*[97m Removing $($app)... " -ForegroundColor Yellow
    }
}


# Uninstalls Microsoft Store (if u pressed yes earlier)
$apps = @(
    "Microsoft.StorePurchaseApp",
    "Microsoft.WindowsStore"
)

if ($prefs.removeWS) {
    foreach ($app in $apps) {
        $ProgressPreference = 'SilentlyContinue'
        if (Get-AppxPackage -Name "*$app*") {
            try {
                # Remove-AppxPackage $($app)* -ErrorAction Stop
                # Write-Error "hi" -ErrorAction Stop | Out-Null
                Write-Host "`r                         ────────────────────────────────────────────────────────────────────────────────────────── [[92mok[97m]" -NoNewLine
                Write-Host ("`r[92m*[97m Removing $app... ─────────────────────────")
            } catch {
                Write-Host "                         ──────────────────────────────────────────────────────────────────────────────────────── [[91mfail[97m]" -NoNewLine
                Write-Host ("`r[91m*[97m Removing $app... ─────────────────────────")
            }
        } else {
            Write-Host "`r                         ──────────────────────────────────────────────────────────────────────────────────────── [[93mskip[97m]" -NoNewLine
            Write-Host "`r[93m*[97m Removing $($app)... " -ForegroundColor Yellow
        }
    }
} else {
    Write-Host "Keeping Microsoft Store..."
}

# Uninstalls Microsoft Edge (again, if u pressed yes earlier)
$apps = @(
    "MicrosoftEdge"
)

if ($prefs.removeEdge) {
    foreach ($app in $apps) {
        if (Get-AppxPackage -Name "*$app*") {
            try {
                # Remove-AppxPackage $($app)* -ErrorAction Stop
                # Write-Error "hi" -ErrorAction Stop | Out-Null
                Write-Host "`r                         ────────────────────────────────────────────────────────────────────────────────────────── [[92mok[97m]" -NoNewLine
                Write-Host ("`r[92m*[97m Removing $app... ─────────────────────────")
            } catch {
                Write-Host "                         ──────────────────────────────────────────────────────────────────────────────────────── [[91mfail[97m]" -NoNewLine
                Write-Host ("`r[91m*[97m Removing $app... ─────────────────────────")
            }
        } else {
            Write-Host "`r                         ──────────────────────────────────────────────────────────────────────────────────────── [[93mskip[97m]" -NoNewLine
            Write-Host "`r[93m*[97m Removing $($app)... " -ForegroundColor Yellow
        }
    }
} else {
    Write-Host "Keeping Microsoft Edge..."
}