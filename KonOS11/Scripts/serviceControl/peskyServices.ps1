# Had to get chatgpt to help me with this one im ngl... -_-
{
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

    foreach ($base in $services) {
        
        $pattern = '^' + [regex]::Escape($base) + '(_[0-9a-f]+)?$'
        $matches = Get-Service | Where-Object { $_.Name -match $pattern }

        foreach ($svc in $matches) {
            try {
                Set-Service -Name $svc.Name -StartupType Disabled -ErrorAction Stop
                Write-Host ('[92m*[0m Disabling' + $svc.Name + '... --------------------------------------[[92mok[0m]')
            } catch {
                Write-Host ('[91m*[0m Disabling ' + $svc.Name + '... --------------------------------------[[91mfail[0m]')
            }
        }
    }
}
