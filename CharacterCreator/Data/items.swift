//
//  items.swift
//
//  Created by Ike Mattice on 8/22/18.
//

let itemData: [String : Any] = [
	"weapons": [
		"light crossbow":[
	//		"type": "rangedWeapon",
			"class": "simple",
			"tags": ["ammunition", "ranged", "loading", "twoHanded"],
			"range": [
				"normal": "80",
				"extended": "320"],
			"damage": [
				"type": "piercing",
				"value": "8"],
			"description": "A sping-loaded weapon that fires sharp bolts at high speeds at the press of the trigger",		],
	//	"simple weapon": [
	//		"type": "simple",
	//		"description": "A weapon that is relative easly to learn how to wield",											],
		"mace":	[
	//		"type": "meleeWeapon",
			"class": "simple",
			"damage": [
				"type": "bludgeoning",
				"value": "6"],
			"description": "A spiked club used to inflict blugeoning damange",												],
		"warhammer": [
	//		"type": "meleeWeapon",
			"class": "martial",
			"tags": ["versatile"],
			"damage": [
				"type": "bludgeoning",
				"value": "8",
				"twoHanded": "10"],
			"description": "A heavy, two-handed hammer used to crush foes", 												],
		"longbow": [
	//		"type": "rangedWeapon",
			"class": "martial",
			"tags": ["ammunition", "ranged", "heavy", "twoHanded"],
			"range": [
				"normal": "150",
				"extended": "600"],
			"damage": [
				"type": "piercing",
				"value": "8"],
			"description": 	"A bow that excels at hitting distant targets",													],
	//	"martial weapon": [
	////		"type": "martial",
	//		"description": 	"A weapon that requires advanced training to effectively use",									],
		"handaxes":	[
	//		"type": "mixedWeapon",
			"class": "simple",
			"tags": ["light", "thrown"],
			"range": [
				"normal": "20",
				"extended": "60"],
			"damage": [
				"type": "slashing",
				"value": "6"],
			"description": 	"A light, throwable axe used for quick and powerful chopping blows", 							],
		"rapier": [
	//		"type": "meleeWeapon",
			"class": "martial",
			"tags": ["finesse"],
			"damage": [
				"type": "piercing",
				"value": "8"],
			"description": 	"A long, thin, agile sword best used for stabbing and riposte",									],
		"shortsword": [
	//		"type": "meleeWeapon",
			"class": "martial",
			"tags": ["finesse", "light"],
			"damage": [
				"type": "piercing",
				"value": "6"],
			"description": 	"A basic sword, measuring no longer than 3 feet long",											],
		"shortbow":	[
	//		"type": "rangedWeapon",
			"class": "simple",
			"tags": ["ammunition", "twoHanded"],
			"range": [
				"normal": "80",
				"extended": "320"],
			"damage": [
				"type": "piercing",
				"value": "6"],
			"description": 	"A bow that excels at hitting close targets at range",											],
		"dagger": [
	//		"type": "mixedWeapon",
			"class": "simple",
			"tags": ["finesse", "light", "thrown"],
			"range": [
				"normal": "20",
				"extended": "60"],
			"damage": [
				"type": "piercing",
				"value": "4"],
			"description": 	"A small, quick blade that can be thrown or easily concealed",									],
		"quarterstaff":	[
	//		"type": "meleeWeapon",
			"class": "simple",
			"tags": ["versatile"],
			"damage": [
				"type": "bludgeoning",
				"value": "6",
				"twoHanded": "8"],
			"description": "A two-handed pole made of wood or metal",														], ],
	"armor": [
		//armor
		"scale mail": 		[
			"type": "armor",
			"description": 	"A type of medium armor made of interlocking shards of metal",									],
		"leather armor":	[
			"type": "armor",
			"description": 	"Armor made from tanned animal hide",															],
		"chain mail":	[
			"type": "armor",
			"description": 	"A shirt made from linked metal rings",															], ],

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

enum ItemTag: String {
	case ammunition, finesse, heavy, light, loading, thrown, twoHanded, versatile, ranged, reach, special
}
