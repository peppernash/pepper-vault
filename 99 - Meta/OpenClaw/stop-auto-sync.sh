#!/bin/bash
# Stop the auto-sync process

echo "🌶️ Stopping OpenClaw auto-sync..."

# Kill any running auto-sync processes
pkill -f "start-auto-sync.sh"

if [[ $? -eq 0 ]]; then
    echo "✅ Auto-sync stopped"
else
    echo "ℹ️ No auto-sync process was running"
fi

# Clean up checksum file
rm -f "$HOME/Documents/Pepper/99 - Meta/OpenClaw/.sync-checksums"