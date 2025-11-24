<#
.SYNOPSIS
Ensures a specific action is executed only after the scheduled date and time.
.DESCRIPTION
This script checks the current system date against a predefined execution date.
If the dates are later than the configured $RunTimestamp, it executes the script. If the date is before the $RunTimestamp date, it exits without making changes.
Intended for controlled remediation after an exact calendar day.
#>

# Execution timestamp
$RunTimestamp = "25-11-2025 12:00"

# Parse scheduled timestamp and compare
$RunDateTime = [datetime]::ParseExact($RunTimestamp,'dd-MM-yyyy HH:mm',$null)
if ((Get-Date) -lt $RunDateTime) {
    Write-Host "Remediation not executed. Currently before scheduled time $RunTimestamp."
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