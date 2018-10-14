//
//  Spell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/7/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation


struct Spell {
	let level: Int
	let name: String
	let school: String
	let range: String
	let castTime: String
	let duration: String
	let components: String
	let materials: String?
	var damage: String? 		= nil
	var target: Target?			= nil
	var shape: Shape?			= nil



	init?(_ name: String) {
		//get the spell info
		guard let targetSpell = spellData[name] as? [String: Any],
		let levelString = targetSpell["level"] 			as? String,
		let level 		= Int(levelString),
		let school 		= targetSpell["school"] 		as? String,
		let castTime 	= targetSpell["cast"] 			as? String,
		let range		= targetSpell["range"] 			as? String,
		let duration	= targetSpell["duration"] 		as? String,
		let components  = targetSpell["components"]		as? String
		else { print("could not find data for \(name)"); return nil }


		if components.contains("m") {
				self.materials	= targetSpell["material"] as? String		}
		else { 	self.materials = nil 										}


		if let damage = targetSpell["damage"] as? [String: Any],
			let value = damage["value"] as? String {
				var multiplierText = "1"

				if let multiplier = damage["multiplier"] as? String {
					multiplierText = multiplier
				}

				self.damage = "\(multiplierText)d\(value)"
		}


		if let count = targetSpell["target"] as? String,
			let targetCount = Target.TargetCount(rawValue: count)
			{ print("works")
			self.target = Target(count: targetCount)
		} else { print("could not convert target data for \(name)")}


		if let shapeDict  = targetSpell["shape"] as? [String : Any],
			let size = shapeDict["size"] as? String,
			let shape = shapeDict["shape"] as? String,
			let shapeStyle = Shape.ShapeStyle(rawValue: shape) {

			self.shape		= Shape(size: size, shape: shapeStyle )
		} else { print("could not convert shape data for \(name)")}

		
		self.name 			= name
		self.level			= level
		self.school 		= school
		self.range 			= range
		self.castTime 		= castTime
		self.duration 		= duration
		self.components 	= components
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

	func isCantrip() -> Bool {
		return level == 0 ? true :  false }



	static let maxLevel = 9
}

extension Spell {
	struct Target {
		let count: TargetCount

		enum TargetCount: String {
			case one, two, three, all
		}
	}

	struct Shape{
		let size: String
		let shape: ShapeStyle

		enum ShapeStyle: String  {
			case sphere, cylindar, cube, line, cone, point
		}
	}
}
