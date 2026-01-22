Import-Module "$env:systemDrive\Kon OS\Modules\ColourCodes.psm1"
function Show-Throbber {
    param(
        [string]$Colour,    
        [string]$Message,
        [scriptblock]$Action
    )

    $spinnyThing = @('\','|','/','|')
    $i = 0

    $run = Start-Job -ScriptBlock $Action

    while ($run.State -eq 'Running') {
        Write-Host -NoNewline "`r$($Colour)[$($spinnyThing[$i])] $($Message)[?25l"
        Start-Sleep -Milliseconds 100
        $i = ($i + 1) % $spinnyThing.Length
    }
}