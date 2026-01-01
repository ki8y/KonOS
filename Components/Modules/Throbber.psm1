function Show-Throbber {
    param(
        [string]$Message,
        [scriptblock]$Action
    )

    $spinnyThing = @('\','|','/','|')
    $i = 0

    $run = Start-Job -ScriptBlock $Action

    while ($run.State -eq 'Running') {
        Write-Host -NoNewline "`r[$($spinnyThing[$i])] $Message[?25l"
        Start-Sleep -Milliseconds 100
        $i = ($i + 1) % $spinnyThing.Length
    }
}