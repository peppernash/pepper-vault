#!/bin/bash
# Stop all sync processes (OpenClaw + GitHub commit + GitHub pull)

echo "🌶️ Stopping full sync..."

# Stop OpenClaw auto-sync
if pgrep -f "start-auto-sync.sh" > /dev/null; then
    ./OpenClaw/stop-auto-sync.sh
else
    echo "ℹ️ OpenClaw auto-sync not running"
fi

# Stop GitHub auto-commit
if pgrep -f "auto-commit.sh" > /dev/null; then
    pkill -f "auto-commit.sh"
    echo "✅ GitHub auto-commit stopped"
else
    echo "ℹ️ GitHub auto-commit not running"
fi

# Stop GitHub auto-pull
if pgrep -f "auto-pull.sh" > /dev/null; then
    pkill -f "auto-pull.sh"
    echo "✅ GitHub auto-pull stopped"
else
    echo "ℹ️ GitHub auto-pull not running"
fi

echo "✅ Full sync stopped"