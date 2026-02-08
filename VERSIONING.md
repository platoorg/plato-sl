# Schema Versioning

## Semantic Versioning

All schemas follow semantic versioning: `MAJOR.MINOR.PATCH`

### MAJOR Version

Breaking changes that require user action:

- Removing required fields
- Renaming fields
- Changing field types incompatibly
- Tightening validation constraints (making rules more restrictive)
- Removing schemas or definitions

**Example**: `v1.5.2` → `v2.0.0`

```cue
// v1.0.0
#Address: {
    street!: string
    city!:   string
}

// v2.0.0 - BREAKING: renamed field
#Address: {
    street_line1!: string  // was 'street'
    city!:         string
}
```

### MINOR Version

Backward-compatible additions:

- Adding new optional fields
- Adding new schemas or definitions
- Loosening validation constraints (making rules less restrictive)
- Adding new enum values
- Adding new examples

**Example**: `v1.5.2` → `v1.6.0`

```cue
// v1.5.0
#Address: {
    street!: string
    city!:   string
}

// v1.6.0 - Compatible: added optional field
#Address: {
    street!:       string
    city!:         string
    street_line2?: string  // new optional field
}
```

### PATCH Version

Bug fixes and non-functional changes:

- Documentation updates
- Example corrections
- Comment clarifications
- Metadata updates
- Internal refactoring without behavior changes

**Example**: `v1.5.2` → `v1.5.3`

## Schema-Level Versioning

Each schema maintains its own version in metadata:

```cue
#Address: {
    _schema: {
        version:  "v1.0.0"
        country:  "US"
        standard: "USPS Publication 28"
    }
    // ...
}
```

## Git Tags

Repository uses git tags for releases:

```bash
# View all versions
git tag -l

# Checkout specific version
git checkout v1.0.0

# Use in CUE imports
import "github.com/platoorg/plato-sl/base/address/us@v1.0.0"
```

## Deprecation Policy

When making breaking changes:

### 1. Deprecation Notice (MINOR version)

- Add `_deprecated: true` to schema
- Document migration path in comments
- Maintain deprecated schema for at least 6 months
- Add warning in documentation

```cue
// Deprecated: Use #NewAddress instead
// This schema will be removed in v2.0.0
// Migration guide: https://...
#OldAddress: {
    _deprecated: true
    // ... schema definition
}

#NewAddress: {
    // ... new schema definition
}
```

### 2. Breaking Change (MAJOR version)

- Remove or change deprecated schema
- Update CHANGELOG.md with migration guide
- Provide migration examples
- Update all documentation

## Version Compatibility

### Forward Compatibility

Schemas are designed to be forward-compatible within major versions:

```cue
// Data validated with v1.0.0 will validate with v1.5.0
// because MINOR versions only add optional fields
```

### Backward Compatibility

MAJOR version changes may break backward compatibility:

```cue
// Data validated with v2.0.0 may NOT validate with v1.x.x
// Use the version that matches your data structure
```

## Changelog

All changes are documented in [CHANGELOG.md](./CHANGELOG.md) with:

- Version number and date
- Type of change (MAJOR/MINOR/PATCH)
- Description of changes
- Migration guide (for breaking changes)
- Examples (where helpful)

## Version Selection

### For Production

Use specific versions with tags:

```bash
cue mod get github.com/platoorg/plato-sl/base@v1.2.3
```

### For Development

You may use version ranges or latest:

```bash
# Latest v1.x.x
cue mod get github.com/platoorg/plato-sl/base@v1

# Latest (not recommended for production)
cue mod get github.com/platoorg/plato-sl/base@latest
```

## Release Process

1. **Update schema versions** in `_schema.version` fields
2. **Update CHANGELOG.md** with changes
3. **Run validation** on all schemas
4. **Update documentation** if needed
5. **Create git tag** with version
6. **Push tag** to trigger release
7. **Create GitHub Release** with notes

```bash
# Example release
git tag -a v1.2.0 -m "Release v1.2.0: Add German address schema"
git push origin v1.2.0
```

## Version Support

- **Latest MAJOR version**: Active development, bug fixes, new features
- **Previous MAJOR version**: Security fixes and critical bugs for 12 months
- **Older versions**: No active support (community support only)

## Questions?

For versioning questions or concerns:

- Open an issue: [GitHub Issues](https://github.com/platoorg/plato-sl/issues)
- Discussion: [GitHub Discussions](https://github.com/platoorg/plato-sl/discussions)
