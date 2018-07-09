//
//  classData.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/7/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

let classData: [String : Any] = [
	"cleric": [
		"description": "Clerics combine the helpful magic of healing and inspiring their allies with spells that harm and hinder foes. They can provoke awe and dread, lay curses of plague or poison, and even call down flames from heaven to consume their enemies.",
		"hit_dice": "8",
		"levels": [
			"1": [
				"Spellcasting": "As a conduit for divine power, you can cast cleric spells.",
				"Divine Domain": "Choose one domain related to your deity: Knowledge, Life, Light, Nature, Tempest, Trickery, or War. Your choice grants you domain spells and other features when you choose it at 1st level. It also grants you additional ways to use Channel Divinity." ],
			"2": [
				"Channel Divinity: Turn Undead": "As an action, you present your holy symbol and speak a prayer censuring the undead and causing it to flee." ],
			"4": [
				"Ability Score Improvement": "You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1"] ],
		"paths": [
			"life domain": [
				"description": "The Life domain focuses on the vibrant positive energy— one of the fundamental forces of the universe—that sustains all life.",
				"levels": [
					"1": [
						"Bonus Proficiency" : "You gain proficiency with heavy armor.",
						"Disciple of Life": "Your healing spells are more effective."	],
					"2": [
						"Channel Divinity: Preserve Life": "Evoke healing energy that can restore hit points to a living creature." ] ] ] ],
		"spells": ["Guidance", "Light", "Resistance", "Sacred Flame", "Spare the Dying", "Thaumaturgy",
				   "Bless", "Command", "Cure Wounds", "Detect Magic", "Guiding Bolt", "Healing Word", "Inflict Wounds", "Sanctuary", "Shield of Faith"]
	],



	"fighter": [
		"description": "Fighters learn the basics of all combat styles. Every fighter can swing an axe, fence with a rapier, wield a longsword or a greatsword, use a bow, and even trap foes in a net with some degree of skill. Likewise, a fighter is adept with shields and every form of armor.",
		"hit_dice": "10",
		"levels": [
			"1": [
				"Fighting Style": "You adopt a particular style of fighting as your specialty, such as Archery, Defense, or Dual Weapon Fighting.",
				"Second Wind": "You have a limited well of stamina that you can draw on to protect yourself from harm." ],
			"2": [
				"Action Surge": "You can push yourself beyond your normal limits for a moment. On your turn, you can take one additional action on top of your regular action and a possible bonus action.", ],
			"3": [
				"Martial Archetype": "Choose an archetype that you strive to emulate in your combat styles and techniques.", ],
			"4": [
				"Ability Score Improvement": "You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1"],
			"17": [
				"Upgrade: Action Surge": "You can use Action Surge twice between rests."], ],
		"paths": [
			"champion": [
				"description": "The archetypal Champion focuses on the development of raw physical power honed to deadly perfection. Those who model themselves in this way combine rigorous training with physical excellence to deal devastating blows.",
				"levels": [
					"3": [
						"Improved Critical": "Your weapon attacks score a critical hit on a roll of 19 or 20."],
					"7": [
						"Remarkable Athlete": "you can add half your proficiency bonus (round up) to any Strength, Dexterity, or Constitution check you make that doesn’t already use your proficiency bonus. In addition, when you make a running long jump, the distance you can cover increases by a number of feet equal to your Strength modifier."], ] ], ],
	],



	"rogue": [
		"description": "Rogues devote as much effort to mastering the use of a variety of skills as they do to perfecting their combat abilities, giving them a broad expertise that few other characters can match. Many rogues focus on stealth and deception, while others refine the skills that help them in a dungeon environment, such as climbing, finding and disarming traps, and opening locks. When it comes to combat, rogues prioritize cunning over brute strength.",
		"hit_dice": "8",
		"levels": [
			"1": [
				"Expertise": "Choose two of your skill proficiencies, or one of your skill proficiencies and your proficiency with thieves’ tools. Your proficiency bonus is doubled for any ability check you make that uses either of the chosen proficiencies.",
				"Sneak Attack": "You know how to strike subtly and exploit a foe’s distraction. You can deal an extra damage to one creature you hit with an attack when you have advantage.",
				"Thieves' Cant": "During your rogue training you learned thieves’ cant, a secret mix of dialect, jargon, and code that allows you to hide messages in seemingly normal conversation. In addition, you understand a set of secret signs and symbols used to convey short, simple messages, such as whether an area is dangerous or the territory of a thieves’ guild, whether loot is nearby, or whether the people in an area are easy marks or will provide a safe house for thieves on the run.", ],
			"2": [
				"Cunning Action": "Your quick thinking and agility allow you to move and act quickly. You can take a bonus action on each of your turns in combat. This action can be used only to take the Dash, Disengage, or Hide action."],
			"3": [
				"Roguish Archetype": "You choose an archetype that you emulate in the exercise of your rogue abilities."],
			"4": [
				"Ability Score Improvement": "You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1"],
			"6": [
				"Upgrade: Expertise": "You choose two more of your proficiencies (in skills or with thieves’ tools) to gain double the proficiency bonus on any ability check for the chosen proficiencies."]
		],
		"paths": [
			"thief": [
				"description": "You hone your skills in the larcenous arts. In addition to improving your agility and stealth, you learn skills useful for delving into ancient ruins, reading unfamiliar languages, and using magic items you normally couldn’t employ.",
				"levels": [
					"3": [
						"Fast Hands": "You can use the bonus action granted by your Cunning Action to make a Dexterity (Sleight of Hand) check, use your thieves’ tools to disarm a trap or open a lock, or take the Use an Object action.",
						"Second-Story Work": "you gain the ability to climb faster than normal; climbing no longer costs you extra movement. In addition, when you make a running jump, the distance you cover increases by a number of feet equal to your Dexterity modifier." ] ] ] ],
	],



	"wizard": [
		"description": "Wizards live and die by their spells. Everything else is secondary. Though the casting of a typical spell requires merely the utterance of a few strange words, fleeting gestures, and sometimes a pinch or clump of exotic materials, these surface components barely hint at the expertise attained after years of apprenticeship and countless hours of study.",
		"hit_dice": "6",
		"levels": [
			"1": [
				"Spellcasting": "As a student of arcane magic, you have a spellbook containing spells that show the first glimmerings of your true power.",
				"Arcane Recovery": "You have learned to regain some of your magical energy by studying your spellbook. Once per day when you finish a short rest, you can choose expended spell slots to recover." ],
			"2": [
				"Arcane Tradition": "you choose an arcane tradition, shaping your practice of magic through one of eight schools: Abjuration, Conjuration, Divination, Enchantment, Evocation, Illusion, Necromancy, or Transmutation.", ],
			"4": [
				"Ability Score Improvement": "You can increase one ability score of your choice by 2, or you can increase two ability scores of your choice by 1"]
		],
		"paths": [
			"school of evocation": [
				"description": "You focus your study on magic that creates powerful elemental effects such as bitter cold, searing flame, rolling thunder, crackling lightning, and burning acid.",
				"levels": [
					"2": [
						"Evocation Savant": "The gold and time you must spend to copy an evocation spell into your spellbook is halved.",
						"Sculpt Spells": "You can create pockets of relative safety within the effects of your evocation spells." ] ], ], ],
		"spells": [ "Acid Splash", "Dancing Lights", "Fire Bolt", "Light", "Mage Hand", "Minor Illusion", "Poison Spray", "Prestidigitation", "Ray of Frost", "Shocking Grasp",
					"Burning Hands","Charm Person", "Comprehend Languages", "Detect Magic", "Disguise Self", "Identify", "Mage Armor", "Magic Missile", "Shield", "Silent Image", "Sleep", "Thunderwave" ]
	]
]

enum ClassKey: String {
	case description, hitDie = "hit_dice", path, levels
}
