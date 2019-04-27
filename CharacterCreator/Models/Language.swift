//
//  Language.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/26/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation


struct Language {
	let name: String
	let spokenBy: String
	let script: String
}

let languages = [
	"common": [
		Language(name: "Common", 		spokenBy: "Most humanoids", 								script: "Common"),
		Language(name: "Draconic", 		spokenBy: "Kobolds, Lizardfolk, Dragons, Dragonborn", 		script: "Draconic"),
		Language(name: "Dwarvish", 		spokenBy: "Dwarves", 										script: "Dwarvish"),
		Language(name: "Elvish", 		spokenBy: "Elves", 											script: "Elvish"),
		Language(name: "Giant", 		spokenBy: "Giants", 										script: "Dwarvish"),
		Language(name: "Gnomish", 		spokenBy: "Gnomes", 										script: "Dwarvish"),
		Language(name: "Goblin", 		spokenBy: "Goblinoids, hobgoblins, bugbears", 				script: "Dwarvish"),
		Language(name: "Halfling", 		spokenBy: "Halflings", 										script: "Common"),



	],
	"rare": [
		Language(name: "Abyssal", 		spokenBy: "Demons", 										script: "Infernal"),
		Language(name: "Aquan", 		spokenBy: "Air-based creatures", 							script: "Elvan"),
		Language(name: "Auran", 		spokenBy: "Air-based creatures", 							script: "Draconic"),
		Language(name: "Celestial", 	spokenBy: "Angels", 										script: "Celestial"),
		Language(name: "Deep Speech", 	spokenBy: "Mind Flayers, Beholders", 						script: "-"),
		Language(name: "Druidic", 		spokenBy: "Druids", 										script: "Druidic"),
		Language(name: "Gnoll", 		spokenBy: "Gnolls", 										script: "Common"),
		Language(name: "Ignan", 		spokenBy: "Fire-based creatures", 							script: "Draconic"),
		Language(name: "Infernal", 		spokenBy: "Devils, Tieflings", 								script: "Infernal"),
		Language(name: "Orc", 			spokenBy: "Orcs", 											script: "Dwarvish"),
		Language(name: "Primordial", 	spokenBy: "Elementals", 									script: "Dwarvish"),
		Language(name: "Sylvan", 		spokenBy: "Fey creatures", 									script: "Elvish"),
		Language(name: "Terran", 		spokenBy: "Earth-based creatures", 							script: "Dwarven"),
		Language(name: "Undercommon", 	spokenBy: "Drow, Underdark traders", 						script: "Elvish")
	],
]
