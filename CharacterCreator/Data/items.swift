//
//  items.swift
//
//  Created by Ike Mattice on 8/22/18.
//

let itemData: [String : Any] = [
//Simple Weapons
	"club":	[
		"class": "simple",
		"tags": ["light"],
		"damage": [
			"multiplier": "1",
			"type": "bludgeoning",
			"value": "4"],
		"description": "A blunt, thick piece of wood that can surprisingly painful when used as a weapon",				],
	"dagger": [
		"class": "simple",
		"tags": ["finesse", "light", "thrown"],
		"range": [
			"normal": "20",
			"extended": "60"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "4"],
		"description": 	"A small, quick blade that can be thrown or easily concealed",									],
	"greatclub":	[
		"class": "simple",
		"tags": ["twoHanded"],
		"damage": [
			"multiplier": "1",
			"type": "bludgeoning",
			"value": "8"],
		"description": "A wooden chunk that is so heavy that it requires two hands to use effectively",				],
	"handaxes":	[
		"class": "simple",
		"tags": ["light", "thrown"],
		"range": [
			"normal": "20",
			"extended": "60"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "6"],
		"description": 	"A light, throwable axe used for quick and powerful chopping blows", 							],
	"javelin":	[
		"class": "simple",
		"tags": ["thrown"],
		"range": [
			"normal": "30",
			"extended": "120"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "6"],
		"description": 	"A throwable spear", 																				],
	"mace":	[
		"class": "simple",
		"damage": [
			"multiplier": "1",
			"type": "bludgeoning",
			"value": "6"],
		"description": "A spiked club used to inflict blugeoning damange",												],
	"quarterstaff":	[
		"class": "simple",
		"tags": ["versatile"],
		"damage": [
			"multiplier": "1",
			"type": "bludgeoning",
			"value": "6",
			"twoHanded": "8"],
		"description": "A two-handed pole made of wood or metal",															],
	"sickle":	[
		"class": "simple",
		"tags": ["light"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "4"],
		"description": 	"A short, curved blade used for harvesting grains", 												],
	"spear":	[
		"class": "simple",
		"tags": ["thrown", "versatile"],
		"range": [
			"normal": "20",
			"extended": "60"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "6",
			"twoHanded": "8"],
		"description": 	"A long pole of wood or metal, ending in a sharpened point", 							],
	"light crossbow":[
			"class": "simple",
			"tags": ["ammunition", "ranged", "loading", "twoHanded"],
			"range": [
				"normal": "80",
				"extended": "320"],
			"damage": [
				"multiplier": "1",
				"type": "piercing",
				"value": "8"],
			"description": "A sping-loaded weapon that fires sharp bolts at high speeds at the press of the trigger",		],
	"dart":[
		"class": "simple",
		"tags": ["finesse", "thrown"],
		"range": [
			"normal": "20",
			"extended": "60"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "4"],
		"description": "A sharpened needle-like stick designed to be thrown",		],
	"shortbow":	[
		"class": "simple",
		"tags": ["ammunition", "twoHanded"],
		"range": [
			"normal": "80",
			"extended": "320"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "6"],
		"description": 	"A bow that excels at hitting close targets at range",											],
	"sling":	[
		"class": "simple",
		"tags": ["ammunition"],
		"range": [
			"normal": "30",
			"extended": "120"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "4"],
		"description": 	"An elastic band that can be used to fling rocks accross a short distance",						],

//Martial Weapons
	"battleaxe": [
		"class": "martial",
		"tags": ["versatile"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "8",
			"twoHanded": "10"],
		"description": "A heavy, two-handed axe used to cleave through foes", 												],
	"flail": [
		"class": "martial",
		"damage": [
			"multiplier": "1",
			"type": "bludgeoning",
			"value": "8"],
		"description": "A jointed pole, often having studs", 																],
	"glaive": [
		"class": "martial",
		"tags": ["heavy", "reach", "twoHanded"],
		"damage": [
			"multiplier": "1",
			"type": "bludgeoning",
			"value": "10" ],
		"description": "A long pole with a bladed edge at one end", 														],
	"greataxe": [
		"class": "martial",
		"tags": ["heavy", "twoHanded"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "12"],
		"description": "A huge, heavy axe, often with a double bladed head", 												],
	"greatsword": [
		"class": "martial",
		"tags": ["heavy", "twoHanded"],
		"damage": [
			"multiplier": "2",
			"type": "slashing",
			"value": "6"],
		"description": "A huge, heavy sword, requireing two hands to wield", 												],
	"halberd": [
		"class": "martial",
		"tags": ["heavy", "reach", "twoHanded"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "10"],
		"description": "A long pole with an axe-shaped head attached to one end", 										],
	"lance": [
		"class": "martial",
		"tags": ["reach", "special"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "12"],
		"special": "You have disadvantage on a target within 5 feet of you when using the lance.  You must use two hands to wield this weapon while unmounted.",
		"description": "A long pole made of metal with a sharpened point",	 										],
	"longsword":	[
		"class": "martial",
		"tags": ["versatile"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "8"],
		"description": "A long, sharp blade made of steel or iron",														],
	"maul":	[
		"class": "martial",
		"tags": ["heavy", "twoHanded"],
		"damage": [
			"multiplier": "2",
			"type": "bludgeoning",
			"value": "6"],
		"description": "A heavy, two-handed hammer",																		],
	"morningstar":	[
		"class": "martial",
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "8"],
		"description": "A one handed weapon ended in a spiked iron ball, which is either attached to the base directly or by a chain",																											],
	"pike":	[
		"class": "martial",
		"tags": ["heavy", "reach", "twoHanded"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "10"],
		"description": "A long pole made of metal with a sharpened point",												],
	"rapier": [
		"class": "martial",
		"tags": ["finesse"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "8"],
		"description": 	"A long, thin, agile sword best used for stabbing and riposte",									],
	"scimitar": [
		"class": "martial",
		"tags": ["finesse", "light"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "6"],
		"description": 	"A curved, wide blade",											],
	"shortsword": [
		"class": "martial",
		"tags": ["finesse", "light"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "6"],
		"description": 	"A basic sword, measuring no longer than 3 feet long",											],
	"trident": [
		"class": "martial",
		"tags": ["thrown", "versatile"],
		"range": [
			"normal": "20",
			"extended": "60"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "6"],
		"description": 	"A long pole ending in three sharp prongs",											],
	"war pick": [
		"class": "martial",
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "8"],
		"description": "I have no idea what a \"war pick\" is", 												],
	"warhammer": [
		"class": "martial",
		"tags": ["versatile"],
		"damage": [
			"multiplier": "1",
			"type": "bludgeoning",
			"value": "8",
			"twoHanded": "10"],
		"description": "A heavy, two-handed hammer", 												],
	"whip": [
		"class": "martial",
		"tags": ["finesse", "reach"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "4"],
		"description": "A long and flexible rope-like weapon", 												],
	"blowgun": [
		"class": "martial",
		"tags": ["ammunition", "ranged", "loading"],
		"range": [
			"normal": "25",
			"extended": "100"],
		"damage": [
			"type": "piercing",
			"value": "1"],
		"description": 	"A air-powered tube that can be used to propel darts at distant targets",						],
	"hand crossbow": [
		"class": "martial",
		"tags": ["ammunition", "light", "loading"],
		"range": [
			"normal": "30",
			"extended": "120"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "6"],
		"description": 	"A small crossbow that can be wielded in one hand",													],
	"heavy crossbow": [
		"class": "martial",
		"tags": ["ammunition", "heavy", "loading", "twoHanded"],
		"range": [
			"normal": "100",
			"extended": "400"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "10"],
		"description": 	"A military grade crossbow",													],
	"longbow": [
		"class": "martial",
		"tags": ["ammunition", "ranged", "heavy", "twoHanded"],
		"range": [
			"normal": "150",
			"extended": "600"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "8"],
		"description": 	"A bow that excels at hitting distant targets",													],
	"net": [
		"class": "martial",
		"tags": ["special", "thrown"],
		"special": "A creature that is of size Large or smaller can be restrained by the net on a successful hit.  Creatures caught by the net must make a DC10 Strength check to break free.  They can also be freed by doing 5 slashing damage to the net, which in turn destroys the net.  Using a net prevents the use of multiple attacks on the turn the net is cast.",
		"range": [
			"normal": "5",
			"extended": "15"],
		"description": 	"A woven collection of rope used to entagle an opponent",										],

//	"armor": [
		//armor
		"scale mail": 		[
			"type": "armor",
			"description": 	"A type of medium armor made of interlocking shards of metal",									],
		"leather armor":	[
			"type": "armor",
			"description": 	"Armor made from tanned animal hide",															],
		"chain mail":	[
			"type": "armor",
			"description": 	"A shirt made from linked metal rings",															],
//],

	//shields
	"shield":		[
		"type": "shield",
		"description": 	"A flat piece of metal or wood that is straped to the arm and helps block attacks",				],

	//packs
	"priest's pack": [
		"type": "pack",
		"description": 	"A backpack containing a blanket, 10 candles, a tinderbox, an alms box, 2 blocks of incense, a censer, vestments, 2 days of rations, and a waterskin",												],
	"explorer's pack": [
		"type": "pack",
		"description": "A backpack containing a bedroll, a mess kit, a tinderbox, 10 torches, 10 days of rations, a waterskin, and 50 feet of hempen rope",					],
	"dungeoneer's pack": [
		"type": "pack",
		"description":  "A backpack containing a crowbar, a hammer, 10 pitons, 10 torches, a tinderbox, 10 days of rations, a waterskin and 50 feet of hempen rope",		],
	"diplomat's pack": [
		"type": "pack",
		"description":  "A backpack containing a chest, 2 cases for maps and scrolls, a set of fine clothes, a bottle of ink, an ink pen, a lamp, 2 flasks of oil, 5 sheets of paper, a vial of perfume, sealing wax, and a bar of soap",																												],
	"burglar's pack": [
		"type": "pack",
		"description": 	"A backpack containing a bag of 1000 ball bearings, 10 feet of string, a bell, 5 candles, a crowbar, a hammer, 10 pitons, a hooded lantern, 2 flasks of oil, 5 days rations, a tinderbox, a waterskin, and 50 feet of hempen rope"																							],
	"entertainer's pack": [
		"type": "pack",
		"description": "A backpack containing a bedroll, 2 costumes, 5 candles, 5 days of rations, a waterskin, and a disguise kit.",										],
	"thieves's tools": [
		"type": "pack",
		"description": "A backpack containing",																																],
	"scholar's pack": [
		"type": "pack",
		"description": 	"A backpack containing a book of lore, a bottle of ink, an ink pen, 10 sheets of parchment, a little bag of sand, and a small knife.",				],

	//other
	"holy symbol": [
		"type": "other",
		"description": 	"An item that has been blessed by a diety and can be channeled to call out to that greater power",],
	"component pouch": [
		"type": "other",
		"description": "A small satchel used to stash materials used in spellcasting",									],
	"arcane focus":			[
		"type": "other",
		"description": "A small item that has been attuned to magic and can be used to amplify most magics",			],
	"spellbook": [
		"type": "other",
		"description": 		"A book containing great knowledge on how to cast arcane arts",								],

	//odd starting item strings that might want to be generated from the above descriptions rather than on their own
	"leather armor and a longbow": [
		"type": "other",
		"description": 		"A bow built for long range combat and light armor to protect when enemies get too close",	],
	"two martial weapons": [
		"type": "other",
		"description": 		"Two martial weapons of your choice",														],
	"martial weapon and a shield": [
		"type": "other",
		"description": 		"A martial weapon of your choice and a shield to block incoming blows.",					],
	"a pair of handaxes": [
		"type": "other",
		"description": 		"A twin set of axes than can be thrown.",													],

]

let SimpleWeapons = ["club", "dagger", "greatclub", "handaxe", "javelin", "light hammer", "mace", "quarterstaff", "sickle", "spear", "light crossbow", "dart", "shortbow", "sling"]
let MartialWeapons = ["battleaxe", "flail", "glaive", "greataxe", "greatsword", "halberd", "lance", "longsword", "maul", "morningstar", "pike", "rapier", "scimitar", "trident", "war pick", "warhammer", "whip", "blowgun", "hand crossbow", "heavy crossbow", "longbow", "net"]

enum ItemType: String {
	case rangedWeapon, meleeWeapon, simple, martial, mixedWeapon, armor, shield, pack, other
}
enum ItemClass: String {
	case martial, simple
}


