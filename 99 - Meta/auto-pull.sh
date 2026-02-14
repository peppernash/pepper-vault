#!/bin/bash
# Auto-pull changes from GitHub every 5 minutes
# Keeps VPS vault in sync with local edits

VAULT_DIR="$HOME/Documents/Pepper"
INTERVAL=300  # 5 minutes

cd "$VAULT_DIR"

echo "🌶️ Starting auto-pull from GitHub (every 5 minutes)"
echo "Press Ctrl+C to stop"

while true; do
    # Fetch latest changes
    if git fetch origin main 2>/dev/null; then
        # Check if there are remote changes
        LOCAL=$(git rev-parse HEAD)
        REMOTE=$(git rev-parse origin/main)
        
        if [[ "$LOCAL" != "$REMOTE" ]]; then
            echo "📥 Pulling changes from GitHub..."
            git pull origin main
            echo "✅ Local vault updated with remote changes"
        fi
    else
        echo "⚠️ Failed to fetch from GitHub ($(date '+%H:%M:%S'))"
    fi
    
    sleep $INTERVAL
done