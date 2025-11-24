<#
.SYNOPSIS
Ensures a specific action is executed only on the exact scheduled date.

.DESCRIPTION
This script checks the current system date against a predefined execution date.
If the dates match, it executes the script. If the date does not match, it exits without making changes. Intended for one-time
controlled remediation on an exact calendar day.
#>

# Execution timestamp
$RunTimestamp = "23-11-2025"

# Parse scheduled timestamp and compare
$RunDateTime = [datetime]::ParseExact($RunTimestamp,'dd-MM-yyyy',$null)
if ((Get-Date).Date -ne $RunDateTime.Date) {
    Write-Host "Remediation not executed. Only runs on $RunTimestamp."
    return
}

################################################################################################
# Custom PowerShell code below this line/block
################################################################################################

# Remediate execution
$RegPath = "HKLM:\SOFTWARE\TestKey"
$Name = "TestKey"
$Value = "TestValue"

# Ensure the key exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the value
New-ItemProperty -Path $RegPath -Name $Name -Value $Value -PropertyType DWORD -Force | Out-Null