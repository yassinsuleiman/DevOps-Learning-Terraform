#!/usr/bin/env bash
set -euo pipefail

# --- Safety checks -----------------------------------------------------------
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "❌ Not inside a Git repo. Run this from your repository root."
  exit 1
fi

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "⚠️  You have uncommitted changes. Commit or stash them first."
  exit 1
fi

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
REMOTE="${1:-origin}"
TARGET_BRANCH="${2:-main}"

echo "➡️  Cleaning repo on branch: $BRANCH (remote: $REMOTE, target: $TARGET_BRANCH)"
echo "   This will rewrite history and require a force-push."

# --- Step 0: Create a safety backup branch -----------------------------------
BACKUP="backup/before-terraform-clean-$(date +%Y%m%d-%H%M%S)"
git branch "$BACKUP"
echo "🛟 Backup branch created: $BACKUP"

# --- Step 1: Add .gitignore (Terraform) --------------------------------------
cat > .gitignore <<'EOF'
# Terraform
.terraform/
*.tfstate
*.tfstate.*
crash.log

# Local overrides
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# OS/editor
.DS_Store
EOF

git add .gitignore
git commit -m "chore: add .gitignore for Terraform artifacts" || true

# --- Step 2: Untrack currently tracked Terraform artifacts -------------------
# Remove any tracked .terraform/ and tfstate files (keeps them on disk).
set +e
git ls-files -z | grep -z '\.terraform/' | xargs -0 git rm -r --cached
git ls-files -z | grep -z '\.tfstate'     | xargs -0 git rm -r --cached
set -e
git commit -m "chore: stop tracking .terraform and tfstate" || true

# --- Step 3: Ensure git-filter-repo is available ------------------------------
if ! command -v git-filter-repo >/dev/null 2>&1; then
  echo "⚠️  git-filter-repo not found."
  echo "   Install it, then re-run this script:"
  echo "     - macOS (Homebrew):  brew install git-filter-repo"
  echo "     - Python (pip):      pip install git-filter-repo"
  exit 1
fi

# --- Step 4: Rewrite history to purge big binaries & .terraform ---------------
# This permanently removes paths from ALL commits (past and present).
git filter-repo --force --invert-paths \
  --path-glob '.terraform/**' \
  --path-glob '*terraform-provider-aws_*'

echo "🧹 History rewritten to remove .terraform and provider binaries."

# --- Step 5: Verify nothing heavy remains (optional sanity) -------------------
echo "🔎 Checking for tracked .terraform entries (should be none):"
git ls-files | grep '\.terraform/' && echo "❌ Found tracked .terraform paths!" && exit 1 || echo "✅ None found."

# --- Step 6: Push rewritten history ------------------------------------------
echo "⬆️  Force-pushing cleaned branch to $REMOTE/$TARGET_BRANCH (with lease)…"
git push --force-with-lease "$REMOTE" "$TARGET_BRANCH"

cat <<MSG

✅ Done.

If others have cloned this repo, they must resync:
  git fetch $REMOTE
  git reset --hard $REMOTE/$TARGET_BRANCH

Notes:
- .terraform/ and *.tfstate are now ignored and untracked.
- Keep committing .terraform.lock.hcl if you want reproducible providers.
- Use a remote backend (S3 + DynamoDB lock) so state files never hit Git.

MSG
