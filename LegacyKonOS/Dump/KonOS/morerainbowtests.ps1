$ascii = @'
                                      ██╗  ██╗ ██████╗ ███╗   ██╗     ██████╗ ███████╗
                                      ██║ ██╔╝██╔═══██╗████╗  ██║    ██╔═══██╗██╔════╝
                                      ████╔╝ ██║   ██║██╔██╗ ██║    ██║   ██║███████╗
                                      ██╔═██╗ ██║   ██║██║╚██╗██║    ██║   ██║╚════██║
                                      ██║  ██╗╚██████╔╝██║ ╚████║    ╚██████╔╝███████║
                                      ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝     ╚═════╝ ╚══════╝
'@ -split "`n"

function Get-GradientColor {
    param ($index, $max)
    $hue = ($index / [math]::Max($max, 1)) * 360
    $h = $hue / 60
    $c = 1
    $x = 1 - [math]::Abs(($h % 2) - 1)
    switch ([math]::Floor($h)) {
        0 { $r,$g,$b = 1,$x,0 }
        1 { $r,$g,$b = $x,1,0 }
        2 { $r,$g,$b = 0,1,$x }
        3 { $r,$g,$b = 0,$x,1 }
        4 { $r,$g,$b = $x,0,1 }
        5 { $r,$g,$b = 1,0,$x }
        default { $r,$g,$b = 1,1,1 }
    }
    # Convert to 0–255 range
    $r = [math]::Round($r * 255)
    $g = [math]::Round($g * 255)
    $b = [math]::Round($b * 255)
    return "`e[38;2;${r};${g};${b}m"
}

foreach ($line in $ascii) {
    $chars = $line.ToCharArray()
    $max = $chars.Length - 1
    for ($i = 0; $i -le $max; $i++) {
        $color = Get-GradientColor $i $max
        Write-Host -NoNewline "$color$($chars[$i])"
    }
    Write-Host "`e[0m"
}
pause