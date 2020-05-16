//
//  Spell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/7/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//


//could use additional damage rolls, such as acid arrow, which does 4d4, and then 2d4 next turn
//targets might be nice, like aid targets 3 specific characters, or acid splash targets 2 creatures within 5 feet of each other
//add an effect, such as a damage roll, an ac bonus or stat alteration, heal
import Foundation
import RealmSwift

struct Spell {
	let level: Int
	let name: String
	let detail: String
	let school: School
	let maxRange: String
	let castTime: (value: Int, metric: String)
	let duration: (value: Int, metric: String)
	let components: [Component]
	let materials: String?
	let spellSave: StatType?
	let damage: Damage?
	let shape: Shape?

	var isCantrip: Bool {
		return level == 0 ? true :  false }

	static let maxLevel = 9

	func damageForCantrip() -> Damage? {
		guard let damage = damage else { print("no damage value"); return nil}
		if level != 0 { print("Invalid Spell level: \(level) \(name)"); return damage}

		let characterLevel 		= Character.current.level
		var multiplier			= 1

		if 		characterLevel >= 5  && characterLevel <= 10 	{ multiplier = 2 }
		else if characterLevel >= 11 && characterLevel <= 16 	{ multiplier = 3 }
		else if characterLevel >= 17 							{ multiplier = 4 }

		return Damage(multiplier: multiplier, type: damage.type, value: damage.value)
	}

	enum School: String {
		case abjuration, conjuration, divination, enchantment, illusion, evocation, necromancy, transmutation
	}
	enum Component: String {
		case verbal, somatic, material
	}
}

extension Spell {
	struct Shape {
		let size: Int
		let style: Style

		enum Style: String  {
			case sphere, cylindar, cube, line, cone, point
		}
		static func fromString(_ string: String) -> Shape? {
			let newString  = string.trimmingCharacters(in: .whitespacesAndNewlines)
			//ideal format "00 shapeStyle"
			guard newString.matches("^[0-9]+ .*") else { return nil }

			guard
				let sizeString		= newString.components(separatedBy: " ").first,
				let shapeString		= newString.components(separatedBy: " ").last,
				let size			= Int(sizeString),
				let style			= Spell.Shape.Style(rawValue: shapeString)
				else { print("Invalid spell shape format for string: \(string)"); return nil }

			return Shape(size: size, style: style)
		}
	}
}

@objcMembers
class SpellRecord: Object {
	dynamic var id: String					= UUID().uuidString
	dynamic var name: String				= "Spell Name"
	dynamic var detail: String				= "Spell Description"
	dynamic var higherLevelDetail: String?	= "Effect of spells cast at higher levels"
	dynamic var availability: List<String>	= List<String>()
	dynamic var level: Int					= 0
	dynamic var school: String				= "SpellSchool"
	dynamic var components: String			= "VSM"
	dynamic var maxRange: String			= "000 feet"
	dynamic var castTime: String			= "0 CastTime"
	dynamic var duration: String			= "0 SpellDuration"
	dynamic var concentration: Bool			= false  //change to requiresConcentration
	dynamic var shape: String?				= "00 shapeStyle"
	dynamic var materials: String?  		= "Materials"
	dynamic var spellSave: String?			= "Stat Save"
	dynamic var damage: String?				= "0d0 damageType"
	dynamic var isRitual: Bool				= false

	static func allRecords(in realm: Realm = RealmProvider.itemRecords.realm) -> Results<SpellRecord> {
		return realm.objects(SpellRecord.self)//.sorted(byKeyPath: "name")
	}

	static func record(for name: String, in realm: Realm = RealmProvider.itemRecords.realm) -> SpellRecord? {
		return allRecords().filter({ $0.name == name }).first
	}

	func spell() -> Spell {
		return Spell(level: level, name: name, detail: detail, school: Spell.School(rawValue: school)!, maxRange: maxRange, castTime: tuple(forString: castTime), duration: tuple(forString: duration), components: components(from: components), materials: materials, spellSave: spellSave == nil ? nil : StatType(rawValue: spellSave!), damage: damage == nil ? nil : Damage.fromString(damage!), shape: shape == nil ? nil : Spell.Shape.fromString(shape!))
	}
	private func tuple(forString string: String) -> (value: Int, metric: String) {
		let newString  = string.trimmingCharacters(in: .whitespacesAndNewlines)
		guard
			let valueString		= newString.components(separatedBy: " ").first,
			let metric		 	= newString.components(separatedBy: " ").last,
			let value			= Int(valueString)
			else { print("Invalid format in \(name.capitalized) for string: \(string)"); return (value: 0, metric: string) }

		return (value:  value, metric: metric)
	}
	private func components(from string: String) -> [Spell.Component] {
		var result = [Spell.Component]()
		let modifiedString = string.lowercased()
		if modifiedString == "" || !modifiedString.matches("^(v|s|m)+") { return result }
		if modifiedString.contains("v") { result.append(.verbal)   	}
		if modifiedString.contains("m") { result.append(.material) 	}
		if modifiedString.contains("s") { result.append(.somatic)	}

		return result
	}
}
