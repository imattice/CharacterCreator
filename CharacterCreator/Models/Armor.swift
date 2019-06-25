//
//  Armor.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/3/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class ArmorRecord: Object {
	dynamic var id: String							= UUID().uuidString
	dynamic var name: String						= ""
	dynamic var acBonus: Int						= 0
	dynamic var type: String						= ""
	dynamic var imposesStealthDisadvantage: Bool	= false
	dynamic var strengthRequired: Int				= 0

	static func allRecords(in realm: Realm = RealmProvider.itemRecords.realm) -> Results<ArmorRecord> {
		return realm.objects(ArmorRecord.self).sorted(byKeyPath: "name")
	}

	static func record(for name: String, in realm: Realm = RealmProvider.itemRecords.realm) -> ArmorRecord? {
		return allRecords().filter({ $0.name == name }).first
	}
}

class Armor: Item {
	let acBonus: Int
	let `class`: ArmorClass
//	let stealthDisadvantage: Bool
//	let strRequired: Int

	init?(armor armorName: String) {
		guard let armorDict 	= armorData[armorName.lowercased()],
			let className 		= armorDict["class"],
			let armorClass 		= ArmorClass(rawValue: className),
			let acBonusString 	= armorDict["acBonus"],
			let acBonus			= Int(acBonusString) else { return nil }

		self.acBonus	= acBonus
		self.class		= armorClass

		super.init(armorName)


	}

	enum ArmorClass: String {
		case unarmored, light, medium, heavy, shield
	}
}

extension Armor {
	static let Padded			= Armor(armor: "padded")!
	static let Leather			= Armor(armor: "leather")!
	static let StuddedLeather	= Armor(armor: "studded leather")!

	static let Hide				= Armor(armor: "hide")!
	static let ChainShirt		= Armor(armor: "chain shirt")!
	static let ScaleMail		= Armor(armor: "scale mail")!
	static let Breastplate		= Armor(armor: "breastplate")!
	static let HalfPlate		= Armor(armor: "half plate")!

	static let RingMail			= Armor(armor: "ring mail")!
	static let ChainMail		= Armor(armor: "chain mail")!
	static let Splint			= Armor(armor: "splint")!
	static let Plate			= Armor(armor: "plate")!

	static let Shield			= Armor(armor: "shield")!
}

let armorData = [
	"padded": [
		"class": "light",
		"acBonus": "1",
		"stealthDisadvantage": "true"				],
	"leather": [
		"class": "light",
		"acBonus": "1"								],
	"studded leather": [
		"class": "light",
		"acBonus": "2",								],

	"hide": [
		"class": "medium",
		"acBonus": "2"								],
	"chain shirt": [
		"class": "medium",
		"acBonus": "3"								],
	"scale mail": [
		"class": "medium",
		"acBonus": "4",
		"stealthDisadvantage": "true"				],
	"breastplate": [
		"class": "medium",
		"acBonus": "4"								],
	"half plate": [
		"class": "medium",
		"acBonus": "5",
		"stealthDisadvantage": "true",				],

	"ring mail": [
		"class": "heavy",
		"acBonus": "4",
		"stealthDisadvantage": "true"				],
	"chain mail": [
		"class": "heavy",
		"acBonus": "6",
		"stealthDisadvantage": "true",
		"strengthRequired": "13",					],
	"splint": [
		"class": "heavy",
		"acBonus": "7",
		"stealthDisadvantage": "true",
		"strengthRequired": "15",					],
	"plate": [
		"class": "heavy",
		"acBonus": "8",
		"stealthDisadvantage": "true",
		"strengthRequired": "15",					],

	"shield": [
		"class": "shield",
		"acBonus": "2",								],
]

