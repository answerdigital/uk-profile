[CmdletBinding()]
param(
    [ValidateRange(1, 65535)]
    [int]$Port = 8080,
    [string]$ImageName = "uk-profile-swagger",
    [string]$ContainerName = "uk-profile-swagger"
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw "Docker is required. Install Docker and start its engine before running this script."
}

docker info --format '{{.ServerVersion}}'
if ($LASTEXITCODE -ne 0) {
    throw "Docker is not available. Start the Docker engine and try again."
}

docker build --tag $ImageName $PSScriptRoot
if ($LASTEXITCODE -ne 0) {
    throw "Failed to build the Swagger UI image."
}

docker run --detach --rm --name $ContainerName --publish "127.0.0.1:${Port}:8080" $ImageName
if ($LASTEXITCODE -ne 0) {
    throw "Failed to start Swagger UI. Check whether port $Port or container name '$ContainerName' is already in use."
}

Write-Host "Swagger UI is starting at http://localhost:$Port"
Write-Host "Stop it with: docker stop $ContainerName"
