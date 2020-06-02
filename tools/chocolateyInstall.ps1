$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageName = 'scla'
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$filePath\${packageName}.application"
$url = 'http://dl.sitecore.net/updater/scla/SitecoreLogAnalyzer.application'

$scriptPath = Split-Path -parent $MyInvocation.MyCommand.Definition
$ahkExe = 'AutoHotKey'
$ahkProcess = "$ahkExe '$scriptPath\scla-install.ahk'"

if (-not (Test-Path $filePath)) {
    New-Item $filePath -type directory
}

Get-ChocolateyWebFile $packageName $fileFullPath $url
Start-Process $fileFullPath -ArgumentList "/s" -Wait
Start-ChocolateyProcessAsAdmin $ahkProcess

$dontQuit = $true
do {
    Start-Sleep -Seconds 1
    $process = Get-Process | `
        ? { $_.mainWindowTItle.Contains("Installing Sitecore Log Analyzer (SCLA)") } | `
        ? { $_.ProcessName -eq "dfsvc" }
    $dontQuit = $process -ne $null
} while ($dontQuit)