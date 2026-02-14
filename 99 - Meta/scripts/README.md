# Git Sync Scripts - Setup Instructions

## Overview

These scripts enable automatic synchronization between:
1. **MacBook** (local editing)
2. **GitHub** (central repository)
3. **VPS** (OpenClaw agents)

## Three Repositories

### 1. pepper-vault (Already exists)
- **Purpose:** Agent configs, memory, projects
- **Location (MacBook):** `~/Documents/Pepper/`
- **Location (VPS):** `/home/pat/.openclaw/workspace/`
- **Status:** ✅ Exists, needs GitHub remote

### 2. secondbrain (To create)
- **Purpose:** Knowledge base, personal areas
- **Location (MacBook):** `~/Documents/SecondBrain/`
- **Location (VPS):** `/home/pat/secondbrain/`
- **Status:** ❌ Needs to be created

### 3. yale-content-hub (To create)
- **Purpose:** Product data, templates, brand voice
- **Location (MacBook):** `~/Library/CloudStorage/OneDrive-.../Yale-Content-Hub/`
- **Location (MacBook Git):** `~/yale-content-hub/` (Git clone)
- **Location (VPS):** `/home/pat/yale-content-hub/`
- **Status:** ❌ Needs to be created

## Setup Steps

### Step 1: Create GitHub Repositories

On GitHub (https://github.com):
1. Create private repo: `peppernash/pepper-vault`
2. Create private repo: `peppernash/secondbrain`
3. Create private repo: `peppernash/yale-content-hub`

### Step 2: Connect pepper-vault to GitHub (VPS)

```bash
cd /home/pat/.openclaw/workspace/
git remote add origin git@github.com:peppernash/pepper-vault.git
git branch -M main
git push -u origin main
```

### Step 3: Initialize SecondBrain Git Repo (MacBook)

```bash
cd ~/Documents/SecondBrain/
git init
cp ~/Documents/Pepper/99\ -\ Meta/scripts/secondbrain.gitignore .gitignore
git add -A
git commit -m "Initial commit: SecondBrain vault"
git branch -M main
git remote add origin git@github.com:peppernash/secondbrain.git
git push -u origin main
```

### Step 4: Initialize Yale Content Hub Git Repo (MacBook)

```bash
cd ~
git clone git@github.com:peppernash/yale-content-hub.git

# Initial sync from OneDrive
rsync -av --exclude='.DS_Store' --exclude='~$*' \
  ~/Library/CloudStorage/OneDrive-Personal/Yale-Content-Hub/ \
  ~/yale-content-hub/

cd ~/yale-content-hub
cp ~/Documents/Pepper/99\ -\ Meta/scripts/yale-content-hub.gitignore .gitignore
git add -A
git commit -m "Initial commit: Yale Content Hub"
git push -u origin main
```

### Step 5: Clone Repos on VPS

```bash
# Clone SecondBrain
cd /home/pat/
git clone git@github.com:peppernash/secondbrain.git

# Clone Yale Content Hub
git clone git@github.com:peppernash/yale-content-hub.git
```

### Step 6: Set Up Cron Jobs (VPS)

Add to crontab (`crontab -e`):

```bash
# Git sync (pull every 5 min, push every 30 min)
*/5 * * * * /home/pat/.openclaw/workspace/99\ -\ Meta/scripts/git-pull.sh
*/30 * * * * /home/pat/.openclaw/workspace/99\ -\ Meta/scripts/git-push.sh
```

### Step 7: Set Up MacBook Sync (MacBook)

Add to crontab (`crontab -e`):

```bash
# Content Hub sync every 30 minutes
*/30 * * * * ~/Documents/Pepper/99\ -\ Meta/scripts/sync-content-hub-to-git.sh
```

## Sync Flow

```
MacBook OneDrive Content Hub
    ↓ (every 30 min)
MacBook Git Clone
    ↓ (push to GitHub)
GitHub Repository
    ↓ (VPS pulls every 5 min)
VPS yale-content-hub/
```

## Testing Sync

### Test 1: MacBook → VPS

1. On MacBook: Edit a file in `~/Documents/Pepper/`
2. Wait for auto-sync (or run manually): `cd ~/Documents/Pepper && git add -A && git commit -m "test" && git push`
3. On VPS: Wait 5 min or run manually: `/home/pat/.openclaw/workspace/99\ -\ Meta/scripts/git-pull.sh`
4. On VPS: Verify file changed: `cat /home/pat/.openclaw/workspace/[your-file]`

### Test 2: VPS → MacBook

1. On VPS: Edit a file in `/home/pat/.openclaw/workspace/`
2. Wait for auto-sync (or run manually): `/home/pat/.openclaw/workspace/99\ -\ Meta/scripts/git-push.sh`
3. On MacBook: Wait for sync or run: `cd ~/Documents/Pepper && git pull`
4. On MacBook: Verify file changed

### Test 3: OneDrive → VPS

1. On MacBook: Edit a file in OneDrive Yale Content Hub
2. Wait 30 min or run manually: `~/Documents/Pepper/99\ -\ Meta/scripts/sync-content-hub-to-git.sh`
3. On VPS: Wait 5 min or run: `/home/pat/.openclaw/workspace/99\ -\ Meta/scripts/git-pull.sh`
4. On VPS: Verify file changed in `/home/pat/yale-content-hub/`

## Troubleshooting

### Logs

Check sync logs:
```bash
# VPS
tail -f /home/pat/.openclaw/logs/git-sync.log

# MacBook
tail -f ~/.openclaw-sync.log
```

### Manual Sync

If auto-sync fails, run scripts manually to see errors:
```bash
# VPS pull
/home/pat/.openclaw/workspace/99\ -\ Meta/scripts/git-pull.sh

# VPS push
/home/pat/.openclaw/workspace/99\ -\ Meta/scripts/git-push.sh

# MacBook Content Hub sync
~/Documents/Pepper/99\ -\ Meta/scripts/sync-content-hub-to-git.sh
```

### Git Conflicts

If you get merge conflicts:
1. On VPS: `git stash` to save local changes
2. Pull: `git pull origin main`
3. Apply stash: `git stash pop`
4. Resolve conflicts manually
5. Commit and push

## Security Note

These scripts use Git SSH authentication. Make sure:
1. SSH keys are set up on both MacBook and VPS
2. SSH keys are added to your GitHub account
3. Private repos are used (content is sensitive)

## Status

- [x] Scripts created
- [x] Scripts made executable
- [x] .gitignore templates created
- [ ] GitHub repos created
- [ ] pepper-vault connected to GitHub
- [ ] SecondBrain repo initialized
- [ ] Yale Content Hub repo initialized
- [ ] Repos cloned on VPS
- [ ] Cron jobs set up (VPS)
- [ ] Cron jobs set up (MacBook)
- [ ] Sync tested end-to-end

---

**Next:** Follow setup steps above to complete Phase 0 infrastructure.
