chcp 65001 >nul
cls
echo. ╭──────────────────────────────────╮
echo. │  🔁 Disabling automatic updates  │
echo. ╰──────────────────────────────────╯
echo.
echo 🛈 Telling Windows Update to wait before offering updates...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpdatePeriod" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpgrade" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpgradePeriod" /t REG_DWORD /d "1" /f >nul 2>&1
echo 🛈 Disabling access to Windows Update via settings or control panel...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d "1" /f >nul 2>&1
echo [92m✅ Done.[0m


:: --Task Scheduler---------
cls
echo. ╭──────────────────────────────────╮
echo. │  💻 Disabling unnecessary tasks  │
echo. ╰──────────────────────────────────╯
echo.
echo 🛈 Stopping automatic updates via task scheduler...
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdates" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\SmartRetry" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndContinueUpdates" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndScanForUpdates" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Report policies" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WaaSMedic\PerformRemediation" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Scheduled Start" /Disable >nul 2>&1
schtasks /DELETE /TN "Microsoft\Windows\WindowsUpdate\" >nul 2>&1
schtasks /DELETE /TN "Microsoft\Windows\InstallService\" >nul 2>&1
schtasks /DELETE /TN "Microsoft\Windows\UpdateOrchestrator" >nul 2>&1

echo 🛈 Disabling telemetry tasks...
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable >nul 2>&1 
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Task Manager\Interactive" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\DiskFootprint\StorageSense" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\DUSM\dusmtask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Flighting\OneSettings\RefreshCache" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Input\LocalUserSyncDataAvailable" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Input\MouseSyncDataAvailable" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Input\PenSyncDataAvailable" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Input\TouchpadSyncDataAvailable" /Disable >nul 2>&1

echo 🛈 Disabling unnecessary application experience tasks...
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner" /Disable >nul 2>&1

echo 🛈 Disabling automatic maintenance tasks...
schtasks /Change /TN "Microsoft\Windows\Defrag\ScheduledDefrag" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\DiskCleanup\SilentCleanup" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Servicing\StartComponentCleanup" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Time Zone\SynchronizeTimeZone" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WDI\ResolutionHost" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Diagnosis\Scheduled" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Setup\SnapshotCleanupTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Setup\SetupCleanupTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Storage Tiers Management\Storage Tiers Management Initialization" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Work Folders\Work Folders Maintenance Work" /Disable >nul 2>&1

echo 🛈 Disabling unnecessary device tasks...
schtasks /Change /TN "Microsoft\Windows\Device Information\Device" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Device Information\Device User" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\EnterpriseMgmt\MDMMaintenenceTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Ras\MobilityManager" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WwanSvc\NotificationTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WwanSvc\OobeDiscovery" /Disable >nul 2>&1

echo 🛈 Disabling unnecessary network tasks...
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\PushToInstall\Registration" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UPnP\UPnPHostConfig" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\SettingSync\NetworkStateChangeTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\SettingSync\NetworkStateChangeTask" /Disable >nul 2>&1

echo 🛈 Disabling international language tasks...
schtasks /Change /TN "Microsoft\Windows\International\Synchronize Language Settings" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\Installation" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Maps\MapsToastTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\MUI\LPRemove" /Disable >nul 2>&1

echo 🛈 Disabling licensing tasks...
schtasks /Change /TN "Microsoft\Windows\License Manager\TempSignedLicenseExchange" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\TPM\Tpm-HASCertRetr" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\TPM\Tpm-Maintenance" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\RecoveryEnvironment\VerifyWinRE" /Disable >nul 2>&1

echo 🛈 Disabling profile tasks...
schtasks /Change /TN "Microsoft\Windows\User Profile Service\HiveUploadTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Work Folders\Work Folders Logon Synchronization" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Workplace Join\Automatic-Device-Join" /Disable >nul 2>&1

echo 🛈 Disabling power saving tasks...
schtasks /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Sysmain\ResPriStaticDbSync" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Sysmain\WsSwapAssessmentTask" /Disable >nul 2>&1

echo 🛈 Disabling Windows Filtering tasks...
schtasks /Change /TN "Microsoft\Windows\Windows Filtering Platform\BfeOnServiceStartTypeChange" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WOF\WIM-Hash-Management" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WOF\WIM-Hash-Validation" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\SpacePort\SpaceAgentTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\SpacePort\SpaceManagerTask" /Disable >nul 2>&1

echo 🛈 Disabling Xbox tasks...
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /Disable >nul 2>&1

echo 🛈 Disabling remote tasks...
schtasks /Change /TN "Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /Disable >nul 2>&1

echo 🛈 Disabling printer tasks...
schtasks /Change /TN "Microsoft\Windows\Printing\EduPrintProv" /Disable
schtasks /Change /TN "Microsoft\Windows\Printing\PrinterCleanupTask" /Disable

echo 🛈 Disabling extra tasks...
schtasks /Change /TN "Microsoft\Windows\RetailDemo\CleanupOfflineContent" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Speech\SpeechModelDownloadTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Management\Provisioning\Cellular" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\Management\Provisioning\Logon" /Disable >nul 2>&1

echo 🛈 Deleting useless tasks...
schtasks /DELETE /TN "AMDInstallLauncher" /f >nul 2>&1
schtasks /DELETE /TN "AMDLinkUpdate" /f >nul 2>&1
schtasks /DELETE /TN "AMDRyzenMasterSDKTask" /f >nul 2>&1
schtasks /DELETE /TN "Driver Easy Scheduled Scan" /f >nul 2>&1
schtasks /DELETE /TN "ModifyLinkUpdate" /f >nul 2>&1
schtasks /DELETE /TN "SoftMakerUpdater" /f >nul 2>&1
schtasks /DELETE /TN "StartCN" /f >nul 2>&1
schtasks /DELETE /TN "StartDVR" /f >nul 2>&1
echo [92m✅ Done.[0m

:: --Services---------------
cls
echo. ╭─────────────────────────────────────╮
echo. │  ⚙️ Disabling unnecessary services  │
echo. ╰─────────────────────────────────────╯
echo.
echo Disabling Xbox Services...
for %%D in (
    PimIndexMaintenanceSvc
    WinHttpAutoProxySvc
    BcastDVRUserService
    xbgm
) do (
    echo 🛈 Setting %%D to disabled...
    sc stop %%D >nul 2>&1
    sc config %%D start= disabled >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%D" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

echo.
echo Disabling Intel Bloatware...
for %%D in (
    dptftcs
    igccservice
    IntelDisplayUMService
    ipfsvc
    WMIRegistrationService
) do (
    echo 🛈 Setting %%D to disabled...
    sc stop %%D >nul 2>&1
    sc config %%D start= disabled >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%D" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

echo.
echo Disabling HP Bloatware...
for %%D in (
    HPNetworkCap
    HPOmenCap
    HPSysInfoCap
    HpTouchpointAnalyticsService
    HPAppHelperCap
    HPAudioAnalytics
    HPDiagsCap
    HotKeyServiceUWP
    LanWlanWwanSwitchingServiceUWP
    hpsvcsscan
    SFUService
) do (
    echo 🛈 Setting %%D to disabled...
    sc stop %%D >nul 2>&1
    sc config %%D start= disabled >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%D" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

echo.
echo Disabling automatic updates...
for %%D in (
    DoSvc
    InstallService
    UsoSvc
    wuauserv
    WaaSMedicSvc
    BITS
    upfc
    uhssvc
    ossrs
) do (
    echo 🛈 Setting %%D to disabled...
    sc stop %%D >nul 2>&1
    sc config %%D start= disabled >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%D" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

for %%D in (
    BcastDVRUserService
    wlidsvc   
    wcncsvc
    DisplayEnhancementService 
    DiagTrack 
    DusmSvc 
    TabletInputService 
    Fax 
    lfsvc 
    AJRouter
    ALG
    Netlogon
    CertPropSvc
    Themes
    DPS
    AssignedAccessManagerSvc
    DialogBlockingService
    NetTcpPortSharing
    PimIndexMaintenanceSvc
    UevAgentService
    WSearch
    VSS
    MapsBroker
    shpamsvc
    ssh-agent
    tzautoupdate
    MSDTC
    SecurityHealthService
    SysMain
    WdiServiceHost
    WinDefend
    seclogon
    wscsvc
    wisvc
    StorSvc
    NcbService
    WdiSystemHost
    AppReadiness
    XblAuthManager
    PNRPAutoReg
    XblGameSave
    XboxGipSvc
    XboxNetApiSvc
    SCardSvr
    CscService
    WalletService
    icssvc
    fhsvc
    FrameServer
    FrameServerMonitor
    EntAppSvc
    DmEnrollmentSvc
    AxInstSV
    DeviceAssociationService
    TieringEngineService
    TextInputManagementService
    CDPSvc
    DevQueryBroker
    EFS
    FDResPub
    HvHost
    vmicguestinterface
    vmicheartbeat
    vmickvpexchange
    vmicrdv
    vmicshutdown
    vmictimesync
    vmicvmsession
    vmicvss
    IKEEXT
    InstallService
    MixedRealityOpenXRSvc
    MsKeyboardFilter
    RasMan
    SensorDataService
    SensorService
    SensrSvc
    SessionEnv
    SharedAccess
    StiSvc
    TokenBroker
    W32Time
    WebClient
    Wecsvc
    autotimesvc
    dmwappushservice
    edgeupdate
    edgeupdatem
    fdPHost
    smphost
    wercplsupport
    DispBrokerDesktopSvc
    FontCache
    LanmanServer
    ShellHWDetection
    TermService
    Wcmsvc
    cbdhsvc 
    WpcMonSvc 
    MicrosoftEdgeElevationService 
    edgeupdate 
    edgeupdatem 
    autotimesvc
    diagnosticshub.standardcollector.service 
    PhoneSvc 
    TapiSrv 
    WbioSrvc 
    SEMgrSvc 
    iphlpsvc 
    BthAvctpSvc 
    BDESVC 
    CDPUserSvc 
    DevicesFlowUserSvc 
    TrkWks 
    dLauncherLoopback 
    NPSMSvc 
    WPDBusEnum 
    PcaSvc 
    RetailDemo
    SSDPSRV 
    OneSyncSvc 
    UserDataSvc 
    UnistoreSvc 
    DsSvc 
    AppVClient 
    SstpSvc 
    WMPNetworkSvc 
    WerSvc  
    WinHttpAutoProxySvc 
    DsmSvc 
    ClipSVC
) do (
    echo 🛈 Setting %%D to disabled...
    sc stop %%D >nul 2>&1
    sc config %%D start= disabled >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%D" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

for %%M in (
    BFE
    PushToInstall
    AppIDSvc
    AppMgmt
    AppXSvc
    Appinfo
    Browser
    COMSysApp
    DcpSvc
    DeviceInstall
    EapHost
    GraphicsPerfSvc
    HomeGroupListener
    HomeGroupProvider
    IEEtwCollectorService
    InventorySvc
    IpxlatCfgSvc
    KtmRm
    LanmanWorkstation
    LicenseManager
    LxpSvc
    McpManagementService
    MSiSCSI 
    NaturalAuthentication
    NcaSvc
    NcdAutoSetup
    NetSetupSvc
    Netman
    NgcCtnrSvc
    NgcSvc
    NlaSvc
    PNRPsvc 
    PeerDistSvc
    PerfHost
    PlugPlay
    PolicyAgent
    QWAVE
    RasAuto
    RpcLocator
    SCPolicySvc
    SDRSVC
    Sense
    SharedRealitySvc
    SmsRouter
    StateRepository
    TimeBroker
    TimeBrokerSvc
    TroubleshootingSvc
    TrustedInstaller
    UI0Detect
    UdkUserSvc
    webthreatdefusersvc
    UmRdpService
    VacSvc  
    WEPHOSTSVC
    WFDSConMgrSvc
    WManSvc
    WSService   
    WaaSMedicSvc
    WarpJITSvc  
    WcsPlugInService
    WdNisSvc
    WiaRpc
    WpnService
    camsvc
    cloudidsvc
    dcsvc
    defragsvc
    dot3svc
    embeddedmode
    hidserv
    lltdsvc
    msiserver
    netprofm
    p2pimsvc
    p2psvc
    perceptionsimulation
    pla
    spectrum
    svsvc
    swprv
    upnphost
    vds
    vm3dservice
    vmvss
    wbengine
    webthreatdefsvc
    wlpasvc
    wmiApSrv
    workfolderssvc
    wudfsvc
) do (
    echo 🛈 Setting %%M to manual...
    sc config %%M start= demand >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%M" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
)

for %%Q in (
    DoSvc
    sppsvc
) do (
    echo 🛈 Setting %%M to automatic ^(delayed^)...
    sc config %%Q start= delayed-auto >nul 2>&1
)

for %%A in (
    AudioEndpointBuilder
    AudioSrv
    Audiosrv
    BrokerInfrastructure
    CoreMessagingRegistrar
    CryptSvc
    DcomLaunch
    Dhcp
    Dnscache
    EventLog
    EventSystem
    gpsvc
    KeyIso
    LSM
    MpsSvc
    Power
    ProfSvc
    RpcEptMapper
    RpcSs
    SamSs
    Schedule
    SENS
    SgrmBroker
    SystemEventsBroker
    UserManager
    VGAuthService
    VMTools
    VaultSvc
    tiledatamodelsvc
    Winmgmt
) do (
    echo 🛈 Setting %%A to automatic...
    sc config %%A start= auto >nul 2>&1
)

echo.
echo Disabling bluetooth...
for %%D in (
    BTAGService
    bthserv
) do (
    echo 🛈 Setting %%D to disabled...
    sc stop %%D >nul 2>&1
    sc config %%D start= disabled >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%D" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

echo.
echo Disabling remote services...
for %%D in (
    RemoteRegistry
    RemoteAccess
    WinRM
    RmSvc
) do (
    echo 🛈 Setting %%D to disabled...
    sc stop %%D >nul 2>&1
    sc config %%D start= disabled >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%D" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

echo.
echo Disabling printer services...
for %%D in (
    PrintNotify
    Spooler
) do (
    echo 🛈 Setting %%D to disabled...
    sc stop %%D >nul 2>&1
    sc config %%D start= disabled >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%D" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)
echo.
echo Disabling Security Health Service...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

:: for those fuckass per user services, praying this works :/
PowerShell -ExecutionPolicy Unrestricted -NoProfile -File "C:\Kon OS\Setup\Service Control\peskyServices.ps1"
echo [92m✅ Done.[0m