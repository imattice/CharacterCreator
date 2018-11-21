//
//  classData.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/7/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

let classData: [String : Any] = [
	"cleric": [
		"description": "Clerics dedicate their lives to the service of a higher power.  They are missionaries of their god and strive to defend their allies to the end.  Channeling the higher powers, Clerics provide healing and defense from the unjustices and evil in the world.",
		"hit_dice": "8",
		"levels": [
			"1": [
				"Spellcasting": "As a conduit for divine power, you can cast cleric spells.",
				"Divine Domain": "Dedicate yourself to the cause of your choosing. Your choice grants you specific spells and other features that align with that domain. Your dedication also provides an additional way to use the Channel Divinity ability." ],
			"2": [
				"Channel Divinity: Turn Undead": "Cause an undead creature to run, filling it a sense of dread eminating from the overwhelming power of your diety." ],
			"5": [
				"Upgrade: Channel Divinity: Destroy Undead": "Weak undead creatures are instantly destroyed when you use your Channel Divinity ability on them.  This affects creatures that are at CR 1/2 or lower."],
			"8": [
				"Upgrade: Channel Divinity: Destroy Undead": "You obliterate strong undead creatures when you use your Channel Divinity on them. This affects creatures that are at CR 1 or lower. "],
			"10": [
				"Divine Intervention": "You call on your diety when you are in great need of their help.  The likelihood that they are willing to intervene grows as your gain levels as a Cleric." ],
			"11": [
				"Upgrade: Channel Divinity: Destroy Undead": "As your power grows, even strong undead creatures are instantly destroyed when you use your Channel Divinity on them. This affects creatures that are at CR 2 or lower."],
			"14": [
				"Upgrade: Channel Divinity: Destroy Undead": "Greater undead creatures begin to fall to your power and are  instantly destroyed when you use your Channel Divinity on them. This affects creatures that are at CR 3 or lower."],
			"17": [
				"Upgrade: Channel Divinity: Destroy Undead": "All but the most powerful undead creatures fail to resist the final call to death, destroying their mortal husks once and for all. This affects creatures that are at CR 4 or lower."],
			"20": [
				"Upgrade: Divine Intervention": "You have proven yourself to be a reliable servent to your deity.  They are willing to help you once every 7 days." ] ],
		"paths": [
			"life domain": [
				"description": "Dedication to protecting and preserving all that is living gives those beholden to the Life Domain unprecidented healing abilities as well as increased training to defenses.",
				"levels": [
					"1": [
						"Bonus Proficiency" : "Life defenders are no stranger to heavy armor and are familiar to the weight and increased defences that it grants.",
						"Disciple of Life": "Knitting wounds and curing ills come easily and are more effective for Life Clerics."	],
					"2": [
						"Channel Divinity: Preserve Life": "Focus your will into a grievious wound to quicken the restoration for that creature." ],
					"6": [
						"Blessed Healer": "As you channel greater healing power through yourself, some of that power is applied to your own wounds."],
					"8": [
						"Divine Strike": "Your attacks are imbued with greater power."]

				],
				"spells": [
					//Level 1
					"bless", "cure wounds",
					//Level 3
					"lesser restoration", "spiritual weapon",
					//Level 5
					"beacon of hope", "revivify",
					//Level 7
					"death ward", "guardian of faith",
					//Level 9
					"mass cure wounds", "raise dead", ], ] ],
		"spells": [
			//Cantrips
			"Guidance", "Light", "Resistance", "Sacred Flame", "Spare the Dying", "Thaumaturgy",
			//Level 1
			"Bless", "Command", "Cure Wounds", "Detect Magic", "Guiding Bolt", "Healing Word", "Inflict Wounds", "Sanctuary", "Shield of Faith",
			//Level 2
			"Aid", "Augury", "Hold Person", "Lesser Restoration", "Prayer of Healing", "Silence", "Spiritual Weapon", "Warding Bond"],
		"spellcasting": [
			"casting_ability": "wis",
			"cantripCount": [
				"1" : "3",
				"4" : "4",
				"10": "5", ],
			"initialSpellCount": "6",
			"spellSlots": [
				"1": ["1": "2"],
				"2": ["1": "3"],
				"3": ["1": "4", "2": "2"],
				"4": ["2": "3"],
				"5": ["3": "2"], ] ],
		"equipment": [
			[["mace"], 				["warhammer"]								],
			[["scale mail"], 		["leather armor"], 		["chain mail"]		],
			[["light crossbow"], 	["simple weapon"]							],
			[["priest's pack"], 	["explorer's pack"]							],
			[["shield"]															],
			[["holy symbol"]													],
		],
		"skills": 	[ "history", "insight", "medicine", "persuasion", "religion"],
	],



	"fighter": [
		"description": "Wielding a variety of weapons, a fighter's physical prowess gives them an advangage in multiple arenas.  They accell in inflicting damage and leading with their weapons to get what they need. Fighters can train to be equally good at raising a defense and deflecting blows that would harm more fragile allies.",
		"hit_dice": "10",
		"levels": [
			"1": [
				"Fighting Style": "Train in a particular weapon that fits your fighting style, be that from a distance with a bow, in the middle of the frey with multiple swords, or even a great shield to keep yourself safe.",
				"Second Wind": "Brush off the imediate sting of previous wounds to maintain your relentless fighting stance." ],
			"2": [
				"Action Surge": "Draw from your reserved power to take an additional action this turn.", ],
			"3": [
				"Martial Archetype": "Choose a path that befits your goals as a warrior.", ],
			"17": [
				"Upgrade: Action Surge": "Increase your reserves, allowing you to take an additional Action Surge between rests."], ],
		"paths": [
			"champion": [
				"description": "Tested and proven, a champion knows how to land devistating blows frequently.  They focus their training on increasing the physical abilities that will bring them glory and praise.",
				"levels": [
					"3": [
						"Improved Critical": "You know exactly where to strike to land a devastating hit and take any opportunity to do so, landing critical hits on a roll of 19 or 20."],
					"7": [
						"Remarkable Athlete": "Your physical skills show themselves as you attempt to use your body to accomplish a feat. You are more successful when attempting a feat using Strenth, Dexterity, or Constitution.  You can also jump further, increasing the distance you travel midair by your Strength modifier."], ] ], ],
		"equipment": [
			[["chain mail"], 		["leather armor", "longbow"]		],
			[["martial weapon"], 	["shield", "simple weapon"]		],
			[["light crossbow"], 	["handaxe", "handaxe"]				],
			[["dungeoneer's pack"], ["explorer's pack"]					],
		],
		"skills": 	[ "acrobatics", "animal handling", "athletics", "history", "insight", "intimidation", "perception", "survival"],
	],



	"rogue": [
		"description": "As a master of multiple skills, Rogues often have a plan or two up their sleeve, ready to act in a moment's notice.  You never know what could be useful, so a true Rogue can talk their way out of any situation or slip through the shadows.  They aren't afraid to practice abilities that may be considered unsavory by the traditional culture, such as lockpicking, setting an ambush, or stealing what they need",
		"hit_dice": "8",
		"levels": [
			"1": [
				"Expertise": "You focus on two skills to truely accell in, doubling your proficiency bonus in the event you need to pull talent out of your bag of tricks.",
				"Sneak Attack": "Fight dirty while a creature is distracted, landing an fierce attack when you have the advantage.",
				"Thieves' Cant": "You recognize the symbols written on the wall and the keywords that are spoken only by fellow rogues.  Utilizing this secret language, you can decode scripts and relay messages to others that know of this code.", ],
			"2": [
				"Cunning Action": "Being slippery, speedy and sneaky, you can use a bonus action each turn to Dash, Disengage or Hide."],
			"3": [
				"Roguish Archetype": "You plan out your future training, dedicating your focus to a specific roguish path."],
			"6": [
				"Upgrade: Expertise": "With additional study, you gain bonus proficiency in two additional skills of your choice, doubling your proficiency boonus for ability checks for those skills."]
		],
		"paths": [
			"thief": [
				"description": "The world's possessions belong to you... you're just reclaiming what's rightfully yours!  Thieves are facinated by the rare and valuable and dedicate their lives to learning how to claim them.  Physical locks, unscalable walls, and magic barriers cannot stop you from making off with your prize.",
				"levels": [
					"3": [
						"Fast Hands": "Before anyone can notice, you've already flicked open a lock, disarmed a trap, or Used an Item as a Cunning Action.",
						"Second-Story Work": "The world becomes your playground as you discover your ability to quickly scale a climbable surface and leap across wide chasms." ] ] ] ],
		"equipment": [
			[["rapier"], 			["shortsword"]											],
			[["shortbow"], 			["shortsword"]											],
			[["burglar's pack"],	["dungeoneer's pack"], 		["explorer's pack"]			],
			[["leather armor"]																],
			[["dagger", "dagger"]															],
			[["thieve's tools"]																]
		],
		"skills": 	[ "acrobatics", "athletics", "deception", "insight", "intimidation", "investigation", "perception", "performance", "persuasion", "sleight of hand", "stealth"],
	],



	"wizard": [
		"description": "Obsessed with the working of magic, Wizards strive to learn as much as they can about the workings of spells and magical items.  With so much to learn, wizards tend to focus their time on a single school of magic that interests them, keeping copious notes and incantations for each spell in their spellbook.",
		"hit_dice": "6",
		"levels": [
			"1": [
				"Spellcasting": "All of your arcane knowledge resides in your spellbook, allowing you to cast a multitude of spells that you've studied.  This is your life's work, encapsulated between the delicate pages.",
				"Arcane Recovery": "Reading and rereading your spellbook offers you the ability to quickly regenerate your spellcasting power during a short rest." ],
			"2": [
				"Arcane Tradition": "You point your studies to a specific genre of magic, allowing you additional bonuses when you study or cast a spell within your specialty.", ],
		],
		"paths": [
			"school of evocation": [
				"description": "You manipulate the world around to you, bending the foundational elemental makeup of your world.  Evocation magic allows you to manipulate fire and ice, thunder and arcane energy to create devistating effects.",
				"levels": [
					"2": [
						"Evocation Savant": "Your natural interest expidites the efficiency at which it takes to add an evocation spell to your spellbook.",
						"Sculpt Spells": "Knowing how damaging your spells can be, you learn how to manipulate your magic so that no allies are hurt by your evocation spells." ] ], ], ],
		"spells": [
			//Cantrips
			"Acid Splash", "Dancing Lights", "Fire Bolt", "Light", "Mage Hand", "Minor Illusion", "Poison Spray", "Prestidigitation", "Ray of Frost", "Shocking Grasp",
			//Level 1
			"Burning Hands","Charm Person", "Comprehend Languages", "Detect Magic", "Disguise Self", "Identify", "Mage Armor", "Magic Missile", "Shield", "Silent Image", "Sleep", "Thunderwave",
			//Level 2
			"Arcane Lock", "Blur", "Darkness", "Flaming Sphere", "Hold Person", "Invisibility", "Knock",
			"Levitate", "Magic Weapon", "Misty Step", "Shatter", "Spider Climb", "Suggestion", "Web"],
		"spellcasting": [
			"casting_ability": "int",
			"cantripCount": [
				"1" : "3",
				"4" : "4",
				"10": "5", ],
			"initialSpellCount": "6",
			"spellSlots": [
				"1": ["1": "2"],
				"2": ["1": "3"],
				"3": ["1": "4", "2": "2"],
				"4": ["2": "3"],
				"5": ["3": "2"], ] ],
		"equipment": [
			[["quarterstaff"], 			["dagger"]				],
			[["component pouch"], 		["arcane focus"]		],
			[["scholar's pack"], 		["explorer's pack"]		],
			[["spellbook"]										],
		],
		"skills": 	[ "arcana", "history", "insight", "investigation", "medicine", "religion"],
	]
]

let allClassLevels: [String: Any] = [
	"Ability Score Improvement": [
		"description": "Your skill increases! You gain two points to distribute among your ability scores as you continue to focus your training in that area."
	]
]

enum AllClassKey: String {
	case abilityScoreIncrease = "Ability Score Improvement"
}

enum ClassKey: String {
	case description, hitDie = "hit_dice", path, levels
}
