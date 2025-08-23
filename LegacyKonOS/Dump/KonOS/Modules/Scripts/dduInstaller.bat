set "file=https://github.com/ki8y/Tweaks/raw/main/GPU/DDU/DisplayDriverUninstaller.exe"
set "name=DDU.exe"
mkdir "%SYSTEMDRIVE%\Kon OS\Display Drivers\DDU"
set "location=%SYSTEMDRIVE%\Kon OS\Display Drivers\DDU"
curl -s -L "%file%" -o "%location%\%name%"
:: DDU (SETTINGS FOLDER)
mkdir "%SYSTEMDRIVE%\Kon OS\Display Drivers\DDU\Settings\AMD"
echo Settings\AMD...
mkdir "%SYSTEMDRIVE%\Kon OS\Display Drivers\DDU\Settings\INTEL"
echo Settings\INTEL...
mkdir "%SYSTEMDRIVE%\Kon OS\Display Drivers\DDU\Settings\Languages"
echo Settings\Languages...
mkdir "%SYSTEMDRIVE%\Kon OS\Display Drivers\DDU\Settings\NVIDIA"
echo Settings\NVIDIA...
mkdir "%SYSTEMDRIVE%\Kon OS\Display Drivers\DDU\Settings\REALTEK"
echo Settings\REALTEK...
:: DDU (SETTINGS\AMD)
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/AMD/classroot.cfg"
set "name=classroot.cfg"
set "location=%SYSTEMDRIVE%\Kon OS\Display Drivers\DDU\Settings\AMD"
echo AMD\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/AMD/clsidleftover.cfg"
set "name=clsidleftover.cfg"
echo AMD\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/AMD/driverfiles.cfg"
set "name=driverfiles.cfg"
echo AMD\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/AMD/interface.cfg"
set "name=interface.cfg"
echo AMD\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/AMD/services.cfg"
set "name=services.cfg"
echo AMD\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/AMD/packages.cfg"
set "name=packages.cfg"
echo AMD\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/AMD/servicesaudio.cfg"
set "name=servicesaudio.cfg"
echo AMD\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/AMD/driverfilesKMAFD.cfg"
set "name=driverfilesKMAFD.cfg"
echo AMD\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/AMD/driverfilesKMPFD.cfg"
set "name=driverfilesKMPFD.cfg"
echo AMD\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/AMD/driverfilesKMPFD.cfg.bak"
set "name=driverfilesKMPFD.cfg.bak"
echo AMD\%name%...
curl -s -L "%file%" -o "%location%\%name%"

:: DDU (Settings\INTEL)
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/INTEL/clsidleftoverigs.cfg"
set "name=clsidleftoverigs.cfg"
set "location=%SYSTEMDRIVE%\Kon OS\Display Drivers\DDU\Settings\INTEL"
echo INTEL\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/INTEL/driverfiles.cfg"
set "name=driverfiles.cfg"
echo INTEL\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/INTEL/interface.cfg"
set "name=interface.cfg"
echo INTEL\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/INTEL/packages.cfg"
set "name=packages.cfg"
echo INTEL\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/INTEL/packagesendurance.cfg"
set "name=packagesendurance.cfg"
echo INTEL\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/INTEL/packagesigs.cfg"
set "name=packagesigs.cfg"
echo INTEL\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/INTEL/packagesoneapi.cfg"
set "name=packagesoneapi.cfg"
echo INTEL\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/INTEL/services.cfg"
set "name=services.cfg"
echo INTEL\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/INTEL/servicesaudio.cfg"
set "name=servicesaudio.cfg"
echo INTEL\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/INTEL/servicesigs.cfg"
set "name=servicesigs.cfg"
echo INTEL\%name%...
curl -s -L "%file%" -o "%location%\%name%"

:: DDU (Settings\Languages)

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Arabic.xml"
set "name=Arabic.xml"
set "location=%SYSTEMDRIVE%\Kon OS\Display Drivers\DDU\Settings\Languages"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Bulgarian.xml"
set "name=Bulgarian.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Czech.xml"
set "name=Czech.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Danish.xml"
set "name=Danish.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/English.xml"
set "name=English.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Finnish.xml"
set "name=Finnish.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/French.xml"
set "name=French.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/German.xml"
set "name=German.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Greek.xml"
set "name=Greek.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Hebrew.xml"
set "name=Hebrew.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Hungarian.xml"
set "name=Hungarian.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Italian.xml"
set "name=Italian.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Japanese.xml"
set "name=Japanese.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Korean.xml"
set "name=Korean.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Latvian.xml"
set "name=Latvian.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Persian.xml"
set "name=Persian.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Polish.xml"
set "name=Polish.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Portuguese.xml"
set "name=Portuguese.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/PortugueseBrazil.xml"
set "name=PortugueseBrazil.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Russian.xml"
set "name=Russian.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Slovak.xml"
set "name=Slovak.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Slovenian.xml"
set "name=Slovenian.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Spanish.xml"
set "name=Spanish.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Swedish.xml"
set "name=Swedish.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Thai.xml"
set "name=Thai.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Turkish.xml"
set "name=Turkish.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/Languages/Ukrainian.xml"
set "name=Ukrainian.xml"
echo Languages\%name%...
curl -s -L "%file%" -o "%location%\%name%"

:: DDU (SETTINGS\NVIDIA)
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/NVIDIA/servicesaudio.cfg"
set "name=servicesaudio.cfg"
set "location=%SYSTEMDRIVE%\Kon OS\Display Drivers\DDU\Settings\NVIDIA"
echo NVIDIA\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/NVIDIA/services.cfg"
set "name=services.cfg"
echo NVIDIA\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/NVIDIA/rtxaud.cfg"
set "name=rtxaud.cfg"
echo NVIDIA\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/NVIDIA/packages.cfg"
set "name=packages.cfg"
echo NVIDIA\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/NVIDIA/nvbservice.cfg"
set "name=nvbservice.cfg"
echo NVIDIA\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/NVIDIA/nvbdriverfiles.cfg"
set "name=nvbdriverfiles.cfg"
echo NVIDIA\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/NVIDIA/interfaceGFE.cfg"
set "name=interfaceGFE.cfg"
echo NVIDIA\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/NVIDIA/interface.cfg"
set "name=interface.cfg"
echo NVIDIA\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/NVIDIA/gfedriverfiles.cfg.bak"
set "name=gfedriverfiles.cfg.bak"
echo NVIDIA\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/NVIDIA/gfedriverfiles.cfg"
set "name=gfedriverfiles.cfg"
echo NVIDIA\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/NVIDIA/driverfiles.cfg"
set "name=driverfiles.cfg"
echo NVIDIA\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/NVIDIA/clsidleftoverGFE.cfg"
set "name=clsidleftoverGFE.cfg"
echo NVIDIA\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/NVIDIA/clsidleftover.cfg"
set "name=clsidleftover.cfg"
echo NVIDIA\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/NVIDIA/classroot.cfg"
set "name=classroot.cfg"
echo NVIDIA\%name%...
curl -s -L "%file%" -o "%location%\%name%"
:: DDU (SETTINGS\REALTEK)
set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/REALTEK/packages.cfg"
set "name=packages.cfg"
set "location=%SYSTEMDRIVE%\Kon OS\Display Drivers\DDU\Settings\REALTEK"
echo REALTEK\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/REALTEK/classroot.cfg"
set "name=classroot.cfg"
echo REALTEK\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/REALTEK/clsidleftover.cfg"
set "name=clsidleftover.cfg"
echo REALTEK\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/REALTEK/driverfiles.cfg"
set "name=driverfiles.cfg"
echo REALTEK\%name%...
curl -s -L "%file%" -o "%location%\%name%"

set "file=https://raw.githubusercontent.com/ki8y/Tweaks/main/GPU/DDU/Settings/REALTEK/services.cfg"
set "name=services.cfg"
echo REALTEK\%name%...
curl -s -L "%file%" -o "%location%\%name%"