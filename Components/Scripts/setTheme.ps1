# Yes, I know PNG files are expensive storage-wise, but compression is just soooo ugly :(
Write-Host "Setting Theme..."

New-Item -ItemType Directory -Path "$env:systemDrive\Kon OS\Wallpapers\Main" -ErrorAction SilentlyContinue | Out-Null

# Some extra wallpaper settings
reg.exe add "HKCU\Control Panel\Desktop" /t REG_DWORD /v 'JPEGImportQuality' /d 100 /f | Out-Null # Disables Wallpaper Compression, even though this may not be necesarry for a png file.
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" /t REG_DWORD /v BackgroundType /d 0 /f | Out-Null # Thanks again Microsoft for adding that shitty "Spotlight" feature that nobody EVER asked for. LMFAO...
reg.exe add "HKCU\Control Panel\Desktop" /t REG_SZ /v "WallpaperStyle" /d 6 /f | Out-Null # This SHOULD set the wallpaper to "fit" mode, but with my luck who knows if it ever works properly first try.
New-Item -ItemType Directory -Path "$env:systemDrive\Kon OS\Wallpapers\Main" -Force -ErrorAction SilentlyContinue | Out-Null

# Enables auto color accents
reg.exe add "HKCU\Control Panel\Desktop" /v AutoColorization /t REG_DWORD /d 1 /f | Out-Null
reg.exe delete "HKCU\Software\Microsoft\Windows\DWM" /v AccentColor /f | Out-Null
reg.exe delete "HKCU\Software\Microsoft\Windows\DWM" /v ColorizationColor /f | Out-Null
reg.exe delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Accent" /v "AccentColor" /f | Out-Null
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /t REG_DWORD /v "ColorPrevalence" /d 1 /f | Out-Null # Disables colour on taskbar, noted this cause i cant ever remember what it does -_-

$date = (Get-Date -Format "MM")
if ($date -match "06") {
    $isPrideMonth = $true
    $fileName = "rainbow"
    Invoke-WebRequest `
        -Uri "https://github.com/ki8y/KonOS/blob/master/Components/Wallpapers/Pride/rainbow.png?raw=true" `
        -OutFile "$env:systemDrive\Kon OS\Wallpapers\Main\rainbow.png" `
        -UseBasicParsing | Out-Null
}

$secretWallpaper = (1..1000 | Get-Random)
if ($secretWallpaper -eq 1) {
    $secretWallpaper = $true
    $fileName = "funny"
    Invoke-WebRequest `
        -Uri "https://github.com/ki8y/KonOS/blob/master/Components/Wallpapers/Funny/funny.png?raw=true" `
        -OutFile "$env:systemDrive\Kon OS\Wallpapers\Main\funny.png" `
        -UseBasicParsing | Out-Null
}

if ($isPrideMonth) {}
elseif ($secretWallpaper) {}
else {
    # Dice roll to choose a wallpaper randomly, I came up with this in math class LOL
    $Colour = ("red", "orange", "yellow", "green", "cyan", "blue", "purple", "magenta", "grey" | Get-Random)
    $fileName = $Colour
    Invoke-WebRequest `
        -Uri "https://github.com/ki8y/KonOS/blob/master/Components/Wallpapers/Main/$($Colour).png?raw=true" `
        -OutFile "$env:systemDrive\Kon OS\Wallpapers\Main\$($Colour).png" `
        -UseBasicParsing | Out-Null
}

Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -PropertyType String -Name "WallPaper" -Value "$env:systemDrive\Kon OS\Wallpapers\$($fileName).png" -Force | Out-Null