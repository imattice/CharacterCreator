//
//  Damage.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/1/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation

//a container for describing how much damage an action would do
struct Damage: Equatable, Codable {
	let multiplier: Int?
	let type: DamageType
	let value: Int

	init(multiplier: Int, type: DamageType, value: Int) {
		self.multiplier	= multiplier
		self.type		= type
		self.value		= value 
	}

//	init?(fromDict damageDict: [String : Any]) {
//		guard let valueString 		= damageDict["value"] as? String,
//			let value				= Int(valueString),
//			let typeString 			= damageDict["type"] as? String,
//			let type 				= Damage.DamageType(rawValue: typeString)
//			else { print("Missing data to create damage object"); return nil }
//
//		if let multiplierString 	= damageDict["multiplier"] as? String,
//			let multiplier			= Int(multiplierString) {
//			self.multiplier = multiplier									}
//		else {
//			self.multiplier = nil											}
//
//		self.type		= type
//		self.value		= value
//	}
    
    init(_ string: String ) throws {
        guard string.matches("^[0-9]+d[0-9]+ (acid|fire|cold|thunder|poison|necrotic|radient|force|bludgeoning|piercing|slashing)")
        else { throw DamageError.parsingError("Damage string does not match pattern 00d00 damageType: '\(string)'") }
        guard
            let damageDieString        = string.components(separatedBy: " ").first,
            let damageTypeString     = string.components(separatedBy: " ").last,
            let multiplierString     = damageDieString.components(separatedBy: "d").first,
            let valueString            = damageDieString.components(separatedBy: "d").last,
            let multiplier            = Int(multiplierString),
            let value                = Int(valueString),
            let type                = DamageType(rawValue: damageTypeString)
        else { throw DamageError.parsingError("Failed to parse damage string '\(string)'") }

        self.multiplier = multiplier
        self.value = value
        self.type = type
    }
//	static func fromString(_ string: String) -> Damage? {
//		let newString  = string.trimmingCharacters(in: .whitespacesAndNewlines)
//
//		//ideal string format: "1d6 fire"
//		guard newString.matches("^[0-9]+d[0-9]+ (acid|fire|cold|thunder|poison|necrotic|radient|force|bludgeoning|piercing|slashing)")
//			else { print("Damage string does not match expected pattern 00d00 damageType: '\(string)'"); return nil }
//		guard
//			let damageDieString		= newString.components(separatedBy: " ").first,
//			let damageTypeString 	= newString.components(separatedBy: " ").last,
//			let multiplierString 	= damageDieString.components(separatedBy: "d").first,
//			let valueString			= damageDieString.components(separatedBy: "d").last,
//			let multiplier			= Int(multiplierString),
//			let value				= Int(valueString),
//			let type				= DamageType(rawValue: damageTypeString)
//			else { print("Incorrect format for Damage string: \(string)"); return nil }
//
//		return Damage(multiplier: multiplier, type: type, value: value)
//	}

	func rollString(withType: Bool) -> String {
		var result = ""

		if let multiplier = multiplier {
			result += "\(multiplier)d"
		}

		result += "\(value)"

		if withType { result += " \(type.rawValue.capitalized)" }
		return result
	}
	enum DamageType: String, Codable {
		case acid, fire, cold, thunder, poison, necrotic, radient, force, bludgeoning, piercing, slashing
	}
}

enum DamageError: Error {
    case parsingError(String)
}


