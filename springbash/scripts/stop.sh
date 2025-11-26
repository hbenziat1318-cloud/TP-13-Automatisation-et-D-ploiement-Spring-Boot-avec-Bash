#!/bin/bash

echo "=== Arrêt de l'application Spring Boot ==="

# Vérifier si le fichier PID existe
if [ -f "logs/app.pid" ]; then
    PID=$(cat logs/app.pid)
    echo "Arrêt du processus $PID..."

    if kill -0 $PID 2>/dev/null; then
        kill -15 $PID
        echo "Signal d'arrêt envoyé au processus $PID"

        # Attendre que le processus se termine
        sleep 5

        if kill -0 $PID 2>/dev/null; then
            echo "Forçage de l'arrêt du processus $PID..."
            kill -9 $PID
        fi
    else
        echo "Le processus $PID n'est pas en cours d'exécution"
    fi

    # Supprimer le fichier PID
    rm -f logs/app.pid
    echo "Fichier PID supprimé"
else
    echo "Aucun fichier PID trouvé. Recherche des processus Spring Boot..."

    # Recherche alternative des processus
    PID=$(ps aux | grep 'spring-boot:run' | grep -v grep | awk '{print $2}')

    if [ -z "$PID" ]; then
        echo "Aucun processus Spring Boot trouvé."
    else
        echo "Processus Spring Boot trouvé: $PID"
        kill -9 $PID
        echo "Processus $PID arrêté avec succès."
    fi
fi

echo "Vérification de la libération du port 8085..."
if lsof -ti:8085 > /dev/null; then
    echo "Le port 8085 est encore occupé. Nettoyage..."
    lsof -ti:8085 | xargs kill -9
else
    echo "Le port 8085 est libre."
fi