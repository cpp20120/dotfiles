<#
.SYNOPSIS
	Lists the battery status
#>

try {
    Add-Type -Assembly System.Windows.Forms
    [System.Windows.Forms.SystemInformation]::PowerStatus
    exit 0 # success
}
catch {
    "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    exit 1
}