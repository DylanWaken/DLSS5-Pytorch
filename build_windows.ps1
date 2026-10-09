$ErrorActionPreference = "Stop"
$projectRoot = $PSScriptRoot
if (-not $env:MAX_JOBS) { $env:MAX_JOBS = "2" }
if (-not $env:CUDA_HOME) { $env:CUDA_HOME = Join-Path $projectRoot ".cuda/Library" }
if (-not (Test-Path -LiteralPath $env:CUDA_HOME)) { throw "Set up the matching CUDA toolkit before building" }
Set-Location -LiteralPath $projectRoot
& python setup.py build_ext --inplace
if ($LASTEXITCODE -ne 0) { throw "CUDA extension build failed" }
