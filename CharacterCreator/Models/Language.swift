//
//  Language.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/26/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation
import RealmSwift

//struct Language {
//	let record: Language
//	let source: String
//}

@objcMembers
class LanguageRecord : Object {
	dynamic var id: String 			= UUID().uuidString
	dynamic var name: String		= ""
	dynamic var spokenBy: String	= ""
	dynamic var script: String		= ""

	static func all(in realm: Realm = RealmProvider.languageRecords.realm) -> Results<LanguageRecord> {
		return realm.objects(LanguageRecord.self).sorted(byKeyPath: "name")
	}
}

enum Script: String {
	case common, draconic, dwarvish, elvish, infernal, celestial, druidic
}

//class Language {
//
//}
//class LanguageChoice: Language {
//
//}


struct Language {
	let name: String
	let spokenBy: String
	let script: String

	static func record(forName name: String) -> Language? {
		if name == "choice" {
			return Language(name: "choice", spokenBy: "", script: "")
		}

		guard let common = languageRecords["common"],
		let rare = languageRecords["rare"]
			else { return nil }

		let languages = common + rare

		return languages.first { $0.name == name.lowercased() }
	}
}

extension Language {
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
		Language(name: "common", 			spokenBy: "Most humanoids", 							script: "Common"),
		Language(name: "draconic", 		spokenBy: "Kobolds, Lizardfolk, Dragons, Dragonborn", 	script: "Draconic"),
		Language(name: "dwarvish", 		spokenBy: "Dwarves", 									script: "Dwarvish"),
		Language(name: "elven", 			spokenBy: "Elves", 										script: "Elvish"),
		Language(name: "giant", 			spokenBy: "Giants", 									script: "Dwarvish"),
		Language(name: "gnomish", 		spokenBy: "Gnomes", 									script: "Dwarvish"),
		Language(name: "goblin", 			spokenBy: "Goblinoids, hobgoblins, bugbears", 			script: "Dwarvish"),
		Language(name: "halfling", 		spokenBy: "Halflings", 									script: "Common"),



	],
	"rare": [
		Language(name: "abyssal", 		spokenBy: "Demons", 									script: "Infernal"),
//		LanguageRecord(name: "aquan", 			spokenBy: "Air-based creatures", 						script: "Elvan"),
//		LanguageRecord(name: "auran", 			spokenBy: "Air-based creatures", 						script: "Draconic"),
		Language(name: "celestial", 		spokenBy: "Angels", 									script: "Celestial"),
		Language(name: "deep speech", 	spokenBy: "Mind Flayers, Beholders", 					script: "-"),
//		LanguageRecord(name: "druidic", 		spokenBy: "Druids", 									script: "Druidic"),
//		LanguageRecord(name: "gnoll", 			spokenBy: "Gnolls", 									script: "Common"),
//		LanguageRecord(name: "ignan", 			spokenBy: "Fire-based creatures", 						script: "Draconic"),
		Language(name: "infernal", 		spokenBy: "Devils, Tieflings", 							script: "Infernal"),
		Language(name: "orc", 			spokenBy: "Orcs", 										script: "Dwarvish"),
//		LanguageRecord(name: "primordial", 		spokenBy: "Elementals", 								script: "Dwarvish"),
//		LanguageRecord(name: "sylvan", 			spokenBy: "Fey creatures", 								script: "Elvish"),
//		LanguageRecord(name: "terran", 			spokenBy: "Earth-based creatures", 						script: "Dwarven"),
		Language(name: "undercommon", 	spokenBy: "Drow, Underdark traders", 					script: "Elvish")
	],
]
