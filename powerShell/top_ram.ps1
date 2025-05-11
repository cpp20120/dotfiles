<#
.SYNOPSIS
    Показывает топ-5 процессов по потреблению ОЗУ с цветным выделением
#>

$totalRAM = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1MB

$topProcesses = Get-Process | 
Sort-Object -Property WS -Descending | 
Select-Object -First 5 |
ForEach-Object {
    $memMB = [math]::Round($_.WS / 1MB, 2)
    $percent = [math]::Round(($_.WS / 1MB) / $totalRAM * 100, 2)
        
    [PSCustomObject]@{
        'Id'          = $_.Id
        'ProcessName' = $_.ProcessName
        'Memory(MB)'  = $memMB
        '% of Total'  = $percent
        'Rank'        = $input.Count 
    }
}

Write-Host ("{0,-8} {1,-18} {2,-12} {3,-12}" -f 'Id', 'ProcessName', 'Memory(MB)', '% of Total') -ForegroundColor Cyan
Write-Host ("{0,-8} {1,-18} {2,-12} {3,-12}" -f '--', '-----------', '----------', '----------') -ForegroundColor DarkCyan

foreach ($proc in $topProcesses) {
    $color = switch ($proc.Rank) {
        0 { "Red" }   
        1 { "Yellow" }
        2 { "Green" }
        default { "Gray" }
    }
    
    Write-Host ("{0,-8} {1,-18} {2,10:N2} {3,10:N2}%" -f 
        $proc.Id,
        $proc.ProcessName,
        $proc.'Memory(MB)',
        $proc.'% of Total') -ForegroundColor $color
}

Write-Host "`nОбщий объем ОЗУ: $([math]::Round($totalRAM, 2)) MB" -ForegroundColor Cyan