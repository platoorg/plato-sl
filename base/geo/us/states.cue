// PlatoSL Base Schema: US States and Territories
// Version: v1
// Country: United States
// Source: USPS, ISO 3166-2:US

package us

// US states and territories - USPS two-letter codes
#State:
	"AL" | // Alabama
	"AK" | // Alaska
	"AZ" | // Arizona
	"AR" | // Arkansas
	"CA" | // California
	"CO" | // Colorado
	"CT" | // Connecticut
	"DE" | // Delaware
	"FL" | // Florida
	"GA" | // Georgia
	"HI" | // Hawaii
	"ID" | // Idaho
	"IL" | // Illinois
	"IN" | // Indiana
	"IA" | // Iowa
	"KS" | // Kansas
	"KY" | // Kentucky
	"LA" | // Louisiana
	"ME" | // Maine
	"MD" | // Maryland
	"MA" | // Massachusetts
	"MI" | // Michigan
	"MN" | // Minnesota
	"MS" | // Mississippi
	"MO" | // Missouri
	"MT" | // Montana
	"NE" | // Nebraska
	"NV" | // Nevada
	"NH" | // New Hampshire
	"NJ" | // New Jersey
	"NM" | // New Mexico
	"NY" | // New York
	"NC" | // North Carolina
	"ND" | // North Dakota
	"OH" | // Ohio
	"OK" | // Oklahoma
	"OR" | // Oregon
	"PA" | // Pennsylvania
	"RI" | // Rhode Island
	"SC" | // South Carolina
	"SD" | // South Dakota
	"TN" | // Tennessee
	"TX" | // Texas
	"UT" | // Utah
	"VT" | // Vermont
	"VA" | // Virginia
	"WA" | // Washington
	"WV" | // West Virginia
	"WI" | // Wisconsin
	"WY" | // Wyoming
	"DC" | // District of Columbia
	"AS" | // American Samoa
	"GU" | // Guam
	"MP" | // Northern Mariana Islands
	"PR" | // Puerto Rico
	"VI" // US Virgin Islands

// State names
#StateName: {
	"AL": "Alabama"
	"AK": "Alaska"
	"AZ": "Arizona"
	"AR": "Arkansas"
	"CA": "California"
	"CO": "Colorado"
	"CT": "Connecticut"
	"DE": "Delaware"
	"FL": "Florida"
	"GA": "Georgia"
	"HI": "Hawaii"
	"ID": "Idaho"
	"IL": "Illinois"
	"IN": "Indiana"
	"IA": "Iowa"
	"KS": "Kansas"
	"KY": "Kentucky"
	"LA": "Louisiana"
	"ME": "Maine"
	"MD": "Maryland"
	"MA": "Massachusetts"
	"MI": "Michigan"
	"MN": "Minnesota"
	"MS": "Mississippi"
	"MO": "Missouri"
	"MT": "Montana"
	"NE": "Nebraska"
	"NV": "Nevada"
	"NH": "New Hampshire"
	"NJ": "New Jersey"
	"NM": "New Mexico"
	"NY": "New York"
	"NC": "North Carolina"
	"ND": "North Dakota"
	"OH": "Ohio"
	"OK": "Oklahoma"
	"OR": "Oregon"
	"PA": "Pennsylvania"
	"RI": "Rhode Island"
	"SC": "South Carolina"
	"SD": "South Dakota"
	"TN": "Tennessee"
	"TX": "Texas"
	"UT": "Utah"
	"VT": "Vermont"
	"VA": "Virginia"
	"WA": "Washington"
	"WV": "West Virginia"
	"WI": "Wisconsin"
	"WY": "Wyoming"
	"DC": "District of Columbia"
	"AS": "American Samoa"
	"GU": "Guam"
	"MP": "Northern Mariana Islands"
	"PR": "Puerto Rico"
	"VI": "US Virgin Islands"
}

// State metadata
#StateInfo: {
	[Code=#State]: {
		code:       Code
		name:       #StateName[Code]
		capital?:   string
		region:     "Northeast" | "Southeast" | "Midwest" | "Southwest" | "West" | "Territory"
		type:       "State" | "District" | "Territory"
		timezone?:  string // Primary timezone
	}
}

// Selected state information (major states for brevity)
stateInfo: #StateInfo & {
	CA: {
		capital:  "Sacramento"
		region:   "West"
		type:     "State"
		timezone: "America/Los_Angeles"
	}
	TX: {
		capital:  "Austin"
		region:   "Southwest"
		type:     "State"
		timezone: "America/Chicago"
	}
	NY: {
		capital:  "Albany"
		region:   "Northeast"
		type:     "State"
		timezone: "America/New_York"
	}
	FL: {
		capital:  "Tallahassee"
		region:   "Southeast"
		type:     "State"
		timezone: "America/New_York"
	}
	IL: {
		capital:  "Springfield"
		region:   "Midwest"
		type:     "State"
		timezone: "America/Chicago"
	}
	DC: {
		region:   "Northeast"
		type:     "District"
		timezone: "America/New_York"
	}
	PR: {
		capital:  "San Juan"
		region:   "Territory"
		type:     "Territory"
		timezone: "America/Puerto_Rico"
	}
}
