# Local Setup Instructions

## 🖥️ **Set Up on Your Local Machine**

### Step 1: Clone Repository
```bash
# Clone to your local machine
git clone https://github.com/peppernash/pepper-vault.git ~/Documents/Pepper
cd ~/Documents/Pepper
```

### Step 2: Configure Git
```bash
# Set your identity for commits
git config user.name "Pat Palingo"
git config user.email "patpalingo@gmail.com"

# Optional: Save GitHub credentials to avoid repeated login
git config credential.helper store
# Next time you push, enter:
# Username: patpalingo
# Password: [your GitHub personal access token]
```

### Step 3: Open in Obsidian
1. **Open Obsidian**
2. Click **"Open folder as vault"**
3. Navigate to `~/Documents/Pepper`
4. Click **"Open"**

## 🔄 **Daily Workflow**

### Making Changes
1. **Edit in Obsidian** - Use templates, create notes, link between files
2. **Core files** in `99 - Meta/OpenClaw/` sync automatically to Pepper's workspace
3. **Commit changes**:
   ```bash
   cd ~/Documents/Pepper
   git add .
   git commit -m "Your descriptive message"
   git push origin main
   ```

### Automatic Sync (VPS Side)
- **Auto-pull**: VPS pulls your changes every 5 minutes
- **Auto-sync**: Changes sync to OpenClaw workspace within 5 seconds
- **Auto-backup**: VPS commits local changes every 30 minutes

## 📁 **Key Folders**

- **`00 - Inbox`** - Quick capture, unsorted notes
- **`01 - Daily Notes`** - Cmd+P → "Open today's daily note"
- **`02 - Projects`** - Yale Appliance, Personal Tech projects
- **`99 - Meta/OpenClaw`** - **Edit these to change Pepper's behavior!**
  - `IDENTITY.md` - How I present myself
  - `SOUL.md` - My core operating principles
  - `USER.md` - Your preferences and context

## 🎯 **Getting Started**

1. **Create today's daily note**: Cmd/Ctrl+P → "Open today's daily note"
2. **Try templates**: Cmd/Ctrl+P → "Templates: Insert template"
3. **Edit my behavior**: Modify files in `99 - Meta/OpenClaw/`
4. **Link between notes**: Use `[[Note Name]]` syntax

## 🚨 **Important**

- **Don't delete** `99 - Meta/OpenClaw/` files - they control Pepper's behavior
- **Do edit them** in Obsidian - changes sync automatically to the VPS
- **Push regularly** to keep everything in sync across devices

---
*Your edits in Obsidian will be live on the VPS within 5 minutes!*