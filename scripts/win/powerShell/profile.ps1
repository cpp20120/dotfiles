# Produce UTF-8 by default
# https://news.ycombinator.com/item?id=12991690
$PSDefaultParameterValues["Out-File:Encoding"] = "utf8"

#Set-Alias -Name editcap -Value C:\Program Files\Wireshark\editcap.exe
Set-Alias -Name n -Value nvim
Set-Alias -Name l -Value Get-ChildItem
Set-Alias -Name python -Value E:\scoop\apps\python313\3.13.3\python.exe
Set-Alias -Name ranger -Value lf
Set-Alias -Name vcpkg -Value E:\vcpkg\vcpkg.exe
Set-Alias -Name procdump -Value E:\Procdump\procdump64.exe
Set-Alias -Name battery -Value $env:USERPROFILE\Scripts\battery.ps1
Set-Alias -Name archive -Value $env:USERPROFILE\Scripts\archive.ps1
Set-Alias -Name ram -Value $env:USERPROFILE\Scripts\ram.ps1
Set-Alias -Name weather -Value $env:USERPROFILE\Scripts\weather.ps1
Set-Alias -Name applist -Value $env:USERPROFILE\Scripts\installedsoftware.ps1
Set-Alias -Name dirzip -Value $env:USERPROFILE\Scripts\dir2zip.ps1
Set-Alias -Name topram -Value $env:USERPROFILE\Scripts\top_ram.ps1
Set-Alias -Name cal -Value $env:USERPROFILE\Scripts\calendar.ps1
function ff($name) {
    Get-ChildItem -Recurse -Filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Output "$($_.Directory)\$($_)"
    }
}

function global:rfv {
    $scriptPath = Join-Path $env:USERPROFILE "Scripts\rfv.ps1"
    
    if (-not (Test-Path $scriptPath)) {
        Write-Host "Скрипт rfv.ps1 не найден!" -ForegroundColor Red
        return
    }

    & $scriptPath @args
}
#Set-Alias -Name devenv -Value C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe
# bash-style completion
Set-PSReadlineKeyHandler -Key Tab -Function Complete

Set-Alias -Name winget -Value "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_1.25.390.0_x64__8wekyb3d8bbwe\winget.exe"
Invoke-Expression (&starship init powershell)
#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

#Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

Invoke-Expression (& { (zoxide init powershell | Out-String) })

Import-Module 'E:\vcpkg\scripts\posh-vcpkg'
