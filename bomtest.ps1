$host.UI.RawUI.WindowSize  = New-Object System.Management.Automation.Host.Size(120,30)
Start-Sleep -Milliseconds 15 # sometimes powershell bugs out and i get an error and idk why but i hope this fixes it
$host.UI.RawUI.BufferSize  = New-Object System.Management.Automation.Host.Size(120,3000)

$accent = '[38;5;99m'
$white = '[97m'

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
$Host.UI.RawUI.WindowTitle = "Kon OS UTF-8 PowerShell 5.1 Test"

# version string indicator thingy
$commit = Invoke-RestMethod -Uri "https://api.github.com/repos/ki8y/KonOS/commits/master"
$version = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/ki8y/KonOS/master/version.txt"
$content = "   │  ⚙️ $($White)$($version.Substring(0,12)) ($($commit.sha.Substring(0,7)))  $accent│"
$DisplayVersion = @"
[38;5;99m   ╭─────────────────────────────╮
$content
[38;5;99m   ╰─────────────────────────────╯
"@

Clear-Host

function Start-Test {

Write-Host "`n🛈 Disabling General Unnecessary Services..." -ForegroundColor DarkYellow
$services = @(
    'PimIndexMaintenanceSvc',
    'WinHttpAutoProxySvc',
    'wlidsvc',
    'wcncsvc',
    'DisplayEnhancementService',
    'DiagTrack',
    'DusmSvc',
    'TabletInputService',
    'Fax',
    'lfsvc'
    'AJRouter',
    'ALG',
    'Netlogon',
    'CertPropSvc',
    'Themes',
    'DPS',
    'AssignedAccessManagerSvc',
    'DialogBlockingService',
    'NetTcpPortSharing',
    'UevAgentService',
    'WSearch',
    'VSS',
    'MapsBroker',
    'shpamsvc',
    'ssh-agent',
    'tzautoupdate',
    'MSDTC',
    'SysMain',
    'WdiServiceHost',
    'seclogon',
    'wscsvc',
    'wisvc',
    'StorSvc',
    'NcbService',
    'WdiSystemHost',
    'AppReadiness',
    'PNRPAutoReg',
    'SCardSvr',
    'CscService',
    'WalletService',
    'icssvc',
    'fhsvc',
    'FrameServer',
    'FrameServerMonitor',
    'EntAppSvc',
    'DmEnrollmentSvc',,
    'AxInstSV',
    'DeviceAssociationService',
    'TieringEngineService',
    'TextInputManagementService',
    'CDPSvc',
    'DevQueryBroker',
    'EFS',
    'FDResPub',
    'HvHost',
    'vmicguestinterface',
    'vmicheartbeat',
    'vmickvpexchange',
    'vmicrdv',
    'vmicshutdown',
    'vmictimesync',
    'vmicvmsession',
    'vmicvss',
    'IKEEXT',
    'MixedRealityOpenXRSvc',
    'MsKeyboardFilter',
    'RasMan',
    'SensorDataService',
    'SensorService',
    'SensrSvc',
    'SessionEnv',
    'SharedAccess',
    'StiSvc',
    'TokenBroker',
    'W32Time',
    'WebClient',
    'Wecsvc',
    'dmwappushservice',
    'fdPHost',
    'smphost',
    'wercplsupport',
    'FontCache',
    'LanmanServer',
    'ShellHWDetection',
    'TermService',
    'Wcmsvc',
    'cbdhsvc',
    'WpcMonSvc',
    'MicrosoftEdgeElevationService',
    'edgeupdate',
    'edgeupdatem',
    'autotimesvc',
    'diagnosticshub.standardcollector.service',
    'PhoneSvc',
    'TapiSrv',
    'WbioSrvc',
    'SEMgrSvc',
    'iphlpsvc',
    'BthAvctpSvc',
    'BDESVC',
    'CDPUserSvc',
    'DevicesFlowUserSvc',
    'TrkWks',
    'dLauncherLoopback',
    'NPSMSvc',
    'WPDBusEnum',
    'PcaSvc',
    'RetailDemo',
    'SSDPSRV',
    'OneSyncSvc',
    'UserDataSvc',
    'UnistoreSvc',
    'DsSvc',
    'AppVClient',
    'SstpSvc',
    'WMPNetworkSvc',
    'WerSvc',
    'DsmSvc',
    'ClipSVC'
)
foreach ($svc in $services) {
    try {
        # Get-Service $svc -ErrorAction SkipHP
        Write-Host "`r                                           ──────────────────────────────────────────────────────────────────────── [[92mok[97m]" -NoNewLine
        Write-Host ("`r" + '[92m*[97m Disabling ' + $svc + '... ─────────────────────────')
    } catch {
        Write-Host "                                              ─────────────────────────────────────────────────────────────────── [[91mfail[97m]" -NoNewLine
        Write-Host ("`r" + '[91m*[97m Disabling ' + $svc + '... ──────────────────────────────────────')
    }
}
Write-Host "`n`nService Control dialogue test finished. `nPress any key to exit..."
cmd /c "pause >nul"
}

function Exit-Test {
    Write-Host "Exiting Kon OS UTF-8 test... cya later :)"
    Start-Sleep 3
}

Write-Host @"
$accent
[?25l


                   [33m⚠️ This is a test version of Kon OS that makes no modifications to your system. ⚠️
                                   ⚠️ Pressing Y will show you more test screens. ⚠️$accent



 
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
"@
Write-Host "$displayVersion"
choice /c YN /n | Out-Null
switch ($LASTEXITCODE) {
    1 { Start-Test }
    2 { Exit-Test }
}

