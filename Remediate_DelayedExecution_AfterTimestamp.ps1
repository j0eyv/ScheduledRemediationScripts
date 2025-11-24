# Remediate execution
$RegPath = "HKLM:\SOFTWARE\TestKey"
$Name = "TestKey"
$Value = "TestValue"

# Execution timestamp
$RunTimestamp = "25-11-2025 12:00"

# Parse scheduled timestamp and compare
$RunDateTime = [datetime]::ParseExact($RunTimestamp,'dd-MM-yyyy HH:mm',$null)
if ((Get-Date) -ge $RunDateTime) {
    Write-Host "Remediation not executed. Past scheduled time $RunTimestamp."
    return
}

# Ensure the key exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the value
New-ItemProperty -Path $RegPath -Name $Name -Value $Value -PropertyType DWORD -Force | Out-Null