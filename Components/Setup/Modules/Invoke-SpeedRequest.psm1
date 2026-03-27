$SpeedRequest = {
    function Invoke-SpeedRequest { 
        param(
            [string]$uri,    
            [string]$outFile,
            [switch]$Silent
        )

        if ($Silent) {
            curl.exe -s -L "$uri" -o "$OutFile"
        }
        elseif (-not $Silent) {
            curl.exe -L "$uri" -o "$OutFile"
        }
    }
}