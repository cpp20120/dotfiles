<#
.SYNOPSIS
Lists the weather of cities
#>

function List-City-Weather {
    $cities = @("Novosibirsk", "Belovo")
    foreach ($city in $cities) {
        $icon = (Invoke-WebRequest http://wttr.in/${City}?format="%c" -UserAgent "curl" -useBasicParsing).Content
        $temp = (Invoke-WebRequest http://wttr.in/${City}?format="%t" -UserAgent "curl" -useBasicParsing).Content
        $rain = (Invoke-WebRequest http://wttr.in/${City}?format="%p %h" -UserAgent "curl" -useBasicParsing).Content
        $wind = (Invoke-WebRequest http://wttr.in/${City}?format="%w" -UserAgent "curl" -useBasicParsing).Content
        $sun = (Invoke-WebRequest http://wttr.in/${City}?format="%S → %s" -UserAgent "curl" -useBasicParsing).Content
        New-Object PSObject -Property @{ CITY = "$city $icon"; TEMP = $temp; RAIN = $rain; WIND = $wind; SUN = $sun }
    }
}

try {
    List-City-Weather | Format-Table -property @{e = 'CITY'; width = 19 }, @{e = 'TEMP'; width = 9 }, @{e = 'RAIN'; width = 14 }, @{e = 'WIND'; width = 12 }, @{e = 'SUN'; width = 20 }
    exit 0
}
catch {
    "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    exit 1
}