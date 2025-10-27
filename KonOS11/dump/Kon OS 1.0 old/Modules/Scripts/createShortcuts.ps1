$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Kon OS.lnk")
$Shortcut.TargetPath = "C:\Kon OS"
$Shortcut.WorkingDirectory = "C:\Kon OS"
$Shortcut.IconLocation = "$env:SystemRoot\System32\shell32.dll,3"
$Shortcut.Save()
