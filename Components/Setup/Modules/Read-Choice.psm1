function Read-Choice {
    # helper function for YES/NO choices :P

    Write-Host "» " -ForegroundColor Blue -NoNewLine
    choice /c YN /n | Out-Null
    switch ($LASTEXITCODE) {
        1 { 
            Write-Host "Yes"
            return $true
        }
        2 {
            Write-Host "No"
            return $false
        }
    }
}