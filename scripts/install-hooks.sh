#!/bin/bash
# Install optional git hooks for commit validation

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
GIT_HOOKS_DIR="$REPO_ROOT/.git/hooks"
SOURCE_HOOKS_DIR="$REPO_ROOT/.git-hooks"

echo "Installing git hooks..."

# Ensure .git/hooks directory exists
mkdir -p "$GIT_HOOKS_DIR"

# Install pre-push hook
if [ -f "$SOURCE_HOOKS_DIR/pre-push" ]; then
    cp "$SOURCE_HOOKS_DIR/pre-push" "$GIT_HOOKS_DIR/pre-push"
    chmod +x "$GIT_HOOKS_DIR/pre-push"
    echo "✅ Installed pre-push hook"
else
    echo "❌ Error: pre-push hook not found at $SOURCE_HOOKS_DIR/pre-push"
    exit 1
fi

echo ""
echo "Git hooks installed successfully!"
echo ""
echo "The pre-push hook will now validate your commits before pushing."
echo "You can bypass it with 'git push --no-verify' if needed."
