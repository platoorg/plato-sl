#!/bin/bash
# Path existence validation for commit scopes
# Usage: validate-commit-scope.sh <type> <scope>

set -e

TYPE="$1"
SCOPE="$2"

if [ -z "$TYPE" ] || [ -z "$SCOPE" ]; then
    echo "Usage: $0 <type> <scope>"
    exit 1
fi

# Convert scope to filesystem path
BASE_PATH="base/$SCOPE"

case "$TYPE" in
    add)
        # Check if any .cue files exist in target path
        if [ -d "$BASE_PATH" ] && find "$BASE_PATH" -name '*.cue' -type f 2>/dev/null | grep -q .; then
            echo "ERROR: Schema already exists at $BASE_PATH. Use 'edit' type instead."
            exit 1
        fi
        ;;

    edit)
        # Check if .cue files exist in target path
        if [ ! -d "$BASE_PATH" ] || ! find "$BASE_PATH" -name '*.cue' -type f 2>/dev/null | grep -q .; then
            echo "ERROR: Schema does not exist at $BASE_PATH. Use 'add' type instead."
            exit 1
        fi
        ;;

    remove)
        # Check if path exists (directory or file)
        if [ ! -d "$BASE_PATH" ] && [ ! -f "$BASE_PATH.cue" ]; then
            echo "ERROR: Path does not exist: $BASE_PATH"
            exit 1
        fi
        ;;

    *)
        # Other commit types don't need path validation
        exit 0
        ;;
esac

exit 0
