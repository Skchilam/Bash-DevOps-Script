#!/bin/bash

# Set threshold percentage (default 80%)
THRESHOLD=80
USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//')

echo "Current disk usage: ${USAGE}%"

if [ "$USAGE" -gt "$THRESHOLD" ]; then
  echo "⚠️ Warning: Disk usage is above ${THRESHOLD}%"
else
  echo "✅ Disk usage is under control"
fi 
