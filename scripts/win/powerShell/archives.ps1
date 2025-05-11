<#
.SYNOPSIS
    Archive utility - pack or unpack files in various formats
.DESCRIPTION
    Provides functionality to compress or extract files in multiple archive formats
.EXAMPLE
    ArchiveUtility -Action pack -Type zip -Source MyFolder
.EXAMPLE
    ArchiveUtility -Action unpack -File archive.zip
#>
function ArchiveUtility {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("pack", "unpack")]
        [string]$Action,

        [Parameter(Mandatory = $false)]
        [ValidateSet("zip", "7z", "tar", "tgz", "tbz", "gz", "bz2")]
        [string]$Type,

        [Parameter(Mandatory = $false)]
        [string]$Source,

        [Parameter(Mandatory = $false)]
        [string]$File
    )

    # Check requirements
    if (-not (Get-Command -Name '7z' -ErrorAction SilentlyContinue)) {
        Write-Warning "7-Zip is recommended for full functionality. Install from https://www.7-zip.org/"
    }

    switch ($Action) {
        "pack" {
            if (-not $Type -or -not $Source) {
                Write-Error "Both -Type and -Source parameters are required for packing"
                return
            }

            if (-not (Test-Path -Path $Source)) {
                Write-Error "'$Source' is not a valid file or directory"
                return
            }

            $destination = switch ($Type) {
                "zip" { "$Source.zip" }
                "7z" { "$Source.7z" }
                "tar" { "$Source.tar" }
                "tgz" { "$Source.tar.gz" }
                "tbz" { "$Source.tar.bz2" }
                "gz" { "$Source.gz" }
                "bz2" { "$Source.bz2" }
            }

            Write-Host "Creating $destination..." -ForegroundColor Cyan

            switch ($Type) {
                "zip" { Compress-Archive -Path $Source -DestinationPath $destination -Force }
                "7z" { & '7z' a $destination $Source }
                "tar" { tar -cpvf $destination $Source }
                "tgz" { tar -czvf $destination $Source }
                "tbz" { tar -cjvf $destination $Source }
                "gz" { & 'gzip' -c -9 -n $Source > $destination }
                "bz2" { & 'bzip2' -k $Source > $destination }
            }

            if (Test-Path $destination) {
                Write-Host "Successfully created: $destination" -ForegroundColor Green
            }
            else {
                Write-Error "Failed to create archive"
            }
        }

        "unpack" {
            if (-not $File) {
                Write-Error "The -File parameter is required for unpacking"
                return
            }

            if (-not (Test-Path -Path $File -PathType Leaf)) {
                Write-Error "'$File' is not a valid file"
                return
            }

            $extension = [System.IO.Path]::GetExtension($File).ToLower()
            $destination = Join-Path (Get-Location) ([System.IO.Path]::GetFileNameWithoutExtension($File))

            Write-Host "Extracting $File to $destination..." -ForegroundColor Cyan

            switch ($extension) {
                '.zip' { Expand-Archive -Path $File -DestinationPath $destination -Force }
                '.7z' { & '7z' x $File "-o$destination" -y }
                '.tar' { tar -xf $File -C $destination }
                '.tar.gz' { tar -xzf $File -C $destination }
                '.tgz' { tar -xzf $File -C $destination }
                '.tar.bz2' { tar -xjf $File -C $destination }
                '.tbz2' { tar -xjf $File -C $destination }
                '.gz' { 
                    $outputFile = $File -replace '\.gz$', ''
                    & 'gzip' -d $File -c > $outputFile 
                }
                '.bz2' { 
                    $outputFile = $File -replace '\.bz2$', ''
                    & 'bzip2' -d $File -c > $outputFile 
                }
                default { 
                    Write-Warning "Unknown archive format. Trying with 7-Zip..."
                    & '7z' x $File "-o$destination" -y 
                }
            }

            if (Test-Path $destination) {
                Write-Host "Successfully extracted to: $destination" -ForegroundColor Green
            }
            else {
                Write-Error "Failed to extract archive"
            }
        }
    }
}

# Set aliases for convenience
New-Alias -Name archive -Value ArchiveUtility -Force
New-Alias -Name pk -Value ArchiveUtility -Force
New-Alias -Name extract -Value ArchiveUtility -Force