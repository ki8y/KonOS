function Read-Choice {
    # helper function for boolean choices :P
    param(
        [Parameter(Mandatory)]
        [string]$Name
    )

    choice /c YN /n | Out-Null
    switch ($LASTEXITCODE) {
        1 { Set-Variable -Name "$name" -Value $true -Scope Script -Force }
        2 { Set-Variable -Name "$name" -Value $false -Scope Script -Force }
    }
}