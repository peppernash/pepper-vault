#!/bin/bash
# Auto-commit and push changes to GitHub
# Runs every 30 minutes to keep vault synced

VAULT_DIR="$HOME/Documents/Pepper"
COMMIT_INTERVAL=1800  # 30 minutes in seconds

cd "$VAULT_DIR"

echo "🌶️ Starting auto-commit for Pepper vault"
echo "Interval: $((COMMIT_INTERVAL / 60)) minutes"
echo "Press Ctrl+C to stop"

while true; do
    # Check if there are any changes
    if ! git diff --quiet || ! git diff --cached --quiet; then
        # Get current timestamp
        TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
        
        # Add all changes
        git add .
        
        # Create commit with timestamp and changed files
        CHANGED_FILES=$(git diff --cached --name-only | head -5)
        if [[ -n "$CHANGED_FILES" ]]; then
            COMMIT_MSG="Auto-sync: $TIMESTAMP

Changed files:
$(echo "$CHANGED_FILES" | sed 's/^/- /')"
            
            git commit -m "$COMMIT_MSG"
            
            echo "📝 Committed changes at $TIMESTAMP"
            
            # Try to push (will fail gracefully if no internet/auth issues)
            if git push origin main 2>/dev/null; then
                echo "📤 Pushed to GitHub"
            else
                echo "⚠️ Push failed (check internet/auth) - changes saved locally"
            fi
        fi
    else
        echo "💤 No changes detected ($(date '+%H:%M:%S'))"
    fi
    
    sleep $COMMIT_INTERVAL
done