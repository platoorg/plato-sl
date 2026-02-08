// PlatoSL Base Schema: UK Address
// Version: v1
// Country: United Kingdom
// Standard: Royal Mail PAF (Postcode Address File)

package uk

import geo_uk "github.com/platoorg/plato-sl/schemas/geo/uk"

// UK Address schema following Royal Mail standards
#Address: {
	// Schema metadata
	_schema: {
		version: "v1"
		country: "GB"
		standard: "Royal Mail PAF"
	}

	// Type discriminator
	_type: "address.uk"

	// Required fields

	// Building name or number with street (e.g., "10 Downing Street", "Flat 2B")
	street_line1!: string & =~"^.{1,100}$"

	// Additional street information
	street_line2?: string & =~"^.{0,100}$"

	// Town or city (e.g., "London", "Manchester")
	town!: string & =~"^[a-zA-Z\\s\\-']{1,50}$"

	// UK Postcode (e.g., "SW1A 1AA", "M1 1AE")
	// Format: Area(1-2 letters) + District(1-2 digits) + Sector(1 digit) + Unit(2 letters)
	postcode!: string & =~"^[A-Z]{1,2}\\d{1,2}[A-Z]?\\s?\\d[A-Z]{2}$"

	// Optional fields

	// County (increasingly optional in modern UK addresses)
	county?: string & =~"^[a-zA-Z\\s\\-']{1,50}$"

	// Country (England, Scotland, Wales, Northern Ireland) - imported from geo schema
	country?: geo_uk.#Country

	// Locality (for rural addresses)
	locality?: string & =~"^[a-zA-Z\\s\\-']{1,50}$"

	// Organisation name (for business addresses)
	organisation?: string & =~"^.{1,100}$"

	// Building name (for named buildings)
	building_name?: string & =~"^.{1,100}$"
}

// Re-export geo definitions for convenience
#PostcodeArea: geo_uk.#PostcodeArea
#Country: geo_uk.#Country
#CountryName: geo_uk.#CountryName

// Export the main schema
Address: #Address

// Example valid addresses
_examples: {
	london_standard: Address & {
		street_line1: "10 Downing Street"
		town:         "London"
		postcode:     "SW1A 2AA"
		country:      "ENG"
	}

	edinburgh_apartment: Address & {
		street_line1: "15 Royal Mile"
		street_line2: "Flat 3F"
		town:         "Edinburgh"
		postcode:     "EH1 1RE"
		country:      "SCT"
	}

	cardiff_business: Address & {
		organisation: "Welsh Assembly"
		street_line1: "Senedd Building"
		town:         "Cardiff"
		postcode:     "CF99 1SN"
		country:      "WLS"
	}

	belfast_standard: Address & {
		street_line1: "1 Belfast Harbour"
		town:         "Belfast"
		postcode:     "BT3 9AL"
		country:      "NIR"
	}

	manchester_business: Address & {
		organisation: "Tech Company Ltd"
		street_line1: "123 Deansgate"
		street_line2: "Suite 200"
		town:         "Manchester"
		postcode:     "M3 2BQ"
		country:      "ENG"
	}

	rural_address: Address & {
		building_name: "Rose Cottage"
		street_line1:  "High Street"
		locality:      "Little Hampden"
		town:          "Great Missenden"
		county:        "Buckinghamshire"
		postcode:      "HP16 9PS"
		country:       "ENG"
	}
}
