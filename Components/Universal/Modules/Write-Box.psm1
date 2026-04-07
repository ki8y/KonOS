function Write-Box {
    [CmdletBinding(DefaultParameterSetName='Indent')]
    param(
      
      [Parameter(Mandatory=$True)]
      [string]$Text,
      
      [int]$Padding = 1,
     
      [Parameter(ParameterSetName='Indent')]
      [int]$Indent = 0,
      
      [Parameter(ParameterSetName='Centered')]
      [switch]$Centered,

      # Colours
      [ValidateSet('Black', 'DarkBlue', 'DarkGreen', 'DarkCyan', 'DarkRed', 'DarkMagenta', 'DarkYellow', 'Gray', 'DarkGray', 'Blue', 'Green', 'Cyan', 'Red', 'Magenta', 'Yellow', 'White')]
      [Alias("Colour")]
      [string]$Color = 'White',

      [string]$Border = 'Sharp'
    )

    $conWidth = (Get-Host).UI.RawUI.WindowSize.Width

    $innerWidth = $Text.Length + ($Padding * 2)
    if ($centered) { # This gave me a headache
      $Indent = [Math]::Max(0, [Math]::Floor(($conWidth - ($innerwidth + 2)) / 2))
      $rawIndent = [Math]::Max(0, [Math]::Floor(($conWidth - ($Text.Length)) / 2))
    }

    $offset = " " * $Indent
    $rawOffset = " " * $RawIndent

    switch ($Border) {
        round {
          Write-Host ("$offset" + "╭" + ("─" * $innerWidth) + "╮") -ForegroundColor $Color
          Write-Host ("$offset" + "│" + (" " * $Padding) + $Text + (" " * $Padding) + "│") -ForegroundColor $Color
          Write-Host ("$offset" + "╰" + ("─" * $innerWidth) + "╯") -ForegroundColor $Color
        }

        sharp {
          Write-Host ("$offset" + "┌" + ("─" * $innerWidth) + "┐") -ForegroundColor $Color
          Write-Host ("$offset" + "│" + (" " * $Padding) + $Text + (" " * $Padding) + "│") -ForegroundColor $Color
          Write-Host ("$offset" + "└" + ("─" * $innerWidth) + "┘") -ForegroundColor $Color
        }

        double { 
          Write-Host ("$offset" + "╔" + ("═" * $innerWidth) + "╗") -ForegroundColor $Color
          Write-Host ("$offset" + "║" + (" " * $Padding) + $Text + (" " * $Padding) + "║") -ForegroundColor $Color
          Write-Host ("$offset" + "╚" + ("═" * $innerWidth) + "╝") -ForegroundColor $Color
        }

        none {
          Write-Host ($RawOffset + $Text) -ForegroundColor $Color
        }
    }
}