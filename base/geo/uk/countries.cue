// PlatoSL Base Schema: UK Countries and Regions
// Version: v1
// Country: United Kingdom
// Source: ISO 3166-2:GB, UK Office for National Statistics

package uk

// UK constituent countries - ISO 3166-2:GB codes
#Country:
	"ENG" | // England
	"SCT" | // Scotland
	"WLS" | // Wales
	"NIR" // Northern Ireland

// Country names
#CountryName: {
	"ENG": "England"
	"SCT": "Scotland"
	"WLS": "Wales"
	"NIR": "Northern Ireland"
}

// English regions (for England only)
#EnglishRegion:
	"NE" |  // North East
	"NW" |  // North West
	"YH" |  // Yorkshire and the Humber
	"EM" |  // East Midlands
	"WM" |  // West Midlands
	"EE" |  // East of England
	"LON" | // London
	"SE" |  // South East
	"SW" // South West

// English region names
#EnglishRegionName: {
	"NE":  "North East"
	"NW":  "North West"
	"YH":  "Yorkshire and the Humber"
	"EM":  "East Midlands"
	"WM":  "West Midlands"
	"EE":  "East of England"
	"LON": "London"
	"SE":  "South East"
	"SW":  "South West"
}

// Scottish council areas (selected major ones)
#ScottishCouncil:
	"ABD" |  // Aberdeen City
	"ABDS" | // Aberdeenshire
	"EDH" |  // Edinburgh
	"GLG" |  // Glasgow
	"HLD" |  // Highland
	"FIF" |  // Fife
	"SCB" |  // Scottish Borders
	"DGY" // Dumfries and Galloway

// Welsh principal areas (selected major ones)
#WelshArea:
	"CRF" | // Cardiff
	"SWA" | // Swansea
	"NWP" | // Newport
	"WRX" | // Wrexham
	"FLN" | // Flintshire
	"GWN" // Gwynedd

// Northern Ireland counties (historic/postal)
#NICounty:
	"ANT" | // Antrim
	"ARM" | // Armagh
	"DOW" | // Down
	"FER" | // Fermanagh
	"LDY" | // Londonderry
	"TYR" // Tyrone

// Country information
#CountryInfo: {
	[Code=#Country]: {
		code:        Code
		name:        #CountryName[Code]
		capital:     string
		population:  int // Approximate, in millions
	}
}

countryInfo: #CountryInfo & {
	ENG: {
		capital:    "London"
		population: 56000000
	}
	SCT: {
		capital:    "Edinburgh"
		population: 5500000
	}
	WLS: {
		capital:    "Cardiff"
		population: 3100000
	}
	NIR: {
		capital:    "Belfast"
		population: 1900000
	}
}

// Postcode areas (first 1-2 letters of UK postcode)
#PostcodeArea:
	"AB" | "AL" | "B" | "BA" | "BB" | "BD" | "BH" | "BL" | "BN" | "BR" |
	"BS" | "BT" | "CA" | "CB" | "CF" | "CH" | "CM" | "CO" | "CR" | "CT" |
	"CV" | "CW" | "DA" | "DD" | "DE" | "DG" | "DH" | "DL" | "DN" | "DT" |
	"DY" | "E" | "EC" | "EH" | "EN" | "EX" | "FK" | "FY" | "G" | "GL" |
	"GU" | "HA" | "HD" | "HG" | "HP" | "HR" | "HS" | "HU" | "HX" | "IG" |
	"IP" | "IV" | "KA" | "KT" | "KW" | "KY" | "L" | "LA" | "LD" | "LE" |
	"LL" | "LN" | "LS" | "LU" | "M" | "ME" | "MK" | "ML" | "N" | "NE" |
	"NG" | "NN" | "NP" | "NR" | "NW" | "OL" | "OX" | "PA" | "PE" | "PH" |
	"PL" | "PO" | "PR" | "RG" | "RH" | "RM" | "S" | "SA" | "SE" | "SG" |
	"SK" | "SL" | "SM" | "SN" | "SO" | "SP" | "SR" | "SS" | "ST" | "SW" |
	"SY" | "TA" | "TD" | "TF" | "TN" | "TQ" | "TR" | "TS" | "TW" | "UB" |
	"W" | "WA" | "WC" | "WD" | "WF" | "WN" | "WR" | "WS" | "WV" | "YO" |
	"ZE" // Shetland Islands
