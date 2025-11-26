Write-Host "=== Arrêt de l'application Spring Boot ===" -ForegroundColor Green

Write-Host "Arrêt des processus Java Spring Boot..." -ForegroundColor Yellow

$javaProcesses = Get-Process java -ErrorAction SilentlyContinue | Where-Object {
    $_.ProcessName -eq "java"
}

if ($javaProcesses) {
    foreach ($process in $javaProcesses) {
        Write-Host "Arrêt du processus $($process.Id)..." -ForegroundColor Yellow
        Stop-Process -Id $process.Id -Force
        Write-Host "? Processus $($process.Id) arrêté" -ForegroundColor Green
    }
} else {
    Write-Host "Aucun processus Java trouvé" -ForegroundColor Yellow
}

Write-Host "Vérification du port 8085..." -ForegroundColor Yellow
$portInUse = netstat -ano | findstr :8085

if ($portInUse) {
    Write-Host "? Le port 8085 est encore occupé" -ForegroundColor Red
} else {
    Write-Host "? Le port 8085 est libre" -ForegroundColor Green
}
