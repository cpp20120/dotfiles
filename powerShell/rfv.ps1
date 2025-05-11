<#
.SYNOPSIS
    Надежный поиск файлов с обработкой всех ошибок
#>

# Сохраните этот файл в кодировке UTF-8 with BOM

# Проверка зависимостей
if (-not (Get-Command rg -ErrorAction SilentlyContinue)) {
    Write-Host "Установите ripgrep: winget install BurntSushi.ripgrep" -ForegroundColor Red
    exit 1
}

if (-not (Get-Command fzf -ErrorAction SilentlyContinue)) {
    Write-Host "Установите fzf: winget install fzf" -ForegroundColor Red
    exit 1
}

# Безопасные директории для поиска (измените под свои нужды)
$searchDirs = @(
    "$env:USERPROFILE\Desktop",
    "$env:USERPROFILE\Documents",
    "$env:USERPROFILE\Projects"
) | Where-Object { Test-Path $_ }

if (-not $searchDirs) {
    Write-Host "Нет доступных директорий для поиска" -ForegroundColor Yellow
    exit 0
}

# Настройки ripgrep
$rgCmd = @(
    "--column",
    "--line-number",
    "--no-heading",
    "--color=always",
    "--smart-case",
    "--hidden",
    "--glob=!{OneDrive,AppData,NTUSER.*,*.tmp,*.log}/*"
)

# Простая функция предпросмотра
function Get-SimplePreview {
    $file = $args[0] -replace '"', ''
    $line = if ($args[1]) { $args[1] } else { 1 }
    
    if (Test-Path $file) {
        if (Get-Command bat -ErrorAction SilentlyContinue) {
            "bat --color=always --style=numbers --line-range ${line}:${line} --highlight-line ${line} --paging=never `"$file`""
        }
        else {
            "Get-Content `"$file`" | Select-Object -First 30"
        }
    }
    else {
        "echo 'Файл не найден'"
    }
}

# Основной процесс поиска
try {
    # Получаем результаты поиска
    $searchResults = if ($args[0]) {
        & rg @rgCmd -- $args[0] $searchDirs 2>$null
    }
    else {
        & rg @rgCmd $searchDirs 2>$null
    }

    if (-not $searchResults) {
        Write-Host "Ничего не найдено" -ForegroundColor Cyan
        exit 0
    }

    # Запускаем fzf
    $selected = $searchResults | fzf --ansi `
        --height 40% `
        --layout=reverse `
        --border `
        --query ($args[0] ?? "") `
        --preview (Get-SimplePreview '{1}' '{2}') `
        --preview-window 'right:60%' `
        --delimiter ':' `
        --prompt 'Search> '

    # Открываем выбранный файл
    if ($selected) {
        $parts = $selected -split ':' -ne ''
        $file = $parts[0].Trim('"', "'")
        $line = if ($parts.Count -gt 1) { $parts[1] } else { 1 }

        if (Test-Path $file) {
            if (Get-Command code -ErrorAction SilentlyContinue) {
                Start-Process code "--goto `"$file`":$line"
            }
            elseif (Get-Command nvim -ErrorAction SilentlyContinue) {
                Start-Process nvim "+$line `"$file`""
            }
            else {
                Start-Process "`"$file`""
            }
        }
        else {
            Write-Host "Файл не найден: $file" -ForegroundColor Red
        }
    }
}
catch {
    Write-Host "Ошибка: $_" -ForegroundColor Red
}