#!/bin/bash

# Script to remove CPA banner from .zshrc

ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"

# Validasi file exists
if [ ! -f "$ZSHRC" ]; then
    echo "Error: $ZSHRC tidak ditemukan!"
    exit 1;
fi

echo "Backing up .zshrc to $BACKUP..."
cp "$ZSHRC" "$BACKUP" || { echo "Backup failed"; exit 1; }

echo "Removing banner section..."

TEMP_FILE=$(mktemp) || { echo "Failed to create temp file"; exit 1; }

awk '
/^# CPA Centered Figlet Banner \+ Spinner$/ { skip=1; next }
skip && /^fi$/ { skip=0; next }
!skip { print }
' "$ZSHRC" > "$TEMP_FILE"

if [ ! -s "$TEMP_FILE" ]; then
    echo "Error: Filter hasil kosong, membatalkan..."
    rm "$TEMP_FILE"
    exit 1;
fi

mv "$TEMP_FILE" "$ZSHRC"

echo "Banner removed successfully!"
echo "Run 'source ~/.zshrc' or restart your terminal to apply changes."
echo "Backup saved at: $BACKUP"