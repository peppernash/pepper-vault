#!/bin/bash
# Stop the auto-commit process

echo "🌶️ Stopping auto-commit..."

# Kill any running auto-commit processes
pkill -f "auto-commit.sh"

if [[ $? -eq 0 ]]; then
    echo "✅ Auto-commit stopped"
else
    echo "ℹ️ No auto-commit process was running"
fi