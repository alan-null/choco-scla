$packageName = 'scla'
$url = 'https://marketplace.sitecore.net/services/~/media/Marketplace/Modules/S/Sitecore_Log_Analyzer/packages/SCLA_2,-d-,0,-d-,0_rev,-d-,_140603.ashx'

Install-ChocolateyZipPackage $packageName $url "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
