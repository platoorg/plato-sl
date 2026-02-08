# PlatoSL Base Schemas

Official, versioned schemas for common data structures.

## Overview

This repository contains the base schemas for the PlatoSL (Schema Language) project. These schemas provide standardized, validated definitions for common data structures like addresses, geographic data, and content types.

## Installation

### Using CUE Module System

```bash
cue mod get github.com/platoorg/plato-sl/base@v1.0.0
```

### Using PlatoSL CLI

```bash
platosl add github.com/platoorg/plato-sl/base/address/us@v1.0.0
```

## Available Schemas

### Address Schemas

Standardized address formats following official postal standards:

- **`base/address/us`** - US addresses (USPS Publication 28 standard)
- **`base/address/uk`** - UK addresses (Royal Mail PAF standard)
- **`base/address/de`** - German addresses (Deutsche Post standard)
- **`base/address/jp`** - Japanese addresses (Japan Post standard)

### Geographic Data

Official geographic reference data:

- **`base/geo/us`** - US states and territories
- **`base/geo/uk`** - UK countries and regions
- **`base/geo/de`** - German Bundesländer (states)
- **`base/geo/jp`** - Japanese prefectures

### Content Contracts

CMS content block definitions:

- **`base/content`** - Image, Avatar, Card, Hero, and other content types

## Usage

### Basic Usage

```cue
package myapp

import us_addr "platosl.org/schemas/address/us"

myAddress: us_addr.#Address & {
    street_line1: "1600 Amphitheatre Parkway"
    city:         "Mountain View"
    state:        "CA"
    zip:          "94043"
}
```

### With Multiple Countries

```cue
package myapp

import (
    us_addr "platosl.org/schemas/address/us"
    uk_addr "platosl.org/schemas/address/uk"
)

#UserAddress: us_addr.#Address | uk_addr.#Address

user: {
    name: "John Doe"
    address: us_addr.#Address & {
        street_line1: "123 Main St"
        city:         "New York"
        state:        "NY"
        zip:          "10001"
    }
}
```

## Examples

See the [examples](./examples/) directory for complete usage examples:

- Basic schema usage
- Extending base schemas
- CMS integration patterns
- Code generation examples

## Versioning

All schemas follow [Semantic Versioning](https://semver.org/):

- **Major**: Breaking changes to schema structure
- **Minor**: New optional fields, new schemas
- **Patch**: Documentation, examples, bug fixes

See [VERSIONING.md](./VERSIONING.md) for complete versioning policy.

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

### Commit Message Conventions

This repository uses structured commit messages to enable automated versioning and future changelog generation.

**Quick Reference:**
- `add(address/fr): add French address schema` - Adding new schemas
- `edit(address/us): update ZIP validation` - Modifying existing schemas
- `remove(content/old): remove deprecated block` - Removing schemas
- `docs: update README` - Documentation changes

**Scopes are required** for `add`, `edit`, and `remove` commits and must match the repository structure (e.g., `address/us`, `content`, `geo/uk`).

See [docs/commit-conventions.md](docs/commit-conventions.md) for complete guidelines.

#### Optional Pre-Push Hook

Install a pre-push hook for local commit validation:

```bash
./scripts/install-hooks.sh
```

This validates your commits before pushing, catching errors early.

## Related Projects

- **[platosl-cli](https://github.com/platoorg/plato-sl-cli)** - Command-line tool for working with schemas
- **[plato](https://github.com/YOUR_ORG/plato)** - Full application platform

## License

[License information to be added]

## Support

- Issues: [GitHub Issues](https://github.com/platoorg/plato-sl/issues)
- Documentation: [base/README.md](./base/README.md)
- Discussion: [GitHub Discussions](https://github.com/platoorg/plato-sl/discussions)
