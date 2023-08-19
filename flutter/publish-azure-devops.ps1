# Script for a Azure DevOps powershell task which can be used to publish a Flutter app to Google Cloud Storage
# A secure `credentials` file needs to be downloaded to the release pipeline
# Pipeline variables need to be set

gcloud auth activate-service-account --key-file $(credentials.secureFilePath)

$version = Get-Content -Path $(ArtifactBasePath)/Android/VERSION

Move-Item $(ArtifactBasePath)/Android/app-release.apk $(ArtifactBasePath)/$(AppName)-$version.apk 

$versions = gcloud storage ls gs://$(Bucket)/$(AppName)-*.apk

if ($versions.contains("gs://$(Bucket)/$(AppName)-$version.apk")) {
    Write-Host "Version already exists" -ForegroundColor Red
    exit 1
}

gcloud storage cp $(ArtifactBasePath)/$(AppName)-$version.apk  gs://$(Bucket)
Write-Host "Uploaded to gs://$(Bucket)/$(AppName)-$version.apk" -ForegroundColor Green

if ($versions.contains("gs://$(Bucket)/$(AppName)-latest.apk")) {
    gcloud storage rm gs://$(Bucket)/$(AppName)-latest.apk
    Write-Host "Removed gs://$(Bucket)/$(AppName)-latest.apk" -ForegroundColor Yellow
}

gcloud storage cp $(ArtifactBasePath)/$(AppName)-latest.apk gs://$(Bucket)
Write-Host "Uploaded to gs://$(Bucket)/$(AppName)-latest.apk" -ForegroundColor Green

exit 0
