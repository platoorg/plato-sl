// PlatoSL Base Schema: Japanese Prefectures (都道府県)
// Version: v1
// Country: Japan
// Source: ISO 3166-2:JP, Japan Post

package jp

// Japanese prefectures - ISO 3166-2:JP codes
#Prefecture:
	"01" | // Hokkaido (北海道)
	"02" | // Aomori (青森県)
	"03" | // Iwate (岩手県)
	"04" | // Miyagi (宮城県)
	"05" | // Akita (秋田県)
	"06" | // Yamagata (山形県)
	"07" | // Fukushima (福島県)
	"08" | // Ibaraki (茨城県)
	"09" | // Tochigi (栃木県)
	"10" | // Gunma (群馬県)
	"11" | // Saitama (埼玉県)
	"12" | // Chiba (千葉県)
	"13" | // Tokyo (東京都)
	"14" | // Kanagawa (神奈川県)
	"15" | // Niigata (新潟県)
	"16" | // Toyama (富山県)
	"17" | // Ishikawa (石川県)
	"18" | // Fukui (福井県)
	"19" | // Yamanashi (山梨県)
	"20" | // Nagano (長野県)
	"21" | // Gifu (岐阜県)
	"22" | // Shizuoka (静岡県)
	"23" | // Aichi (愛知県)
	"24" | // Mie (三重県)
	"25" | // Shiga (滋賀県)
	"26" | // Kyoto (京都府)
	"27" | // Osaka (大阪府)
	"28" | // Hyogo (兵庫県)
	"29" | // Nara (奈良県)
	"30" | // Wakayama (和歌山県)
	"31" | // Tottori (鳥取県)
	"32" | // Shimane (島根県)
	"33" | // Okayama (岡山県)
	"34" | // Hiroshima (広島県)
	"35" | // Yamaguchi (山口県)
	"36" | // Tokushima (徳島県)
	"37" | // Kagawa (香川県)
	"38" | // Ehime (愛媛県)
	"39" | // Kochi (高知県)
	"40" | // Fukuoka (福岡県)
	"41" | // Saga (佐賀県)
	"42" | // Nagasaki (長崎県)
	"43" | // Kumamoto (熊本県)
	"44" | // Oita (大分県)
	"45" | // Miyazaki (宮崎県)
	"46" | // Kagoshima (鹿児島県)
	"47" // Okinawa (沖縄県)

// Prefecture names in Japanese
#PrefectureName: {
	"01": "北海道"
	"02": "青森県"
	"03": "岩手県"
	"04": "宮城県"
	"05": "秋田県"
	"06": "山形県"
	"07": "福島県"
	"08": "茨城県"
	"09": "栃木県"
	"10": "群馬県"
	"11": "埼玉県"
	"12": "千葉県"
	"13": "東京都"
	"14": "神奈川県"
	"15": "新潟県"
	"16": "富山県"
	"17": "石川県"
	"18": "福井県"
	"19": "山梨県"
	"20": "長野県"
	"21": "岐阜県"
	"22": "静岡県"
	"23": "愛知県"
	"24": "三重県"
	"25": "滋賀県"
	"26": "京都府"
	"27": "大阪府"
	"28": "兵庫県"
	"29": "奈良県"
	"30": "和歌山県"
	"31": "鳥取県"
	"32": "島根県"
	"33": "岡山県"
	"34": "広島県"
	"35": "山口県"
	"36": "徳島県"
	"37": "香川県"
	"38": "愛媛県"
	"39": "高知県"
	"40": "福岡県"
	"41": "佐賀県"
	"42": "長崎県"
	"43": "熊本県"
	"44": "大分県"
	"45": "宮崎県"
	"46": "鹿児島県"
	"47": "沖縄県"
}

// Prefecture names in English (Romaji)
#PrefectureNameEN: {
	"01": "Hokkaido"
	"02": "Aomori"
	"03": "Iwate"
	"04": "Miyagi"
	"05": "Akita"
	"06": "Yamagata"
	"07": "Fukushima"
	"08": "Ibaraki"
	"09": "Tochigi"
	"10": "Gunma"
	"11": "Saitama"
	"12": "Chiba"
	"13": "Tokyo"
	"14": "Kanagawa"
	"15": "Niigata"
	"16": "Toyama"
	"17": "Ishikawa"
	"18": "Fukui"
	"19": "Yamanashi"
	"20": "Nagano"
	"21": "Gifu"
	"22": "Shizuoka"
	"23": "Aichi"
	"24": "Mie"
	"25": "Shiga"
	"26": "Kyoto"
	"27": "Osaka"
	"28": "Hyogo"
	"29": "Nara"
	"30": "Wakayama"
	"31": "Tottori"
	"32": "Shimane"
	"33": "Okayama"
	"34": "Hiroshima"
	"35": "Yamaguchi"
	"36": "Tokushima"
	"37": "Kagawa"
	"38": "Ehime"
	"39": "Kochi"
	"40": "Fukuoka"
	"41": "Saga"
	"42": "Nagasaki"
	"43": "Kumamoto"
	"44": "Oita"
	"45": "Miyazaki"
	"46": "Kagoshima"
	"47": "Okinawa"
}

// Regions of Japan
#Region:
	"Hokkaido" |       // 北海道
	"Tohoku" |         // 東北
	"Kanto" |          // 関東
	"Chubu" |          // 中部
	"Kansai" |         // 関西
	"Chugoku" |        // 中国
	"Shikoku" |        // 四国
	"Kyushu-Okinawa" // 九州・沖縄

// Prefecture information
#PrefectureInfo: {
	[Code=#Prefecture]: {
		code:     Code
		name:     #PrefectureName[Code]
		nameEN:   #PrefectureNameEN[Code]
		region:   #Region
		capital?: string
		type:     "Prefecture" | "Metropolis" | "Urban Prefecture" | "Circuit"
	}
}

// Major prefecture information
prefectureInfo: #PrefectureInfo & {
	"01": {
		region:  "Hokkaido"
		capital: "札幌市"
		type:    "Circuit"
	}
	"13": {
		region:  "Kanto"
		capital: "東京"
		type:    "Metropolis"
	}
	"26": {
		region:  "Kansai"
		capital: "京都市"
		type:    "Urban Prefecture"
	}
	"27": {
		region:  "Kansai"
		capital: "大阪市"
		type:    "Urban Prefecture"
	}
	"40": {
		region:  "Kyushu-Okinawa"
		capital: "福岡市"
		type:    "Prefecture"
	}
	"47": {
		region:  "Kyushu-Okinawa"
		capital: "那覇市"
		type:    "Prefecture"
	}
}
