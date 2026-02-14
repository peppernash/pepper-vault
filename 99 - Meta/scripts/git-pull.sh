#!/bin/bash
# Git Pull Script - VPS Side
# Runs every 5 minutes to pull changes from GitHub

set -euo pipefail

WORKSPACE="/home/pat/.openclaw/workspace"
LOG_FILE="/home/pat/.openclaw/logs/git-sync.log"

# Create log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "=== Git Pull Started ==="

# Function to pull a repo
pull_repo() {
    local repo_path="$1"
    local repo_name=$(basename "$repo_path")
    
    if [ ! -d "$repo_path" ]; then
        log "⚠️  $repo_name: Directory not found at $repo_path"
        return 1
    fi
    
    cd "$repo_path"
    
    # Check if it's a git repo
    if [ ! -d ".git" ]; then
        log "⚠️  $repo_name: Not a git repository"
        return 1
    fi
    
    # Check for remote
    if ! git remote get-url origin &> /dev/null; then
        log "⚠️  $repo_name: No remote configured"
        return 1
    fi
    
    # Check for local changes
    if ! git diff-index --quiet HEAD -- 2>/dev/null; then
        log "⚠️  $repo_name: Has uncommitted changes, skipping pull"
        return 1
    fi
    
    # Pull changes
    log "🔄 $repo_name: Pulling changes..."
    if git pull --rebase origin main 2>&1 | tee -a "$LOG_FILE"; then
        log "✅ $repo_name: Pull successful"
    else
        log "❌ $repo_name: Pull failed"
        return 1
    fi
}

# Pull pepper-vault (main workspace)
pull_repo "$WORKSPACE"

# Pull secondbrain (when it exists)
if [ -d "/home/pat/secondbrain" ]; then
    pull_repo "/home/pat/secondbrain"
fi

# Pull yale-content-hub (when it exists)
if [ -d "/home/pat/yale-content-hub" ]; then
    pull_repo "/home/pat/yale-content-hub"
fi

log "=== Git Pull Complete ==="
