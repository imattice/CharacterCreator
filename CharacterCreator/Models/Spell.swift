//
//  Spell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/7/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation


struct Spell {
	let level: String
	let name: String
	let school: String
	let range: String
	let castTime: String
	let duration: String
	var damage: String? 	= nil

	init?(_ name: String) {
		//get the spell info
		guard let targetSpell = spellData[name] as? [String: Any] else { print("could not find data for \(name)"); return nil }
		let level 		= targetSpell["level"] 			as! String
		let school 		= targetSpell["school"] 		as! String
		let castTime 	= targetSpell["cast"] 			as! String
		let range		= targetSpell["range"] 			as! String
		let duration	= targetSpell["duration"] 		as! String

		if let damage = targetSpell["damage"] as? [String: Any],
			let value = damage["value"] as? String {
				var multiplierText = "1"

				if let multiplier = damage["multiplier"] as? String {
					multiplierText = multiplier
				}

				self.damage = "\(multiplierText)d\(value)"
		}

		self.name = name
		self.level = level
		self.school = school
		self.range = range
		self.castTime = castTime
		self.duration = duration
	}


//	func damageForCantrip() -> String {
//		guard let damage = damage else { print("no damage value"); return ""}
//
//		let level 		= Character.current.level
//
//		if self.level != "0" { print("Invalid Spell level: \(level) \(name)"); return damage}
//
//
//		if 		level >= 5  && level <= 10 	{ return "2d\(damage)" }
//		else if level >= 11 && level <= 16 	{ return "3d\(damage)" }
//		else if level >= 17 				{ return "4d\(damage)" }
//		else 								{ return "1d\(damage)" }
//	}
	func description() -> String? {
		guard let spellData = spellData[name] as? [String:Any],
			let description = spellData["description"] as? String else { print("description unavailable for \(name)"); return nil }
		return description
	}

	static let maxLevel = 9
}
