#!/bin/bash
# Git Push Script - VPS Side
# Runs every 30 minutes to push local changes to GitHub

set -euo pipefail

WORKSPACE="/home/pat/.openclaw/workspace"
LOG_FILE="/home/pat/.openclaw/logs/git-sync.log"

# Create log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "=== Git Push Started ==="

# Function to push a repo
push_repo() {
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
    
    # Check if there are changes to commit
    if git diff-index --quiet HEAD -- 2>/dev/null; then
        log "ℹ️  $repo_name: No changes to commit"
        return 0
    fi
    
    # Add all changes
    log "📝 $repo_name: Adding changes..."
    git add -A
    
    # Create commit message with timestamp
    local commit_msg="Auto-commit from VPS: $(date '+%Y-%m-%d %H:%M:%S')"
    
    # Commit changes
    log "💾 $repo_name: Committing changes..."
    if git commit -m "$commit_msg" 2>&1 | tee -a "$LOG_FILE"; then
        log "✅ $repo_name: Commit successful"
    else
        log "❌ $repo_name: Commit failed"
        return 1
    fi
    
    # Push to remote
    log "⬆️  $repo_name: Pushing to origin..."
    if git push origin main 2>&1 | tee -a "$LOG_FILE"; then
        log "✅ $repo_name: Push successful"
    else
        log "❌ $repo_name: Push failed"
        return 1
    fi
}

# Push pepper-vault (main workspace)
push_repo "$WORKSPACE"

# Push secondbrain (when it exists)
if [ -d "/home/pat/secondbrain" ]; then
    push_repo "/home/pat/secondbrain"
fi

# Push yale-content-hub (when it exists)
if [ -d "/home/pat/yale-content-hub" ]; then
    push_repo "/home/pat/yale-content-hub"
fi

log "=== Git Push Complete ==="
