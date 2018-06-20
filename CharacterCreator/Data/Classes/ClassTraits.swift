let classTraits: [String: Any] = [
	"cleric": [
		"hit_dice": 8,
		"proficiencies": [
			"armor": ["light", "medium", "shields"],
			"weapons": ["simple"], ],
		"saving_throws": ["wisdom", "charisma"],

		"skill_proficiency": [
			"increase_count": 2,
			"skills":  ["history", "insight", "medicine", "persuasion", "religion"]
		],
		"starting_equiptment": [
			["mace", "warhammer"],
			["scale mail", "leather armor", "chain mail"],
			["light crossbow with 20 bolts", "simple weapon"],
			["priest's pack", "explorer's pack"],
			["shield and holy symbol"],
		],

		"starting_spells": [
			"cantrips": [
				"count": 3,
				"spells": [
				],
			],
			"first_level": [
				"count": 1,
				"count_modifier": "wisdom_modifier",

			]
		],
		"spellcasting_ability" : "wisdom",
		"spellcasting_focus": "holy symbol",
		
	]

]
