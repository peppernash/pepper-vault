#!/bin/bash
# Content Hub Sync Script - MacBook Side
# Syncs OneDrive Content Hub to local Git repo every 30 minutes
# Run this on the MacBook (not VPS)

set -euo pipefail

# Path to OneDrive Content Hub (adjust as needed)
ONEDRIVE_PATH="$HOME/Library/CloudStorage/OneDrive-Personal/Yale-Content-Hub"

# Path to local Git clone
GIT_REPO_PATH="$HOME/yale-content-hub"

LOG_FILE="$HOME/.openclaw-sync.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "=== Content Hub Sync Started ==="

# Check if OneDrive path exists
if [ ! -d "$ONEDRIVE_PATH" ]; then
    log "❌ OneDrive path not found: $ONEDRIVE_PATH"
    log "⚠️  Please update ONEDRIVE_PATH in this script to match your OneDrive location"
    exit 1
fi

# Check if Git repo exists
if [ ! -d "$GIT_REPO_PATH" ]; then
    log "❌ Git repo not found: $GIT_REPO_PATH"
    log "⚠️  Please clone the yale-content-hub repo first:"
    log "   cd $HOME && git clone <repo-url> yale-content-hub"
    exit 1
fi

# Sync OneDrive → Git (using rsync to preserve file attributes)
log "🔄 Syncing OneDrive Content Hub to Git repo..."
if rsync -av --delete \
    --exclude='.DS_Store' \
    --exclude='.git' \
    --exclude='~$*' \
    --exclude='*.tmp' \
    "$ONEDRIVE_PATH/" "$GIT_REPO_PATH/" \
    2>&1 | tee -a "$LOG_FILE"; then
    log "✅ Sync successful"
else
    log "❌ Sync failed"
    exit 1
fi

# Enter Git repo
cd "$GIT_REPO_PATH"

# Check if there are changes
if git diff-index --quiet HEAD -- 2>/dev/null; then
    log "ℹ️  No changes detected"
    log "=== Content Hub Sync Complete ==="
    exit 0
fi

# Add all changes
log "📝 Adding changes..."
git add -A

# Create commit message with timestamp
COMMIT_MSG="Auto-sync from OneDrive: $(date '+%Y-%m-%d %H:%M:%S')"

# Commit changes
log "💾 Committing changes..."
if git commit -m "$COMMIT_MSG" 2>&1 | tee -a "$LOG_FILE"; then
    log "✅ Commit successful"
else
    log "❌ Commit failed"
    exit 1
fi

# Push to remote
log "⬆️  Pushing to origin..."
if git push origin main 2>&1 | tee -a "$LOG_FILE"; then
    log "✅ Push successful"
else
    log "❌ Push failed"
    exit 1
fi

log "=== Content Hub Sync Complete ==="
