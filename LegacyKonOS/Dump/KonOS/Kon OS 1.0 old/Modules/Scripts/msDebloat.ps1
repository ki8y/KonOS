# Remove the Taskbar pins (current user)
Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\Shell\LayoutModification.xml" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" -Force -ErrorAction SilentlyContinue
# Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Recurse -Force

# List of app package names or names to match
$appsToRemove = @(
    "Microsoft.549981C3F5F10", 	# Cortana
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
    "Microsoft.BingWeather",           # Weather
    "Microsoft.GetHelp",               # Feedback Hub
    "Microsoft.Getstarted",            # Tips
    "Microsoft.Microsoft3DViewer",     # Paint 3D
    "Microsoft.MicrosoftOfficeHub",    # Office
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.MicrosoftStickyNotes",  # Sticky Notes
    "Microsoft.MSPaint",               # Paint
    "Microsoft.Office.OneNote",        # OneNote
    "Microsoft.OneConnect",
    "Microsoft.People",                # People
    "Microsoft.SkypeApp",              # Skype
    "Microsoft.Wallet",
    "Microsoft.Whiteboard",
    "Microsoft.WindowsAlarms",         # Alarms & Clock
    "Microsoft.WindowsCamera",         # Camera
    "Microsoft.WindowsMaps",           # Maps
    "Microsoft.WindowsSoundRecorder",  # Voice Recorder
    "Microsoft.Xbox.TCUI",
    "Microsoft.XboxApp",               # Xbox
    "Microsoft.XboxGameOverlay",
    "Microsoft.XboxGamingOverlay",     # Xbox Game Bar
    "Microsoft.XboxIdentityProvider",
    "Microsoft.YourPhone",
    "HPAudioControl",
    "Microsoft.ZuneMusic",             # Groove Music
    "Microsoft.ZuneVideo",             # Films & TV
    "Microsoft.WindowsCommunicationsApps", # Mail & Calendar
    "Microsoft.ScreenSketch",          # Snip & Sketch
    "Microsoft.WindowsFeedbackHub",    # Feedback Hub (again)
    "Microsoft.BingNews", 	# News
	"Microsoft.Copilot",
    "Microsoft.BingFinance",
    "Microsoft.XboxLive",               # Xbox Live (alias/catch-all)
    "Microsoft.StorePurchaseApp",       # Store stuff
    "Microsoft.WindowsStore"            # The actual store
)

foreach ($app in $appsToRemove) {
    Write-Host "Processing $app..."

    # Remove from all user profiles (AppxPackage)
    $users = Get-ChildItem "C:\Users" -Directory | Where-Object {
        Test-Path "$($_.FullName)\AppData\Local\Packages"
    }

    foreach ($user in $users) {
        $sid = (Get-LocalUser -Name $user.Name).SID
        if ($sid) {
            Write-Host " - Removing $app for user $($user.Name)"
            Get-AppxPackage -User $user.Name | Where-Object { $_.Name -like $app } |
                Remove-AppxPackage -ErrorAction SilentlyContinue
        }
    }

    # Remove provisioned package for new users
    Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like $app } |
        Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
}

# Disable Microsoft Copilot (Windows 11+)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f

# Disable web search in Windows Search (Bing integration)
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f

# Onedrive Uninstaller
Write-Host "Uninstalling OneDrive..."
Start-Process "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" -ArgumentList "/uninstall" -Wait -NoNewWindow

Write-Host "All selected apps have been removed (or removal attempted)."

Write-Host "Disabling text input app..."
$folder = "C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy"
$backupFolder = "${folder}_DISABLED"
$exePath = "$folder\TextInputHost.exe"
$firewallRuleName = "Block TextInputHost"

Write-Host "Disabling Microsoft Text Input Application..."

# Kill process if running
Stop-Process -Name "TextInputHost" -Force -ErrorAction SilentlyContinue

# Take ownership and grant full control to admins
takeown /f "$folder" /r /d y | Out-Null
icacls "$folder" /grant administrators:F /t | Out-Null

# Rename the folder to disable the app
Rename-Item -Path "$folder" -NewName ($backupFolder -replace '.*\\', '') -Force

# Add firewall rule to block any traffic if the exe is restored
if (Test-Path "$exePath") {
    netsh advfirewall firewall add rule name="$firewallRuleName" dir=out action=block program="$exePath" enable=yes | Out-Null
}

Write-Host "Text Input App disabled." -ForegroundColor Green

