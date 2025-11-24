# Remediate execution
$RegPath = "HKLM:\SOFTWARE\TestKey"
$Name = "TestKey"
$Value = "TestValue"

# Execution timestamp
$RunTimestamp = "23-11-2025"

# Parse scheduled timestamp and compare
$RunDateTime = [datetime]::ParseExact($RunTimestamp,'dd-MM-yyyy',$null)
if ((Get-Date).Date -ne $RunDateTime.Date) {
    Write-Host "Remediation not executed. Only runs on $RunTimestamp."
    return
}

# Ensure the key exists
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the value
New-ItemProperty -Path $RegPath -Name $Name -Value $Value -PropertyType DWORD -Force | Out-Null