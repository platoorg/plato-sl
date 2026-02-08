// PlatoSL Base Schema: Japanese Address
// Version: v1
// Country: Japan
// Standard: Japan Post

package jp

import geo_jp "github.com/platoorg/plato-sl/schemas/geo/jp"

// Japanese Address schema following Japan Post standards
#Address: {
	// Schema metadata
	_schema: {
		version: "v1"
		country: "JP"
		standard: "Japan Post"
	}

	// Type discriminator
	_type: "address.jp"

	// Required fields

	// Postal code (〒) - 7 digits with hyphen (e.g., "100-0001", "150-0002")
	// Format: 3 digits + hyphen + 4 digits
	postal_code!: string & =~"^\\d{3}-\\d{4}$"

	// Prefecture (都道府県) - imported from geo schema
	prefecture!: geo_jp.#Prefecture

	// City/Municipality (市区町村) - e.g., "千代田区", "渋谷区", "横浜市"
	city!: string & =~"^.{1,50}$"

	// Town/District (町域) - e.g., "丸の内", "神南", "みなとみらい"
	town!: string & =~"^.{1,50}$"

	// Street address and building (番地・建物名)
	// e.g., "1-1-1", "2-3-4 山田ビル", "3丁目4-5 タワーマンション 202号室"
	street_address!: string & =~"^.{1,100}$"

	// Optional fields

	// Room/Suite number (部屋番号)
	room?: string & =~"^.{0,20}$"

	// Building name (建物名)
	building?: string & =~"^.{0,100}$"

	// Company/Organization name (会社名・組織名)
	organization?: string & =~"^.{0,100}$"

	// Additional information (その他)
	additional_info?: string & =~"^.{0,200}$"

	// Alternative representations

	// Romanized versions (for international use)
	romanized?: {
		prefecture!:     string
		city!:           string
		town!:           string
		street_address!: string
		building?:       string
		room?:           string
		organization?:   string
	}
}

// Re-export prefecture definitions for convenience
#Prefecture: geo_jp.#Prefecture
#PrefectureName: geo_jp.#PrefectureName
#PrefectureNameEN: geo_jp.#PrefectureNameEN

// Export the main schema
Address: #Address

// Example valid addresses
_examples: {
	tokyo_standard: Address & {
		postal_code:   "100-0001"
		prefecture:    "13"
		city:          "千代田区"
		town:          "千代田"
		street_address: "1-1"
		romanized: {
			prefecture:     "Tokyo"
			city:           "Chiyoda-ku"
			town:           "Chiyoda"
			street_address: "1-1"
		}
	}

	tokyo_apartment: Address & {
		postal_code:   "150-0041"
		prefecture:    "13"
		city:          "渋谷区"
		town:          "神南"
		street_address: "1-2-3"
		building:      "渋谷マンション"
		room:          "301号室"
		romanized: {
			prefecture:     "Tokyo"
			city:           "Shibuya-ku"
			town:           "Jinnan"
			street_address: "1-2-3"
			building:       "Shibuya Mansion"
			room:           "301"
		}
	}

	osaka_business: Address & {
		postal_code:   "530-0001"
		prefecture:    "27"
		city:          "大阪市北区"
		town:          "梅田"
		street_address: "1-1-1"
		building:      "大阪ビル"
		organization:  "株式会社サンプル"
		romanized: {
			prefecture:     "Osaka"
			city:           "Osaka-shi Kita-ku"
			town:           "Umeda"
			street_address: "1-1-1"
			building:       "Osaka Building"
			organization:   "Sample Corporation"
		}
	}

	yokohama_residential: Address & {
		postal_code:   "220-0012"
		prefecture:    "14"
		city:          "横浜市西区"
		town:          "みなとみらい"
		street_address: "2-2-1"
		building:      "みなとみらいタワー"
		room:          "1501"
		romanized: {
			prefecture:     "Kanagawa"
			city:           "Yokohama-shi Nishi-ku"
			town:           "Minato Mirai"
			street_address: "2-2-1"
			building:       "Minato Mirai Tower"
			room:           "1501"
		}
	}

	kyoto_traditional: Address & {
		postal_code:   "600-8216"
		prefecture:    "26"
		city:          "京都市下京区"
		town:          "烏丸通"
		street_address: "七条下る"
		romanized: {
			prefecture:     "Kyoto"
			city:           "Kyoto-shi Shimogyo-ku"
			town:           "Karasuma-dori"
			street_address: "Shichijo-sagaru"
		}
	}
}
