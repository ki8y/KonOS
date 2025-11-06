echo. ╭────────────────────────╮
echo. │ 🗑️ Debloating Windows  │
echo. ╰────────────────────────╯
echo.

:: --Edge Remover-------------
echo                     ├────────────────────────── Removing Microsoft Edge ──────────────────────────┤
  echo.
  echo 🛈 Killing Edge processes...
  taskkill /f /im msedge.exe >nul 2>&1
  taskkill /f /im msedgewebview2.exe >nul 2>&1
  🛈 Deleting Edge Scheduled Tasks...
  schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineCore" /f >nul 2>&1
  schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineUA" /f >nul 2>&1
  echo 🛈 Erasing Edge directories...
  rd /s /q "C:\Program Files (x86)\Microsoft\Edge" >nul 2>&1
  rd /s /q "C:\Program Files (x86)\Microsoft\EdgeCore" >nul 2>&1
  rd /s /q "C:\Program Files (x86)\Microsoft\EdgeUpdate" >nul 2>&1
  rd /s /q "C:\Program Files (x86)\Microsoft\EdgeWebView" >nul 2>&1
  rd /s /q "C:\Program Files (x86)\Microsoft\Temp" >nul 2>&1
  🛈 Erasing Edge shortcuts..
  del "C:\Users\Public\Desktop\Microsoft Edge.lnk" /f >nul 2>&1
  for /d %%U in ("%SystemDrive%\Users\*") do (
    del "%%U\Desktop\Microsoft Edge.lnk" /f >nul 2>&1
    del "%%U\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk" /f >nul 2>&1
  )
  echo 🛈 Blocking EdgeUpdate via firewall to prevent reinstallation...
  netsh advfirewall firewall add rule name="Block_EdgeUpdate" dir=out action=block program="C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" enable=yes >nul 2>&1
  netsh advfirewall firewall add rule name="Block_EdgeUpdate_Inbound" dir=in action=block program="C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" enable=yes >nul 2>&1
  echo 🛈 Blocking msedge.exe via firewall to prevent reinstallation...
  netsh advfirewall firewall add rule name="Block_msedge" dir=out action=block program="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" enable=yes >nul 2>&1
  netsh advfirewall firewall add rule name="Block_msedge_Inbound" dir=in action=block program="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" enable=yes >nul 2>&1
echo [92m✅ Done.[0m

:: --Smartscreen Remover-----------
echo.
echo                     ├─────────────────────── Removing Defender Smartscreen ───────────────────────┤
echo.
set "smartscreen1=C:\Windows\System32\smartscreen.exe"
set "smartscreen2=C:\Windows\SystemApps\Microsoft.Windows.AppRep.ChxApp_cw5n1h2txyewy\CHXSmartScreen.exe"
if exist "%smartscreen1%" (
    takeown /F "%smartscreen1%" >nul 2>&1
    icacls "%smartscreen1%" /grant administrators:F >nul 2>&1
    echo Removing Smartscreen [Phase 1]
    taskkill /f /im smartscreen.exe
    del "%smartscreen1%" /f /q

    chcp 65001 >nul
    echo [92m✓ Done.
chcp 437 >nul
) else (
    echo File not found: %smartscreen1%. Is it already deleted?
)
if exist "%smartscreen2%" (
    takeown /F "%smartscreen2%" >nul 2>&1
    icacls "%smartscreen2%" /grant administrators:F >nul 2>&1
    echo Removing Smartscreen [Phase 2]
    taskkill /f /im CHXSmartScreen.exe
    del "%smartscreen2%" /f /q
    chcp 65001 >nul
    echo [92m✓ Done.
chcp 437 >nul
) else (
    echo File not found: %smartscreen2%. Is it already deleted?
)
