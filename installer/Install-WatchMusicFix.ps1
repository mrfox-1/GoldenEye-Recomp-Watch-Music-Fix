$ErrorActionPreference = 'Stop'

function Read-CleanPath([string]$Prompt) {
    $value = Read-Host $Prompt
    return $value.Trim().Trim('"')
}

function Stop-WithMessage([string]$Message) {
    Write-Host ''
    Write-Host "ERROR: $Message" -ForegroundColor Red
    exit 1
}

Write-Host 'GoldenEye Recomp 1.2.4 - Watch Music Fix' -ForegroundColor Cyan
Write-Host 'This installs the fixed program files and extracts the watch theme'
Write-Host 'from your own assets\music.xwb. No game music is included.'
Write-Host ''

$gameDirText = Read-CleanPath 'Drag the GoldenEye game folder here, then press Enter'
if (-not $gameDirText) {
    Stop-WithMessage 'No game folder was selected.'
}

try {
    $gameDir = (Resolve-Path -LiteralPath $gameDirText).Path
} catch {
    Stop-WithMessage "The game folder does not exist: $gameDirText"
}

if (-not (Test-Path -LiteralPath $gameDir -PathType Container)) {
    Stop-WithMessage 'The selected game path is not a folder.'
}

$gameExe = Join-Path $gameDir 'GoldenEye.exe'
$assetDir = Join-Path $gameDir 'assets'
$musicBank = Join-Path $assetDir 'music.xwb'
if (-not (Test-Path -LiteralPath $gameExe -PathType Leaf)) {
    Stop-WithMessage 'GoldenEye.exe was not found in that folder.'
}
if (-not (Test-Path -LiteralPath $assetDir -PathType Container)) {
    Stop-WithMessage 'The assets folder was not found in that folder.'
}
if (-not (Test-Path -LiteralPath $musicBank -PathType Leaf)) {
    Stop-WithMessage 'assets\music.xwb was not found. Select the main GoldenEye Recomp folder.'
}

$payloadDir = Join-Path $PSScriptRoot 'payload'
$payloadExe = Join-Path $payloadDir 'GoldenEye.exe'
if (-not (Test-Path -LiteralPath $payloadExe -PathType Leaf)) {
    Stop-WithMessage 'The patch payload is incomplete. Keep the payload folder beside the installer.'
}

$decoderDir = Join-Path $PSScriptRoot 'vgmstream'
$decoderExe = Join-Path $decoderDir 'vgmstream-cli.exe'
if (-not (Test-Path -LiteralPath $decoderExe -PathType Leaf)) {
    Stop-WithMessage 'The open-source music decoder is missing. Keep the vgmstream folder beside the installer.'
}

$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$backupDir = Join-Path $gameDir "backup-before-watch-fix-$stamp"
New-Item -ItemType Directory -Path $backupDir | Out-Null

$filesToInstall = @(
    'GoldenEye.exe',
    'rexruntimerd.dll',
    'TracyClientrd.dll',
    'msvcp140.dll',
    'msvcp140_atomic_wait.dll',
    'vcruntime140.dll',
    'vcruntime140_1.dll',
    'vulkan-1.dll'
)

Write-Host ''
Write-Host 'Backing up the existing program files...'
foreach ($name in $filesToInstall) {
    $existing = Join-Path $gameDir $name
    if (Test-Path -LiteralPath $existing -PathType Leaf) {
        Copy-Item -LiteralPath $existing -Destination (Join-Path $backupDir $name) -Force
    }
}

Write-Host 'Installing the fixed program files...'
foreach ($name in $filesToInstall) {
    $source = Join-Path $payloadDir $name
    if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
        Stop-WithMessage "The patch payload is missing $name. Your original files remain in $backupDir"
    }
    Copy-Item -LiteralPath $source -Destination (Join-Path $gameDir $name) -Force
}

Write-Host 'Extracting the watch theme from your own music.xwb...'
$watchTheme = Join-Path $gameDir 'watch_theme.wav'
$temporaryTheme = Join-Path $gameDir 'watch_theme.extracting.wav'
if (Test-Path -LiteralPath $temporaryTheme) {
    Remove-Item -LiteralPath $temporaryTheme -Force
}

$decoderExitCode = 1
Push-Location $decoderDir
try {
    & $decoderExe '-s' '33' '-i' '-W' '1' '-L' '-o' $temporaryTheme $musicBank
    $decoderExitCode = $LASTEXITCODE
} finally {
    Pop-Location
}
if ($decoderExitCode -ne 0) {
    Stop-WithMessage "Music extraction failed with code $decoderExitCode. Your original files remain in $backupDir"
}
if (-not (Test-Path -LiteralPath $temporaryTheme -PathType Leaf)) {
    Stop-WithMessage "Music extraction did not create the WAV. Your original files remain in $backupDir"
}
if ((Get-Item -LiteralPath $temporaryTheme).Length -lt 100000) {
    Remove-Item -LiteralPath $temporaryTheme -Force
    Stop-WithMessage "The extracted WAV was unexpectedly small. Your original files remain in $backupDir"
}
Move-Item -LiteralPath $temporaryTheme -Destination $watchTheme -Force

Write-Host ''
Write-Host 'SUCCESS: The watch music fix is installed.' -ForegroundColor Green
Write-Host "Backup: $backupDir"
Write-Host "Music extracted locally: $watchTheme"
Write-Host 'Start the game normally with GoldenEye.exe.'
