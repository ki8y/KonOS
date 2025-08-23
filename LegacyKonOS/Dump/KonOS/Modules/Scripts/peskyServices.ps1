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
    $matchthing = Get-Service | Where-Object { $_.Name -like "$prefix*" }

    foreach ($svc in $matchthing) {
        try {
            Write-Host "[INFO] Disabling: $($svc.Name) ($($svc.DisplayName))" -ForegroundColor Yellow
            cmd.exe /c "sc.exe stop $svc.Name"
            cmd.exe /c "sc.exe config $svc.Name start= disabled"
            cmd.exe /c "reg add "HKLM\SYSTEM\CurrentControlSet\Services\$svc.Name" /v Start /t REG_DWORD /d 4 /f"

            Write-Host "[OK] $($svc.Name) disabled successfully." -ForegroundColor Green
        } catch {
            Write-Host "[FAIL] Could not disable $($svc.Name): $_" -ForegroundColor Red
        }
    }
}