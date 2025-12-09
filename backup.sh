#!/bin/bash

CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/configs_backups"

CONFIGS=("kitty" "alacritty" "starship" "nvim" "fastfetch")
EXTRA_FILES=("$HOME/.zshrc" "$0")

mkdir -p "$BACKUP_DIR"

echo "Backing up to $BACKUP_DIR"
echo ""

echo "Cleaning extra files"
EXPECTED_ITEMS=("${CONFIGS[@]}")
for f in "${EXTRA_FILES[@]}"; do
    EXPECTED_ITEMS+=("$(basename "$f")")
done
for item in "$BACKUP_DIR"/*; do
    base_item="$(basename "$item")"
    if [[ ! " ${EXPECTED_ITEMS[*]} " =~ " ${base_item} " ]]; then
        rm -rf "$item"
        echo "Removed $base_item"
    fi
done
echo ""

echo "Backing up config folders"
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

echo "Backing up extra files"
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
echo ""

echo "Checking git repo"
if [[ -d "$BACKUP_DIR/.git" ]]; then
    read -p "Commit & push? [Y/n]: " ans
    ans=${ans:-Y}
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        cd "$BACKUP_DIR" || exit
        TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
        git add .
        git commit -m "Backup: $TIMESTAMP"
        git push
        echo "Changes pushed"
    else
        echo "Skipped commit"
    fi
else
    echo "No git repo found"
fi
