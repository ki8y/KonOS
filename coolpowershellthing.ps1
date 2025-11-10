

function Show-Spinner {
    param([scriptblock]$Action)

    $spinnything = @('⢿','⣻','⣽','⣾','⣷','⣯','⣟','⡿')
    $s = 0

    $job = Start-Job -ScriptBlock $Action

    while ($job.State -eq 'Running') {
        Write-Host -NoNewline "`r $($spinnything[$s]) Initializing...[?25l"
        Start-Sleep -Milliseconds 50
        $s = ($s + 1) % $spinnything.Length
    }

    Receive-Job $job | Out-Null
    Remove-Job $job
}

New-Item -Path "$env:SystemDrive\Kon OS\snd" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
# $setup    = "$env:SystemDrive\Kon OS\snd"
$base = "$($env:SystemDrive)\Kon OS\snd"


Show-Spinner {
    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/main/General/sounds/startup.wav" `
        -OutFile "$($using:base)\startup.wav" `
        -UseBasicParsing
    Invoke-WebRequest `
        "https://github.com/ki8y/KonOS/raw/main/General/sounds/shutdown.wav" `
        -OutFile "$($using:base)\shutdown.wav" `
        -UseBasicParsing
}

[System.Console]::SetWindowSize(120, 30)



$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host
$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "c:\Kon OS\snd\startup.wav"
$sound.Play()


Write-Host @"
[38;5;99m
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
cmd /c 'pause >nul 2>&1'
Clear-Host
Write-Host "Bye then :P"
$sound = New-Object System.Media.SoundPlayer
$sound.SoundLocation = "c:\Kon OS\snd\shutdown.wav"
$sound.PlaySync()
