//
//  data.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/21/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//


let raceData: [String: Any] = [
	"dwarf": [
		"description": "Bold and hardy, dwarves are known as skilled warriors, miners, and workers of stone and metal. Their courage and endurance are also easily a match for any of the larger folk.",
		"modifiers": [
			"con"				: 2	],
		"subraces": [
			"hill": [
				"description": "Hill dwarves have keen senses, deep intuition, and remarkable resilience.",
				"modifiers": [
					"wis"		: 1,
					"hp"		: 1	]],
			"mountian": [
				"description": "Mountian dwarves are strong and hardy, accustomed to a difficult life in rugged terrain.",
				"modifiers": [
					"str"		: 2,]]]],

	"elf": [
		"description": "Elves are a magical people of otherworldly grace, living in the world but not entirely part of it. Elves love nature and magic, art and artistry, music and poetry, and the good things of the world.",
		"modifiers": [
			"dex"				: 2 ],
		"subraces": [
			"high": [
				"description": "High elves have a keen mind and a mastery of at least the basics of magic.",
				"modifiers": [
					"int"		: 1	] ],
			"wood": [
				"description": "Wood elves have keen senses and intuition, and your fleet feet carry you quickly and stealthily through your native forests. ",
				"modifiers": [
					"wis"		: 1	] ] ] ],

	"halfling": [
		"description": "The comforts of home are the goals of most halflings’ lives: a place to settle in peace and quiet, far from marauding monsters and clashing armies; a blazing fire and a generous meal; fine drink and fine conversation. Though some halflings live out their days in remote agricultural communities, others form nomadic bands that travel constantly, lured by the open road and the wide horizon to discover the wonders of new lands and peoples.",
		"modifiers": [
			"dex"				: 2	],
		"subraces": [
			"lightfoot": [
				"description": "Lightfoot halflings can easily hide from notice, even using other people as cover.",
				"modifiers": [
					"cha"		: 1	] ],
			"stout": [
				"description": "Stout halflings are hardier than average and have some resistance to poison.",
				"modifiers": [
					"con"		: 1	] ] ] ],

	"human": [
		"description": "In the reckonings of most worlds, humans are the youngest of the common races, late to arrive on the world scene and short-lived in comparison to dwarves, elves, and dragons. Perhaps it is because of their shorter lives that they strive to achieve as much as they can in the years they are given. Or maybe they feel they have something to prove to the elder races, and that’s why they build their mighty empires on the foundation of conquest and trade. Whatever drives them, humans are the innovators, the achievers, and the pioneers of the worlds.",
		"modifiers": [
			"all_stats"			: 1	]]
]

enum RaceKey: String {
	case description, modifiers, subraces
}
enum Stat: String {
	case strength,
		constitution,
		dexterity,
		charisma,
		wisdom,
		intelligence
}
