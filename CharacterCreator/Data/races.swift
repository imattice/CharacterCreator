//
//  raceData.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/21/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//




let raceData: [String: Any] = [
	"dwarf": [
		"description": "Stout and stubborn, a dwarf is known for their tenacity with metalwork and ores.  They can often be found in deep recesses of mountains, underground and generally keeping to themselves.",
		"modifiers": [
			"con"				: 2	],
		"languages": [
			"common",
			"dwarvish"],
		"subraces": [
			"hill": [
				"description": "Hill dwarves have left the mountianous caverns in favor of rolling hills.  In doing so, they've traded some of their natrual strenth for a broader world view and increased stamina.",
				"modifiers": [
					"wis"		: 1,
					"hp"		: 1	]],
			"mountian": [
				"description": "Mountian dwarves are strong and hardy, accustomed to a difficult life in rugged terrain.  They are protective of their own territory, and will defend an ally with fierce abbandon.",
				"modifiers": [
					"str"		: 2,]]]],

	"elf": [
		"description": "The elves posess grace unlike any other, seeming to move quickly through sunbeams without so much as a hint of disruption.  Learning new magicks come easily to them, as do many other works that marry art, craft and deep wisdom.",
		"modifiers": [
			"dex"				: 2 ],
		"languages": [
			"common",
			"elven" ],
		"subraces": [
			"high": [
				"description": "The high elves have renounced their woodland ancestry in favor of the acadamies, politics, and labratories of large cities.  They prefer the comforts of modern life while spending a great amount of time engaged in their work.",
				"modifiers": [
					"int"		: 1	] ],
			"wood": [
				"description": "The wood elves embrace the natural order of the world, living amonst the treetops of thick-wooded forests. They've attuned their survival instints, granting them intuitive awareness, quick reaction time, and the stealth of an experianced hunter.",
				"modifiers": [
					"wis"		: 1	] ] ] ],

	"halfling": [
		"description": "A comfortable home and the happiness of friends are what most halflings desire.  They tend to avoid the adventuring life, though some are willing to ignore the expectation of the domestic life to see the world.",
		"modifiers": [
			"dex"				: 2	],
		"languages": [
			"common",
			"halfling"
		],
		"subraces": [
			"lightfoot": [
				"description": "Lightfoot halflings use their tiny stature to their advantage, allowing them to hide in event the smallest of places.  They tend to be extremely friendly and easy to get along with.",
				"modifiers": [
					"cha"		: 1	] ],
			"stout": [
				"description": "Stout halflings are said to be desendant of dwarves, which give them a resistance to poison and a heightened stamina.  Because of this, their ability to win a drinking contest is unmatched.",
				"modifiers": [
					"con"		: 1	] ] ] ],

	"human": [
		"description": "Humankind has reached every corner of the world, giving them an advantage in numbers, and unmatched diversity in their abilities.  Wise scholars, brave fighters and famous performers have been humans.  Their great ambition and innovation is unlike any other race and has allowed them to make a significant impact in the state of the world.",
		"languages": [
			"common", "choice"],
		"modifiers": [
			"all_stats"			: 1	]]
]

enum RaceKey: String {
	case description, modifiers, subraces
}

