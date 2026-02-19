# Yes, I know PNG files are expensive storage-wise, but compression is just soooo ugly :(
Write-Host "Setting Theme..."

reg.exe add "HKCU\Control Panel\Desktop" /t REG_DWORD /v 'JPEGImportQuality' /d 100 /f | Out-Null # Disables Wallpaper Compression, even though this may not be necesarry for a png file.
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" /t REG_DWORD /v BackgroundType /d 0 /f # Thanks again Microsoft for adding that shitty "Spotlight" feature that nobody EVER asked for. LMFAO...
reg.exe add "HKCU\Control Panel\Desktop" /t REG_SZ /v "WallpaperStyle" /d 6 /f # This SHOULD set the wallpaper to "fit" mode, but with my luck who knows if it ever works properly first try.

New-Item -ItemType Directory -Path "$env:systemDrive\Kon OS\Wallpapers\Main" -Force -ErrorAction SilentlyContinue | Out-Null

# Dice roll to choose a wallpaper randomly, I came up with this in math class LOL
$Colour = ("red", "orange", "yellow", "green", "cyan", "blue", "purple", "magenta", "grey" | Get-Random)
if ($Colour -Match 'red') {
    #ABGR is hard :(
    $Alpha = FF 
    $Red = E8
    $Green = 11
    $Blue = 23
    
    Invoke-WebRequest `
        -Uri "https://github.com/ki8y/KonOS/blob/master/Components/Wallpapers/Main/red.png?raw=true" `
        -OutFile "$env:systemDrive\Kon OS\Wallpapers\Main\red.png" `
        -UseBasicParsing | Out-Null
    
    reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /t REG_DWORD /v "ColorPrevalence" /d 1 /f # Disables colour on taskbar, noted this cause i cant ever remember what it does -_-
    reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Accent" /t 
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -PropertyType String -Name "WallPaper" -Value "$env:systemDrive\Kon OS\Wallpapers" -Force | Out-Null
    Set-ItemProperty -Path "HKCU:\Control Panel\Colors" -PropertyType String -Name "WallPaper" -Value "$env:systemDrive\Kon OS\Wallpapers" -Force | Out-Null
} elseif ($Colour -Match 'orange') {

} elseif ($Colour -Match 'yellow') {
} elseif ($Colour -Match 'green') {
} elseif ($Colour -Match 'cyan') {
} elseif ($Colour -Match 'blue') {
} elseif ($Colour -Match 'purple') {
} elseif ($Colour -Match 'magenta') {
} elseif ($Colour -Match 'grey') {

}