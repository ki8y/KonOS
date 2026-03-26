function Exit-Setup {
    # cleans stuff up and exits da flippin SETUP.

    param(
        [int]$exitCode = 0
    )   
    
    Write-Output "Exiting setup..."
    Write-Host "[$($KonOS)] Cleaning setup files..."
    Remove-Item -Path "$KonOS\Setup" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    
    Write-Host "[$($KonOS)] Exiting setup..."
    Start-Sleep -Milliseconds 500 # just looks cooler if it says "exiting setup" lmfao

    Clear-Host
    if ($exitCode -ne 0) {
        Write-Host "Setup exited prematurely.`nError Code: $exitcode"
        Write-Output "Setup exited prematurely. Error Code: $exitcode" | Add-Content -Path "$KonOS\setupLog.txt"
    } else {
        Write-Output "Successfully cancelled setup." | Add-Content -Path "$KonOS\setupLog.txt"
    }

    Exit $exitCode
}