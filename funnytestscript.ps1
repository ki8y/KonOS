$env:PATH = "$PSScriptRoot\Components\Modules\PsExec;$env:PATH"
#Clear-Host

# parent script
Write-Host "Parent script"
Write-Host "Is Admin:" -NoNewLine; ([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544' | Write-Host

# child script
PsExec64 -accepteula -l -nobanner wt.exe --fullscreen Powershell -Command "Invoke-Expression ((Invoke-RestMethod https://raw.githubusercontent.com/ki8y/KonOS/master/Bootstrapper.ps1).TrimStart([char]0xFEFF))"

pause

# -NoProfile -ExecutionPolicy Bypass -Command 
Write-Host `"Is Admin:`" -NoNewLine
([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -contains 'S-1-5-32-544' | Write-Host