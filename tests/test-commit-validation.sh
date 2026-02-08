#!/bin/bash
# Automated tests for commit validation
# Usage: ./tests/test-commit-validation.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

TESTS_PASSED=0
TESTS_FAILED=0

echo "Running commit validation tests..."
echo ""

# Helper function to run a test
run_test() {
    local test_name="$1"
    local commit_type="$2"
    local commit_scope="$3"
    local expected_result="$4"  # "pass" or "fail"

    echo -n "Testing: $test_name ... "

    # Create test commit message
    local commit_msg="${commit_type}"
    if [ -n "$commit_scope" ]; then
        commit_msg="${commit_type}(${commit_scope})"
    fi
    commit_msg="${commit_msg}: test commit"

    # Validate commit message format
    if echo "$commit_msg" | grep -qE '^(add|edit|remove|docs|chore|ci|test|refactor)(\([a-z/\-]+\))?!?: .+'; then
        format_valid=true
    else
        format_valid=false
    fi

    # Check scope requirement
    if echo "$commit_type" | grep -qE '^(add|edit|remove)$'; then
        if [ -z "$commit_scope" ]; then
            scope_valid=false
        else
            scope_valid=true
        fi
    else
        scope_valid=true
    fi

    # Check scope format if present
    if [ -n "$commit_scope" ]; then
        if echo "$commit_scope" | grep -qE '^[a-z]+(/[a-z\-]+){0,2}$'; then
            scope_format_valid=true
        else
            scope_format_valid=false
        fi
    else
        scope_format_valid=true
    fi

    # Determine overall result
    if $format_valid && $scope_valid && $scope_format_valid; then
        actual_result="pass"
    else
        actual_result="fail"
    fi

    # Check against expected result
    if [ "$actual_result" = "$expected_result" ]; then
        echo -e "${GREEN}✓ PASS${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "${RED}✗ FAIL${NC}"
        echo "  Expected: $expected_result, Got: $actual_result"
        echo "  Commit: $commit_msg"
        echo "  Format valid: $format_valid, Scope valid: $scope_valid, Scope format valid: $scope_format_valid"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

# Test valid commit formats
echo "=== Testing Valid Commit Formats ==="
run_test "add with category/country scope" "add" "address/fr" "pass"
run_test "edit with category/country scope" "edit" "address/us" "pass"
run_test "remove with category/country scope" "remove" "content/blocks" "pass"
run_test "add with category scope" "add" "content" "pass"
run_test "edit with category/country/schema scope" "edit" "address/us/postal" "pass"
run_test "docs without scope" "docs" "" "pass"
run_test "docs with optional scope" "docs" "readme" "pass"
run_test "chore without scope" "chore" "" "pass"
run_test "chore with optional scope" "chore" "deps" "pass"
run_test "ci with scope" "ci" "github" "pass"
run_test "test with scope" "test" "address" "pass"
run_test "refactor with scope" "refactor" "address" "pass"
run_test "scope with hyphens" "add" "address/postal-codes" "pass"
echo ""

# Test invalid commit formats
echo "=== Testing Invalid Commit Formats ==="
run_test "add without required scope" "add" "" "fail"
run_test "edit without required scope" "edit" "" "fail"
run_test "remove without required scope" "remove" "" "fail"
run_test "scope with uppercase" "add" "Address/US" "fail"
run_test "scope with underscores" "add" "address_us" "fail"
run_test "scope with numbers" "add" "address/us/123" "fail"
run_test "scope with spaces" "add" "address us" "fail"
run_test "scope with too many levels" "add" "a/b/c/d" "fail"
run_test "invalid commit type" "update" "address/us" "fail"
echo ""

# Test scope format validation
echo "=== Testing Scope Format Validation ==="
run_test "single level scope" "add" "content" "pass"
run_test "two level scope" "add" "address/us" "pass"
run_test "three level scope" "add" "address/us/postal" "pass"
run_test "scope with single hyphen" "add" "content/hero-block" "pass"
run_test "scope with multiple hyphens" "add" "content/super-hero-block" "pass"
run_test "scope starting with slash" "add" "/address/us" "fail"
run_test "scope ending with slash" "add" "address/us/" "fail"
run_test "scope with double slash" "add" "address//us" "fail"
run_test "scope with dot" "add" "address.us" "fail"
echo ""

# Summary
echo "================================"
echo "Test Results:"
echo -e "  ${GREEN}Passed: $TESTS_PASSED${NC}"
echo -e "  ${RED}Failed: $TESTS_FAILED${NC}"
echo "================================"

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed.${NC}"
    exit 1
fi
