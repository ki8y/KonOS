$col = Get-Content "C:\Users\Wybie\Documents\GitHub\KonOSRedone\Components\Universal\Data\Colours.json" | ConvertFrom-Json
Import-Module "C:\Users\Wybie\Documents\GitHub\KonOSRedone\Components\Universal\Modules\Write-Box.psm1"


# Pull Kon OS version :P
$Commit = Invoke-RestMethod -Uri "https://api.github.com/repos/ki8y/KonOS/commits/master"
$Ver = [PSCustomObject]@{
    Major           = 1
    Minor           = 1
    Patch           = 0
    PreReleaseLabel = "Development Hell"
}
$VerString = "$($Ver.Major).$($Ver.Minor).$($Ver.Patch) $($Ver.PreReleaseLabel) ($($commit.sha.Substring(0,7)))"


# Kon OS Title Screen.
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 # enable utf8 stuff
function Write-Title {
    $ConsoleSize = $Host.UI.RawUI.WindowSize

    $X = [Math]::Max(0, [Math]::Floor(($consoleSize.Width - 62) / 2))
    $Y = [Math]::Max(0, [Math]::Floor(($consoleSize.Height - 6) / 2 - 3))
    $Y2 = [Math]::Max(0, [Math]::Floor(($consoleSize.Height - $Y) - 14) - 4)
    $XOffset = " " * $X
    $YOffset = "`n" * $Y
    $YOffset2 = "`n" * $Y2

    $Title = @"
$($YOffset)$($col.Text.Accent)
$XOffset       ██╗  ██╗ ██████╗ ███╗   ██╗     ██████╗ ███████╗
$XOffset       ██║ ██╔╝██╔═══██╗████╗  ██║    ██╔═══██╗██╔════╝
$XOffset       █████╔╝ ██║   ██║██╔██╗ ██║    ██║   ██║███████╗
$XOffset       ██╔═██╗ ██║   ██║██║╚██╗██║    ██║   ██║╚════██║
$XOffset       ██║  ██╗╚██████╔╝██║ ╚████║    ╚██████╔╝███████║
$XOffset       ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚══════╝

$XOffset╔════════════════════════════════════════════════════════════╗
$XOffset║              $($col.Text.White)I gave up on fixing the flicker$($col.Text.Accent)               ║
$XOffset╚════════════════════════════════════════════════════════════╝

$XOffset            $($col.Text.Green)╭────────────╮          $($col.Text.Red)╭────────────╮
$XOffset            $($col.Text.Green)│   ☑️ [Y]   │          $($col.Text.Red)│   ✖️ [N]   │
$XOffset            $($col.Text.Green)╰────────────╯          $($col.Text.Red)╰────────────╯$($Col.Text.White)
$($YOffset2)
"@
    [Console]::Write($Title)
    Write-Box -Text "⚙️ $VerString" -Border Round -Color Accent -HighlightText -Padding 2 -Indent 0 -NoNewLine
}

# Initialize title screen :D
[Console]::CursorVisible = $false
Clear-Host
$bootSnd.Play()
:TitleLoop while ($true) {
    $ConsoleSize = $Host.UI.RawUI.WindowSize
    $X = [Math]::Max(0, [Math]::Floor(($consoleSize.Width - 33) / 2 - 1))
    $Y = [Math]::Max(0, [Math]::Floor(($consoleSize.Height - 1) / 2 - 1))
    $XOffset = " " * $X
    $YOffset = "`n" * $Y

    if ($ConsoleSize.Width -ne $oldSize.Width -or $ConsoleSize.Height -ne $oldSize.Height) {

        [Console]::Clear()
        Write-Title
        $oldSize = $ConsoleSize
    
    }
    if ([Console]::KeyAvailable) {
        $Key = [Console]::ReadKey($true)

        switch ($Key.Key) {

            'Y' {
                break TitleLoop
            }

            'N' {
                break TitleLoop
            }
        }
    }

    Start-Sleep -Milliseconds 16
}
Write-Host "`nTitle loop broken!"
[Console]::CursorVisible = $true