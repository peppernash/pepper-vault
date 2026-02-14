# GitHub Repository Setup

## Step 1: Create Repository on GitHub

1. Go to [github.com/new](https://github.com/new)
2. **Repository name**: `pepper-vault`
3. **Description**: `Personal knowledge management system with OpenClaw integration`
4. **Visibility**: ✅ Private (recommended for personal vault)
5. **Initialize**: ❌ Do NOT initialize with README, .gitignore, or license (we have these)
6. Click **Create repository**

## Step 2: Connect Local Repository

After creating the GitHub repo, run these commands:

```bash
cd ~/Documents/Pepper
git remote add origin https://github.com/patpalingo/pepper-vault.git
git branch -M main
git push -u origin main
```

## Step 3: Enable Auto-Sync (Optional)

```bash
# Start auto-sync for OpenClaw files
./99\ -\ Meta/OpenClaw/start-auto-sync.sh &

# Start auto-commit and push (every 30 minutes)
./99\ -\ Meta/auto-commit.sh &
```

## GitHub Personal Access Token

For secure authentication, create a Personal Access Token:

1. Go to **GitHub Settings** → **Developer settings** → **Personal access tokens** → **Tokens (classic)**
2. **Generate new token**
3. **Scopes**: Select `repo` (Full control of private repositories)
4. **Expiration**: Choose appropriate timeframe
5. **Copy token** and use it as password when pushing

## Authentication Setup

Configure Git to use token authentication:

```bash
git config --global credential.helper store
# Then push once - Git will prompt for username (patpalingo) and password (your token)
```

---

**After setup is complete, your Pepper vault will be:**
- 📝 Editable in Obsidian
- 🔄 Auto-synced to OpenClaw
- 📦 Backed up to GitHub
- 🌐 Accessible from any device