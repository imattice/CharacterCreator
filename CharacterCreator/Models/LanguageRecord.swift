//
//  Language.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/26/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation

struct Language {
	let record: LanguageRecord
	let source: String
}


struct LanguageRecord {
	let name: String
	let spokenBy: String
	let script: String

	static func record(forName name: String) -> LanguageRecord? {
		if name == "choice" {
			return LanguageRecord(name: "choice", spokenBy: "", script: "")
		}

		guard let common = languageRecords["common"],
		let rare = languageRecords["rare"]
			else { return nil }

		let languages = common + rare

		return languages.first { $0.name == name.lowercased() }
	}
}

extension LanguageRecord {
	static let Common 			= record(forName: "common")!
	static let Draconic 		= record(forName: "draconic")!
	static let Dwarvish 		= record(forName: "dwarvish")!
	static let Elven		 	= record(forName: "Elven")!
	static let Giant 			= record(forName: "giant")!
	static let Gnomish 			= record(forName: "gnomish")!
	static let Goblin			= record(forName: "goblin")!
	static let Halfling 		= record(forName: "halfling")!
	static let Abyssal 			= record(forName: "abyssal")!
	static let Celestial 		= record(forName: "celestial")!
	static let DeepSpeech 		= record(forName: "deep speech")!
	static let Infernal 		= record(forName: "infernal")!
	static let Orc				= record(forName: "orc")!
	static let Undercommon 		= record(forName: "undercommon")!
}

let languageRecords = [
	"common": [
		LanguageRecord(name: "common", 			spokenBy: "Most humanoids", 							script: "Common"),
		LanguageRecord(name: "draconic", 		spokenBy: "Kobolds, Lizardfolk, Dragons, Dragonborn", 	script: "Draconic"),
		LanguageRecord(name: "dwarvish", 		spokenBy: "Dwarves", 									script: "Dwarvish"),
		LanguageRecord(name: "elven", 			spokenBy: "Elves", 										script: "Elvish"),
		LanguageRecord(name: "giant", 			spokenBy: "Giants", 									script: "Dwarvish"),
		LanguageRecord(name: "gnomish", 		spokenBy: "Gnomes", 									script: "Dwarvish"),
		LanguageRecord(name: "goblin", 			spokenBy: "Goblinoids, hobgoblins, bugbears", 			script: "Dwarvish"),
		LanguageRecord(name: "halfling", 		spokenBy: "Halflings", 									script: "Common"),



	],
	"rare": [
		LanguageRecord(name: "abyssal", 		spokenBy: "Demons", 									script: "Infernal"),
//		LanguageRecord(name: "aquan", 			spokenBy: "Air-based creatures", 						script: "Elvan"),
//		LanguageRecord(name: "auran", 			spokenBy: "Air-based creatures", 						script: "Draconic"),
		LanguageRecord(name: "celestial", 		spokenBy: "Angels", 									script: "Celestial"),
		LanguageRecord(name: "deep speech", 	spokenBy: "Mind Flayers, Beholders", 					script: "-"),
//		LanguageRecord(name: "druidic", 		spokenBy: "Druids", 									script: "Druidic"),
//		LanguageRecord(name: "gnoll", 			spokenBy: "Gnolls", 									script: "Common"),
//		LanguageRecord(name: "ignan", 			spokenBy: "Fire-based creatures", 						script: "Draconic"),
		LanguageRecord(name: "infernal", 		spokenBy: "Devils, Tieflings", 							script: "Infernal"),
		LanguageRecord(name: "orc", 			spokenBy: "Orcs", 										script: "Dwarvish"),
//		LanguageRecord(name: "primordial", 		spokenBy: "Elementals", 								script: "Dwarvish"),
//		LanguageRecord(name: "sylvan", 			spokenBy: "Fey creatures", 								script: "Elvish"),
//		LanguageRecord(name: "terran", 			spokenBy: "Earth-based creatures", 						script: "Dwarven"),
		LanguageRecord(name: "undercommon", 	spokenBy: "Drow, Underdark traders", 					script: "Elvish")
	],
]