//
//  Armor.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/3/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation

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
	static let padded			= Armor(armor: "padded")!
	static let leather			= Armor(armor: "leather")!
	static let studdedLeather	= Armor(armor: "studded leather")!

	static let hide				= Armor(armor: "hide")!
	static let chainShirt		= Armor(armor: "chain shirt")!
	static let scaleMail		= Armor(armor: "scale mail")!
	static let breastplate		= Armor(armor: "breastplate")!
	static let halfPlate		= Armor(armor: "half plate")!

	static let ringMail			= Armor(armor: "ring mail")!
	static let chainMail		= Armor(armor: "chain mail")!
	static let splint			= Armor(armor: "splint")!
	static let plate			= Armor(armor: "plate")!

	static let shield			= Armor(armor: "shield")!
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

