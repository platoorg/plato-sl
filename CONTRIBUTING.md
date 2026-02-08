# Contributing to PlatoSL Base Schemas

Thank you for your interest in contributing to PlatoSL base schemas! This document provides guidelines for contributing new schemas, improvements, and bug fixes.

## Types of Contributions

### 1. New Schemas

Adding schemas for new countries, data types, or content blocks.

### 2. Schema Improvements

Enhancing existing schemas with new optional fields or better validation.

### 3. Bug Fixes

Fixing incorrect validation rules or data.

### 4. Documentation

Improving examples, comments, and guides.

## Before You Start

1. **Check existing issues** - Someone may already be working on it
2. **Open an issue** - Discuss your proposal before writing code
3. **Review versioning policy** - Understand MAJOR vs MINOR vs PATCH changes
4. **Read the style guide** - Follow existing patterns

## Schema Contribution Guidelines

### Schema Structure

All schemas should follow this structure:

```cue
// PlatoSL Base Schema: [Description]
// Version: v1
// Country: [ISO Country Code]
// Standard: [Official Standard Reference]

package [country_code]

import geo "[module]/geo/[country]"  // if needed

// Main schema definition with metadata
#[SchemaName]: {
    // Schema metadata (required)
    _schema: {
        version:  "v1.0.0"
        country:  "[ISO 3166-1 alpha-2]"
        standard: "[Official Standard Name]"
    }

    // Type discriminator (required)
    _type: "[category].[country]"

    // Required fields (use ! suffix)
    field_name!: string & =~"^.{1,100}$"

    // Optional fields (use ? suffix)
    optional_field?: string

    // Validation rules
    // ... conditional logic if needed
}

// Re-export related definitions
#RelatedType: geo.#Type

// Export main schema
[SchemaName]: #[SchemaName]

// Examples (required - at least 3 diverse examples)
_examples: {
    basic: [SchemaName] & {
        // ... basic example
    }

    complex: [SchemaName] & {
        // ... complex example
    }

    edge_case: [SchemaName] & {
        // ... edge case example
    }
}
```

### Naming Conventions

- **Package names**: Lowercase country codes (`us`, `uk`, `de`, `jp`)
- **Schema names**: PascalCase with hash (`#Address`, `#PostalCode`)
- **Field names**: snake_case (`street_line1`, `postal_code`)
- **File names**: lowercase with hyphens (`address.cue`, `postal-codes.cue`)

### Required Fields

Every schema must include:

1. **Header comment** with version, country, and standard reference
2. **`_schema` metadata** with version, country, and standard
3. **`_type` discriminator** for schema identification
4. **Field documentation** using comments above each field
5. **Validation patterns** using CUE constraints
6. **At least 3 examples** covering different use cases
7. **Export statement** for the main schema

### Field Validation

Use appropriate CUE constraints:

```cue
// String length
name!: string & =~"^.{1,100}$"

// Pattern matching
zip!: string & =~"^\\d{5}(-\\d{4})?$"

// Number ranges
age!: int & >=0 & <=150

// Enums (use imported geo data when possible)
state!: geo.#State

// Optional with default
active?: bool | *true
```

### Examples

Provide diverse, realistic examples:

```cue
_examples: {
    // Standard/common case
    standard: Address & {
        // ...
    }

    // Complex case with optional fields
    with_options: Address & {
        // ...
    }

    // Edge case
    edge_case: Address & {
        // ...
    }

    // Error case (demonstrates what NOT to do)
    // Commented out, for documentation only
    // invalid_example: Address & {
    //     // ... incorrect data
    // }
}
```

## Development Workflow

### 1. Fork and Clone

```bash
git clone https://github.com/YOUR_USERNAME/platosl.git
cd platosl
```

### 2. Create Branch

```bash
git checkout -b feature/add-french-address-schema
```

### 3. Add Your Schema

```bash
# Create directory structure
mkdir -p base/address/fr
mkdir -p base/geo/fr

# Create schema files
vim base/address/fr/address.cue
vim base/geo/fr/regions.cue
```

### 4. Validate

```bash
# Validate your schema
cue vet ./base/address/fr/...
cue vet ./base/geo/fr/...

# Test with examples
cue eval ./base/address/fr/...
```

### 5. Document

Update relevant documentation:

- Add entry to main README.md
- Update CHANGELOG.md
- Add usage example to examples/

### 6. Test

Ensure all schemas still validate:

```bash
# Validate all schemas
cue vet ./base/address/...
cue vet ./base/geo/...
cue vet ./base/content/...
```

### 7. Commit

We use [Conventional Commits](https://www.conventionalcommits.org/) to automate releases with release-please.

**Commit Message Format:**
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Schema-Specific Commit Types:**
- `add:` - Adding new schemas (triggers MINOR version bump)
- `edit:` - Modifying existing schemas (triggers PATCH version bump)
- `remove:` - Removing schemas (triggers MAJOR version bump - must include `BREAKING CHANGE:`)
- `docs:` - Documentation changes only (triggers PATCH version bump)
- `chore:` - Infrastructure changes (triggers PATCH version bump)

**Version Bump Rules:**
- **MAJOR (1.0.0 → 2.0.0)**: Use `remove:` with `BREAKING CHANGE:` footer, or any commit with `!` suffix
- **MINOR (1.0.0 → 1.1.0)**: Use `add:` for new schemas
- **PATCH (1.0.0 → 1.0.1)**: Use `edit:`, `docs:`, or `chore:`

**Examples:**

```bash
# Adding a new schema (MINOR bump)
git commit -m "add(address): add French address schema

- Add base/address/fr with La Poste standard
- Add base/geo/fr with regions and departments
- Include 5 diverse examples

Addresses #123"

# Editing a schema (PATCH bump)
git commit -m "edit(address): correct UK postcode validation pattern

Previous pattern incorrectly rejected valid GIR 0AA postcode"

# Documentation update (PATCH bump)
git commit -m "docs: add usage examples for German addresses"

# Removing a schema (MAJOR bump)
git commit -m "remove(address): remove deprecated Canada address schema

The CA schema has been superseded by the new North America schema.

BREAKING CHANGE: base/address/ca schema removed, use base/address/na instead"

# Breaking change to existing schema (MAJOR bump)
git commit -m "edit(address)!: restructure US address schema

- Rename 'street' to 'street_line1' for consistency
- Add dedicated 'street_line2' field

BREAKING CHANGE: Field 'street' renamed to 'street_line1'"
```

### 8. Push and PR

```bash
git push origin feature/add-french-address-schema
```

Then open a Pull Request on GitHub with:
- Clear description of what you're adding
- Reference to any related issues
- Explanation of design decisions
- Confirmation that validation passes

## Schema Research

When adding address schemas for new countries:

### 1. Official Standards

Research the official postal standard:
- USPS (United States)
- Royal Mail (United Kingdom)
- Deutsche Post (Germany)
- Japan Post (Japan)
- La Poste (France)
- etc.

### 2. Field Requirements

Document:
- Required vs optional fields
- Field formats and validation rules
- Special cases or exceptions
- Unicode character support

### 3. Examples

Collect diverse real-world examples:
- Standard residential address
- Business address
- PO Box or alternative delivery
- Rural or special addressing
- Address with all optional fields

### 4. Geographic Data

Research official codes:
- State/province codes
- Region identifiers
- Postal code formats

## Pull Request Checklist

Before submitting:

- [ ] Schema follows structure guidelines
- [ ] Includes `_schema` metadata
- [ ] Includes `_type` discriminator
- [ ] All fields have descriptive comments
- [ ] Validation rules are appropriate
- [ ] At least 3 diverse examples provided
- [ ] Schema validates with `cue vet`
- [ ] Examples evaluate with `cue eval`
- [ ] README.md updated
- [ ] CHANGELOG.md updated
- [ ] Related documentation updated
- [ ] Commit message follows convention
- [ ] All existing schemas still validate

## Review Process

1. **Automated checks** - CI runs validation on all schemas
2. **Code review** - Maintainer reviews for quality and correctness
3. **Discussion** - Clarifications or improvements discussed
4. **Approval** - Once approved, will be merged
5. **Release** - Included in next semantic version release

## Automated Release Process

This repository uses [release-please](https://github.com/googleapis/release-please) to automate releases.

### How It Works

1. **When PRs are merged** to `main`, release-please analyzes commit messages
2. **Release PR is created** automatically with:
   - Updated CHANGELOG.md
   - Version bump based on commit types
   - Release notes
3. **When Release PR is merged**, release-please automatically:
   - Creates a GitHub Release
   - Creates a git tag (e.g., `1.2.0`)
   - Publishes release notes

### Version Bumps

Based on Conventional Commits:

- `feat:` → MINOR version bump (1.0.0 → 1.1.0)
- `fix:`, `docs:`, `chore:` → PATCH version bump (1.0.0 → 1.0.1)
- `BREAKING CHANGE:` → MAJOR version bump (1.0.0 → 2.0.0)

### For Maintainers

To release a new version:

1. Merge PRs to `main` using Conventional Commits
2. Release-please will open a PR titled "chore(main): release X.Y.Z"
3. Review the Release PR's changelog and version bump
4. Merge the Release PR to publish the release
5. The git tag and GitHub Release are created automatically

## Versioning for Contributors

When contributing:

- **New schemas or optional fields**: MINOR version bump
- **Bug fixes or docs**: PATCH version bump
- **Breaking changes**: Requires discussion and MAJOR version bump

Don't update version numbers in your PR - maintainers will handle versioning during release.

## Code of Conduct

- Be respectful and constructive
- Focus on the schema quality, not personal preferences
- Provide evidence for design decisions
- Help review others' contributions
- Follow the official standards when available

## Questions?

- **General questions**: [GitHub Discussions](https://github.com/platoorg/plato-sl/discussions)
- **Bug reports**: [GitHub Issues](https://github.com/platoorg/plato-sl/issues)
- **Security issues**: Email security@YOUR_ORG.com

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

Thank you for contributing to PlatoSL! 🎉
