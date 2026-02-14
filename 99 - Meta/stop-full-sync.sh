#!/bin/bash
# Stop both OpenClaw sync and GitHub auto-commit

echo "🌶️ Stopping full sync..."

# Stop OpenClaw auto-sync
if pgrep -f "start-auto-sync.sh" > /dev/null; then
    ./OpenClaw/stop-auto-sync.sh
else
    echo "ℹ️ OpenClaw auto-sync not running"
fi

# Stop GitHub auto-commit
if pgrep -f "auto-commit.sh" > /dev/null; then
    ./stop-auto-commit.sh
else
    echo "ℹ️ GitHub auto-commit not running"
fi

echo "✅ Full sync stopped"