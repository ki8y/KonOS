$env:PATH = "$PSScriptRoot\Components\Modules\PsExec;$env:PATH"
Clear-Host
Write-Host "Parent script"
Write-Host "Is Admin:" -NoNewLine
([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544' | Write-Host;
PsExec64 -accepteula -l -nobanner `
wt.exe --fullscreen sp `; @"
Write-Host `"hai`";
Write-Host `"Is Admin:`" -NoNewLine;
([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544' | Write-Host
"@
pause

# -NoProfile -ExecutionPolicy Bypass -Command 