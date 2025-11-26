Write-Host "=== Affichage des logs de l'application ===" -ForegroundColor Green

if (-not (Test-Path "logs\app.log")) {
    Write-Host "? Aucun fichier de logs trouvé" -ForegroundColor Red
    Write-Host "L'application a-t-elle été démarrée ?" -ForegroundColor Yellow
    exit 1
}

Write-Host "Dernières 30 lignes des logs :" -ForegroundColor Yellow
Write-Host "----------------------------------------" -ForegroundColor Gray
Get-Content "logs\app.log" | Select-Object -Last 30
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host ""
Write-Host "Pour suivre les logs en temps réel, ouvrez: logs\app.log" -ForegroundColor Cyan
