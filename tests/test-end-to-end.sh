#!/bin/bash
# End-to-end test for commit validation
# This script creates a test branch and validates different commit scenarios

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=== End-to-End Commit Validation Test ==="
echo ""

# Save current branch
ORIGINAL_BRANCH=$(git branch --show-current)
echo "Current branch: $ORIGINAL_BRANCH"

# Create test branch
TEST_BRANCH="test/commit-validation-$(date +%s)"
echo "Creating test branch: $TEST_BRANCH"
git checkout -b "$TEST_BRANCH" >/dev/null 2>&1

# Cleanup function
cleanup() {
    echo ""
    echo "Cleaning up..."
    git checkout "$ORIGINAL_BRANCH" >/dev/null 2>&1
    git branch -D "$TEST_BRANCH" >/dev/null 2>&1 || true
    echo "Cleanup complete"
}

trap cleanup EXIT

echo ""
echo "--- Test 1: Valid 'edit' commit for existing schema ---"
# Edit existing schema (address/us exists)
touch base/address/us/test.tmp
git add base/address/us/test.tmp
git commit -m "edit(address/us): update validation pattern" >/dev/null 2>&1
echo -n "Validating commit... "
if "$REPO_ROOT/scripts/validate-commits.sh" "HEAD~1..HEAD" >/dev/null 2>&1; then
    echo -e "${GREEN}✓ PASS${NC}"
else
    echo -e "${RED}✗ FAIL${NC}"
    exit 1
fi

echo ""
echo "--- Test 2: Invalid 'add' commit for existing schema ---"
# Try to add existing schema (address/us already exists)
touch base/address/us/test2.tmp
git add base/address/us/test2.tmp
git commit -m "add(address/us): should fail" >/dev/null 2>&1
echo -n "Validating commit... "
if ! "$REPO_ROOT/scripts/validate-commits.sh" "HEAD~1..HEAD" >/dev/null 2>&1; then
    echo -e "${GREEN}✓ PASS (correctly rejected)${NC}"
else
    echo -e "${RED}✗ FAIL (should have been rejected)${NC}"
    exit 1
fi

echo ""
echo "--- Test 3: Valid 'add' commit for new schema ---"
# Add new schema (address/fr doesn't have .cue files yet)
mkdir -p base/address/fr
touch base/address/fr/README.md
git add base/address/fr/README.md
git commit -m "add(address/fr): add French address schema" >/dev/null 2>&1
echo -n "Validating commit... "
if "$REPO_ROOT/scripts/validate-commits.sh" "HEAD~1..HEAD" >/dev/null 2>&1; then
    echo -e "${GREEN}✓ PASS${NC}"
else
    echo -e "${RED}✗ FAIL${NC}"
    exit 1
fi

echo ""
echo "--- Test 4: Invalid 'edit' commit for non-existent schema ---"
# Try to edit non-existent schema
mkdir -p base/address/zz
touch base/address/zz/test.tmp
git add base/address/zz/test.tmp
git commit -m "edit(address/zz): should fail" >/dev/null 2>&1
echo -n "Validating commit... "
if ! "$REPO_ROOT/scripts/validate-commits.sh" "HEAD~1..HEAD" >/dev/null 2>&1; then
    echo -e "${GREEN}✓ PASS (correctly rejected)${NC}"
else
    echo -e "${RED}✗ FAIL (should have been rejected)${NC}"
    exit 1
fi

echo ""
echo "--- Test 5: Valid 'docs' commit without scope ---"
echo "test" >> README.md
git add README.md
git commit -m "docs: update README" >/dev/null 2>&1
echo -n "Validating commit... "
if "$REPO_ROOT/scripts/validate-commits.sh" "HEAD~1..HEAD" >/dev/null 2>&1; then
    echo -e "${GREEN}✓ PASS${NC}"
else
    echo -e "${RED}✗ FAIL${NC}"
    exit 1
fi

echo ""
echo "--- Test 6: Invalid 'add' commit missing scope ---"
touch test-file.tmp
git add test-file.tmp
git commit -m "add: missing scope should fail" >/dev/null 2>&1
echo -n "Validating commit... "
if ! "$REPO_ROOT/scripts/validate-commits.sh" "HEAD~1..HEAD" >/dev/null 2>&1; then
    echo -e "${GREEN}✓ PASS (correctly rejected)${NC}"
else
    echo -e "${RED}✗ FAIL (should have been rejected)${NC}"
    exit 1
fi

echo ""
echo "--- Test 7: Invalid scope format (uppercase) ---"
touch test-file2.tmp
git add test-file2.tmp
git commit -m "add(Address/US): uppercase should fail" >/dev/null 2>&1
echo -n "Validating commit... "
if ! "$REPO_ROOT/scripts/validate-commits.sh" "HEAD~1..HEAD" >/dev/null 2>&1; then
    echo -e "${GREEN}✓ PASS (correctly rejected)${NC}"
else
    echo -e "${RED}✗ FAIL (should have been rejected)${NC}"
    exit 1
fi

echo ""
echo "--- Test 8: Valid commit range validation ---"
echo -n "Validating all commits in range... "
if "$REPO_ROOT/scripts/validate-commits.sh" "$ORIGINAL_BRANCH..$TEST_BRANCH" >/dev/null 2>&1; then
    echo -e "${RED}✗ FAIL (should have rejected invalid commits)${NC}"
    exit 1
else
    echo -e "${GREEN}✓ PASS (correctly rejected range with invalid commits)${NC}"
fi

echo ""
echo "================================"
echo -e "${GREEN}All end-to-end tests passed!${NC}"
echo "================================"
