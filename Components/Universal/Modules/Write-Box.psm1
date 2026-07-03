function Write-Box {
    [CmdletBinding(DefaultParameterSetName = 'Indent')]
    param(
      
        [Parameter(Mandatory = $True)]
        [string]$Text,
      
        [int]$Padding = 1,
     
        [Parameter(ParameterSetName = 'Indent')]
        [int]$Indent = 0,
      
        [Parameter(ParameterSetName = 'Centered')]
        [switch]$Centered,

        [switch]$HighlightText = $false,

        [switch]$NoNewLine = $false,

        # Colours
        [ValidateSet('Accent', 'Black', 'DarkBlue', 'DarkGreen', 'DarkCyan', 'DarkRed', 'DarkMagenta', 'DarkYellow', 'Gray', 'DarkGray', 'Blue', 'Green', 'Cyan', 'Red', 'Magenta', 'Yellow', 'White', 'Accent')]
        [Alias("Colour")]
        [string]$Color = 'White',

        [string]$Border = 'Sharp'
    )

    $esc = ([char]27)

    $conWidth = (Get-Host).UI.RawUI.WindowSize.Width

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
    if ($centered) {
        # This gave me a headache
        $Indent = [Math]::Max(0, [Math]::Floor(($conWidth - ($innerwidth + 2)) / 2))
        $rawIndent = [Math]::Max(0, [Math]::Floor(($conWidth - ($Text.Length)) / 2))
    }

    $offset = " " * $Indent
    $rawOffset = " " * $RawIndent

    switch ($Border) {
        round {
            $Box = @{
                1 = ("$offset" + "$fColor" + "╭" + ("─" * $innerWidth) + "╮")
                2 = ("$offset" + "$fColor" + "│" + (" " * $Padding) + "$Highlighter" + $Text + "$fColor" + (" " * $Padding) + "│")
                3 = ("$offset" + "$fColor" + "╰" + ("─" * $innerWidth) + "╯")
            }
        }

        sharp {
            $Box = @{
                1 = ("$offset" + "$fColor" + "┌" + ("─" * $innerWidth) + "┐")
                2 = ("$offset" + "$fColor" + "│" + (" " * $Padding) + "$Highlighter" + $Text + "$fColor" + (" " * $Padding) + "│")
                3 = ("$offset" + "└" + ("─" * $innerWidth) + "┘")
            }
        }

        double { 
            $Box = @{
                1 = ("$offset" + "$fColor" + "╔" + ("═" * $innerWidth) + "$fColor" + "╗")
                2 = ("$offset" + "$fColor" + "║" + (" " * $Padding) + "$Highlighter" + $Text + "$fColor" + (" " * $Padding) + "║")
                3 = ("$offset" + "$fColor" + "╚" + ("═" * $innerWidth) + "$fColor" + "╝")
            }
        }

        none {
            $Box = ($RawOffset + $Text)
        }
    }
    Write-Host @(
        $Box.1,
        $Box.2,
        $Box.3
    ) -Separator "`n" -NoNewline:$NoNewline
}