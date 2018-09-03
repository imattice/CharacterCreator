//
//  items.swift
//
//  Created by Ike Mattice on 8/22/18.
//

let itemData: [String : Any] = [
	//weapons
	"light crossbow":[
		"type": "rangedWeapon",
		"description": "A sping-loaded weapon that fires sharp bolts at high speeds at the press of the trigger",		],
	"simple weapon": [
		"type": "simple",
		"description": "A weapon that is relative easly to learn how to wield",											],
	"mace":	[
		"type": "meleeWeapon",
		"description": "A spiked club used to inflict blugeoning damange",												],
	"warhammer": [
		"type": "meleeWeapon",
		"description": "A heavy, two-handed hammer used to crush foes", 												],
	"longbow": [
		"type": "rangedWeapon",
		"description": 	"A bow that excels at hitting distant targets",													],
	"martial weapon": [
		"type": "martial",
		"description": 	"A weapon that requires advanced training to effectively use",									],
	"handaxes":	[
		"type": "mixedWeapon",
		"description": 	"A light axe used for quick and powerful chopping blows", 										],
	"rapier": [
		"type": "meleeWeapon",
		"description": 	"A long, thin, agile sword best used for stabbing and riposte",									],
	"shortsword": [
		"type": "meleeWeapon",
		"description": 	"A basic sword, measuring no longer than 3 feet long",											],
	"shortbow":	[
		"type": "rangedWeapon",
		"description": 	"A bow that excels at hitting close targets at range",											],
	"dagger": [
		"type": "mixedWeapon",
		"description": 	"A small, quick blade that can be thrown or easily concealed",									],
	"quarterstaff":	[
		"type": "meleeWeapon",
		"description": "A two-handed pole made of wood or metal",														],

	//armor
	"scale mail": 		[
		"type": "armor",
		"description": 	"A type of medium armor made of interlocking shards of metal",									],
	"leather armor":	[
		"type": "armor",
		"description": 	"Armor made from animal hide",																	],
	"chain mail":	[
		"type": "armor",
		"description": 	"A shirt made from linked metal rings",															],

	//shields
	"shield":		[
		"type": "shield",
		"description": 	"A flat piece of metal or wood that is straped to the arm and helps block attacks",				],

	//packs
	"priest's pack": [
		"type": "pack",
		"description": 	"A backpack containing:",																		],
	"explorer's pack": [
		"type": "pack",
		"description": "A backpack containing:",																		],
	"dungeoneer's pack": [
		"type": "pack",
		"description":  "A backpack containing:",																		],
	"burglar's pack": [
		"type": "pack",
		"description": 	"A backpack containing:",																		],
	"thieves's tools": [
		"type": "pack",
		"description": "A backpack containing:",																		],
	"scholar's pack": [
		"type": "pack",
		"description": 	"A backpack containing:",																		],

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
]

enum ItemType: String {
	case rangedWeapon, meleeWeapon, simple, martial, mixedWeapon, armor, shield, pack, other
}
