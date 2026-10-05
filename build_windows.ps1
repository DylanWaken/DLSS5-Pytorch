$ErrorActionPreference = "Stop"
$projectRoot = $PSScriptRoot
$env:TORCH_CUDA_ARCH_LIST = "12.0"
$env:MAX_JOBS = "2"
$env:CUDA_HOME = Join-Path $projectRoot ".cuda/Library"
if (-not (Test-Path -LiteralPath $env:CUDA_HOME)) { throw "Set up the matching CUDA toolkit before building" }
Set-Location -LiteralPath $projectRoot
& python setup.py build_ext --inplace
if ($LASTEXITCODE -ne 0) { throw "CUDA extension build failed" }
