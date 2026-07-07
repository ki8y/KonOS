# Reusable variables throughout the  script

# Kon OS path
$global:KonOS = "$env:systemDrive\Kon OS"

$esc = [char]27 # ESC code

# Colours
$global:White = "$($esc)[97m"
$global:accent = "$($esc)[38;5;99m"

# Console window size (cells)
$global:conSize = (Get-Host).UI.RawUI.WindowSize
