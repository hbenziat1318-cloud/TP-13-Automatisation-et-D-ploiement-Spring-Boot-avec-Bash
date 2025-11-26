#!/bin/bash

echo "=== Archivage des logs ==="

if [ ! -d "logs" ]; then
    echo "Aucun répertoire logs trouvé."
    exit 1
fi

if [ -z "$(ls -A logs)" ]; then
    echo "Le répertoire logs est vide."
    exit 1
fi

DATE=$(date +%Y%m%d_%H%M%S)
ARCHIVE_NAME="logs_$DATE.tar.gz"

echo "Création de l'archive $ARCHIVE_NAME..."
tar -czf "$ARCHIVE_NAME" logs/

if [ $? -eq 0 ]; then
    echo "✅ Archive créée avec succès: $ARCHIVE_NAME"
    echo "Taille de l'archive: $(du -h $ARCHIVE_NAME | cut -f1)"
else
    echo "❌ Erreur lors de la création de l'archive"
    exit 1
fi