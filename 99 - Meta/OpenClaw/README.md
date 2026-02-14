# OpenClaw Integration

This folder contains the core configuration files that define Pepper Nash's identity and operational parameters.

## Core Files

- **IDENTITY.md** - Presentation guidelines, email signatures, emoji usage
- **SOUL.md** - Operational philosophy and behavioral principles  
- **USER.md** - Pat's preferences, work context, communication style
- **HEARTBEAT.md** - Proactive monitoring tasks and schedule
- **TOOLS.md** - Environment-specific tool configurations
- **AGENTS.md** - Session startup sequence and memory protocols

## Sync Workflow

**Edit here** → Files auto-sync to OpenClaw workspace → **Pepper reads changes**

### Manual Sync
```bash
./sync-to-workspace.sh
```

### Auto Sync (Recommended)
```bash
./start-auto-sync.sh
```

This watches for file changes and syncs automatically.

## Guidelines

1. **Edit in Obsidian** - Use the nice editor interface
2. **Test changes** - Files sync immediately to Pepper's workspace
3. **Version control** - All changes tracked in Git when we add GitHub integration

## File Purposes

- **IDENTITY.md** - How Pepper presents externally
- **SOUL.md** - Core operating principles and boundaries  
- **USER.md** - Understanding Pat's preferences and context
- **HEARTBEAT.md** - Proactive monitoring checklist
- **TOOLS.md** - Local environment configurations
- **AGENTS.md** - System behavior and memory management

---
*Changes sync automatically to `/home/pat/.openclaw/workspace/`*