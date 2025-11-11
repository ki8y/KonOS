$accent = '[38;5;99m'

$Host.UI.RawUI.WindowTitle = "Kon OS | Loading..."
function Show-Spinner {
    param([scriptblock]$Action)

    $spinnything = @('⢿','⣻','⣽','⣾','⣷','⣯','⣟','⡿')
    $i = 0

    $job = Start-Job -ScriptBlock $Action

    while ($job.State -eq 'Running') {
        Write-Host -NoNewline "`r$($spinnything[$i]) Initializing...[?25l"
        Start-Sleep -Milliseconds 50
        $i = ($i + 1) % $spinnything.Length
    }

    Receive-Job $job | Out-Null
    Remove-Job $job
}

New-Item -Path "$env:SystemDrive\Kon OS\snd" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
# $setup    = "$env:SystemDrive\Kon OS\snd"
$snds = "$($env:SystemDrive)\Kon OS\snd"
$ver = "$($env:SystemDrive)\Kon OS"

Show-Spinner {
    
    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/main/General/sounds/startup.wav" `
        -OutFile "$($using:snds)\startup.wav" `
        -UseBasicParsing

    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/main/General/sounds/shutdown.wav" `
        -OutFile "$($using:snds)\shutdown.wav" `
        -UseBasicParsing
        
    Invoke-WebRequest `
        "https://raw.githubusercontent.com/ki8y/KonOS/refs/heads/main/KonOS11/versionCheck.txt" `
        -OutFile "$($using:ver)\ver.txt" `
        -UseBasicParsing
}




[System.Console]::SetWindowSize(120, 30)
$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host
$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "c:\Kon OS\snd\startup.wav"
$sound.Play()

$Host.UI.RawUI.WindowTitle = "Kon OS Bootstrapper | Powershell Prototype 1"
Write-Host @"
$accent
[?25l







 
                                    ██╗  ██╗ ██████╗ ███╗   ██╗     ██████╗ ███████╗
                                    ██║ ██╔╝██╔═══██╗████╗  ██║    ██╔═══██╗██╔════╝
                                    █████╔╝ ██║   ██║██╔██╗ ██║    ██║   ██║███████╗
                                    ██╔═██╗ ██║   ██║██║╚██╗██║    ██║   ██║╚════██║
                                    ██║  ██╗╚██████╔╝██║ ╚████║    ╚██████╔╝███████║
                                    ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚══════╝

                             ╔════════════════════════════════════════════════════════════╗
                             ║                        [97mBegin Setup?[38;5;99m                        ║
                             ╚════════════════════════════════════════════════════════════╝

[32m                                         ╭────────────╮[31m          ╭────────────╮
[32m                                         │   ✅ [Y]   │[31m          │   ❎ [N]   │
[32m                                         ╰────────────╯[31m          ╰────────────╯
[38;5;99m 
"@
Write-Host "[38;5;99m"
Get-Content 'C:\Kon OS\ver.txt'
cmd /c 'pause >nul 2>&1'

function Setup {
    Write-Host "[38;5;99m 
 ╭─────────────────────────────────╮
 │  [97m💽 Downloading Kon OS Scripts[38;5;99m  │
 ╰─────────────────────────────────╯
"
pause
    exit
}
function Unsetup {
    Write-Host "Bai :("
    pause
    exit
}

choice /c YN /n
switch ($LASTEXITCODE) {
    1 { Setup }
    2 { Unsetup }
}


Clear-Host
Write-Host "Bye then :P"
$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "c:\Kon OS\snd\shutdown.wav"
$sound.PlaySync()
