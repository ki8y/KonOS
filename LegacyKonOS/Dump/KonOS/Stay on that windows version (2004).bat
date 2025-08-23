reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /f /v TargetReleaseVersion /t REG_DWORD /d 1
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /f /v TargetReleaseVersionInfo /t REG_SZ /d 2004
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /f /v ProductVersion /t REG_SZ /d "Windows 10"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 