$ports = 5500,8080,3000,9000,10000,49152
$started = $false
foreach ($p in $ports) {
    $t = Test-NetConnection -ComputerName 'localhost' -Port $p -WarningAction SilentlyContinue
    if (-not $t.TcpTestSucceeded) {
        Write-Host "Starting serve.ps1 on port $p"
        Start-Process -NoNewWindow -FilePath 'powershell' -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File 'c:\\Users\\rajez\\Desktop\\loch-quarry-website\\serve.ps1' -Port $p"
        $started = $true
        Write-Host "Server started in background on port $p"
        break
    } else {
        Write-Host "Port $p in use"
    }
}
if (-not $started) { Write-Host 'No free ports found in list. Try running script manually with a different port.' }
