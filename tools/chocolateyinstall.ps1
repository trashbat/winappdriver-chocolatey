$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/microsoft/WinAppDriver/releases/download/v1.1.1/WindowsApplicationDriver.msi'

If ([Environment]::OSVersion.Version -lt (New-Object 'Version' 10,0)) {
  Write-Error "WinAppDriver requires Windows 10."
  throw $_.Exception
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'MSI'
  url            = $url
  softwareName   = 'Windows Application Driver'
  checksum       = 'E659B59CD5E4F20D60F2B18D14F9B18865C85D5A2F2FEB3883954E2DD0638F5D'
  checksumType   = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
