function Read-Choice {
    # helper function for YES/NO choices :P

    $esc = ([char]27)
    
    $konSize = (Get-Host).UI.RawUI.WindowSize # Console size (konsize lololo)
    
    # Error thing
    $ErrorMessage = "ⓧ Invalid key. Press any key to try again..."
    $padding = 2
    $InnerWidth = $ErrorMessage.Length + ($padding * 2)

    $IndentX = [Math]::Max(0, [Math]::Floor(($konSize.Width - $ErrorMessage.Length) / 2 - 1))
    $IndentY = [Math]::Max(0, [Math]::Floor(($konSize.Height - 3) / 2))

    $fColor = "$($esc)[31m"
    $highlighter = "$($esc)[97m"

    do {
        Write-Host "`r» " -ForegroundColor Blue -NoNewline; $cursorPos = [PSCustomObject]@{
            # save cursor position for error message
            "x" = [Console]::get_CursorLeft()
            "y" = [Console]::get_CursorTop()
        }

        switch (([System.Console]::ReadKey($true) | Select-Object -ExpandProperty Key)) {
            Y {
                Write-Host ("`r$($esc)[92m» " + "$($esc)[97m" + "Yes")
                return $true
                $validResponse = $true
            }
            N {
                Write-Host ("`r$($esc)[91m» " + "$($esc)[97m" + "No")
                return $false
                $validResponse = $true
            }
            default {
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
        } 
    } while (-not $validResponse)
}