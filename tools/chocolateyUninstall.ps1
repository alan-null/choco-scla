﻿$obj = Get-ChildItem "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\" |
? { $_.GetValueNames().IndexOf("HelpLink") -gt -1 } |
? { $_.GetValue("HelpLink").Contains('https://github.com/Sitecore/sitecore-log-analyzer/issues') } | Select-Object -First 1

if ($obj) {
    $appPathKey = $obj.Name.Replace("HKEY_CURRENT_USER\", "HKCU:\")
    if (Test-Path $appPathKey) {
        $entry = Get-Item $appPathKey
        $entry.GetValue("DisplayVersion")
        $entry.GetValue("DisplayName")

        $scriptPath = Split-Path -parent $MyInvocation.MyCommand.Definition
        $ahkExe = 'AutoHotKey'
        $ahkProcess = "$ahkExe '$scriptPath\scla-uninstall.ahk'"

        $uninst = $entry.GetValue("UninstallString")
        $index = $uninst.IndexOf(" ")
        $exe = $uninst.Substring(0, $index)
        $argz = $uninst.Substring($index, $uninst.Length - $index)
        Start-Process $exe $argz
        Start-ChocolateyProcessAsAdmin $ahkProcess
    }
    else {
        Write-Host $packageName "Nothing to uninstall."
    }
}