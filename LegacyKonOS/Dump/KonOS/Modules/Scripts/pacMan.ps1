# Scuffed code to install package managers and a few other stuff

# Scoop
Write-Host ""
Write-Host "Installing Scoop..."
Write-Host ""
iex "& {$(irm get.scoop.sh)} -RunAsAdmin"


# Chocolatey
Write-Host ""
Write-Host "Installing Chocolatey..."
Write-Host ""
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Git (for buckets mostly, but generally helpful)
scoop install git

# Runtimes
Write-Host ""
Write-Host "Installing Runtimes..." 
scoop bucket add extras
scoop install extras/vcredist-aio
scoop install extras/windowsdesktop-runtime
scoop install versions/windowsdesktop-runtime-6.0
scoop install versions/windowsdesktop-runtime-7.0


# 7zip
Write-Host ""
Write-Host "Installing 7-Zip..." 
choco install 7zip.install -y

# VLC
Write-Host ""
Write-Host "Installing VLC..." 
choco install vlc -y

# Notepad ++ (Removed because some people prefer other things, but I might bring it back in the future)
# Write-Host ""
# Write-Host "Installing Notepad++..." 
# choco install notepadplusplus.install


# FastFetch (maximum nerd stuff)
Write-Host ""
Write-Host "Installing FastFetch..." 
scoop bucket add main
scoop install main/fastfetch

# Windows Terminal
Write-Host ""
Write-Host "Installing Terminal..." 
scoop bucket add extras
scoop install extras/windows-terminal


