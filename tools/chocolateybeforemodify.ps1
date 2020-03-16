$winappdriver = Get-Process WinAppDriver -ErrorAction SilentlyContinue

if ($winappdriver) {
    $winappdriver.CloseMainWindow()

    Start-Sleep 5
    $winappdriver | Stop-Process -Force
}
