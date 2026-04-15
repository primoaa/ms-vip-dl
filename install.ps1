# ============================================================
#  MANDO SPORT VIP V45 - Silent Installer
#  This script downloads and installs MANDO SPORT VIP
#  without triggering SmartScreen warnings.
# ============================================================

$ErrorActionPreference = "Stop"

$appName     = "MANDO SPORT VIP"
$installDir  = Join-Path $env:LOCALAPPDATA $appName
$downloadUrl = "https://github.com/primoaa/ms-vip-dl/releases/download/v45/MANDO_SPORT_VIP_Setup.exe"
$setupFile   = Join-Path $env:TEMP "MANDO_SPORT_VIP_Setup.exe"

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   MANDO SPORT VIP V45 - Installation" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# --- Step 1: Download ---
Write-Host "[1/3] Downloading installer..." -ForegroundColor Yellow
# Using .NET WebClient -> does NOT add Mark of the Web (MOTW)
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($downloadUrl, $setupFile)
Write-Host "      Downloaded successfully!" -ForegroundColor Green

# --- Step 2: Remove MOTW (safety net) ---
Write-Host "[2/3] Preparing installation..." -ForegroundColor Yellow
if (Test-Path "$setupFile" -PathType Leaf) {
    # Remove Zone.Identifier stream (Mark of the Web) if it exists
    Remove-Item -Path $setupFile -Stream "Zone.Identifier" -ErrorAction SilentlyContinue
}
Write-Host "      Ready!" -ForegroundColor Green

# --- Step 3: Run installer silently ---
Write-Host "[3/3] Installing..." -ForegroundColor Yellow
Write-Host "      The installer will open now." -ForegroundColor Yellow
Write-Host ""

# Run the Inno Setup installer (with /SILENT for quiet install, or without for wizard)
Start-Process -FilePath $setupFile -ArgumentList "/SILENT" -Wait

# Cleanup
Remove-Item $setupFile -Force -ErrorAction SilentlyContinue

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "   Installation complete!" -ForegroundColor Green
Write-Host "   Launch from desktop shortcut." -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
