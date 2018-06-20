let raceTraits: [String : Any] = [
	"dwarf": [
		"ability_score_adjustment": [
			"constitution": 2 ],
		"size": "medium",
		"speed": 25,
		"vision": [
			"light"	: 120,
			"dim"	: 60,
			"dark"	: 30 ],
		"weapon_proficiency": [
			"battleaxe", "handaxe", "light hammer", "warhammer" ],
		"tool_proficiency": [
			"smith's tools", "brewer's supplies", "mason's tools" ],
		"languages": [
			"common", "dwarvish" ],


		"modifiers": [
			"heavy_armor_speed_adjustment": 0,
			"damage" : [
				"poison": "resist" ],
			"saving_throw": [
				"poison": "advantage" ],
			"ability_score_for_topic": [
				"history" : [
					"topic": "stonework",
					"modifier": "double_proficiency"
				]
			]
		],

		"subraces": [
			"hill dwarf": [
				"modifiers": [
					"ability_score_adjustment": [
						"wisdom": 1 ],
					"hit_point_max": 1,
					"hit_point_on_level_up": 1, ] ],
			"mountian dwarf": [
				"modifiers": [
					"ability_score_adjustment": [
						"strength": 2],
					"armor_proficiency": [
						"light", "medium"
					]
				]
			]
			
		]
	]
]
