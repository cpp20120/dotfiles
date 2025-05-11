<#
.SYNOPSIS
    Показывает топ-5 процессов по потреблению ОЗУ с цветным выделением и информацией об использовании памяти
#>

# Получаем данные о памяти
$totalRAM = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1MB
$usedRAM = (Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize - (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory
$usedRAM = $usedRAM / 1KB  # Конвертируем в MB

# Получаем топ-5 процессов
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

# Выводим заголовок таблицы
Write-Host ("{0,-8} {1,-18} {2,-12} {3,-12}" -f 'Id', 'ProcessName', 'Memory(MB)', '% of Total') -ForegroundColor Cyan
Write-Host ("{0,-8} {1,-18} {2,-12} {3,-12}" -f '--', '-----------', '----------', '----------') -ForegroundColor DarkCyan

# Выводим процессы с цветами
foreach ($proc in $topProcesses) {
    $color = switch ($proc.Rank) {
        0 { "Red" }     # 1 место
        1 { "Yellow" }  # 2 место
        2 { "Green" }   # 3 место
        default { "Gray" }
    }
    
    Write-Host ("{0,-8} {1,-18} {2,10:N2} {3,10:N2}%" -f 
        $proc.Id,
        $proc.ProcessName,
        $proc.'Memory(MB)',
        $proc.'% of Total') -ForegroundColor $color
}

# Выводим информацию об использовании памяти
$usagePercentage = [math]::Round(($usedRAM / $totalRAM) * 100, 2)
$usageColor = if ($usagePercentage -gt 90) { "Red" }
elseif ($usagePercentage -gt 70) { "Yellow" }
else { "Green" }

Write-Host "`nИспользование ОЗУ: $([math]::Round($usedRAM, 2)) MB / $([math]::Round($totalRAM, 2)) MB ($usagePercentage%)" -ForegroundColor $usageColor