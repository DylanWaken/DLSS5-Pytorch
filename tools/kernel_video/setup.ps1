<#
Install the video's isolated Python/Manim and portable MiKTeX toolchain.
Run from the repository root:
  powershell -ExecutionPolicy Bypass -File tools/kernel_video/setup.ps1
No machine PATH or registry changes are requested. Downloads live in the
user cache, outside the project and its training environment.

Official installation references:
https://docs.manim.community/en/stable/installation.html
https://miktex.org/howto/deploy-miktex
https://docs.miktex.org/manual/miktexsetup.html
#>
[CmdletBinding()]
param(
    [string]$RuntimeRoot = (Join-Path $env:USERPROFILE '.cache\dlssnr-kernel-video'),
    [string]$BasePython = (Join-Path $PSScriptRoot '..\..\.venv\Scripts\python.exe')
)

$ErrorActionPreference = 'Stop'
function Invoke-Checked {
    param([string]$Executable, [string[]]$Arguments)
    & $Executable @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Command failed ($LASTEXITCODE): $Executable"
    }
}

$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot)
New-Item -ItemType Directory -Path $RuntimeRoot -Force | Out-Null
$python = Join-Path $RuntimeRoot 'venv\Scripts\python.exe'
if (!(Test-Path -LiteralPath $python)) {
    Invoke-Checked $BasePython @('-m', 'venv', (Join-Path $RuntimeRoot 'venv'))
}
Invoke-Checked $python @('-m', 'pip', 'install', '-r', (Join-Path $PSScriptRoot 'requirements.txt'))

$texBin = Join-Path $RuntimeRoot 'miktex\texmfs\install\miktex\bin\x64'
if (!(Test-Path -LiteralPath (Join-Path $texBin 'latex.exe'))) {
    $archive = Join-Path $RuntimeRoot 'miktexsetup-x64.zip'
    if (!(Test-Path -LiteralPath $archive)) {
        Invoke-WebRequest -Uri 'https://miktex.org/download/win/miktexsetup-x64.zip' -OutFile $archive
    }
    $setupDir = Join-Path $RuntimeRoot 'miktex-setup'
    Expand-Archive -LiteralPath $archive -DestinationPath $setupDir -Force
    $setup = Join-Path $setupDir 'miktexsetup_standalone.exe'
    $packages = Join-Path $RuntimeRoot 'miktex-repository'
    Invoke-Checked $setup @('--verbose', "--local-package-repository=$packages", '--package-set=basic', 'download')
    $portable = Join-Path $RuntimeRoot 'miktex'
    Invoke-Checked $setup @('--verbose', "--local-package-repository=$packages", "--portable=$portable", '--package-set=basic', '--use-registry=no', '--modify-path=no', 'install')
}

# The process-local PATH also reaches child LaTeX/dvisvgm invocations.
$env:PATH = "$texBin;$(Join-Path $RuntimeRoot 'venv\Scripts');$env:PATH"
Invoke-Checked (Join-Path $texBin 'initexmf.exe') @('--set-config-value=[MPM]AutoInstall=1')
Invoke-Checked (Join-Path $texBin 'mpm.exe') @('--set-repository=https://mirrors.ibiblio.org/pub/mirrors/CTAN/systems/win32/miktex/tm/packages/')

# MiKTeX's Windows DVI converter requires cwd and generated Tex files to
# reside on the same drive; source files can remain in the repository.
Push-Location -LiteralPath $RuntimeRoot
try {
    Invoke-Checked $python @('-m', 'manim', '--renderer', 'cairo', '--format', 'mp4', '--media_dir', (Join-Path $RuntimeRoot 'smoke-media'), '-ql', (Join-Path $PSScriptRoot 'toolchain_smoke.py'), 'ToolchainSmoke')
} finally {
    Pop-Location
}
Write-Output "Python: $python"
Write-Output "TeX executables: $texBin"
Invoke-Checked $python @('-c', 'import imageio_ffmpeg; print("FFmpeg: " + imageio_ffmpeg.get_ffmpeg_exe())')
Write-Output "Verified MathTex video: $(Join-Path $RuntimeRoot 'smoke-media\videos\toolchain_smoke\480p15\ToolchainSmoke.mp4')"
