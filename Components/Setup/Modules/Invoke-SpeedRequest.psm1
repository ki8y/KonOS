function Invoke-SpeedRequest { # Invoke-WebRequest is slow on powershell 5, so i made this helper function
    param(
        [string]$uri,    
        [string]$outFile
    )
    curl.exe -L "$uri" -o "$OutFile"
}