$prefixes = @(
    "PimIndexMaintenanceSvc_",
    "WpnUserService_",
    "MessagingService_",
    "cbdhsvc_",
    "CDPUserSvc_",
    "BluetoothUserService_",
    "CaptureService_",
    "ConsentUxUserSvc_",
    "CredentialEnrollmentManagerUserSvc_",
    "DeviceAssociationBrokerSvc_",
    "DevicePickerUserSvc_",
    "P9RdrService_",
    "PenService_",
    "PrintWorkflowUserSvc_",
    "UdkUserSvc_",
    "webthreatdefusersvc_",
    "UnistoreSvc_",
    "UserDataSvc_",
    "NPSMSvc_",
    "DevicesFlowUserSvc_",
    "OneSyncSvc_"
)

foreach ($prefix in $prefixes) {
    $matches = Get-Service | Where-Object { $_.Name -like "$prefix*" }

    foreach ($svc in $matches) {
        try {
            Write-Host "[INFO] Disabling: $($svc.Name) ($($svc.DisplayName))" -ForegroundColor Yellow
            sc.exe stop $svc.Name
            cmd.exe /c "sc.exe config $svc.Name start= disabled"

            Write-Host "[OK] $($svc.Name) disabled successfully." -ForegroundColor Green
        } catch {
            Write-Host "[FAIL] Could not disable $($svc.Name): $_" -ForegroundColor Red
        }
    }
}