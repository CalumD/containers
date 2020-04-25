#!/bin/bash

MAPPED_DIR='/mnt/user/appdata/minecraft'
MAP_NAME=$(grep -o "level-name=.*" "$MAPPED_DIR/server.properties" | cut -f'2' -d'=' -)
echo "Map to backup: ${MAP_NAME}, from directory: ${MAPPED_DIR}"

BACKUP_DIR="${MAPPED_DIR}/BACKUPS"
echo "Asserting existence of backup dir: ${BACKUP_DIR}"
mkdir -p "${BACKUP_DIR}"

echo "Executing RSYNC: ${BACKUP_DIR}"
rsync -vrp --delete "$MAPPED_DIR/$MAP_NAME" "$BACKUP_DIR"

echo "Backup Complete"
