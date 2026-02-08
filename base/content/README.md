# Content Contracts

**The data structure agreement between CMS and visual implementation.**

## Purpose

Define what content the CMS collects and what structure developers receive.

```
┌─────────────┐                    ┌──────────────────┐
│     CMS     │                    │   Visual Code    │
│             │                    │                  │
│  Collects   │ ──── Contract ───▶ │    Renders       │
│  Content    │      (PlatoSL)     │    Content       │
└─────────────┘                    └──────────────────┘
```

## Not UI Implementation

PlatoSL defines **what data exists**, not how it looks:

```cue
// ✅ Content contract
#Avatar: {
    image!: #Image
    name?:  string & =~"^.{1,30}$"
}

// CMS knows: Collect image + optional short name
// Developer knows: Receive image + optional name
// Both agree on max 30 chars
```

The developer decides:
- Should it be circular or square?
- What size?
- Where does the name appear?
- What fonts/colors?

## Available Content Types

### Basic Types

**`image.cue`** - Image reference
```cue
#Image: {
    src!: string  // URL
    alt!: string  // Accessibility
}
```

**`avatar.cue`** - Profile picture
```cue
#Avatar: {
    image!: #Image
    name?:  string & =~"^.{1,30}$"  // Max 30 chars
}
```

### Content Blocks

**`blocks.cue`** - Common content structures

```cue
#Card: {
    title!:       string & =~"^.{1,100}$"
    image?:       #Image
    description?: string & =~"^.{0,500}$"
    link?:        string
}

#Hero: {
    heading!:    string & =~"^.{1,100}$"
    subheading?: string & =~"^.{0,200}$"
    image?:      #Image
    ctaText?:    string & =~"^.{1,30}$"
    ctaLink?:    string
}

#TextBlock: {
    heading?:       string
    text!:          string
    image?:         #Image
    imagePosition?: "left" | "right" | "top" | "bottom"
}

#Gallery: {
    title?:  string
    images!: [...#Image]
}

#Quote: {
    text!:   string
    author?: {
        name!:   string
        title?:  string
        avatar?: #Image
    }
}

#CTA: {
    text!:        string
    link!:        string
    description?: string
}
```

## Usage Flow

### 1. CMS Author Fills Content

```typescript
// CMS form based on PlatoSL schema
{
  "heading": "Welcome to Our Platform",
  "subheading": "Build amazing things",
  "image": {
    "src": "hero.jpg",
    "alt": "Platform dashboard"
  },
  "ctaText": "Get Started",
  "ctaLink": "/signup"
}
```

### 2. Developer Receives Validated Data

```typescript
// Generated types from PlatoSL
import { Hero, HeroSchema } from './generated/types';

// Runtime validation
const hero: Hero = HeroSchema.parse(cmsData);

// Type-safe rendering
<YourHeroComponent
  heading={hero.heading}
  subheading={hero.subheading}
  image={hero.image?.src}
  ctaText={hero.ctaText}
  ctaLink={hero.ctaLink}
/>
```

### 3. Both Sides Trust the Contract

- **CMS**: "I'll collect exactly these fields with these constraints"
- **Developer**: "I'll receive exactly this structure, guaranteed valid"
- **PlatoSL**: "I enforce the contract"

## Examples

### Blog Post with Avatar Author

```cue
import content "platosl.org/base/content"

#BlogPost: {
    title!:   string
    author!:  content.#Avatar
    hero!:    content.#Hero
    content!: string
}
```

CMS collects:
- Title (text)
- Author image + name (avatar widget)
- Hero heading/image/CTA (hero widget)
- Content (rich text)

Developer receives:
```typescript
{
  title: "My Post",
  author: {
    image: { src: "...", alt: "..." },
    name: "Jane"
  },
  hero: {
    heading: "Welcome",
    image: { src: "...", alt: "..." }
  },
  content: "<p>...</p>"
}
```

### Product Page

```cue
import content "platosl.org/base/content"

#ProductPage: {
    hero!:     content.#Hero
    features!: [...content.#Card]
    gallery!:  content.#Gallery
    cta!:      content.#CTA
}
```

CMS provides structured content blocks.
Developer renders with their design system.

## Generate Code

```bash
# TypeScript types + Zod validation
platosl gen typescript --zod --output types.ts

# JSON Schema for CMS
platosl gen jsonschema --output cms-schema.json

# Go structs for backend
platosl gen go --package content --output content.go
```

## Benefits

### For CMS

- ✅ Know exactly what fields to collect
- ✅ Enforce max lengths, formats
- ✅ Require necessary fields (alt text!)
- ✅ Validate before saving

### For Developers

- ✅ Type-safe data structures
- ✅ Runtime validation
- ✅ Know exactly what you'll receive
- ✅ Autocomplete in IDE

### For Teams

- ✅ Single source of truth
- ✅ CMS and code stay in sync
- ✅ Breaking changes caught early
- ✅ Clear documentation

## Real-World Example

**CMS Schema:**
```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "Hero",
  "type": "object",
  "required": ["heading"],
  "properties": {
    "heading": {
      "type": "string",
      "maxLength": 100
    },
    "image": {
      "type": "object",
      "required": ["src", "alt"],
      "properties": {
        "src": { "type": "string" },
        "alt": { "type": "string" }
      }
    }
  }
}
```

**TypeScript Types:**
```typescript
interface Hero {
  heading: string;
  subheading?: string;
  image?: Image;
  ctaText?: string;
  ctaLink?: string;
}

interface Image {
  src: string;
  alt: string;
}
```

**React Component:**
```tsx
function HeroSection({ data }: { data: Hero }) {
  return (
    <div className="hero">
      <h1>{data.heading}</h1>
      {data.subheading && <p>{data.subheading}</p>}
      {data.image && (
        <img src={data.image.src} alt={data.image.alt} />
      )}
      {data.ctaText && data.ctaLink && (
        <a href={data.ctaLink}>{data.ctaText}</a>
      )}
    </div>
  );
}
```

## Summary

**PlatoSL Content Contracts = CMS ↔ Code Agreement**

- Simple, focused data structures
- What content is collected
- What format is expected
- Validation rules enforced
- Type-safe on both sides

Not UI, not styling, not implementation—just the content contract.
