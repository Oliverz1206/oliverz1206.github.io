Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  throw 'git not found. Please install Git for Windows.'
}

$httpProxy  = git config --global --get http.proxy  2>$null
$httpsProxy = git config --global --get https.proxy 2>$null

if (-not [string]::IsNullOrWhiteSpace($httpProxy)) {
  git config --global --unset http.proxy
  Write-Host ('Removed http.proxy (previous: {0})' -f $httpProxy)
} else {
  Write-Host 'http.proxy not set.'
}

if (-not [string]::IsNullOrWhiteSpace($httpsProxy)) {
  git config --global --unset https.proxy
  Write-Host ('Removed https.proxy (previous: {0})' -f $httpsProxy)
} else {
  Write-Host 'https.proxy not set.'
}

Write-Host 'Remaining proxy-related git configs:'
git config -l | Select-String -Pattern 'proxy' -SimpleMatch -ErrorAction SilentlyContinue | ForEach-Object { $_.ToString() }
