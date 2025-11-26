Write-Host "=== Démarrage de l'application Spring Boot ===" -ForegroundColor Green

try {
    $null = Get-Command mvn -ErrorAction Stop
    Write-Host "? Maven trouvé" -ForegroundColor Green
} catch {
    Write-Host "? Erreur: Maven n'est pas installé" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path "logs")) {
    New-Item -ItemType Directory -Path "logs" | Out-Null
    Write-Host "? Répertoire logs créé" -ForegroundColor Green
}

Write-Host "Compilation et démarrage de l'application..." -ForegroundColor Yellow
Write-Host "Les logs seront sauvegardés dans logs\app.log" -ForegroundColor Yellow

Start-Process -NoNewWindow -FilePath "mvn" -ArgumentList "spring-boot:run" -RedirectStandardOutput "logs\app.log"

Write-Host "? Application démarrée en arrière-plan" -ForegroundColor Green
Write-Host "Vérifiez les logs avec: .\scripts\logs.ps1" -ForegroundColor Cyan
Write-Host "Arrêtez l'application avec: .\scripts\stop.ps1" -ForegroundColor Cyan
