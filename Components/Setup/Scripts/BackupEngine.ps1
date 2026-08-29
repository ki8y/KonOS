enum StartupType {
    Boot = 0
    System = 1
    Automatic = 2
    Manual = 3
    Disabled = 4
}

# Grabs tweaks and flags from json :P
[string]$JsonRaw = Get-Content "C:\Users\Wybie\Downloads\TestTweaks.json" -Raw
$Tweaks = ConvertFrom-Json -InputObject $JsonRaw

$bcdedit = bcdedit /enum '{current}'

# Handles different types of tweaks
$Handlers = @{

    Registry = {

        param($Job)
        
        $Data = [Microsoft.Win32.Registry]::GetValue(
            $Job.Key,
            $Job.Value,
            $null
        )
        switch ($job.DataType) {
            3        {$Output = [byte[]]$Data}
            "binary" {$Output = [byte[]]$Data}
            default  {$Output = $Data}
        }

        $Job.Data = $Output

    }

    ScheduledTask = {
        param($Job)

        $task = Get-ScheduledTask -TaskPath $job.TaskPath -TaskName $job.TaskName
        if ($task) {
            $data = $task.State
            switch ($data) {
                'Ready' {$job.Command = "Enable"}
                'Disabled' {$job.Command = "Disable"}
            }
        }

    }

    BCD = {
        param($Job)
        $policy = ($bcdedit.Where({$_ -match "$($job.Value)"}))[0]

        if ($policy) {
            $line = $policy.Trim()
            
            # grabs everything after the first space
            $firstSpaceIndex = $line.IndexOf(" ")
            $job.Data = $line.Substring($firstSpaceIndex).Trim()
        }
        else {
            $job.Data = $null
        }

    }

    Service = {
        param($job)
        $Data = [Microsoft.Win32.Registry]::GetValue(
            "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\$($Job.Name)",
            "Start",
            $null
        )

        [string]$Output = [StartupType]$Data
        $job.StartupType = $Output
    }

}

Write-Host "Scanning and backing up default values..."
foreach ($Category in $tweaks) {

    foreach ($Tweak in $Category.Tweaks) {
        $i = 0
        foreach ($Job in $Tweak.Apply) {
            $Handler = $Handlers[$Job.Type]
            if ($null -eq $handler) {
                # just remove it if it doesnt exist lmao
                $list = [System.Collections.Generic.List[PSCustomObject]]($Tweak.Apply)
                $list.RemoveAt($i)
                $Tweak.Apply = $list.ToArray()
                
                continue
            }
            & $Handler $Job
            $i++
        }
    }
}
$Json = ConvertTo-Json -InputObject $Tweaks -Depth 100 -Compress
Set-Content -Path "C:\KonOS\backup.json" -Value $Json -Force