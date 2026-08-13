#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
IGNORE_FILE="$SCRIPT_DIR/rclone-ignore.txt"
LOG_FILE="/home/ale/Logs/backup/gdrive_backup.log"

declare -A LOCAL_TO_REMOTE=(
  ["/home/ale/Documents"]="gdrive:Backup/Documents"
  ["/home/ale/Pictures"]="gdrive:Backup/Pictures"
  ["/home/ale/Music"]="gdrive:Backup/Music"
)

for LOCAL_DIR in "${!LOCAL_TO_REMOTE[@]}"; do
  REMOTE_DIR="${LOCAL_TO_REMOTE[$LOCAL_DIR]}"
  rclone copy "$LOCAL_DIR" "$REMOTE_DIR" \
    --verbose \
    --transfers 4 \
    --checkers 8 \
    --delete-during \
    --timeout 5m \
    --contimeout 1m \
    --log-file "$LOG_FILE" \
    --log-file-max-size 100M \
    --exclude-from "$IGNORE_FILE"
done
