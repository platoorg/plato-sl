# Changelog

All notable changes to PlatoSL base schemas will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.2](https://github.com/platoorg/plato-sl/compare/platosl-0.0.1...platosl-0.0.2) (2026-02-08)


### Added

* first version ([18c8bbd](https://github.com/platoorg/plato-sl/commit/18c8bbdbfa200f9157521bd07459598e8b93e47e))

## [Unreleased]

### Added
- Initial repository setup

## [1.0.0] - 2026-02-08

### Added

#### Address Schemas
- US address schema (`base/address/us`) following USPS Publication 28
  - Support for street addresses, PO boxes
  - ZIP and ZIP+4 format support
  - Puerto Rico urbanization support
  - State validation using geo schema
- UK address schema (`base/address/uk`) following Royal Mail PAF
  - Support for UK postcode format
  - Country distinction (England, Scotland, Wales, Northern Ireland)
  - Building name and organisation support
- German address schema (`base/address/de`) following Deutsche Post
  - Street (Straße) and house number (Hausnummer) format
  - Postleitzahl (PLZ) 5-digit format
  - Support for Postfach (PO Box)
  - Support for Packstation delivery
  - Bundesland (state) validation
- Japanese address schema (`base/address/jp`) following Japan Post
  - 7-digit postal code format (〒)
  - Prefecture-based structure
  - Support for romanized addresses
  - Building and room number support

#### Geographic Data
- US states and territories schema (`base/geo/us`)
  - All 50 states plus DC and territories
  - 2-letter state codes
  - Full state names
- UK countries and regions schema (`base/geo/uk`)
  - England, Scotland, Wales, Northern Ireland
  - 3-letter country codes
  - Postcode areas
- German Bundesländer schema (`base/geo/de`)
  - All 16 German states
  - 2-letter state codes
  - Full state names in German
- Japanese prefectures schema (`base/geo/jp`)
  - All 47 prefectures
  - Prefecture codes (1-47)
  - Japanese and English names

#### Content Schemas
- Image content block (`base/content`)
  - URL, alt text, dimensions
  - Responsive image support
- Avatar content block (`base/content`)
  - User profile images
  - Initials fallback support
- General content blocks for CMS integration

#### Documentation
- Usage examples for all schemas
- Blog content integration example
- CMS integration patterns
- Code generation examples

### Changed
- Module path set to `platosl.org/schemas` for standalone use

### Infrastructure
- CUE module configuration with v0.9.2 support
- Examples directory with practical usage patterns

## Version History

[Unreleased]: https://github.com/platoorg/plato-sl/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/platoorg/plato-sl/releases/tag/v1.0.0
