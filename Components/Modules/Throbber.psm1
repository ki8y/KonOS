Import-Module "$env:systemDrive\Kon OS\Modules\ColourCodes.psm1"
function Show-Throbber {
    param(
        [Parameter(Position = 0)]
        [scriptblock]$Action,
    
        [Parameter(Position = 1)]
        [string]$Message,

        [string]$Color = "$($White)"
    )

    $spinnyThing = @('\','|','/','|')
    $i = 0

    $run = Start-Job -ScriptBlock $Action

    while ($run.State -eq 'Running') {
        Write-Host -NoNewline "`r$($Color)[$($spinnyThing[$i])] $Message[?25l"
        Start-Sleep -Milliseconds 100
        $i = ($i + 1) % $spinnyThing.Length
    }
}