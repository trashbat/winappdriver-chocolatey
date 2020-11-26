$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://github.com/microsoft/WinAppDriver/releases/download/v1.2.1/WindowsApplicationDriver_1.2.1.msi'

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
  checksum       = 'A76A8F4E44B29BAD331ACF6B6C248FCC65324F502F28826AD2ACD5F3C80857FE'
  checksumType   = 'sha256'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
