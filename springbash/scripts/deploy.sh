#!/bin/bash

echo "=== Déploiement de l'application Spring Boot ==="

# Vérifier si Maven est installé
if ! command -v mvn &> /dev/null; then
    echo "Erreur: Maven n'est pas installé ou n'est pas dans le PATH"
    exit 1
fi

# Vérifier si Java est installé
if ! command -v java &> /dev/null; then
    echo "Erreur: Java n'est pas installé ou n'est pas dans le PATH"
    exit 1
fi

# Arrêter l'application si elle est en cours d'exécution
if [ -f "scripts/stop.sh" ]; then
    ./scripts/stop.sh
    sleep 2
fi

echo "Nettoyage et compilation du projet..."
mvn clean package -DskipTests

if [ $? -ne 0 ]; then
    echo "Erreur lors de la compilation du projet"
    exit 1
fi

echo "Création du répertoire logs si nécessaire..."
if [ ! -d "logs" ]; then
    mkdir logs
fi

echo "Démarrage de la nouvelle version..."
nohup java -jar target/springbash-1.0.0.jar > logs/deploy.log 2>&1 &

# Sauvegarder le PID
echo $! > logs/app.pid

echo "Nouvelle version déployée avec succès (PID : $!)"
echo "Logs de déploiement: logs/deploy.log"
echo "Application principale: logs/app.log"

# Attendre un peu et vérifier le statut
sleep 3
echo ""
echo "Vérification du statut de l'application..."
./scripts/healthcheck.sh