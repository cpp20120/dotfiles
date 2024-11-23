Set-PoshPrompt ~\Documents\PowerShell\paradox-greg.omp.json

$PSDefaultParameterValues["Out-File:Encoding"] = "utf8"

Set-PSReadlineKeyHandler -Key Tab -Function Complete

Set-Alias -Name nf -Value winfetch
Set-Alias -Name cl -Value clear
Set-Alias -Name n -Value nvim
Set-Alias -Name l -Value Get-ChildItem
Set-Alias -Name python -Value C:\Users\cppshizoid\AppData\Local\Programs\Python\Python312\python.exe
Set-Alias -Name ranger -Value lf

function clg_run {
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )

    if (-not $Args) {
        Write-Host "Error: No input files specified!" -ForegroundColor Red
        return
    }

    Write-Host "Compiling with arguments: $Args"

    clang++ -Wall -o test @Args -std=c++20 -fuse-ld=lld
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Compilation successful. Running test..."
        ./test
    } else {
        Write-Host "Compilation failed!" -ForegroundColor Red
    }
}


Import-Module 'C:\Users\cppshizoid\scoop\apps\vcpkg\current\scripts\posh-vcpkg'
#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module
