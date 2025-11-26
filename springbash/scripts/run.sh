#!/bin/bash

echo "=== Démarrage de l'application Spring Boot ==="

# Vérifier si Maven est installé
if ! command -v mvn &> /dev/null; then
    echo "Erreur: Maven n'est pas installé ou n'est pas dans le PATH"
    exit 1
fi

# Vérifier si le répertoire logs existe
if [ ! -d "logs" ]; then
    mkdir logs
    echo "Répertoire logs créé"
fi

echo "Compilation et démarrage de l'application..."
echo "Les logs seront sauvegardés dans logs/app.log"

# Démarrer l'application en arrière-plan
nohup mvn spring-boot:run > logs/app.log 2>&1 &

# Sauvegarder le PID
echo $! > logs/app.pid

echo "Application démarrée avec succès (PID : $!)"
echo "Vérifiez les logs avec: ./scripts/logs.sh"
echo "Arrêtez l'application avec: ./scripts/stop.sh"