function Read-Choice {
    # helper function for YES/NO choices :P

    $esc = ([char]27)

    $validResponse = $false

    
    $konSize = (Get-Host).UI.RawUI.WindowSize # Console size (konsize lololo)
    
    # Error thing
    $ErrorMessage = "ⓧ Invalid key. Press any key to try again..."
    $padding = 2
    $InnerWidth = $ErrorMessage.Length + ($padding * 2)

    $IndentX = [Math]::Max(0, [Math]::Floor(($konSize.Width - $ErrorMessage.Length) / 2 - 1))
    $IndentY = [Math]::Max(0, [Math]::Floor(($konSize.Height - 3) / 2))

    $OffsetX = " " * $IndentX
    $OffsetY = "`n" * $IndentY

    $fColor = "$($esc)[31m"
    $highlighter = "$($esc)[97m"

    do {
        Write-Host "`r» " -ForegroundColor Blue -NoNewline; $cursorPos = (Get-Host).UI.RawUI.CursorPosition

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
                Write-Host "$ESC[H" -NoNewline
                
                Write-Host ("$($OffsetY)`n$($offsetX)" + "$fColor" + "╭" + ("─" * $innerWidth) + "╮")
                Write-Host ("$($offsetX)" + "$fColor" + "│" + (" " * $Padding) + "$Highlighter" + $ErrorMessage + "$fColor" + (" " * $Padding) + "│")
                Write-Host ("$($offsetX)" + "$fColor" + "╰" + ("─" * $innerWidth) + "╯") -NoNewline
                
                [System.Console]::ReadKey($true) | Out-Null
                Write-Host "$esc[3A"
                $clearError = " " * ($innerWidth + 2)
                Write-Host "$offsetx$clearError`n$offsetx$clearError`n$offsetx$clearError"
                Write-Host "$esc[$($cursorPos.Y);$($cursorPos.X)f"
                Write-Host "$esc[2C" -NoNewline
            }
        } 
    } while (-not $validResponse)
}