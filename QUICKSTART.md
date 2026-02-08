# Commit Validation Quickstart Guide

## TL;DR

This repository validates commit messages automatically. Use structured commits like:
- `add(address/fr): add French address schema`
- `edit(address/us): update ZIP validation`
- `docs: update README`

## For New Contributors

### What You Need to Know

1. **Scopes are required** for `add`, `edit`, and `remove` commits
2. **Scopes must match** repository structure: `address/us`, `content`, `geo/uk`
3. **Lowercase only** in scopes (not `Address/US`, but `address/us`)
4. **CI validates everything** - invalid commits will fail

### Quick Examples

✅ **Valid commits:**
```bash
git commit -m "add(address/fr): add French address schema"
git commit -m "edit(geo/us): update state abbreviations"
git commit -m "remove(content/old): remove deprecated block"
git commit -m "docs: update README"
git commit -m "chore(deps): update dependencies"
```

❌ **Invalid commits:**
```bash
git commit -m "add: missing scope"              # Error: scope required
git commit -m "add(Address/US): wrong case"     # Error: must be lowercase
git commit -m "add(address/us): exists"         # Error: schema already exists
git commit -m "edit(address/zz): update"        # Error: schema doesn't exist
```

### Install Local Validation (Optional)

Get instant feedback before pushing:

```bash
./scripts/install-hooks.sh
```

Now invalid commits will be caught locally before CI runs.

To bypass the hook temporarily:
```bash
git push --no-verify
```

## For Experienced Contributors

### Scope Format

Pattern: `{category}/{country?}/{schema?}`

**Examples:**
- `content` - Category-level
- `address/us` - Country-specific
- `geo/uk` - Geographic data
- `address/fr/postal` - Schema-specific (future)

**Regex:** `^[a-z]+(/[a-z\-]+){0,2}$`

### Path Validation Rules

| Type | Rule | Example |
|------|------|---------|
| `add` | Path must NOT contain `.cue` files | `add(address/fr)` when `base/address/fr/` is empty |
| `edit` | Path MUST contain `.cue` files | `edit(address/us)` when `base/address/us/*.cue` exists |
| `remove` | Path must exist | `remove(content/old)` when `base/content/old/` exists |

### Manual Validation

Test your commits before pushing:

```bash
# Validate commits in your branch
./scripts/validate-commits.sh origin/main..HEAD

# Validate specific commit range
./scripts/validate-commits.sh abc123..def456

# Validate last commit
./scripts/validate-commits.sh HEAD~1..HEAD
```

### Edge Cases

**Multiple files changed:**
```bash
# Use most specific common scope
git commit -m "edit(address/us): update validation and examples"

# OR separate into multiple commits
git commit -m "edit(address/us): update validation"
git commit -m "edit(address/us): add examples"
```

**Creating new categories:**
```bash
# Both are valid
git commit -m "add(payment): add payment schema structure"
git commit -m "add(payment/stripe): add Stripe payment schema"
```

**Non-schema commits (scope optional):**
```bash
git commit -m "docs: update guide"           # Valid
git commit -m "docs(readme): update guide"   # Also valid
git commit -m "chore: update CI"             # Valid
git commit -m "ci(github): add workflow"     # Also valid
```

## Troubleshooting

### "Scope is required for 'add' type commits"

Add a scope that matches the path:
```bash
# Wrong
git commit -m "add: add schema"

# Correct
git commit -m "add(address/fr): add French address schema"
```

### "Schema already exists, use 'edit' instead"

The path already contains `.cue` files:
```bash
# Check what exists
ls -la base/address/us/

# Use 'edit' instead of 'add'
git commit -m "edit(address/us): update validation"
```

### "Schema does not exist, use 'add' instead"

The path doesn't contain `.cue` files yet:
```bash
# Check if path exists
find base/address/zz -name "*.cue"

# Use 'add' instead of 'edit'
git commit -m "add(address/zz): add new schema"
```

### "Invalid scope format"

Check your scope follows the rules:
```bash
❌ Address/US      # Uppercase not allowed
❌ address_us      # Underscores not allowed
❌ address/us/1    # Numbers not allowed
✅ address/us      # Correct
✅ address/us/postal-codes  # Hyphens OK
```

## Testing

Run the test suite locally:

```bash
# Unit tests (31 tests)
./tests/test-commit-validation.sh

# End-to-end tests (8 tests)
./tests/test-end-to-end.sh
```

## More Information

- **Complete guide**: [docs/commit-conventions.md](docs/commit-conventions.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **Implementation details**: [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)

## Questions?

- Open an issue: [GitHub Issues](https://github.com/platoorg/plato-sl/issues)
- Read the docs: [docs/commit-conventions.md](docs/commit-conventions.md)
