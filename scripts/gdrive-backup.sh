#!/bin/bash

LOCAL_DIR="/home/ale/Documents"
REMOTE_DIR="gdrive:Backup/Documents"
LOG_FILE="/home/ale/Logs/backup/gdrive_backup.log"

rclone copy "$LOCAL_DIR" "$REMOTE_DIR" \
  --verbose \
  --transfers 4 \
  --checkers 8 \
  --delete-during \
  --timeout 5m \
  --contimeout 1m \
  --log-file "$LOG_FILE" \
  --log-file-max-size 100M
