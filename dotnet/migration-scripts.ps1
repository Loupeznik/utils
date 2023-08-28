param (
    [Parameter(Mandatory = $true)]
    [string]
    $project,
    [Parameter(Mandatory = $true)]
    [ValidateSet('add','remove','updatedb')]
    [string]
    $action,
    [string]
    $name
)

function Get-ExecutingDirectory
{
    $currentDirectory = Get-Location

    $runningDirectory = "unknown"

    if ((Test-Path (Join-Path $currentDirectory "README.md")) -eq $true) # check root directory
    {
        $runningDirectory = "root"
    }

    if ((Test-Path (Join-Path $currentDirectory "migration-scripts.ps1")) -eq $true) # check scripts directory
    {
        $runningDirectory = "scripts"
    }

    return $runningDirectory
}

function Write-ErrorAndExit([string] $message)
{
    Write-Host "[ERROR] $message" -ForegroundColor Red
    Pop-Location
    exit 1
}

$executingDirectory = Get-ExecutingDirectory

if ($executingDirectory -eq "unknown")
{
    Write-ErrorAndExit "Not running from a supported directory. Please run this script from the root or scripts directory."
}

if ($executingDirectory -eq "root")
{
    $location = "src/$project.Api"
}
else
{
    $location = "../src/$project.Api"
}

if ((Test-Path $location) -eq $false)
{
    Write-ErrorAndExit "Could not find service $service at $location."
}

Push-Location $location

if ($action -eq "add")
{
    if ([string]::IsNullOrWhiteSpace($name))
    {
        Write-ErrorAndExit "Name is required when adding a migration."
    }

    dotnet ef migrations add $name --project "../$project.Data"
}
elseif ($action -eq "remove")
{
    dotnet ef migrations remove --project ."../$project.Data"
}
elseif ($action -eq "updatedb")
{
    dotnet ef database update $name --project "../$project.Data"
}
else
{
    Write-ErrorAndExit "Unknown action $action."
}

Pop-Location
