#!/bin/bash
# Auto-sync script for OpenClaw files
# Polls for file changes and syncs automatically

VAULT_DIR="$HOME/Documents/Pepper/99 - Meta/OpenClaw"
SYNC_SCRIPT="$VAULT_DIR/sync-to-workspace.sh"
INTERVAL=5  # Check every 5 seconds

echo "🌶️ Starting OpenClaw auto-sync (every ${INTERVAL}s)"
echo "Press Ctrl+C to stop"
echo "Watching: $VAULT_DIR"

# Create a checksum file to track changes
CHECKSUM_FILE="$VAULT_DIR/.sync-checksums"

while true; do
    # Generate current checksums
    CURRENT_CHECKSUMS=$(find "$VAULT_DIR" -name "*.md" -not -path "*/.git/*" -exec md5sum {} \; 2>/dev/null | sort)
    
    # Check if checksums changed
    if [[ -f "$CHECKSUM_FILE" ]]; then
        PREVIOUS_CHECKSUMS=$(cat "$CHECKSUM_FILE")
        if [[ "$CURRENT_CHECKSUMS" != "$PREVIOUS_CHECKSUMS" ]]; then
            echo "📝 Changes detected, syncing..."
            "$SYNC_SCRIPT"
        fi
    else
        echo "🔄 First run, creating checksum baseline"
        "$SYNC_SCRIPT"
    fi
    
    # Update checksum file
    echo "$CURRENT_CHECKSUMS" > "$CHECKSUM_FILE"
    
    sleep $INTERVAL
done