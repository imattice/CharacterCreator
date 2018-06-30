//
//  data.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/21/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

let classData: [String : Any] = [
	"cleric": [
		"description": "Clerics combine the helpful magic of healing and inspiring their allies with spells that harm and hinder foes. They can provoke awe and dread, lay curses of plague or poison, and even call down flames from heaven to consume their enemies.",
		"hit_dice": "8"
	],
	"fighter": [
		"description": "Fighters learn the basics of all combat styles. Every fighter can swing an axe, fence with a rapier, wield a longsword or a greatsword, use a bow, and even trap foes in a net with some degree of skill. Likewise, a fighter is adept with shields and every form of armor.",
		"hit_dice": "10"
	],
	"rogue": [
		"description": "Rogues devote as much effort to mastering the use of a variety of skills as they do to perfecting their combat abilities, giving them a broad expertise that few other characters can match. Many rogues focus on stealth and deception, while others refine the skills that help them in a dungeon environment, such as climbing, finding and disarming traps, and opening locks. When it comes to combat, rogues prioritize cunning over brute strength.",
		"hit_dice": "8",
],
	"wizard": [
		"description": "Wizards live and die by their spells. Everything else is secondary. Though the casting of a typical spell requires merely the utterance of a few strange words, fleeting gestures, and sometimes a pinch or clump of exotic materials, these surface components barely hint at the expertise attained after years of apprenticeship and countless hours of study.",
		"hit_dice": "6",
	],
]

enum ClassKey: String {
	case description, hitDie = "hit_dice"
}




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
