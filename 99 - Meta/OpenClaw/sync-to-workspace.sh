#!/bin/bash
# OpenClaw Workspace Sync Script
# Syncs core files between Obsidian vault and OpenClaw workspace

VAULT_DIR="$HOME/Documents/Pepper/99 - Meta/OpenClaw"
WORKSPACE_DIR="$HOME/.openclaw/workspace"

# Files to sync
FILES=(
    "IDENTITY.md"
    "SOUL.md" 
    "USER.md"
    "HEARTBEAT.md"
    "TOOLS.md"
    "AGENTS.md"
)

echo "🌶️ OpenClaw Sync Starting..."

# Sync from Vault → Workspace (your edits go live)
for file in "${FILES[@]}"; do
    if [[ -f "$VAULT_DIR/$file" ]]; then
        if [[ ! -f "$WORKSPACE_DIR/$file" ]] || [[ "$VAULT_DIR/$file" -nt "$WORKSPACE_DIR/$file" ]]; then
            cp "$VAULT_DIR/$file" "$WORKSPACE_DIR/"
            echo "📤 Synced $file → workspace"
        fi
    fi
done

# Sync from Workspace → Vault (system updates to vault)
for file in "${FILES[@]}"; do
    if [[ -f "$WORKSPACE_DIR/$file" ]]; then
        if [[ ! -f "$VAULT_DIR/$file" ]] || [[ "$WORKSPACE_DIR/$file" -nt "$VAULT_DIR/$file" ]]; then
            cp "$WORKSPACE_DIR/$file" "$VAULT_DIR/"
            echo "📥 Synced $file ← workspace"
        fi
    fi
done

echo "✅ Sync complete"