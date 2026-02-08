# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## Project Overview

PlatoSL (Schema Language) is a CUE-based schema repository providing standardized, versioned data structures for:
- **Address schemas** - Following official postal standards (US, UK, DE, JP)
- **Geographic data** - Official reference data (states, regions, prefectures)
- **Content contracts** - CMS content block definitions (Image, Card, Hero, etc.)

Module path: `github.com/platoorg/plato-sl/schemas`

## Common Commands

### Validation
```bash
# Validate all schemas
cue vet ./base/address/...
cue vet ./base/geo/...
cue vet ./base/content/...

# Validate specific country schema
cue vet ./base/address/us/...
```

### Evaluation
```bash
# Evaluate schema with examples
cue eval ./base/address/us/...

# Export to JSON
cue export ./base/address/us/... -o address.json
```

### Module Management
```bash
# View module info
cue mod init

# Check dependencies
cue mod tidy
```

## Architecture

### Directory Structure
```
base/
├── address/{country}/    # Address schemas by country code
│   └── address.cue       # #Address schema with _schema metadata, _type discriminator
├── geo/{country}/        # Geographic reference data by country
│   └── states.cue        # Enum definitions for states/regions (imported by address schemas)
└── content/              # CMS content block schemas
    ├── image.cue         # #Image schema
    ├── avatar.cue        # #Avatar schema
    └── blocks.cue        # #Card, #Hero, #TextBlock, #Gallery, #Quote, #CTA
```

### Schema Structure Pattern

Every schema follows this structure:
1. **Header comment** - Version, country, official standard reference
2. **Package declaration** - Uses country code (e.g., `package us`)
3. **Imports** - Geographic data from corresponding geo package
4. **Main schema** (`#SchemaName`) with:
   - `_schema` metadata (version, country, standard)
   - `_type` discriminator (e.g., `"address.us"`)
   - Required fields (suffix: `!`)
   - Optional fields (suffix: `?`)
   - Validation constraints using CUE patterns
5. **Re-exports** - Related types from geo packages
6. **Export statement** - `SchemaName: #SchemaName`
7. **Examples** - `_examples` with 3+ diverse cases

### Naming Conventions
- **Package names**: Lowercase country codes (`us`, `uk`, `de`, `jp`)
- **Schema names**: PascalCase with `#` prefix (`#Address`, `#State`)
- **Field names**: snake_case (`street_line1`, `postal_code`)
- **File names**: lowercase with hyphens (`address.cue`, `postal-codes.cue`)

### Schema Relationships

Address schemas import and use geo schemas:
```cue
import geo_us "github.com/platoorg/plato-sl/schemas/geo/us"

#Address: {
    state!: geo_us.#State  // References enum from geo package
}
```

## Commit Message Convention

Uses [Conventional Commits](https://www.conventionalcommits.org/) for automated releases via release-please:

**Schema-specific commit types:**
- `add:` - New schemas (triggers MINOR bump: 1.0.0 → 1.1.0)
- `edit:` - Schema modifications (triggers PATCH bump: 1.0.0 → 1.0.1)
- `remove:` with `BREAKING CHANGE:` - Schema removal (triggers MAJOR bump: 1.0.0 → 2.0.0)
- `docs:` - Documentation only (triggers PATCH bump)
- `chore:` - Infrastructure changes (triggers PATCH bump)

**Breaking changes:**
- Add `!` suffix to type OR include `BREAKING CHANGE:` in footer
- Triggers MAJOR version bump

**Examples:**
```bash
# Adding a new schema (MINOR)
git commit -m "add(address): add French address schema

- Add base/address/fr with La Poste standard
- Add base/geo/fr with regions and departments"

# Editing a schema (PATCH)
git commit -m "edit(address): correct UK postcode validation pattern"

# Breaking change (MAJOR)
git commit -m "edit(address)!: restructure US address schema

BREAKING CHANGE: Field 'street' renamed to 'street_line1'"
```

## Versioning

All schemas follow semantic versioning (MAJOR.MINOR.PATCH):

- **MAJOR**: Breaking changes (field removal/rename, tightening validation, schema removal)
- **MINOR**: Backward-compatible additions (new optional fields, new schemas, loosening validation)
- **PATCH**: Non-functional changes (docs, examples, comments)

Each schema maintains version in `_schema.version` metadata.

## Adding New Schemas

When adding schemas for new countries:

1. **Research official standard** (e.g., USPS, Royal Mail, Deutsche Post)
2. **Create directory structure**:
   ```bash
   mkdir -p base/address/{country_code}
   mkdir -p base/geo/{country_code}
   ```
3. **Create geo enum** first (states/regions/prefectures)
4. **Create address schema** that imports geo enum
5. **Include diverse examples** (residential, business, PO box, rural, edge cases)
6. **Validate**: `cue vet ./base/address/{country_code}/...`
7. **Update documentation**: README.md, CHANGELOG.md

## Release Process

Automated via release-please GitHub Action:
1. Merge PRs to `main` with conventional commits
2. Release-please creates/updates a Release PR automatically
3. Review Release PR (changelog, version bump)
4. Merge Release PR to publish (creates git tag and GitHub Release automatically)

No manual version bumps needed - release-please handles versioning based on commit messages.
