$ErrorActionPreference = "Stop"

$baseUrl = $env:BASE_URL
if ([string]::IsNullOrWhiteSpace($baseUrl)) {
    $baseUrl = "http://localhost:8080"
}

function Test-Endpoint {
    param(
        [string] $Name,
        [string] $Url
    )

    Write-Host "Checking ${Name}: ${Url}"
    Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 10 | Out-Null
}

Test-Endpoint -Name "gateway health" -Url "$baseUrl/actuator/health"
Test-Endpoint -Name "gateway readiness" -Url "$baseUrl/actuator/health/readiness"

Write-Host "Smoke health checks passed."
