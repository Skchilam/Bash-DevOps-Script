#!/bin/bash

HOSTS_FILE="hosts.txt"
LOG_FILE="ping_results.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Check if hosts file exists
if [ ! -f "$HOSTS_FILE" ]; then
  echo "❌ $HOSTS_FILE not found!"
  exit 1
fi

echo "===== Ping Test Started at $TIMESTAMP =====" >> "$LOG_FILE"

while read -r HOST; do
  if ping -c 1 -W 1 "$HOST" > /dev/null 2>&1; then
    echo "$TIMESTAMP ✅ $HOST is reachable" >> "$LOG_FILE"
  else
    echo "$TIMESTAMP ❌ $HOST is unreachable" >> "$LOG_FILE"
  fi
done < "$HOSTS_FILE"

echo "Ping test complete. Results saved to $LOG_FILE"
