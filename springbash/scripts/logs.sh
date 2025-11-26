#!/bin/bash

echo "=== Affichage des logs de l'application ==="

if [ ! -f "logs/app.log" ]; then
    echo "Aucun fichier de logs trouvé."
    echo "L'application a-t-elle été démarrée ?"
    exit 1
fi

echo "Dernières 30 lignes des logs :"
echo "----------------------------------------"
tail -n 30 logs/app.log
echo "----------------------------------------"
echo ""
echo "Pour suivre les logs en temps réel, utilisez: tail -f logs/app.log"