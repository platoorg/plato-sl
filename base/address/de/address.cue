// PlatoSL Base Schema: German Address
// Version: v1
// Country: Germany
// Standard: Deutsche Post

package de

import geo_de "github.com/platoorg/plato-sl/schemas/geo/de"

// German Address schema following Deutsche Post standards
#Address: {
	// Schema metadata
	_schema: {
		version: "v1"
		country: "DE"
		standard: "Deutsche Post"
	}

	// Type discriminator
	_type: "address.de"

	// Required fields

	// Street name (e.g., "Hauptstraße", "Unter den Linden")
	strasse!: string & =~"^.{1,100}$"

	// House number with optional addition (e.g., "15", "23a", "42-44")
	hausnummer!: string & =~"^\\d+[a-z]?(-\\d+[a-z]?)?$"

	// Postal code (Postleitzahl) - 5 digits (e.g., "10115", "80331")
	plz!: string & =~"^\\d{5}$"

	// City/Town (e.g., "Berlin", "München")
	stadt!: string & =~"^[a-zA-ZäöüßÄÖÜ\\s\\-']{1,50}$"

	// Optional fields

	// Address addition (e.g., "Hinterhaus", "2. Stock")
	adresszusatz?: string & =~"^.{0,100}$"

	// Post office box (Postfach)
	postfach?: string & =~"^\\d+$"

	// Packstation number (for DHL Packstation delivery)
	packstation?: string & =~"^\\d{3}$"

	// Post number (Postnummer) for Packstation
	postnummer?: string & =~"^\\d{8,10}$"

	// State (Bundesland) - imported from geo schema
	bundesland?: geo_de.#State

	// Validation rules

	// If using Packstation, post number is required
	if packstation != _|_ {
		postnummer!: string & =~"^\\d{8,10}$"
	}

	// If using Postfach, street and house number are not needed
	if postfach != _|_ {
		strasse?:     string
		hausnummer?:  string
	}
}

// Re-export state definitions for convenience
#Bundesland: geo_de.#State
#BundeslandName: geo_de.#StateName

// Export the main schema
Address: #Address

// Example valid addresses
_examples: {
	berlin_standard: Address & {
		strasse:    "Unter den Linden"
		hausnummer: "77"
		plz:        "10117"
		stadt:      "Berlin"
		bundesland: "BE"
	}

	munich_apartment: Address & {
		strasse:      "Maximilianstraße"
		hausnummer:   "15"
		adresszusatz: "2. Stock, Wohnung 23"
		plz:          "80539"
		stadt:        "München"
		bundesland:   "BY"
	}

	hamburg_business: Address & {
		strasse:      "Große Reichenstraße"
		hausnummer:   "27"
		adresszusatz: "c/o Müller GmbH"
		plz:          "20457"
		stadt:        "Hamburg"
		bundesland:   "HH"
	}

	postfach: Address & {
		postfach: "102030"
		plz:      "50667"
		stadt:    "Köln"
	}

	packstation: Address & {
		packstation: "123"
		postnummer:  "12345678"
		plz:         "10115"
		stadt:       "Berlin"
	}

	with_umlaut: Address & {
		strasse:    "Würzburger Straße"
		hausnummer: "42"
		plz:        "90766"
		stadt:      "Fürth"
		bundesland: "BY"
	}
}
