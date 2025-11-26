#!/bin/bash

echo "=== Vérification de la santé de l'application ==="

# Attendre un peu pour que l'application démarre
sleep 2

echo "Test de l'endpoint de santé..."
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8085/actuator/health)

if [ "$response" = "200" ]; then
    echo "✅ L'application est en bonne santé (HTTP $response)"
    echo "Détails de la santé:"
    curl -s http://localhost:8085/actuator/health | python3 -m json.tool 2>/dev/null || curl -s http://localhost:8085/actuator/health
else
    echo "❌ L'application ne répond pas correctement (HTTP $response)"
    echo "Vérifiez les logs avec: ./scripts/logs.sh"
    exit 1
fi

echo ""
echo "Test de l'endpoint hello..."
curl -s http://localhost:8085/api/users/hello
echo ""