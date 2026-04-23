# Read-Choice but instead it uses custom keybinds instead of only Y/N.
function Read-Choice {
    # Choice.exe replacement
    param( 
        [PSCustomObject]$Binds,
        [string]$Sound
    )

    $Binds | ForEach-Object { # make sure the user didnt input two buttons for a key lol
        if ($_.Length -ne 1) {
            throw "You cant do dat"
            Write-Host "$_.Exception.Message"
        }
    }

    # Error message
    function Write-ChoiceError {
        param (
            [string]$ErrorMessage
        )

        $konSize = (Get-Host).UI.RawUI.WindowSize # Console size (konsize lololo)
    
        # Error thing
        $padding = 2
        $InnerWidth = $ErrorMessage.Length + ($padding * 2)

        $IndentX = [Math]::Max(0, [Math]::Floor(($konSize.Width - $ErrorMessage.Length) / 2 - 1))
        $IndentY = [Math]::Max(0, [Math]::Floor(($konSize.Height - 3) / 2))

        $fColor = "$($esc)[31m"
        $highlighter = "$($esc)[97m"
        # error message
        Write-Host "$esc[?25l" -NoNewline # hide cursor
        [Console]::SetCursorPosition(0, 0)

        # i gotta figure out how to make this look cleaner lol
        Write-Host (([Console]::SetCursorPosition(($IndentX), ($IndentY))) + "$fColor" + "╭" + ("─" * $innerWidth) + "╮")
        Write-Host (([Console]::SetCursorPosition(($IndentX), ([Console]::get_CursorTop()))) + "$fColor" + "│" + (" " * $Padding) + "$Highlighter" + $ErrorMessage + "$fColor" + (" " * $Padding) + "│")
        Write-Host (([Console]::SetCursorPosition(($IndentX), ([Console]::get_CursorTop()))) + "$fColor" + "╰" + ("─" * $innerWidth) + "╯")
                
        [System.Console]::ReadKey($true) | Out-Null # kinda like 'cmd /c pause.exe | out-null' but it should have less overhead.
                
        $wipeError = " " * ($innerWidth + 2)
        1..3 | ForEach-Object {
            # clear the error screen
            Write-Host ([Console]::SetCursorPosition(($IndentX), ([Console]::get_CursorTop() - 1))) -NoNewline
            Write-Host "$WipeError" -NoNewline
        }

        [Console]::SetCursorPosition($($cursorPos.X), $($cursorPos.Y))
        Write-Host "$esc[?25h" -NoNewline # unhide cursor
    }

    if ($Binds -notcontains $Key) {
        Write-ChoiceError -ErrorMessage "ⓧ Invalid key. Press any key to try again..."
    }
}
