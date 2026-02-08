// PlatoSL Base Schema: US Address
// Version: v1
// Country: United States
// Standard: USPS Publication 28

package us

import geo_us "github.com/platoorg/plato-sl/schemas/geo/us"

// US Address schema following USPS standards
#Address: {
	// Schema metadata
	_schema: {
		version: "v1"
		country: "US"
		standard: "USPS Publication 28"
	}

	// Type discriminator
	_type: "address.us"

	// Required fields

	// Primary street address (e.g., "123 Main St", "PO Box 456")
	street_line1!: string & =~"^.{1,100}$"

	// Optional secondary address (e.g., "Apt 2B", "Suite 500")
	street_line2?: string & =~"^.{0,100}$"

	// City name (e.g., "San Francisco")
	city!: string & =~"^[a-zA-Z\\s\\-']{1,50}$"

	// Two-letter state code - imported from geo schema
	state!: geo_us.#State

	// ZIP code: 5 digits or ZIP+4 format (e.g., "94102" or "94102-1234")
	zip!: string & =~"^\\d{5}(-\\d{4})?$"

	// Optional fields

	// County (rarely used but sometimes required)
	county?: string & =~"^[a-zA-Z\\s\\-']{1,50}$"

	// Urbanization (used in Puerto Rico)
	urbanization?: string & =~"^[a-zA-Z\\s\\-']{1,50}$"

	// Validation rules

	// Puerto Rico requires urbanization in some cases
	if state == "PR" {
		urbanization?: string
	}
}

// Re-export state definitions for convenience
#StateCode: geo_us.#State
#StateName: geo_us.#StateName

// Export the main schema
Address: #Address

// Example valid addresses
_examples: {
	california_standard: Address & {
		street_line1: "1600 Amphitheatre Parkway"
		city:         "Mountain View"
		state:        "CA"
		zip:          "94043"
	}

	new_york_apartment: Address & {
		street_line1: "123 Broadway"
		street_line2: "Apt 4B"
		city:         "New York"
		state:        "NY"
		zip:          "10012-1234"
	}

	texas_business: Address & {
		street_line1: "500 S Main St"
		street_line2: "Suite 200"
		city:         "Fort Worth"
		state:        "TX"
		zip:          "76102"
	}

	po_box: Address & {
		street_line1: "PO Box 12345"
		city:         "Seattle"
		state:        "WA"
		zip:          "98101"
	}

	puerto_rico: Address & {
		street_line1:  "123 Calle Principal"
		urbanization:  "Villa Carolina"
		city:          "Carolina"
		state:         "PR"
		zip:           "00985"
	}

	dc_address: Address & {
		street_line1: "1600 Pennsylvania Ave NW"
		city:         "Washington"
		state:        "DC"
		zip:          "20500"
	}
}
