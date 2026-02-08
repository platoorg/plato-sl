#!/bin/bash
# Main commit validation script
# Usage: validate-commits.sh <commit-range>

set -e

COMMIT_RANGE="$1"

if [ -z "$COMMIT_RANGE" ]; then
    echo "Usage: $0 <commit-range>"
    echo "Example: $0 origin/main..HEAD"
    exit 1
fi

# Conventional commits regex pattern
# Matches: type(scope): subject or type: subject
COMMIT_PATTERN='^(add|edit|remove|docs|chore|ci|test|refactor)(\([a-z/\-]+\))?!?: .+'

# Scope format regex (lowercase letters, hyphens, slashes, 1-3 levels)
SCOPE_PATTERN='^[a-z]+(/[a-z\-]+){0,2}$'

# Types that require a scope
SCOPE_REQUIRED_TYPES="add|edit|remove"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VALIDATION_FAILED=0

# Get list of commits in range
COMMITS=$(git log --format=%H "$COMMIT_RANGE" 2>/dev/null || echo "")

if [ -z "$COMMITS" ]; then
    echo "No commits found in range: $COMMIT_RANGE"
    exit 0
fi

echo "Validating commits in range: $COMMIT_RANGE"
echo ""

# Iterate through each commit
while IFS= read -r commit_hash; do
    # Get commit message (first line only)
    commit_msg=$(git log -1 --format=%s "$commit_hash")

    echo "Checking commit: $commit_hash"
    echo "  Message: $commit_msg"

    # Check conventional commits format
    if ! echo "$commit_msg" | grep -qE "$COMMIT_PATTERN"; then
        echo "  ❌ FAIL: Invalid conventional commit format"
        echo "     Expected: type(scope): subject"
        echo "     Valid types: add, edit, remove, docs, chore, ci, test, refactor"
        VALIDATION_FAILED=1
        continue
    fi

    # Extract type and scope
    TYPE=$(echo "$commit_msg" | sed -E 's/^([a-z]+)(\([^)]+\))?!?: .*/\1/')
    SCOPE=$(echo "$commit_msg" | sed -E 's/^[a-z]+\(([^)]+)\)!?: .*/\1/')

    # If scope extraction failed (no parentheses), SCOPE will equal commit_msg
    if [ "$SCOPE" = "$commit_msg" ]; then
        SCOPE=""
    fi

    echo "  Type: $TYPE"
    echo "  Scope: ${SCOPE:-<none>}"

    # Check if scope is required for this type
    if echo "$TYPE" | grep -qE "^($SCOPE_REQUIRED_TYPES)$"; then
        if [ -z "$SCOPE" ]; then
            echo "  ❌ FAIL: Scope is required for '$TYPE' type commits"
            echo "     Example: $TYPE(address/us): your message here"
            VALIDATION_FAILED=1
            continue
        fi
    fi

    # Validate scope format if present
    if [ -n "$SCOPE" ]; then
        if ! echo "$SCOPE" | grep -qE "$SCOPE_PATTERN"; then
            echo "  ❌ FAIL: Invalid scope format: $SCOPE"
            echo "     Scope must be lowercase with format: category/country/schema"
            echo "     Examples: address/us, content, geo/uk"
            VALIDATION_FAILED=1
            continue
        fi

        # Validate path existence for schema-changing commits
        if echo "$TYPE" | grep -qE "^($SCOPE_REQUIRED_TYPES)$"; then
            if ! "$SCRIPT_DIR/validate-commit-scope.sh" "$TYPE" "$SCOPE"; then
                echo "  ❌ FAIL: Path validation failed"
                VALIDATION_FAILED=1
                continue
            fi
        fi
    fi

    echo "  ✅ PASS"
    echo ""

done <<< "$COMMITS"

if [ $VALIDATION_FAILED -eq 1 ]; then
    echo "❌ Commit validation failed"
    echo ""
    echo "See docs/commit-conventions.md for detailed guidelines"
    exit 1
fi

echo "✅ All commits valid"
exit 0
