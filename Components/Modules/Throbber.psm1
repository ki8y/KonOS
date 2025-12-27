function Show-Throbber {
    param(
        [string]$Message,
        [scriptblock]$Action
    )

    $spinnything = @('\','|','/','|')
    $i = 0

    $run = Start-Job -ScriptBlock $Action

    while ($run.State -eq 'Running') {
        Write-Host -NoNewline "`r[$($spinnything[$i])] $Message[?25l"
        Start-Sleep -Milliseconds 100
        $i = ($i + 1) % $spinnything.Length
    }
}