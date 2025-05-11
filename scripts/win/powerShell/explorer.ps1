while ($true) {
    $explorer = Get-Process -Name "explorer" -ErrorAction SilentlyContinue
    if (-not $explorer) {
        Start-Process "explorer.exe"
        Add-Content -Path "$env:ProgramData\explorer-monitor.log" -Value "$(Get-Date): explorer.exe was restarted"
    }
    Start-Sleep -Seconds 10
}

