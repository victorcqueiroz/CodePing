#requires -Version 7.0
[CmdletBinding()]
param(
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release',
    [string]$Dotnet = 'dotnet'
)

$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
$publishRoot = [IO.Path]::GetFullPath((Join-Path $projectRoot 'artifacts\publish'))
$publishFolder = Join-Path $publishRoot 'win-x64'
$stageFolder = Join-Path $publishRoot ('build-' + [guid]::NewGuid().ToString('N'))
function Assert-PublishTarget([string]$Target) {
    $absolute = [IO.Path]::GetFullPath($Target)
    if (-not $absolute.StartsWith($publishRoot + [IO.Path]::DirectorySeparatorChar,[StringComparison]::OrdinalIgnoreCase)) { throw 'Alvo fora da publicação.' }
    $item = Get-Item -LiteralPath $absolute -Force -ErrorAction SilentlyContinue
    while ($item) { if ($item.LinkType) { throw 'Publicação não permite links/junções.' }; $item = $item.Parent }
    if (Test-Path -LiteralPath $absolute) { foreach ($entry in Get-ChildItem -LiteralPath $absolute -Recurse -Force) { if ($entry.LinkType) { throw 'Link na publicação.' } } }
}

Push-Location -LiteralPath $projectRoot
try {
    & $Dotnet publish .\ClaudeAlerta.csproj -c $Configuration -r win-x64 --self-contained true -o $stageFolder
    if ($LASTEXITCODE -ne 0) { throw "dotnet publish terminou com código $LASTEXITCODE." }
    foreach ($file in @('README.md','VALIDACAO.md','CHANGELOG.md')) { Copy-Item -LiteralPath (Join-Path $projectRoot $file) -Destination $stageFolder }
    Copy-Item -LiteralPath (Join-Path $projectRoot 'README.md') -Destination (Join-Path $stageFolder 'LEIA-ME.md')
    foreach ($folder in @('docs','design','Assets')) { Copy-Item -LiteralPath (Join-Path $projectRoot $folder) -Destination $stageFolder -Recurse -Force }
    # Current apphost keeps already-loaded hooks and shortcuts working under the former filename.
    Copy-Item -LiteralPath (Join-Path $stageFolder 'CodePing.exe') -Destination (Join-Path $stageFolder 'ClaudeAlerta.exe')
    Assert-PublishTarget $publishFolder; Assert-PublishTarget $stageFolder
    if (Test-Path -LiteralPath $publishFolder) { Remove-Item -LiteralPath $publishFolder -Recurse -Force }
    Move-Item -LiteralPath $stageFolder -Destination $publishFolder
    Write-Host "Publicação concluída: $publishFolder"
}
finally {
    if (Test-Path -LiteralPath $stageFolder) { Assert-PublishTarget $stageFolder; Remove-Item -LiteralPath $stageFolder -Recurse -Force }
    Pop-Location
}
