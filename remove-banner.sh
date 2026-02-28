#!/bin/bash

# Script to remove CPA banner from .zshrc

ZSHRC="$HOME/.zshrc"
BACKUP="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"

# Backup original file
echo "Backing up .zshrc to $BACKUP..."
cp "$ZSHRC" "$BACKUP"

# Remove the banner section using sed
# This removes from "# CPA Centered Figlet Banner + Spinner" to the closing "fi"
echo "Removing banner section..."

# Create a temporary file
TEMP_FILE=$(mktemp)

# Use awk to remove the banner block
awk '
/^# CPA Centered Figlet Banner \+ Spinner$/ { skip=1; next }
skip && /^fi$/ && !/echo/ { skip=0; next }
!skip { print }
' "$ZSHRC" > "$TEMP_FILE"

# Replace original file
mv "$TEMP_FILE" "$ZSHRC"

echo "Banner removed successfully!"
echo "Run 'source ~/.zshrc' or restart your terminal to apply changes."
echo "Backup saved at: $BACKUP"
