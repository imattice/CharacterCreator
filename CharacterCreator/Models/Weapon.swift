//
//  Weapon.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/1/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit


class Weapon: Item {
	let tags: [Tag]
	let damage: Damage
	let `class`: WeaponClass

	lazy var isRanged: Bool = {
		return tags.contains(.ranged) }()

	init?(weapon name: String) {
		guard let weaponDict 			= weaponDict[name.lowercased()] 				else { return nil }
		guard let classData 			= weaponDict["class"] as? String,
			let weaponClass 			= WeaponClass(rawValue: classData)			 	else { return nil }

		self.class	= weaponClass

		if let damageDict 			= weaponDict["damage"] as? [String : Any],
			let damage = Damage(fromDict: damageDict) {

			self.damage = damage
		}
		else { self.damage	= Damage(multiplier: 0, type: .force, value: 0)	}

		var tags = [Tag]()
		if let tagData = weaponDict["tags"] as? [String] {
			for tagRecord in tagData {
				guard let tag = Tag(rawValue: tagRecord) else { print("could not create itemtag enum from \(tagRecord)"); continue }
				tags.append(tag)
			}
		}
		self.tags = tags

		super.init(name.lowercased())
	}


	enum Tag: String {
		case ammunition, finesse, heavy, light, loading, thrown, twoHanded, versatile, ranged, reach, special

		func image() -> UIImage? {
			switch self {
			case .ammunition: 	return UIImage(named: "bow")
			case .finesse: 		return UIImage(named: "rapier")
			case .heavy:		return UIImage(named: "warhammer")
			case .light: 		return UIImage(named: "dagger")
			case .loading: 		return UIImage(named: "crossbow")
			case .thrown: 		return UIImage(named: "handaxe")
			case .twoHanded: 	return UIImage(named: "bow")
			case .versatile: 	return UIImage(named: "staff")
			case .ranged: 		return UIImage(named: "bow")
			case .reach: 		return UIImage(named: "rapier")
			case .special: 		return UIImage(named: "arcane focus")
			}
		}
	}

	enum WeaponClass: String {
		case martial, simple
	}
}

extension Weapon {
	static let Quarterstaff = Weapon(weapon: "quarterstaff")!
	static let Dagger		= Weapon(weapon: "dagger")!

	static let Shortbow		= Weapon(weapon: "shortbow")!
	static let Longbow		= Weapon(weapon: "longbow")!
}

class WeaponSelectionItem: Item {
	let category: Category

	override init(_ name: String) {
		if name == "martial weapon" {
			self.category 	= .martial	}
		else {
			self.category	= .simple	}

		super.init(name)
	}

	enum Category {
		case simple, martial	}
}


let weaponDict = [
	//Simple weapons
	"club":	[
		"class": "simple",
		"tags": ["light"],
		"damage": [
			"multiplier": "1",
			"type": "bludgeoning",
			"value": "4"],												],
	"dagger": [
		"class": "simple",
		"tags": ["finesse", "light", "thrown"],
		"range": [
			"normal": "20",
			"extended": "60"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "4"],												],
	"greatclub":	[
		"class": "simple",
		"tags": ["twoHanded"],
		"damage": [
			"multiplier": "1",
			"type": "bludgeoning",
			"value": "8"],												],
	"handaxe":	[
		"class": "simple",
		"tags": ["light", "thrown"],
		"range": [
			"normal": "20",
			"extended": "60"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "6"],												],
	"javelin":	[
		"class": "simple",
		"tags": ["thrown"],
		"range": [
			"normal": "30",
			"extended": "120"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "6"],												],
	"mace":	[
		"class": "simple",
		"damage": [
			"multiplier": "1",
			"type": "bludgeoning",
			"value": "6"],												],
	"quarterstaff":	[
		"class": "simple",
		"tags": ["versatile"],
		"damage": [
			"multiplier": "1",
			"type": "bludgeoning",
			"value": "6",
			"twoHanded": "8"],													],
	"sickle":	[
		"class": "simple",
		"tags": ["light"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "4"],											],
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
			"twoHanded": "8"],										],
	"light crossbow":[
		"class": "simple",
		"tags": ["ammunition", "ranged", "loading", "twoHanded"],
		"range": [
			"normal": "80",
			"extended": "320"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "8"],												],
	"dart":[
		"class": "simple",
		"tags": ["finesse", "thrown"],
		"range": [
			"normal": "20",
			"extended": "60"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "4"],												],
	"shortbow":	[
		"class": "simple",
		"tags": ["ammunition", "twoHanded"],
		"range": [
			"normal": "80",
			"extended": "320"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "6"],												],
	"sling":	[
		"class": "simple",
		"tags": ["ammunition"],
		"range": [
			"normal": "30",
			"extended": "120"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "4"],												],

	//Martial Weapons
	"battleaxe": [
		"class": "martial",
		"tags": ["versatile"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "8",
			"twoHanded": "10"],											],
	"flail": [
		"class": "martial",
		"damage": [
			"multiplier": "1",
			"type": "bludgeoning",
			"value": "8"],												],
	"glaive": [
		"class": "martial",
		"tags": ["heavy", "reach", "twoHanded"],
		"damage": [
			"multiplier": "1",
			"type": "bludgeoning",
			"value": "10" ],											],
	"greataxe": [
		"class": "martial",
		"tags": ["heavy", "twoHanded"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "12"],											],
	"greatsword": [
		"class": "martial",
		"tags": ["heavy", "twoHanded"],
		"damage": [
			"multiplier": "2",
			"type": "slashing",
			"value": "6"],											],
	"halberd": [
		"class": "martial",
		"tags": ["heavy", "reach", "twoHanded"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "10"],												],
	"lance": [
		"class": "martial",
		"tags": ["reach", "special"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "12"],
		"special": "You have disadvantage on a target within 5 feet of you when using the lance.  You must use two hands to wield this weapon while unmounted.",],
	"longsword":	[
		"class": "martial",
		"tags": ["versatile"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "8"],											],
	"maul":	[
		"class": "martial",
		"tags": ["heavy", "twoHanded"],
		"damage": [
			"multiplier": "2",
			"type": "bludgeoning",
			"value": "6"],																	],
	"morningstar":	[
		"class": "martial",
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "8"],																								],
	"pike":	[
		"class": "martial",
		"tags": ["heavy", "reach", "twoHanded"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "10"],											],
	"rapier": [
		"class": "martial",
		"tags": ["finesse"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "8"],						],
	"scimitar": [
		"class": "martial",
		"tags": ["finesse", "light"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "6"],									],
	"shortsword": [
		"class": "martial",
		"tags": ["finesse", "light"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "6"],										],
	"trident": [
		"class": "martial",
		"tags": ["thrown", "versatile"],
		"range": [
			"normal": "20",
			"extended": "60"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "6"],									],
	"war pick": [
		"class": "martial",
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "8"],											],
	"warhammer": [
		"class": "martial",
		"tags": ["versatile"],
		"damage": [
			"multiplier": "1",
			"type": "bludgeoning",
			"value": "8",
			"twoHanded": "10"],										],
	"whip": [
		"class": "martial",
		"tags": ["finesse", "reach"],
		"damage": [
			"multiplier": "1",
			"type": "slashing",
			"value": "4"],										],
	"blowgun": [
		"class": "martial",
		"tags": ["ammunition", "ranged", "loading"],
		"range": [
			"normal": "25",
			"extended": "100"],
		"damage": [
			"type": "piercing",
			"value": "1"],			],
	"hand crossbow": [
		"class": "martial",
		"tags": ["ammunition", "light", "loading"],
		"range": [
			"normal": "30",
			"extended": "120"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "6"],										],
	"heavy crossbow": [
		"class": "martial",
		"tags": ["ammunition", "heavy", "loading", "twoHanded"],
		"range": [
			"normal": "100",
			"extended": "400"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "10"],											],
	"longbow": [
		"class": "martial",
		"tags": ["ammunition", "ranged", "heavy", "twoHanded"],
		"range": [
			"normal": "150",
			"extended": "600"],
		"damage": [
			"multiplier": "1",
			"type": "piercing",
			"value": "8"],											],
	"net": [
		"class": "martial",
		"tags": ["special", "thrown"],
		"special": "A creature that is of size Large or smaller can be restrained by the net on a successful hit.  Creatures caught by the net must make a DC10 Strength check to break free.  They can also be freed by doing 5 slashing damage to the net, which in turn destroys the net.  Using a net prevents the use of multiple attacks on the turn the net is cast.",
		"range": [
			"normal": "5",
			"extended": "15"],								],
]

let SimpleWeapons = ["club", "dagger", "greatclub", "handaxe", "javelin", "light hammer", "mace", "quarterstaff", "sickle", "spear", "light crossbow", "dart", "shortbow", "sling"]
let MartialWeapons = ["battleaxe", "flail", "glaive", "greataxe", "greatsword", "halberd", "lance", "longsword", "maul", "morningstar", "pike", "rapier", "scimitar", "trident", "war pick", "warhammer", "whip", "blowgun", "hand crossbow", "heavy crossbow", "longbow", "net"]
