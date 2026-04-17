# Testing vertical indenting and centering
function Write-Box {
    [CmdletBinding(DefaultParameterSetName = 'Indent')]
    param(
      
        [Parameter(Mandatory = $True)]
        [string]$Text,
      
        [int]$Padding = 1,
     
        [Parameter(ParameterSetName = 'Indent')]
        [int]$IndentX = 0,

        [Parameter(ParameterSetName = 'Indent')]
        [int]$IndentY = 0,
      
        [Parameter(ParameterSetName = 'Centered')]
        [switch]$CenteredX,

        [Parameter(ParameterSetName = 'Centered')]
        [switch]$CenteredY,

        [switch]$HighlightText = $false,

        [switch]$NoNewLine = $false,

        # Colours
        [ValidateSet('Accent', 'Black', 'DarkBlue', 'DarkGreen', 'DarkCyan', 'DarkRed', 'DarkMagenta', 'DarkYellow', 'Gray', 'DarkGray', 'Blue', 'Green', 'Cyan', 'Red', 'Magenta', 'Yellow', 'White', 'Accent')]
        [Alias("Colour")]
        [string]$Color = 'White',

        [string]$Border = 'Sharp'
    )

    $esc = ([char]27)

    $konSize = (Get-Host).UI.RawUI.WindowSize

    switch ($Color) {
        Accent { $fColor = "$($esc)[38;5;99m" }
        Black { $fColor = "$($esc)[30m" }
        DarkBlue { $fColor = "$($esc)[34m" }
        DarkGreen { $fColor = "$($esc)[32m" }
        DarkCyan { $fColor = "$($esc)[36m" }
        DarkRed { $fColor = "$($esc)[31m" }
        DarkMagenta { $fColor = "$($esc)[35m" }
        DarkYellow { $fColor = "$($esc)[33m" }
        DarkGray { $fColor = "$($esc)[90m" }
        Gray { $fColor = "$($esc)[37m" }
        Blue { $fColor = "$($esc)[94m" }
        Green { $fColor = "$($esc)[92m" }
        Cyan { $fColor = "$($esc)[96m" }
        Red { $fColor = "$($esc)[91m" }
        Magenta { $fColor = "$($esc)[95m" }
        Yellow { $fColor = "$($esc)[93m" }
        White { $fColor = "$($esc)[97m" }
    }

    switch ($HighlightText) {
        true { $highlighter = "$($esc)[97m" }
        false { $highlighter = $fcolor }
    }

    $innerWidth = $Text.Length + ($Padding * 2)
    if ($centeredx) {
        # This gave me a headache
        $IndentX = [Math]::Max(0, [Math]::Floor(($konSize.Width - ($innerwidth + 2)) / 2))
        $rawIndentX = [Math]::Max(0, [Math]::Floor(($konSize.Width - ($Text.Length)) / 2))
    }
    if ($centeredy) {
        # This gave me a headache
        $IndentY = [Math]::Max(0, [Math]::Floor(($konSize.Height - 3) / 2))
        $rawIndentY = [Math]::Max(0, [Math]::Floor(($konSize.Height - 1) / 2))
    }

    $offsetX = " " * $IndentX
    $rawOffsetX = " " * $RawIndentX

    $offsetY = "`n" * $IndentY
    $rawOffsetY = "`n" * $RawIndentY

    switch ($Border) {
        round {
            Write-Host ("$($OffsetY)`n$($offsetX)" + "$fColor" + "╭" + ("─" * $innerWidth) + "╮")
            Write-Host ("$($offsetX)" + "$fColor" + "│" + (" " * $Padding) + "$Highlighter" + $Text + "$fColor" + (" " * $Padding) + "│")
            Write-Host ("$($offsetX)" + "$fColor" + "╰" + ("─" * $innerWidth) + "╯") -NoNewline:$NoNewLine
        }

        sharp {
            Write-Host ("$($OffsetY)$($offsetX)" + "$fColor" + "┌" + ("─" * $innerWidth) + "┐")
            Write-Host ("$($offsetX)" + "$fColor" + "│" + (" " * $Padding) + "$Highlighter" + $Text + "$fColor" + (" " * $Padding) + "│")
            Write-Host ("$($offsetX)" + "$fColor" + "└" + ("─" * $innerWidth) + "┘") -NoNewline:$NoNewLine
        }

        double { 
            Write-Host ("$($OffsetY)$($offsetX)" + "$fColor" + "╔" + ("═" * $innerWidth) + "$fColor" + "╗")
            Write-Host ("$($offsetX)" + "$fColor" + "║" + (" " * $Padding) + "$Highlighter" + $Text + "$fColor" + (" " * $Padding) + "║")
            Write-Host ("$($offsetX)" + "$fColor" + "╚" + ("═" * $innerWidth) + "$fColor" + "╝") -NoNewline:$NoNewLine
        }

        none {
            Write-Host ($RawOffsetY + $RawOffsetX + $Text) -NoNewline:$NoNewLine
        }
    }
}