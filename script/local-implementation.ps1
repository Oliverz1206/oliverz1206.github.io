param(
  # Optional: override proxy from parameter or env var GIT_HTTP_PROXY
  [string]$Proxy = $env:GIT_HTTP_PROXY
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($Proxy)) { $Proxy = 'http://127.0.0.1:7890' }

# Tool checks
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  throw 'git not found. Please install Git for Windows.'
}
if (-not (Get-Command bundle -ErrorAction SilentlyContinue)) {
  throw 'bundle not found. Please ensure Ruby/Bundler is installed and on PATH.'
}

# Read existing global proxy
$httpProxy  = git config --global --get http.proxy  2>$null
$httpsProxy = git config --global --get https.proxy 2>$null

if ([string]::IsNullOrWhiteSpace($httpProxy) -or [string]::IsNullOrWhiteSpace($httpsProxy)) {
  Write-Host ('Git proxy not set. Applying: {0}' -f $Proxy)
  git config --global http.proxy  $Proxy
  git config --global https.proxy $Proxy
} else {
  Write-Host ('Git proxy already set: http.proxy={0}; https.proxy={1}' -f $httpProxy, $httpsProxy)
}

# Optional: enterprise TLS interception
# git config --global http.sslbackend schannel

if (-not (Test-Path -Path 'Gemfile')) {
  Write-Warning 'Gemfile not found in current directory. Are you in the Jekyll site root?'
}

Write-Host 'Running: bundle exec jekyll clean'
& bundle exec jekyll clean

Write-Host 'Starting: bundle exec jekyll serve'
& bundle exec jekyll serve
