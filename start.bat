@echo off
setlocal

set "PORT=8080"
set "CONTAINER_NAME=uk-profile-swagger"
set "IMAGE_NAME=uk-profile-swagger"
if not "%~1"=="" set "PORT=%~1"
if not "%~2"=="" set "CONTAINER_NAME=%~2"
if not "%~3"=="" set "IMAGE_NAME=%~3"

docker info >nul 2>&1
if errorlevel 1 (
    echo Docker is not available. Install Docker and start its engine, then try again. >&2
    exit /b 1
)

docker build --tag "%IMAGE_NAME%" "%~dp0."
if errorlevel 1 exit /b 1

docker run --detach --rm --name "%CONTAINER_NAME%" --publish "127.0.0.1:%PORT%:8080" "%IMAGE_NAME%"
if errorlevel 1 exit /b 1

echo Swagger UI is starting at http://localhost:%PORT%
echo Stop it with: docker stop %CONTAINER_NAME%
