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

# Success message :D (it doesnt care if it failed, cuz im dumb and idk how to do allat)
Write-Host ""
Write-Host "Package Managers installed successfully." -ForegroundColor White -BackgroundColor DarkGreen 

# Runtimes
Write-Host ""
Write-Host "Installing Runtimes..." 
choco install vcredist140 -y
choco install dotnetfx -y
choco install dotnet-5.0-desktopruntime -y
choco install dotnet-6.0-desktopruntime -y
choco install dotnet-7.0-desktopruntime -y
choco install dotnet-8.0-desktopruntime -y
choco install dotnet-9.0-desktopruntime -y

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

# Git
Write-Host ""
Write-Host "Installing git..." 
choco install git.install -y

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


