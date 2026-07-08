function Show-Menu {
    param(
        [Array]$Options,
        [String]$Message = "Config"
    )
    
    $ESC = [char]27
    
    $DuplicateKeys = $Options |
        Group-Object Key |
        Where-Object Count -GT 1

    if ($DuplicateKeys) {
        Write-Error ("Duplicate option keys detected: " + $($DuplicateKeys.Name -join ', ')) -ErrorAction Stop
    }
    
    $MenuItems = [ordered]@{}
    foreach ($Option in $Options) {
        $menuItems += @{
            "$($Option.Key)" = @{
                "State" = $option.Default
                "Label" = $option.Label
                "Description" = $option.Description
            }
        }
    }

    
    $keys = [System.Collections.ArrayList]::new()
    $keys.AddRange($menuItems.Keys)

    $cursor = 0
    $running = $true

    Clear-Host
    [Console]::CursorVisible = $false # hide ugly cursor

    while ($running) {
        [Console]::SetCursorPosition(0, 0) # Move cursor to top left to redraw (i learned to not use clear-host yay)
        Write-Host "$Message (Press ENTER to select):`n" -ForegroundColor Yellow

        # draw da menu
        for ($i = 0; $i -lt $keys.Count; $i++) {
            $item = $MenuItems[$keys[$i]]

            $name = $item.Label
            $checked = if ($item.State) { "[✓]" } else { "[ ]" }
        
            # highlighter
            if ($i -eq $cursor) {
                Write-Host " » $checked $($esc)[4m$name$($esc)[24m " -BackgroundColor DarkCyan -ForegroundColor White
            }
            else {
                Write-Host "   $checked $name "
            }
        }
        
        Write-Host "   ───────────"

        if ($cursor -eq $keys.Count) {
            Write-Host " » CONFIRM " -BackgroundColor Green -ForegroundColor Black
        }
        else {
            Write-Host "   CONFIRM " -ForegroundColor Gray
        }

        # keyboard stuff
        [string]$key = ([Console]::ReadKey($true)).Key

        if ( $key -in "UpArrow", "W" ) { $cursor = if ($cursor -gt 0) { $cursor - 1 } else { $keys.Count } }

        if ( $key -in "DownArrow", "S") { $cursor = if ($cursor -lt $keys.Count) { $cursor + 1 } else { 0 } }

        if ($key -match "Enter") { 
            if ($cursor -lt $keys.Count) { 
                $menuItems[$keys[$cursor]].State = !$menuItems[$keys[$cursor]].State
            } # Toggle (If not on finish)
            elseif ($cursor -eq $keys.Count) { 
                $running = $false 
            } # If finish is highlighted, stop running
        }
    
    }

    
    [Console]::CursorVisible = $true # make cursor re appear

    Clear-Host
    $Result = [ordered]@{}

    foreach ($key in $MenuItems.Keys) {
        $result[$key] = $menuItems[$key].State
    }

    return [PSCustomObject]$Result
}

<#
$options = @(
    [PSCustomObject]@{
        "Key" = "Option1"
        "Label" = "Option 1"
        "Description" = $Null
        "Default" = $false
    }
)
#>