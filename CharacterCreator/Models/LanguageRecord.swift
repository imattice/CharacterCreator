//
//  Language.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/26/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation


struct LanguageRecord {
	let name: String
	let spokenBy: String
	let script: String
}

let languageRecords = [
	"common": [
		LanguageRecord(name: "Common", 		spokenBy: "Most humanoids", 							script: "Common"),
		LanguageRecord(name: "Draconic", 		spokenBy: "Kobolds, Lizardfolk, Dragons, Dragonborn", 	script: "Draconic"),
		LanguageRecord(name: "Dwarvish", 		spokenBy: "Dwarves", 									script: "Dwarvish"),
		LanguageRecord(name: "Elvish", 		spokenBy: "Elves", 										script: "Elvish"),
		LanguageRecord(name: "Giant", 		spokenBy: "Giants", 									script: "Dwarvish"),
		LanguageRecord(name: "Gnomish", 		spokenBy: "Gnomes", 									script: "Dwarvish"),
		LanguageRecord(name: "Goblin", 		spokenBy: "Goblinoids, hobgoblins, bugbears", 			script: "Dwarvish"),
		LanguageRecord(name: "Halfling", 		spokenBy: "Halflings", 									script: "Common"),



	],
	"rare": [
		LanguageRecord(name: "Abyssal", 		spokenBy: "Demons", 									script: "Infernal"),
		LanguageRecord(name: "Aquan", 		spokenBy: "Air-based creatures", 						script: "Elvan"),
		LanguageRecord(name: "Auran", 		spokenBy: "Air-based creatures", 						script: "Draconic"),
		LanguageRecord(name: "Celestial", 	spokenBy: "Angels", 									script: "Celestial"),
		LanguageRecord(name: "Deep Speech", 	spokenBy: "Mind Flayers, Beholders", 					script: "-"),
		LanguageRecord(name: "Druidic", 		spokenBy: "Druids", 									script: "Druidic"),
		LanguageRecord(name: "Gnoll", 		spokenBy: "Gnolls", 									script: "Common"),
		LanguageRecord(name: "Ignan", 		spokenBy: "Fire-based creatures", 						script: "Draconic"),
		LanguageRecord(name: "Infernal", 		spokenBy: "Devils, Tieflings", 							script: "Infernal"),
		LanguageRecord(name: "Orc", 			spokenBy: "Orcs", 										script: "Dwarvish"),
		LanguageRecord(name: "Primordial", 	spokenBy: "Elementals", 								script: "Dwarvish"),
		LanguageRecord(name: "Sylvan", 		spokenBy: "Fey creatures", 								script: "Elvish"),
		LanguageRecord(name: "Terran", 		spokenBy: "Earth-based creatures", 						script: "Dwarven"),
		LanguageRecord(name: "Undercommon", 	spokenBy: "Drow, Underdark traders", 					script: "Elvish")
	],
]
