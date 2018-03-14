$packageName = 'scla'
$url = 'https://marketplace.sitecore.net/services/~/media/Marketplace/Modules/S/Sitecore_Log_Analyzer/packages/SCLA_2,-d-,0,-d-,0_rev,-d-,_140603.ashx'

Install-ChocolateyZipPackage $packageName $url "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$workingDirectory = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
Install-ChocolateyShortcut -ShortcutFilePath "$workingDirectory\Sitecore Log Analyzer.lnk" -TargetPath "$toolsPath\SCLA.Launcher.exe" -WorkingDirectory $toolsPath