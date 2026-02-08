# Geographic Data Schemas

This directory contains reusable geographic and administrative division schemas organized by country.

## Purpose

Geographic data like states, provinces, prefectures, and postal codes are used across multiple schemas (addresses, shipping, demographics, etc.). By centralizing these definitions, we ensure:

1. **Consistency** - Same codes and names everywhere
2. **Reusability** - Import once, use anywhere
3. **Maintainability** - Update in one place
4. **Validation** - Enforce valid values across all schemas

## Structure

```
geo/
├── de/           # Germany
│   └── states.cue           # Bundesländer (German states)
├── us/           # United States
│   └── states.cue           # US states and territories
├── uk/           # United Kingdom
│   └── countries.cue        # UK countries and regions
└── jp/           # Japan
    └── prefectures.cue      # Japanese prefectures
```

## Usage

### Import and Use

CUE supports cross-file and cross-package references. Import geo schemas in your own schemas:

```cue
package myapp

import geo_de "platosl.org/base/geo/de"
import geo_us "platosl.org/base/geo/us"

// Use German states
#MySchema: {
    bundesland: geo_de.#State
}

// Use US states
#AnotherSchema: {
    state: geo_us.#State
}
```

### Examples

#### German States

```cue
import geo_de "platosl.org/base/geo/de"

userLocation: {
    state: geo_de.#State & "BY"  // Bavaria
    stateName: geo_de.#StateName["BY"]  // "Bayern"
}
```

#### US States

```cue
import geo_us "platosl.org/base/geo/us"

shippingAddress: {
    state: geo_us.#State & "CA"  // California
    stateName: geo_us.#StateName["CA"]  // "California"
}
```

#### UK Countries

```cue
import geo_uk "platosl.org/base/geo/uk"

location: {
    country: geo_uk.#Country & "SCT"  // Scotland
    countryName: geo_uk.#CountryName["SCT"]  // "Scotland"
}
```

#### Japanese Prefectures

```cue
import geo_jp "platosl.org/base/geo/jp"

address: {
    prefecture: geo_jp.#Prefecture & "13"  // Tokyo
    prefectureName: geo_jp.#PrefectureName["13"]  // "東京都"
    prefectureNameEN: geo_jp.#PrefectureNameEN["13"]  // "Tokyo"
}
```

## Available Definitions

### Germany (`geo/de/states.cue`)

- `#State` - ISO 3166-2:DE two-letter state codes (BW, BY, BE, etc.)
- `#StateName` - German state names
- `#StateNameEN` - English state names
- `#StateInfo` - Complete state metadata with capitals and regions
- `stateInfo` - Concrete state information data

### United States (`geo/us/states.cue`)

- `#State` - USPS two-letter state/territory codes (AL, AK, CA, etc.)
- `#StateName` - Full state names
- `#StateInfo` - State metadata with regions, capitals, timezones
- `stateInfo` - Sample state information

### United Kingdom (`geo/uk/countries.cue`)

- `#Country` - UK constituent countries (ENG, SCT, WLS, NIR)
- `#CountryName` - Country names
- `#EnglishRegion` - English regions (NE, NW, LON, etc.)
- `#EnglishRegionName` - English region names
- `#PostcodeArea` - UK postcode areas (first 1-2 letters)
- `#ScottishCouncil` - Scottish council areas
- `#WelshArea` - Welsh principal areas
- `#NICounty` - Northern Ireland counties
- `#CountryInfo` - Country metadata
- `countryInfo` - Concrete country information

### Japan (`geo/jp/prefectures.cue`)

- `#Prefecture` - ISO 3166-2:JP prefecture codes ("01" to "47")
- `#PrefectureName` - Japanese prefecture names (kanji)
- `#PrefectureNameEN` - Romanized prefecture names
- `#Region` - Japanese regions (Hokkaido, Tohoku, Kanto, etc.)
- `#PrefectureInfo` - Prefecture metadata
- `prefectureInfo` - Sample prefecture information

## Cross-File References

CUE's import system enables seamless cross-file references:

### Within the Same Package

Files in the same directory and package are automatically merged:

```cue
// File 1: types.cue
package myapp

#BaseType: string

// File 2: schema.cue
package myapp

// Can use #BaseType from types.cue
#MySchema: {
    field: #BaseType
}
```

### Across Packages

Import other packages explicitly:

```cue
package myapp

import geo "platosl.org/base/geo/de"

#MySchema: {
    state: geo.#State
}
```

## Integration with Address Schemas

All address schemas now import from geo:

- `base/address/de/address.cue` imports `geo/de`
- `base/address/us/address.cue` imports `geo/us`
- `base/address/uk/address.cue` imports `geo/uk`
- `base/address/jp/address.cue` imports `geo/jp`

This ensures:
- Address schemas validate against official state/province codes
- No duplication of geographic data
- Easy updates when geographic divisions change

## Benefits

### For Schema Authors

```cue
// Before: Duplicate state definitions everywhere
#AddressSchema: {
    state: "CA" | "NY" | "TX" | ...  // 50+ states!
}

#ShippingSchema: {
    state: "CA" | "NY" | "TX" | ...  // Same list again!
}

// After: Import once, reuse everywhere
import geo_us "platosl.org/base/geo/us"

#AddressSchema: {
    state: geo_us.#State  // All states automatically
}

#ShippingSchema: {
    state: geo_us.#State  // Same definition, no duplication
}
```

### For Application Developers

```typescript
// Generate TypeScript types from CUE
import { State, StateName } from './generated/types';

// State is a union type: "AL" | "AK" | "AZ" | ...
const validState: State = "CA";

// StateName is a map: { "CA": "California", ... }
const fullName = StateName["CA"];  // "California"
```

### For Validators

```javascript
// Generate Zod schemas from CUE
import { StateSchema } from './generated/zod';

// Runtime validation
StateSchema.parse("CA");  // ✓ Valid
StateSchema.parse("XX");  // ✗ Throws error
```

## Standards and Sources

All geographic data follows official standards:

- **Germany**: ISO 3166-2:DE (German Federal Statistical Office)
- **United States**: USPS Publication 28, ISO 3166-2:US
- **United Kingdom**: Royal Mail PAF, ISO 3166-2:GB, ONS
- **Japan**: Japan Post, ISO 3166-2:JP

## Future Additions

Potential geographic schemas to add:

- **Canada**: Provinces and territories
- **Australia**: States and territories
- **France**: Regions and departments
- **Spain**: Autonomous communities
- **India**: States and union territories
- **China**: Provinces and municipalities
- **Brazil**: States
- **Mexico**: States

## Contributing

When adding new geographic schemas:

1. Follow official standards (ISO 3166-2, postal authorities)
2. Include both code and human-readable names
3. Provide English translations when applicable
4. Add metadata (capitals, regions) when useful
5. Include comprehensive examples
6. Document the source/standard used

## Example: Complete Integration

Here's how everything works together:

```cue
// 1. Define geo data once
// geo/us/states.cue
package us

#State: "CA" | "NY" | ...

// 2. Import in address schema
// address/us/address.cue
package us

import geo_us "platosl.org/base/geo/us"

#Address: {
    state: geo_us.#State
}

// 3. Use in your application
// myapp/customer.cue
package myapp

import us_address "platosl.org/base/address/us"

#Customer: {
    name: string
    address: us_address.#Address
}

// 4. Generate code
// $ platosl gen typescript --zod

// 5. Use in TypeScript
import { Customer, CustomerSchema } from './generated/types';

const customer: Customer = {
    name: "Jane Doe",
    address: {
        street_line1: "123 Main St",
        city: "San Francisco",
        state: "CA",  // Type-checked!
        zip: "94102"
    }
};

// Runtime validation
CustomerSchema.parse(customer);  // ✓ Valid
```

## Summary

The `geo/` directory provides:
- ✅ Centralized geographic data
- ✅ Cross-file/cross-package references
- ✅ Official standards compliance
- ✅ Reusable across all schemas
- ✅ Type-safe code generation
- ✅ Runtime validation support
