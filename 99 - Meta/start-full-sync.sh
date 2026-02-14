#!/bin/bash
# Start full Pepper vault sync (OpenClaw + GitHub + auto-pull)

VAULT_DIR="$HOME/Documents/Pepper/99 - Meta"

echo "🌶️ Starting full Pepper vault sync..."

# Start OpenClaw auto-sync in background
if ! pgrep -f "start-auto-sync.sh" > /dev/null; then
    cd "$VAULT_DIR/OpenClaw" && ./start-auto-sync.sh &
    echo "✅ OpenClaw auto-sync started"
else
    echo "ℹ️ OpenClaw auto-sync already running"
fi

# Start GitHub auto-commit in background
if ! pgrep -f "auto-commit.sh" > /dev/null; then
    cd "$VAULT_DIR" && ./auto-commit.sh &
    echo "✅ GitHub auto-commit started"
else
    echo "ℹ️ GitHub auto-commit already running"
fi

# Start GitHub auto-pull in background
if ! pgrep -f "auto-pull.sh" > /dev/null; then
    cd "$VAULT_DIR" && ./auto-pull.sh &
    echo "✅ GitHub auto-pull started"
else
    echo "ℹ️ GitHub auto-pull already running"
fi

echo "
🔄 Full sync active:
- Obsidian ↔ OpenClaw (every 5s)
- GitHub push (every 30min)
- GitHub pull (every 5min)

To stop: ./stop-full-sync.sh
"