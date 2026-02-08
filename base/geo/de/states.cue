// PlatoSL Base Schema: German States (Bundesländer)
// Version: v1
// Country: Germany
// Source: Official German administrative divisions

package de

// German states (Bundesländer) - ISO 3166-2:DE codes
#State:
	"BW" | // Baden-Württemberg
	"BY" | // Bayern (Bavaria)
	"BE" | // Berlin
	"BB" | // Brandenburg
	"HB" | // Bremen
	"HH" | // Hamburg
	"HE" | // Hessen (Hesse)
	"MV" | // Mecklenburg-Vorpommern
	"NI" | // Niedersachsen (Lower Saxony)
	"NW" | // Nordrhein-Westfalen (North Rhine-Westphalia)
	"RP" | // Rheinland-Pfalz (Rhineland-Palatinate)
	"SL" | // Saarland
	"SN" | // Sachsen (Saxony)
	"ST" | // Sachsen-Anhalt (Saxony-Anhalt)
	"SH" | // Schleswig-Holstein
	"TH" // Thüringen (Thuringia)

// Human-readable state names (German)
#StateName: {
	"BW": "Baden-Württemberg"
	"BY": "Bayern"
	"BE": "Berlin"
	"BB": "Brandenburg"
	"HB": "Bremen"
	"HH": "Hamburg"
	"HE": "Hessen"
	"MV": "Mecklenburg-Vorpommern"
	"NI": "Niedersachsen"
	"NW": "Nordrhein-Westfalen"
	"RP": "Rheinland-Pfalz"
	"SL": "Saarland"
	"SN": "Sachsen"
	"ST": "Sachsen-Anhalt"
	"SH": "Schleswig-Holstein"
	"TH": "Thüringen"
}

// Human-readable state names (English)
#StateNameEN: {
	"BW": "Baden-Württemberg"
	"BY": "Bavaria"
	"BE": "Berlin"
	"BB": "Brandenburg"
	"HB": "Bremen"
	"HH": "Hamburg"
	"HE": "Hesse"
	"MV": "Mecklenburg-Western Pomerania"
	"NI": "Lower Saxony"
	"NW": "North Rhine-Westphalia"
	"RP": "Rhineland-Palatinate"
	"SL": "Saarland"
	"SN": "Saxony"
	"ST": "Saxony-Anhalt"
	"SH": "Schleswig-Holstein"
	"TH": "Thuringia"
}

// State metadata with capitals and regions
#StateInfo: {
	[Code=#State]: {
		code:    Code
		name:    #StateName[Code]
		nameEN:  #StateNameEN[Code]
		capital: string
		region:  "North" | "East" | "South" | "West"
	}
}

// Complete state information
stateInfo: #StateInfo & {
	BW: {
		capital: "Stuttgart"
		region:  "South"
	}
	BY: {
		capital: "München"
		region:  "South"
	}
	BE: {
		capital: "Berlin"
		region:  "East"
	}
	BB: {
		capital: "Potsdam"
		region:  "East"
	}
	HB: {
		capital: "Bremen"
		region:  "North"
	}
	HH: {
		capital: "Hamburg"
		region:  "North"
	}
	HE: {
		capital: "Wiesbaden"
		region:  "West"
	}
	MV: {
		capital: "Schwerin"
		region:  "North"
	}
	NI: {
		capital: "Hannover"
		region:  "North"
	}
	NW: {
		capital: "Düsseldorf"
		region:  "West"
	}
	RP: {
		capital: "Mainz"
		region:  "West"
	}
	SL: {
		capital: "Saarbrücken"
		region:  "West"
	}
	SN: {
		capital: "Dresden"
		region:  "East"
	}
	ST: {
		capital: "Magdeburg"
		region:  "East"
	}
	SH: {
		capital: "Kiel"
		region:  "North"
	}
	TH: {
		capital: "Erfurt"
		region:  "East"
	}
}
