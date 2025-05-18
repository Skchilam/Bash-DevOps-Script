#!/bin/bash

# Check if source and destination are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <source_directory> <backup_directory>"
  exit 1
fi

SOURCE=$1
DEST=$2
DATE=$(date +%Y-%m-%d_%H-%M-%S)
FILENAME="backup_${DATE}.tar.gz"

# Create backup
tar -czf "${DEST}/${FILENAME}" "$SOURCE"

# Notify user
if [ $? -eq 0 ]; then
  echo "Backup successful: ${DEST}/${FILENAME}"
else
  echo "Backup failed!"
fi
