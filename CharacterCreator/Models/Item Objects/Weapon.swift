//
//  Weapon.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/1/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import UIKit
import RealmSwift

//defines an Item that is used to inflict damage
class Weapon: Item {
	let tags: [Tag]
	let damage: Damage
	let category: Category
	let range: (normal: Int, extended: Int)?

	lazy var isRanged: Bool = {
		return tags.contains(.ranged) }()
	lazy var specialMechanic: String? = {
		return WeaponRecord.record(for: name)?.specialMechanic	}()
	lazy var twoHandedDamage: Damage? = {
		return tags.contains(.versatile) ?
			Damage(multiplier: damage.multiplier!, type: damage.type, value: damage.value + 2) : nil	}()

	init(name: String, tags: [Tag], damage: Damage, category: Category, range: (normal: Int, extended: Int)?, detail: String) {
		self.tags		= tags
		self.damage 	= damage
		self.category	= category
		self.range		= range

		super.init(name, type: .weapon, detail: detail)
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

	enum Category: String {
		case martial, simple
	}
}

extension Weapon {
	static let Quarterstaff 	= WeaponRecord.record(for: "quarterstaff")!.weapon()
	static let Dagger			= WeaponRecord.record(for: "dagger")!.weapon()
	static let Club				= WeaponRecord.record(for: "club")!.weapon()
	static let Greatclub		= WeaponRecord.record(for: "greatclub")!.weapon()
	static let Handaxe			= WeaponRecord.record(for: "handaxe")!.weapon()
	static let Javelin			= WeaponRecord.record(for: "javelin")!.weapon()
	static let Mace				= WeaponRecord.record(for: "mace")!.weapon()
	static let Quaterstaff		= WeaponRecord.record(for: "quarterstaff")!.weapon()
	static let Sickle			= WeaponRecord.record(for: "sickle")!.weapon()
	static let Spear			= WeaponRecord.record(for: "spear")!.weapon()
	static let LightCrossbow	= WeaponRecord.record(for: "light crossbow")!.weapon()
	static let Dart				= WeaponRecord.record(for: "dart")!.weapon()
	static let Sling			= WeaponRecord.record(for: "sling")!.weapon()
	static let Shortbow			= WeaponRecord.record(for: "shortbow")!.weapon()

	static let Battleaxe		= WeaponRecord.record(for: "battleaxe")!.weapon()
	static let Flail			= WeaponRecord.record(for: "flail")!.weapon()
	static let Glaive			= WeaponRecord.record(for: "glaive")!.weapon()
	static let Greataxe			= WeaponRecord.record(for: "greataxe")!.weapon()
	static let Greatsword		= WeaponRecord.record(for: "greatsword")!.weapon()
	static let Halberd			= WeaponRecord.record(for: "halberd")!.weapon()
	static let Lance			= WeaponRecord.record(for: "lance")!.weapon()
	static let Longsword		= WeaponRecord.record(for: "longsword")!.weapon()
	static let Maul				= WeaponRecord.record(for: "maul")!.weapon()
	static let Morningstar		= WeaponRecord.record(for: "morningstar")!.weapon()
	static let Pike				= WeaponRecord.record(for: "pike")!.weapon()
	static let Rapier			= WeaponRecord.record(for: "rapier")!.weapon()
	static let Scimitar			= WeaponRecord.record(for: "scimitar")!.weapon()
	static let Shortsword		= WeaponRecord.record(for: "shortsword")!.weapon()
	static let Trident			= WeaponRecord.record(for: "trident")!.weapon()
	static let WarPick			= WeaponRecord.record(for: "war pick")!.weapon()
	static let Warhammer		= WeaponRecord.record(for: "warhammer")!.weapon()
	static let Whip				= WeaponRecord.record(for: "whip")!.weapon()
	static let Blowgun			= WeaponRecord.record(for: "blowgun")!.weapon()
	static let HandCrossbow		= WeaponRecord.record(for: "hand crossbow")!.weapon()
	static let HeavyCrossbow	= WeaponRecord.record(for: "heavy crossbow")!.weapon()
	static let Longbow			= WeaponRecord.record(for: "longbow")!.weapon()
	static let Net				= WeaponRecord.record(for: "net")!.weapon()
}

//used as a placeholder for where a weapon selection is to be made rather than a specific weapon
class WeaponSelectionItem: Item {
	let category: Weapon.Category

	override init(_ name: String, type: Item.ItemType = .weapon , detail: String = "") {
		if name == "martial weapon" {
			self.category 	= .martial	}
		else {
			self.category	= .simple	}

		super.init(name, type: type, detail: detail)
	}
}


@objcMembers
class WeaponRecord: Object {
	dynamic var id: String					= UUID().uuidString
	dynamic var name: String				= "weaponName"
	dynamic var tags: List<String>			= List<String>()
	dynamic var damage: String				= "0d0 damageType"
	dynamic var range: String?				= "000:000"
	dynamic var isSimple: Bool 				= true
	dynamic var specialMechanic: String?	= nil
	dynamic var detail: String				= ""


	static func allRecords(in realm: Realm = RealmProvider.itemRecords.realm) -> Results<WeaponRecord> {
		return realm.objects(WeaponRecord.self).sorted(byKeyPath: "name")
	}

	static func record(for name: String, in realm: Realm = RealmProvider.itemRecords.realm) -> WeaponRecord? {
		return allRecords().filter({ $0.name == name }).first
	}
	func weapon() -> Weapon {
		let weaponTags: [Weapon.Tag] = {
			var result = [Weapon.Tag]()
			for tag in self.tags {
				guard let weaponTag = Weapon.Tag(rawValue: tag)
					else { print("could not initialize tag: \(tag) for item: \(name)"); continue }
				result.append(weaponTag)
				}
			return result
		}()

		return Weapon(name: name,
					  tags: weaponTags,
					  damage: Damage.fromString(damage)!,
					  category: isSimple ? .simple : .martial,
					  range: rangeFromString(range),
					  detail: detail)
	}
	private func rangeFromString(_ string: String?) -> (normal: Int, extended: Int)? {
		guard let newString = string?.trimmingCharacters(in: .whitespacesAndNewlines)
			else { return nil }

		//ideal string format: "000:000"
		guard newString.matches("^[0-9]+:[0-9]+")
			else { print("Damage string does not match pattern 000:000 damageType: '\(String(describing: string))'"); return nil }

		guard let normalString = newString.components(separatedBy: ":").first,
			let extendedString = newString.components(separatedBy: ":").last,
			let normal = Int(normalString),
			let extended = Int(extendedString)
			else { print("Incorrect format for range string: \(String(describing: string))"); return nil }

		return (normal: normal, extended: extended)
	}
}


//let weaponDict = [
//	//Simple weapons
//	"club":	[
//		"class": "simple",
//		"tags": ["light"],
//		"damage": [
//			"multiplier": "1",
//			"type": "bludgeoning",
//			"value": "4"],												],
//	"dagger": [
//		"class": "simple",
//		"tags": ["finesse", "light", "thrown"],
//		"range": [
//			"normal": "20",
//			"extended": "60"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "4"],												],
//	"greatclub":	[
//		"class": "simple",
//		"tags": ["twoHanded"],
//		"damage": [
//			"multiplier": "1",
//			"type": "bludgeoning",
//			"value": "8"],												],
//	"handaxe":	[
//		"class": "simple",
//		"tags": ["light", "thrown"],
//		"range": [
//			"normal": "20",
//			"extended": "60"],
//		"damage": [
//			"multiplier": "1",
//			"type": "slashing",
//			"value": "6"],												],
//	"javelin":	[
//		"class": "simple",
//		"tags": ["thrown"],
//		"range": [
//			"normal": "30",
//			"extended": "120"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "6"],												],
//	"mace":	[
//		"class": "simple",
//		"damage": [
//			"multiplier": "1",
//			"type": "bludgeoning",
//			"value": "6"],												],
//	"quarterstaff":	[
//		"class": "simple",
//		"tags": ["versatile"],
//		"damage": [
//			"multiplier": "1",
//			"type": "bludgeoning",
//			"value": "6",
//			"twoHanded": "8"],													],
//	"sickle":	[
//		"class": "simple",
//		"tags": ["light"],
//		"damage": [
//			"multiplier": "1",
//			"type": "slashing",
//			"value": "4"],											],
//	"spear":	[
//		"class": "simple",
//		"tags": ["thrown", "versatile"],
//		"range": [
//			"normal": "20",
//			"extended": "60"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "6",
//			"twoHanded": "8"],										],
//	"light crossbow":[
//		"class": "simple",
//		"tags": ["ammunition", "ranged", "loading", "twoHanded"],
//		"range": [
//			"normal": "80",
//			"extended": "320"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "8"],												],
//	"dart":[
//		"class": "simple",
//		"tags": ["finesse", "thrown"],
//		"range": [
//			"normal": "20",
//			"extended": "60"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "4"],												],
//	"shortbow":	[
//		"class": "simple",
//		"tags": ["ammunition", "twoHanded"],
//		"range": [
//			"normal": "80",
//			"extended": "320"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "6"],												],
//	"sling":	[
//		"class": "simple",
//		"tags": ["ammunition"],
//		"range": [
//			"normal": "30",
//			"extended": "120"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "4"],												],
//
//	//Martial Weapons
//	"battleaxe": [
//		"class": "martial",
//		"tags": ["versatile"],
//		"damage": [
//			"multiplier": "1",
//			"type": "slashing",
//			"value": "8",
//			"twoHanded": "10"],											],
//	"flail": [
//		"class": "martial",
//		"damage": [
//			"multiplier": "1",
//			"type": "bludgeoning",
//			"value": "8"],												],
//	"glaive": [
//		"class": "martial",
//		"tags": ["heavy", "reach", "twoHanded"],
//		"damage": [
//			"multiplier": "1",
//			"type": "bludgeoning",
//			"value": "10" ],											],
//	"greataxe": [
//		"class": "martial",
//		"tags": ["heavy", "twoHanded"],
//		"damage": [
//			"multiplier": "1",
//			"type": "slashing",
//			"value": "12"],											],
//	"greatsword": [
//		"class": "martial",
//		"tags": ["heavy", "twoHanded"],
//		"damage": [
//			"multiplier": "2",
//			"type": "slashing",
//			"value": "6"],											],
//	"halberd": [
//		"class": "martial",
//		"tags": ["heavy", "reach", "twoHanded"],
//		"damage": [
//			"multiplier": "1",
//			"type": "slashing",
//			"value": "10"],												],
//	"lance": [
//		"class": "martial",
//		"tags": ["reach", "special"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "12"],
//		"special": "You have disadvantage on a target within 5 feet of you when using the lance.  You must use two hands to wield this weapon while unmounted.",],
//	"longsword":	[
//		"class": "martial",
//		"tags": ["versatile"],
//		"damage": [
//			"multiplier": "1",
//			"type": "slashing",
//			"value": "8"],											],
//	"maul":	[
//		"class": "martial",
//		"tags": ["heavy", "twoHanded"],
//		"damage": [
//			"multiplier": "2",
//			"type": "bludgeoning",
//			"value": "6"],																	],
//	"morningstar":	[
//		"class": "martial",
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "8"],																								],
//	"pike":	[
//		"class": "martial",
//		"tags": ["heavy", "reach", "twoHanded"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "10"],											],
//	"rapier": [
//		"class": "martial",
//		"tags": ["finesse"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "8"],						],
//	"scimitar": [
//		"class": "martial",
//		"tags": ["finesse", "light"],
//		"damage": [
//			"multiplier": "1",
//			"type": "slashing",
//			"value": "6"],									],
//	"shortsword": [
//		"class": "martial",
//		"tags": ["finesse", "light"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "6"],										],
//	"trident": [
//		"class": "martial",
//		"tags": ["thrown", "versatile"],
//		"range": [
//			"normal": "20",
//			"extended": "60"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "6"],									],
//	"war pick": [
//		"class": "martial",
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "8"],											],
//	"warhammer": [
//		"class": "martial",
//		"tags": ["versatile"],
//		"damage": [
//			"multiplier": "1",
//			"type": "bludgeoning",
//			"value": "8",
//			"twoHanded": "10"],										],
//	"whip": [
//		"class": "martial",
//		"tags": ["finesse", "reach"],
//		"damage": [
//			"multiplier": "1",
//			"type": "slashing",
//			"value": "4"],										],
//	"blowgun": [
//		"class": "martial",
//		"tags": ["ammunition", "ranged", "loading"],
//		"range": [
//			"normal": "25",
//			"extended": "100"],
//		"damage": [
//			"type": "piercing",
//			"value": "1"],			],
//	"hand crossbow": [
//		"class": "martial",
//		"tags": ["ammunition", "light", "loading"],
//		"range": [
//			"normal": "30",
//			"extended": "120"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "6"],										],
//	"heavy crossbow": [
//		"class": "martial",
//		"tags": ["ammunition", "heavy", "loading", "twoHanded"],
//		"range": [
//			"normal": "100",
//			"extended": "400"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "10"],											],
//	"longbow": [
//		"class": "martial",
//		"tags": ["ammunition", "ranged", "heavy", "twoHanded"],
//		"range": [
//			"normal": "150",
//			"extended": "600"],
//		"damage": [
//			"multiplier": "1",
//			"type": "piercing",
//			"value": "8"],											],
//	"net": [
//		"class": "martial",
//		"tags": ["special", "thrown"],
//		"special": "A creature that is of size Large or smaller can be restrained by the net on a successful hit.  Creatures caught by the net must make a DC10 Strength check to break free.  They can also be freed by doing 5 slashing damage to the net, which in turn destroys the net.  Using a net prevents the use of multiple attacks on the turn the net is cast.",
//		"range": [
//			"normal": "5",
//			"extended": "15"],								],
//]

let SimpleWeapons = ["club", "dagger", "greatclub", "handaxe", "javelin", "light hammer", "mace", "quarterstaff", "sickle", "spear", "light crossbow", "dart", "shortbow", "sling"]
let MartialWeapons = ["battleaxe", "flail", "glaive", "greataxe", "greatsword", "halberd", "lance", "longsword", "maul", "morningstar", "pike", "rapier", "scimitar", "trident", "war pick", "warhammer", "whip", "blowgun", "hand crossbow", "heavy crossbow", "longbow", "net"]
