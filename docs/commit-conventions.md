# Commit Message Conventions

This document describes the commit message conventions for the PlatoSL schema repository.

## Overview

We use [Conventional Commits](https://www.conventionalcommits.org/) with structured scopes to enable:
- Consistent commit history
- Automated versioning via release-please
- Future per-schema changelog generation
- Validation that prevents common mistakes

All commits are automatically validated in CI. You can optionally install a pre-push hook for faster local feedback.

---

## Format

```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

### Type

Required. Must be one of:

- **`add`** - Adding new schemas or data structures
- **`edit`** - Modifying existing schemas or data
- **`remove`** - Removing schemas or data (usually includes `BREAKING CHANGE`)
- **`docs`** - Documentation changes
- **`chore`** - Maintenance tasks (dependencies, tooling, etc.)
- **`ci`** - CI/CD configuration changes
- **`test`** - Adding or modifying tests
- **`refactor`** - Code refactoring without changing functionality

### Scope

**Format:** `{category}/{country?}/{schema?}`

**Required for:** `add`, `edit`, `remove`
**Optional for:** `docs`, `chore`, `ci`, `test`, `refactor`

**Rules:**
- Lowercase letters, hyphens, and forward slashes only
- 1-3 hierarchical levels matching repository structure
- Must match pattern: `^[a-z]+(/[a-z\-]+){0,2}$`

**Examples:**
- `content` - Category-level scope
- `address/us` - Country-specific scope
- `geo/uk` - Geographic data for UK
- `address/us/postal-codes` - Schema-specific scope (future use)

### Subject

Required. Brief description of the change:
- Lowercase first letter
- No period at the end
- Imperative mood ("add" not "added" or "adds")
- Maximum 72 characters

---

## Validation Rules

### Scope Requirement

Scopes are **mandatory** for schema-related commits:

```bash
✅ add(address/fr): add French address schema
❌ add: add French address schema  # Missing scope
```

Scopes are **optional** for infrastructure commits:

```bash
✅ docs: update README
✅ docs(README): update installation guide  # Both valid
✅ chore: update CUE version
✅ chore(deps): update CUE version          # Both valid
```

### Path Existence Validation

The validation system checks that your commit type matches the state of the repository:

#### `add` Type

**Rule:** Path must NOT contain any `.cue` files

```bash
✅ add(address/fr): add French address schema
   # Valid if base/address/fr/ has no .cue files

❌ add(address/us): add US address schema
   # Fails if base/address/us/ already has .cue files
   # Use 'edit' instead
```

#### `edit` Type

**Rule:** Path MUST contain `.cue` files

```bash
✅ edit(address/us): update ZIP+4 validation
   # Valid if base/address/us/ has .cue files

❌ edit(address/zz): update validation
   # Fails if base/address/zz/ doesn't exist
   # Use 'add' instead
```

#### `remove` Type

**Rule:** Path must exist (directory or file)

```bash
✅ remove(content/blocks): remove deprecated card variant
   # Valid if base/content/blocks/ exists

❌ remove(content/nonexistent): remove old schema
   # Fails if base/content/nonexistent/ doesn't exist
```

---

## Examples

### Adding New Schemas

```bash
# Adding a new country address schema
add(address/fr): add French address schema

# Adding new content type
add(content/hero): add hero block schema

# Adding geographic reference data
add(geo/ca): add Canadian province data
```

### Editing Existing Schemas

```bash
# Updating validation rules
edit(address/us): improve ZIP+4 validation pattern

# Adding new fields
edit(geo/uk): add Scottish county subdivisions

# Fixing bugs
edit(content/card): fix required field validation
```

### Removing Schemas

```bash
# Removing deprecated schemas (breaking change)
remove(content/legacy): remove deprecated card variant

BREAKING CHANGE: The legacy card variant is no longer supported.
Migrate to the new card schema in content/card.

# Removing country-specific data
remove(address/test): remove test country schema
```

### Non-Schema Commits

```bash
# Documentation
docs: update contribution guidelines
docs(README): add CUE installation instructions

# Maintenance
chore: update CUE to v0.10.0
chore(deps): bump release-please action version

# CI/CD
ci: add commit validation workflow
ci(github): enable dependabot

# Testing
test(address): add US ZIP validation tests

# Refactoring
refactor(address): extract common validation patterns
```

---

## Edge Cases

### Multiple Files Changed

**Preferred:** Use the most specific common scope

```bash
# If changing multiple files under address/us/
edit(address/us): update validation patterns across schemas
```

**Alternative:** Separate commits for clarity

```bash
edit(address/us): improve postcode validation
edit(address/us): add military address examples
```

### Creating New Categories

When adding the first schema in a new category:

```bash
# Option 1: Category-level scope
add(payment): add payment schema structure

# Option 2: First schema defines category
add(payment/stripe): add Stripe payment schema
```

Both are valid. The validation checks that `base/payment/` doesn't contain `.cue` files.

### Scope vs Changed Files

The validation system checks the **scope path** you specify, not all changed files. This allows flexibility:

```bash
# This is valid even if you also update docs or tests
edit(address/us): update postal code validation
```

In the future, we may add validation to ensure changed files match the scope, but currently it's advisory only.

---

## Local Validation with Pre-Push Hook

### Installation

Install the optional pre-push hook for fast local feedback:

```bash
./scripts/install-hooks.sh
```

This hook validates your commits **before** they're pushed to the remote repository, catching errors earlier than CI.

### Bypassing the Hook

If you need to bypass the hook (e.g., emergency fix):

```bash
git push --no-verify
```

⚠️ **Note:** CI validation will still run and may block your PR.

---

## Fixing Validation Errors

### Error: "Scope is required for 'add' type commits"

```bash
❌ add: add French address schema

✅ add(address/fr): add French address schema
```

### Error: "Invalid scope format"

```bash
❌ add(Address/US): add schema        # Wrong case
❌ add(address/us/123): add schema    # Numbers not allowed
❌ add(address_us): add schema        # Underscore not allowed

✅ add(address/us): add schema        # Correct format
```

### Error: "Schema already exists, use 'edit' instead"

```bash
❌ add(address/us): update validation  # base/address/us/ exists

✅ edit(address/us): update validation
```

### Error: "Schema does not exist, use 'add' instead"

```bash
❌ edit(address/zz): add new schema    # base/address/zz/ doesn't exist

✅ add(address/zz): add new schema
```

### Error: "Path does not exist"

```bash
❌ remove(content/missing): remove old schema

# Check that the path actually exists first
ls -la base/content/missing
```

---

## Troubleshooting

### How to check what exists in a scope?

```bash
# Check if a path has .cue files
find base/address/us -name '*.cue' -type f

# List directory contents
ls -la base/address/us/
```

### How to amend a commit message?

```bash
# Amend the last commit message
git commit --amend

# Reword older commits interactively
git rebase -i HEAD~3
```

⚠️ **Warning:** Don't rewrite commits that have already been pushed to shared branches.

### How to see validation errors locally?

```bash
# Validate a commit range manually
./scripts/validate-commits.sh origin/main..HEAD

# Validate specific commits
./scripts/validate-commits.sh abc123..def456
```

---

## CI Validation

All commits in pull requests and pushes to `main` are automatically validated by the GitHub Actions workflow.

**Workflow:** `.github/workflows/commit-validation.yml`

If validation fails:
1. Check the CI logs for specific error messages
2. Fix the commit messages (amend or rebase)
3. Force-push the corrected commits

---

## Future Enhancements

This validation system creates a foundation for:
- **Per-schema changelogs** - Automatically generated from commit history
- **Scope suggestions** - Fuzzy matching to suggest correct scope on error
- **Multi-file validation** - Ensure all changed files match commit scope
- **Schema website** - Browse schema changelogs online

These features will be added incrementally as needed.

---

## Questions?

See [CONTRIBUTING.md](../CONTRIBUTING.md) for general contribution guidelines.

For issues or suggestions about commit validation, please open an issue on GitHub.
