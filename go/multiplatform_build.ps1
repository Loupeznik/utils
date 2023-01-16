param (
    [string]$appName,
    [string]$repoName,
    [bool]$isGin
)

$archs = @("amd64", "386", "arm64")
$module = "github.com/$repoName/$appName"

if ($isGin) {
    $env:GIN_MODE="release"
}

foreach ($arch in $archs)
{
    Write-Host "Building for Windows/$arch"
    $Env:GOOS="windows"; $Env:GOARCH=$arch; go build -o bin/$appname-$arch-win.exe $module

    if ($arch -ne "386") {
        Write-Host "Building for MacOS/$arch"
        $Env:GOOS="darwin"; $Env:GOARCH=$arch; go build -o bin/$appname-$arch-darwin $module
    }
    
    Write-Host "Building for Linux/$arch"
    $Env:GOOS="linux"; $Env:GOARCH=$arch; go build -o bin/$appname-$arch-linux $module
}
