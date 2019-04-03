//
//  Class.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
import UIKit

struct Class {
	let base: String
	let path: String
	let availableClass: AvailableClass
	var castingAttributes: SpellCastingAttributes?

	var features: [Int: [ClassFeature]] 	{ return getAllLevelFeatures() }

	init?(fromString className: String, withPath pathName: String) {

		//set the name to a subrace friendly name
		self.base 				= className.lowercased()
		self.path				= pathName.lowercased()
		self.availableClass 	= AvailableClass(rawValue: base.lowercased())!

		if let spellcastingAttributes = SpellCastingAttributes(for: base) {
			self.castingAttributes = spellcastingAttributes						}
		else {
			self.castingAttributes = nil 										}
	}

	public func getAllLevelFeatures() -> [Int: [ClassFeature]] {
		var result = [Int: [ClassFeature]]()

		//make sure we have the data we need
		guard let classDict = classData[base] as? [String:Any],
			let classLevelDict = classDict["levels"] as? [String:Any] 	else { print("Could not initialize class data for the \(base) class"); return result}

		guard let paths = classDict["paths"] as? [String:Any],
			let pathDict = paths[path] as? [String:Any],
			let pathLevelDict = pathDict["levels"] as? [String:Any] 	else { print("could not initialize path data for the \(base) class"); return result}


		// get features for each level
		for level in 1...Character.levelMax {
			var levelFeatures = [ClassFeature]()

			//check for features for all classes
			if [4, 8, 12, 16, 19].contains(level) {
				let title = AllClassKey.abilityScoreIncrease.rawValue
				let dict = allClassLevels[title] as! [String: String]
				let description = dict["description"]!

				let levelFeature = ClassFeature(title: title, description: description, source: "All Classes")

				levelFeatures.append(levelFeature)
			}

			//check for class specific features
			if let classLevel = classLevelDict[String(level)] as? [String:Any] {
				let levelFeature = getFeatures(forDict: classLevel, source: base)

				levelFeatures.append(contentsOf: levelFeature)
			}

			//check for path specific features
			if let pathLevel = pathLevelDict[String(level)] as? [String:Any] {
				let levelFeature = getFeatures(forDict: pathLevel, source: path)

				levelFeatures.append(contentsOf: levelFeature)
			}

			// if we haven't found any features, skip this level
			if levelFeatures.isEmpty { continue }
			
			// add the level data to the dictionary
			// if there's alreay a key for this level, just add the contents
			if let _ = result[level] {
				result[level]!.append(contentsOf: levelFeatures) }
			// if there isn't a key, then we replace the contents with the new group of features
			else {
				result[level] = levelFeatures
			}
		}

		return result
	}

	private func getFeatures(forDict dict: [String: Any], source: String) -> [ClassFeature] {
		var result = [ClassFeature]()

		for feature in dict {
			guard let description = feature.value as? String
				else { print("invalid level value for \(source) at level \(feature.key)"); return result }

			let levelFeature = ClassFeature(title: feature.key, description: description, source: source)

			result.append(levelFeature)
		}

		return result
	}

	func name() -> String {
		return "\(path.capitalized) \(base.capitalized)"
	}

	func baseDescription() -> String {
		guard let classDict = classData[base] as? [String : Any],
			let description = classDict["description"] as? String
			else { print("could not initialize description for \(base)"); return ""	}

		return description
	}

	func pathDescription() -> String {
		guard let classDict = classData[base] as? [String : Any],
			let pathsDict	= classDict["paths"] as? [String : Any],
			let pathDict	= pathsDict[path] as? [String : Any],
			let description = pathDict["description"] as? String
			else { print("could not initialize description for \(path)"); return ""	}

		return description
	}
	func color() -> UIColor.AppColor {
		return UIColor.color(for: availableClass)
	}
	func gradient() -> [UIColor] {
		return UIColor.gradient(for: availableClass)
	}
	func skillSelection() -> [String]? {
		guard let dict = classData[base] as? [String: Any] else { print("could not create dict from \(base)"); return nil }
		guard let skills = dict["skills"] as? [String] else { print("could not get skills for \(base)"); return nil }

		return skills
	}
}

extension Class {
	struct SpellCastingAttributes {
		let castingAbility: StatType
		let initialSpellCount: Int
		let spellSlots: [(SpellLevel: Int, SlotCount: Int)]

		init?(for base: String) {

			guard let classDict = classData[base] as? [String: Any],
				let spellcastingDict = classDict["spellcasting"] as? [String : Any]
				else { return nil }
			guard let castingAbilityData = spellcastingDict["casting_ability"] as? String,
				let castingAbility = StatType(rawValue: castingAbilityData),
				let spellCountData = spellcastingDict["initialSpellCount"] as? String,
				let initialSpellCount = Int(spellCountData)
				else { print("failed to initialize casting data for class \(base)."); return nil }
			guard let slotDict = spellcastingDict["spellSlots"] as? [String : Any ],
				let slotsForLevel = slotDict["1"] as? [String : String]
				else { print("failed to initialize spell slot data for class \(base)."); return nil }

			//process the spell slot data
			var result = [(SpellLevel: Int, SlotCount: Int)]()
			for (level, slot) in slotsForLevel {
				guard let level = Int(level), let slot = Int(slot)
					else { print("could not create spell slot tuple"); continue }
				result.append((SpellLevel: level, SlotCount: slot))
			}

			self.castingAbility 		= castingAbility
			self.initialSpellCount 		= initialSpellCount
			self.spellSlots				= result





		}

//		private func slotsForLevel() -> [(SpellLevel: Int, SlotCount: Int)]{
//			var result = [(SpellLevel: Int, SlotCount: Int)]()
//			for (level, slot) in slotsForLevel {
//				guard let level = Int(level), let slot = Int(slot)
//					else { print("could not create spell slot tuple"); return }
//				result.append((SpellLevel: level, SlotCount: slot))
//			}
//
//			return result
//
//		}
	}
}

enum AvailableClass: String {
	case fighter, cleric, wizard, rogue
}

struct ClassFeature {
	let title: String
	let description: String
	let source: String
}
