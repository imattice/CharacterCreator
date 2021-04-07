//
//  Armor.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/3/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

//import Foundation
//import RealmSwift
//
////defines an Item used to increase the armor class of a character
//class Armor: Item {
//	let acBonus: Int
//	let category: Category
//	let stealthDisadvantage: Bool
//	let strRequired: Int
//
//	init(name: String, acBonus: Int, category: Category, stealthDisadvantage: Bool, strengthRequired: Int, detail: String) {
//		self.acBonus				= acBonus
//		self.category				= category
//		self.stealthDisadvantage	= stealthDisadvantage
//		self.strRequired			= strengthRequired
//
//		super.init(name, type: .armor, detail: detail)
//	}
//
//	enum Category: String {
//		case unarmored, light, medium, heavy, shield
//	}
//}
//
//extension Armor {
//	static let Padded			= ArmorRecord.record(for: "padded")!.armor()
//	static let Leather			= ArmorRecord.record(for: "leather")!.armor()
//	static let StuddedLeather	= ArmorRecord.record(for: "studded leather")!.armor()
//
//	static let Hide				= ArmorRecord.record(for: "hide")!.armor()
//	static let ChainShirt		= ArmorRecord.record(for: "chain shirt")!.armor()
//	static let ScaleMail		= ArmorRecord.record(for: "scale mail")!.armor()
//	static let Breastplate		= ArmorRecord.record(for: "breastplate")!.armor()
//	static let HalfPlate		= ArmorRecord.record(for: "half plate")!.armor()
//
//	static let RingMail			= ArmorRecord.record(for: "ring mail")!.armor()
//	static let ChainMail		= ArmorRecord.record(for: "chain mail")!.armor()
//	static let Splint			= ArmorRecord.record(for: "splint")!.armor()
//	static let Plate			= ArmorRecord.record(for: "plate")!.armor()
//
//	static let Shield			= ArmorRecord.record(for: "shield")!.armor()
//}
//
//
//@objcMembers
//class ArmorRecord: Object {
//	dynamic var id: String							= UUID().uuidString
//	dynamic var name: String						= ""
//	dynamic var acBonus: Int						= 0
//	dynamic var type: String						= "unarmored"
//	dynamic var imposesStealthDisadvantage: Bool	= false
//	dynamic var strengthRequired: Int				= 0
//	dynamic var detail: String						= "A detailed description"
//
//	static func allRecords(in realm: Realm = RealmProvider.itemRecords.realm) -> Results<ArmorRecord> {
//		return realm.objects(ArmorRecord.self)//.sorted(byKeyPath: "name")
//	}
//
//	static func record(for name: String, in realm: Realm = RealmProvider.itemRecords.realm) -> ArmorRecord? {
//		return allRecords().filter({ $0.name == name }).first
//	}
//
//	func armor() -> Armor {
//		return Armor(name: 					name,
//					 acBonus: 				acBonus,
//					 category: 				Armor.Category(rawValue: type)!,
//					 stealthDisadvantage: 	imposesStealthDisadvantage,
//					 strengthRequired: 		strengthRequired,
//					 detail:				detail)
//	}
//}

//
//let armorData = [
//	"padded": [
//		"class": "light",
//		"acBonus": "1",
//		"stealthDisadvantage": "true"				],
//	"leather": [
//		"class": "light",
//		"acBonus": "1"								],
//	"studded leather": [
//		"class": "light",
//		"acBonus": "2",								],
//
//	"hide": [
//		"class": "medium",
//		"acBonus": "2"								],
//	"chain shirt": [
//		"class": "medium",
//		"acBonus": "3"								],
//	"scale mail": [
//		"class": "medium",
//		"acBonus": "4",
//		"stealthDisadvantage": "true"				],
//	"breastplate": [
//		"class": "medium",
//		"acBonus": "4"								],
//	"half plate": [
//		"class": "medium",
//		"acBonus": "5",
//		"stealthDisadvantage": "true",				],
//
//	"ring mail": [
//		"class": "heavy",
//		"acBonus": "4",
//		"stealthDisadvantage": "true"				],
//	"chain mail": [
//		"class": "heavy",
//		"acBonus": "6",
//		"stealthDisadvantage": "true",
//		"strengthRequired": "13",					],
//	"splint": [
//		"class": "heavy",
//		"acBonus": "7",
//		"stealthDisadvantage": "true",
//		"strengthRequired": "15",					],
//	"plate": [
//		"class": "heavy",
//		"acBonus": "8",
//		"stealthDisadvantage": "true",
//		"strengthRequired": "15",					],
//
//	"shield": [
//		"class": "shield",
//		"acBonus": "2",								],
//]
//
