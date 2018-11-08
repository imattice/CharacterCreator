//
//  Damage.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/1/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation


struct Damage {
	let multiplier: Int?
	let type: DamageType
	let value: Int

	init?(fromDict damageDict: [String : Any]) {
		guard let valueString 		= damageDict["value"] as? String,
			let value				= Int(valueString),
			let typeString 			= damageDict["type"] as? String,
			let type 				= Damage.DamageType(rawValue: typeString)
			else { print("Missing data to create damage object"); return nil }

		if let multiplierString 	= damageDict["multiplier"] as? String,
			let multiplier			= Int(multiplierString) {
			self.multiplier = multiplier									}
		else {
			self.multiplier = nil											}

		self.type		= type
		self.value		= value
	}

	func rollString(withType: Bool) -> String {
		var result = ""

		if let multiplier = multiplier {
			result += "\(multiplier)d"
		}

		result += "\(value)"

		if withType { result += " \(type.rawValue.capitalized)" }
		return result
	}
	enum DamageType: String {
		case acid, fire, cold, thunder, poison, necrotic, radient, force, bludgeoning, piercing, slashing
	}
}

