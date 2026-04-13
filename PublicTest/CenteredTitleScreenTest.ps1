# ESC code
$esc = ([char]27)

$conWidth = (Get-Host).UI.RawUI.WindowSize.Width
$conHeight = (Get-Host).UI.RawUI.WindowSize.Height

# Colours
$global:White = "$($esc)[97m"
$accent = "$($esc)[38;5;99m"

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
		[ValidateSet('Black', 'DarkBlue', 'DarkGreen', 'DarkCyan', 'DarkRed', 'DarkMagenta', 'DarkYellow', 'Gray', 'DarkGray', 'Blue', 'Green', 'Cyan', 'Red', 'Magenta', 'Yellow', 'White', 'Accent')]
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
			Write-Host ("$offset" + "$fColor" + "╭" + ("─" * $innerWidth) + "╮")
			Write-Host ("$offset" + "$fColor" + "│" + (" " * $Padding) + "$Highlighter" + $Text + "$fColor" + (" " * $Padding) + "│")
			Write-Host ("$offset" + "$fColor" + "╰" + ("─" * $innerWidth) + "╯") -NoNewline:$NoNewLine
		}

		sharp {
			Write-Host ("$offset" + "$fColor" + "┌" + ("─" * $innerWidth) + "┐")
			Write-Host ("$offset" + "$fColor" + "│" + (" " * $Padding) + "$Highlighter" + $Text + "$fColor" + (" " * $Padding) + "│")
			Write-Host ("$offset" + "└" + ("─" * $innerWidth) + "┘") -NoNewline:$NoNewLine
		}

		double { 
			Write-Host ("$offset" + "$fColor" + "╔" + ("═" * $innerWidth) + "$fColor" + "╗")
			Write-Host ("$offset" + "$fColor" + "║" + (" " * $Padding) + "$Highlighter" + $Text + "$fColor" + (" " * $Padding) + "║")
			Write-Host ("$offset" + "$fColor" + "╚" + ("═" * $innerWidth) + "$fColor" + "╝") -NoNewline:$NoNewLine
		}

		none {
			Write-Host ($RawOffset + $Text) -NoNewline:$NoNewLine
		}
	}
}

$TitleIndent = [Math]::Max(0, [Math]::Floor(($conWidth - 48) / 2 - 1)) # -48 because thats how big the kon os logo is in columns
$SubtitleIndent = [Math]::Max(0, [Math]::Floor(($conWidth - 62) / 2 - 1)) # -62 because thats how big the subtitle is in columns
$ButtonIndent = [Math]::Max(0, [Math]::Floor(($conWidth - 38) / 2 - 1)) # the buttons are 38 columns wide
$LineIndent = [Math]::Max(0, [Math]::Floor(($ConHeight - 6) / 2 - 3)) # the kon os ansi logo is 6 lines tall, i dont include the others cause i want the kon os logo to be the center.
$LineIndent2 = [Math]::Max(0, [Math]::Floor((($ConHeight - $LineIndent) - 14) - 3) - 2   ) # For the version indicator, I feel like this is gonna be the hardest one

# title lines = 14

$Offset = " " * $TitleIndent
$Offset2 = " " * $SubtitleIndent
$Offset3 = " " * $ButtonIndent 
$LineOffset = "`n" * $LineIndent
$LineOffset2 = "`n" * $LineIndent2

<#
fun fact about this section: I was working on this at school and the version url wasnt working, so I was trying to figure out why and found that
for some reason my school wifi blocked githubusercontent.com, NOT github.com, only githubusercontent.com. Thanks school :)

And before anyone judges me for working on Kon OS in school, yes you're probably right I shouldn't be doing this but
I'm bored and I want to think of cool things instead.
#>
$Version = @"
{
  "Major": 1,
  "Minor": 0,
  "Patch": 0,
  "PreReleaseLabel": "Alpha"
}
"@ | ConvertFrom-Json
$Commit = Invoke-RestMethod -Uri "https://api.github.com/repos/ki8y/KonOS/commits/master"
$VerIndicator = "$($Version.Major).$($Version.Minor).$($Version.Patch) $($Version.PreReleaseLabel) ($($($commit.sha.Substring(0,7))))"

Clear-Host
Write-Host @"
$LineOffset $Accent
$offset ██╗  ██╗ ██████╗ ███╗   ██╗     ██████╗ ███████╗
$offset ██║ ██╔╝██╔═══██╗████╗  ██║    ██╔═══██╗██╔════╝
$offset █████╔╝ ██║   ██║██╔██╗ ██║    ██║   ██║███████╗
$offset ██╔═██╗ ██║   ██║██║╚██╗██║    ██║   ██║╚════██║
$offset ██║  ██╗╚██████╔╝██║ ╚████║    ╚██████╔╝███████║
$offset ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚══════╝

$offset2 ╔════════════════════════════════════════════════════════════╗
$offset2 ║                        $($esc)[97mBegin Setup?$accent                        ║
$offset2 ╚════════════════════════════════════════════════════════════╝

$offset3 $($esc)[32m╭────────────╮$($esc)[31m          ╭────────────╮
$offset3 $($esc)[32m│   ☑️ [Y]   │$($esc)[31m          │   ✖️ [N]   │
$offset3 $($esc)[32m╰────────────╯$($esc)[31m          ╰────────────╯
$($LineOffset2)
"@
Write-Box -Text "⚙️ $VerIndicator" -Border Round -Color Accent -HighlightText -Padding 2 -Indent 1 -NoNewLine 
cmd /c "pause" | Out-Null
