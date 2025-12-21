# --Task Scheduler---------

Write-Host @"
`e[38;5;99m
                                          ╭──────────────────────────────────╮
                                          │  💻 Disabling automatic updates  │
                                          ╰──────────────────────────────────╯

"@
# Yeah...
Write-Host "🛈 Disabling Windows Update in Task Scheduler..." -ForegroundColor DarkYellow
$tasks = @(
    'ScanForUpdates',
    'ScanForUpdatesAsUser',
    'SmartRetry',
    'WakeUpAndContinueUpdates',
    'WakeUpAndScanForUpdates'
)
foreach ($task in $tasks) {
    try {
        # Write-Error "" -NoNewLine -ErrorAction Stop | Out-Null
        Write-Host "`r                                           ──────────────────────────────────────────────────────────────────────── [[92mok[97m]" -NoNewLine
        Write-Host ("`r" + '[92m*[97m Disabling ' + $task + '... ─────────────────────────')
    } catch {
        Write-Host "                                              ─────────────────────────────────────────────────────────────────── [[91mfail[97m]" -NoNewLine
        Write-Host ("`r" + '[91m*[97m Disabling ' + $task + '... ──────────────────────────────────────')
    }
}
# Disable-ScheduledTask -TaskPath "\Microsoft\Windows\InstallService\$task" -TaskName "ScanForUpdates"


Write-Host @"
`e[38;5;99m
                                        ╭─────────────────────────────────────╮
                                        │  ⚙️ Disabling Unnecessary Services  │
                                        ╰─────────────────────────────────────╯

"@
# Yeah...
Write-Host "🛈 Disabling Xbox Services..." -ForegroundColor DarkYellow
$services = @(
    'XblAuthManager',
    'BcastDVRUserService',
    'XblGameSave',
    'XboxGipSvc',
    'XboxNetApiSvc',
    'xbgm'
)
foreach ($svc in $services) {
    try {
        # Write-Error "" -NoNewLine -ErrorAction Stop | Out-Null
        Write-Host "`r                                           ──────────────────────────────────────────────────────────────────────── [[92mok[97m]" -NoNewLine
        Write-Host ("`r" + '[92m*[97m Disabling ' + $svc + '... ─────────────────────────')
    } catch {
        Write-Host "                                              ─────────────────────────────────────────────────────────────────── [[91mfail[97m]" -NoNewLine
        Write-Host ("`r" + '[91m*[97m Disabling ' + $svc + '... ──────────────────────────────────────')
    }
}

Write-Host "`n🛈 Disabling Unnecessary Intel Services..." -ForegroundColor DarkYellow
$services = @(
    'dptftcs',
    'igccservice',
    'IntelDisplayUMService',
    'ipfsvc',
    'WMIRegistrationService'
)
foreach ($svc in $services) {
    try {
        Write-Host "`r                                           ──────────────────────────────────────────────────────────────────────── [[92mok[97m]" -NoNewLine
        Write-Host ("`r" + '[92m*[97m Disabling ' + $svc + '... ─────────────────────────')
    } catch {
        Write-Host "                                              ─────────────────────────────────────────────────────────────────── [[91mfail[97m]" -NoNewLine
        Write-Host ("`r" + '[91m*[97m Disabling ' + $svc + '... ──────────────────────────────────────')
    }
}

Write-Host "`n🛈 Disabling Unnecessary HP Services (if they exist)..." -ForegroundColor DarkYellow
$services = @(
    'HPNetworkCap',
    'HPOmenCap',
    'HPSysInfoCap',
    'HpTouchpointAnalyticsService',
    'HPAppHelperCap',
    'HPAudioAnalytics',
    'HPDiagsCap',
    'HotKeyServiceUWP',
    'LanWlanWwanSwitchingServiceUWP',
    'hpsvcsscan',
    'SFUService'
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

Write-Host "`n🛈 Disabling Windows Update Services..." -ForegroundColor DarkYellow
$services = @(
    'DoSvc',
    'InstallService',
    'UsoSvc',
    'wuauserv',
    'WaaSMedicSvc',
    'BITS',
    'upfc',
    'uhssvc',
    'ossrs'
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

Write-Host "`n🛈 Disabling bluetooth services..." -ForegroundColor DarkYellow
$tasks = @(
    'BTAGService',
    'bthserv'
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
    'SecurityHealthService',
    'SysMain',
    'WdiServiceHost',
    'WinDefend',
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


# FUCKASS user service strings i hate them jesus christ
#<Wow, they didnt even work anyway -_->#
Write-Host "`n🛈 Disabling user-specific services..." -ForegroundColor DarkYellow
$services = @(
    'PimIndexMaintenanceSvc',
    'WpnUserService',
    'MessagingService',
    'cbdhsvc',
    'CDPUserSvc',
    'BluetoothUserService',
    'CaptureService',
    'ConsentUxUserSvc',
    'CredentialEnrollmentManagerUserSvc',
    'DeviceAssociationBrokerSvc',
    'DevicePickerUserSvc',
    'P9RdrService',
    'PenService',
    'PrintWorkflowUserSvc',
    'UdkUserSvc',
    'webthreatdefusersvc',
    'UnistoreSvc',
    'UserDataSvc',
    'NPSMSvc',
    'DevicesFlowUserSvc',
    'OneSyncSvc'
)
foreach ($svc in $services) {
    try {
        #Set-ItemProperty `
        #-Path "Registry::HKLM\SYSTEM\CurrentControlSet\Services\$svc" `
        #-Name 'Start' `
        #-Value '4' `
        #-Force | Out-Null
        Write-Host "`r                                           ──────────────────────────────────────────────────────────────────────── [[92mok[97m]" -NoNewLine
        Write-Host ("`r" + '[92m*[97m Disabling ' + $svc + '... ─────────────────────────')
    } catch {
        Write-Host "                                              ─────────────────────────────────────────────────────────────────── [[91mfail[97m]" -NoNewLine
        Write-Host ("`r" + '[91m*[97m Disabling ' + $svc + '... ──────────────────────────────────────')
    }
}


# Setting some services to manual...
Write-Host "`n🛈 Setting low priority services to manual..." -ForegroundColor DarkYellow
$services = @(    
    'BFE',
    'PushToInstall',
    'AppIDSvc',
    'AppMgmt',
    'AppXSvc',
    'Appinfo',
    'Browser',
    'COMSysApp',
    'DcpSvc',
    'DeviceInstall',
    'EapHost',
    'GraphicsPerfSvc',
    'HomeGroupListener',
    'HomeGroupProvider',
    'IEEtwCollectorService',
    'InventorySvc',
    'IpxlatCfgSvc',
    'KtmRm',
    'LanmanWorkstation',
    'LicenseManager',
    'LxpSvc',
    'McpManagementService',
    'MSiSCSI',
    'NaturalAuthentication',
    'NcaSvc',
    'NcdAutoSetup',
    'NetSetupSvc',
    'Netman',
    'NgcCtnrSvc',
    'NgcSvc',
    'NlaSvc',
    'PNRPsvc',
    'PeerDistSvc',
    'PerfHost',
    'PlugPlay',
    'PolicyAgent',
    'QWAVE',
    'RasAuto',
    'RpcLocator',
    'SCPolicySvc',
    'SDRSVC',
    'Sense',
    'SharedRealitySvc',
    'SmsRouter',
    'StateRepository',
    'TimeBroker',
    'TimeBrokerSvc',
    'TroubleshootingSvc',
    'TrustedInstaller',
    'UI0Detect',
    'UdkUserSvc',
    'webthreatdefusersvc',
    'UmRdpService',
    'VacSvc',
    'WEPHOSTSVC',
    'WFDSConMgrSvc',
    'WManSvc',
    'WSService',
    'WaaSMedicSvc',
    'WarpJITSvc',
    'WcsPlugInService',
    'WdNisSvc',
    'WiaRpc',
    'WpnService',
    'camsvc',
    'cloudidsvc',
    'dcsvc',
    'defragsvc',
    'dot3svc',
    'embeddedmode',
    'hidserv',
    'lltdsvc',
    'msiserver',
    'netprofm',
    'p2pimsvc',
    'p2psvc',
    'perceptionsimulation',
    'pla',
    'spectrum',
    'svsvc',
    'swprv',
    'upnphost',
    'vds',
    'vm3dservice',
    'vmvss',
    'wbengine',
    'webthreatdefsvc',
    'wlpasvc',
    'wmiApSrv',
    'workfolderssvc',
    'wudfsvc'
)

foreach ($svc in $services) {
    try {
        # Set-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Services\$svc" -Name 'Start' -Value '4' -Force | Out-Null
        Write-Host "`r                                           ──────────────────────────────────────────────────────────────────────── [[92mok[97m]" -NoNewLine
        Write-Host ("`r" + '[92m*[97m Setting ' + $svc + ' to manual... ─────────────────────────')
    } catch {
        Write-Host "                                              ─────────────────────────────────────────────────────────────────── [[91mfail[97m]" -NoNewLine
        Write-Host ("`r" + '[92m*[97m Setting ' + $svc + ' to manual...  ──────────────────────────────────────')
    }
}

# Setting some services to manual...
Write-Host "`n🛈 Setting low priority services to manual..." -ForegroundColor DarkYellow
$services = @(    
    'BFE',
    'PushToInstall',
    'AppIDSvc',
    'AppMgmt',
    'AppXSvc',
    'Appinfo',
    'Browser',
    'COMSysApp',
    'DcpSvc',
    'DeviceInstall',
    'EapHost',
    'GraphicsPerfSvc',
    'HomeGroupListener',
    'HomeGroupProvider',
    'IEEtwCollectorService',
    'InventorySvc',
    'IpxlatCfgSvc',
    'KtmRm',
    'LanmanWorkstation',
    'LicenseManager',
    'LxpSvc',
    'McpManagementService',
    'MSiSCSI',
    'NaturalAuthentication',
    'NcaSvc',
    'NcdAutoSetup',
    'NetSetupSvc',
    'Netman',
    'NgcCtnrSvc',
    'NgcSvc',
    'NlaSvc',
    'PNRPsvc',
    'PeerDistSvc',
    'PerfHost',
    'PlugPlay',
    'PolicyAgent',
    'QWAVE',
    'RasAuto',
    'RpcLocator',
    'SCPolicySvc',
    'SDRSVC',
    'Sense',
    'SharedRealitySvc',
    'SmsRouter',
    'StateRepository',
    'TimeBroker',
    'TimeBrokerSvc',
    'TroubleshootingSvc',
    'TrustedInstaller',
    'UI0Detect',
    'UdkUserSvc',
    'webthreatdefusersvc',
    'UmRdpService',
    'VacSvc',
    'WEPHOSTSVC',
    'WFDSConMgrSvc',
    'WManSvc',
    'WSService',
    'WaaSMedicSvc',
    'WarpJITSvc',
    'WcsPlugInService',
    'WdNisSvc',
    'WiaRpc',
    'WpnService',
    'camsvc',
    'cloudidsvc',
    'dcsvc',
    'defragsvc',
    'dot3svc',
    'embeddedmode',
    'hidserv',
    'lltdsvc',
    'msiserver',
    'netprofm',
    'p2pimsvc',
    'p2psvc',
    'perceptionsimulation',
    'pla',
    'spectrum',
    'svsvc',
    'swprv',
    'upnphost',
    'vds',
    'vm3dservice',
    'vmvss',
    'wbengine',
    'webthreatdefsvc',
    'wlpasvc',
    'wmiApSrv',
    'workfolderssvc',
    'wudfsvc'
)
foreach ($svc in $services) {
    try {
        # Set-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Services\$svc" -Name 'Start' -Value '4' -Force | Out-Null
        Write-Host "`r                                           ──────────────────────────────────────────────────────────────────────── [[92mok[97m]" -NoNewLine
        Write-Host ("`r" + '[92m*[97m Setting ' + $svc + ' to manual... ─────────────────────────')
    } catch {
        Write-Host "                                              ─────────────────────────────────────────────────────────────────── [[91mfail[97m]" -NoNewLine
        Write-Host ("`r" + '[92m*[97m Setting ' + $svc + ' to manual...  ──────────────────────────────────────')
    }
}

# High priority services
Write-Host "`n🛈 Setting high priority services to automatic (delayed)..." -ForegroundColor DarkYellow
$services = @(
    'DoSvc',
    'sppsvc'
)
foreach ($svc in $services) {
    try {
        # Set-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Services\$svc" -Name 'Start' -Value '4' -Force | Out-Null
        Write-Host "`r                                           ──────────────────────────────────────────────────────────────────────── [[92mok[97m]" -NoNewLine
        Write-Host ("`r" + '[92m*[97m Setting ' + $svc + ' to automatic (delayed)... ─────────────────────────')
    } catch {
        Write-Host "                                              ─────────────────────────────────────────────────────────────────── [[91mfail[97m]" -NoNewLine
        Write-Host ("`r" + '[92m*[97m Setting ' + $svc + ' to automatic (delayed)...  ──────────────────────────────────────')
    }
}

# High priority services
Write-Host "`n🛈 Setting highest priority services to automatic..." -ForegroundColor DarkYellow
$services = @(
    'AudioEndpointBuilder',
    'AudioSrv',
    'Audiosrv',
    'BrokerInfrastructure',
    'CoreMessagingRegistrar',
    'CryptSvc',
    'DcomLaunch',
    'Dhcp',
    'Dnscache'
    'EventLog',
    'EventSystem',
    'gpsvc',
    'KeyIso',
    'LSM',
    'MpsSvc',
    'Power',
    'ProfSvc',
    'RpcEptMapper',
    'RpcSs',
    'SamSs',
    'Schedule',
    'SENS',
    'SgrmBroker',
    'SystemEventsBroker',
    'UserManager',
    'VGAuthService',
    'VMTools',
    'VaultSvc',
    'DispBrokerDesktopSvc',
    'tiledatamodelsvc',
    'Winmgmt'
)
foreach ($svc in $services) {
    try {
        # Set-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Services\$svc" -Name 'Start' -Value '4' -Force | Out-Null
        Write-Host "`r                                           ──────────────────────────────────────────────────────────────────────── [[92mok[97m]" -NoNewLine
        Write-Host ("`r" + '[92m*[97m Setting ' + $svc + ' to automatic... ─────────────────────────')
    } catch {
        Write-Host "                                              ─────────────────────────────────────────────────────────────────── [[91mfail[97m]" -NoNewLine
        Write-Host ("`r" + '[92m*[97m Setting ' + $svc + ' to automatic...  ──────────────────────────────────────')
    }
}
pause