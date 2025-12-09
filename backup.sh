#!/bin/bash

CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/configs_backups"
CONFIGS=("kitty" "alacritty" "starship" "nvim" "fastfetch")
EXTRA_FILES=("$HOME/.zshrc" "$0")

mkdir -p "$BACKUP_DIR"

echo "Backing up to $BACKUP_DIR"
echo ""

for cfg in "${CONFIGS[@]}"; do
    SRC_PATH="$CONFIG_DIR/$cfg"
    DEST_PATH="$BACKUP_DIR/$cfg"
    if [[ -d "$SRC_PATH" ]]; then
        rm -rf "$DEST_PATH" 2>/dev/null
        cp -r "$SRC_PATH" "$DEST_PATH"
        echo "Backed up $cfg"
    else
        echo "Skipped $cfg"
    fi
done

for file in "${EXTRA_FILES[@]}"; do
    FILE_NAME="$(basename "$file")"
    DEST_PATH="$BACKUP_DIR/$FILE_NAME"
    if [[ -f "$file" ]]; then
        cp "$file" "$DEST_PATH"
        echo "Backed up $FILE_NAME"
    else
        echo "Skipped $FILE_NAME"
    fi
done

echo ""
echo "Backup complete at $BACKUP_DIR"

