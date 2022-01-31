<#
    .SYNOPSIS
    Builds apk and publishes the artifact to a GCP bucket

    .DESCRIPTION
    The script builds your flutter app, tests it and creates an artifact. It the uploads it to 
    defined GCP storage bucket with current version and defined application name.

    .NOTES
    Call from root directory of your Flutter app even if the script is stored in another directory
#>

# Check and import powershell-yaml module

if (-not (Get-Module -ListAvailable -Name powershell-yaml)) {
    Install-Module powershell-yaml
}

Import-Module powershell-yaml

# Set variables

$bucket = Get-GcsBucket -Name "<yourbucketname>" # Set this
$filePath = "pubspec.yaml"

if (-not (Test-Path -Path $filePath -PathType Leaf)) {
    Write-Host "[ERROR] Pubspec file was not found" -ForegroundColor red
    exit
}

# Parse pubspec.yaml to get current version

$content = [string]::Empty
foreach ($line in (Get-Content $filePath)) { 
    $content += "`n" + $line 
}

$version = (ConvertFrom-YAML $content)["version"]
$appName = (ConvertFrom-YAML $content)["name"]

# Build

Set-Location -Path "C:\Dev\$appname" # Set this
flutter build apk

# Test

flutter test

# Publish

New-GcsObject -Bucket $bucket -ObjectName "$appName-android-$version.apk" -File .\build\app\outputs\apk\release\app-release.apk -Force
