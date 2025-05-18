#!/bin/bash

CSV_FILE="users.csv"

if [ "$(id -u)" -ne 0 ]; then
  echo "❌ Please run as root or with sudo."
  exit 1
fi

if [ ! -f "$CSV_FILE" ]; then
  echo "❌ File $CSV_FILE not found!"
  exit 1
fi

while IFS=',' read -r username action group; do
  # Skip header or empty lines
  [[ "$username" == "username" || -z "$username" ]] && continue

  if [[ "$action" == "create" ]]; then
    if id "$username" &>/dev/null; then
      echo "⚠️ User $username already exists."
    else
      useradd -m "$username"
      echo "$username:Welcome123" | chpasswd
      echo "✅ Created user $username with default password."

      if [[ -n "$group" ]]; then
        groupadd -f "$group"
        usermod -aG "$group" "$username"
        echo "➕ Added $username to group $group"
      fi
    fi
  elif [[ "$action" == "delete" ]]; then
    if id "$username" &>/dev/null; then
      userdel -r "$username"
      echo "🗑️ Deleted user $username"
    else
      echo "⚠️ User $username does not exist."
    fi
  else
    echo "❌ Invalid action for $username: $action"
  fi
done < "$CSV_FILE"
