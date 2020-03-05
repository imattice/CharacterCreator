//
//  Race.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
import RealmSwift

typealias Subrace = Race

struct Race {
	let parentRace: String
	let subrace: String?
	let modifiers: [Modifier]

	static let HillDwarf 			= Race(fromParent: "dwarf", withSubrace: "hill")!
	static let MountianDwarf		= Race(fromParent: "dwarf", withSubrace: "mountian")!
	static let HighElf				= Race(fromParent: "elf", withSubrace: "high")!
	static let WoodElf				= Race(fromParent: "elf", withSubrace: "wood")!
	static let LightfootHalfling	= Race(fromParent: "halfling", withSubrace: "lightfoot")!
	static let StoutHalfling		= Race(fromParent: "halfling", withSubrace: "stout")!
	static let Human				= Race(fromParent: "human", withSubrace: nil)


	init?(fromParent parentName: String, withSubrace subraceName: String?) {
		guard let parentData = raceData[parentName] as? [String : Any]
			else { print("invalid value \(parentName)"); return nil }

		var allModifiers = [Modifier]()

		//get subrace information
		if let subraceName = subraceName {
			guard let subraceArray = parentData["subraces"] as? [String: Any],
				let subraceData = subraceArray[subraceName] as? [String: Any]
				else { print("invalid value \(subraceName)"); return nil }

			self.subrace = subraceName.lowercased()
			self.parentRace = parentName.lowercased()

			//check for modifiers from the subrace
			if let modifiers = subraceData["modifiers"] as? [String: Int] {
				for modifierData in modifiers {
					allModifiers.append(Modifier(type: .increaseStat, attribute: modifierData.key, value: modifierData.value, origin: .subrace))			}}}
		else {
			//set the name to just be the parent race if no subrace is available
			self.subrace 	= nil
			self.parentRace = parentName.lowercased()  }

		//add modifiers from the parent race
		if let modifiers = parentData["modifiers"] as? [String : Int] {

			for modifierData in modifiers {
				allModifiers.append(Modifier(type: .increaseStat, attribute: modifierData.key, value: modifierData.value, origin: .race))
			}
		}

		self.modifiers = allModifiers
	}

	static func modifierString(for raceName: String, withSubrace subraceName: String?) -> String {
		guard let raceData = raceData[raceName] as? [String : Any] else {print("invalid raceName: \(raceName)"); return ""}

		var result: String = ""
		var modifierArray: [String: Int]

		//set loop to subrace modifiers
		if let subraceName = subraceName {
			guard let subraces = raceData["subraces"] as? [String: Any],
				let subraceData = subraces[subraceName] as? [String: Any],
				let modifiers = subraceData["modifiers"] as? [String : Int] else {print("invalid modifiers for subrace"); return "" }
			modifierArray = modifiers

			//set loop to parent modifiers
		} else {
			guard let modifiers = raceData["modifiers"] as? [String : Int] else {print("invalid modifiers for parent race"); return "" }

			modifierArray = modifiers
		}

		//append each modifier to the result
		for modifier in modifierArray { result += "+ \(modifier.key.capitalized) " }

		return result.replacingOccurrences(of: "_", with: " ").trimmingCharacters(in: .whitespaces)
	}

	func modifierString() -> String {
		var result = ""

		for modifier in modifiers {
			result += "+ \(modifier.value) \(modifier.type)\n"
		}

		return result.trimmingCharacters(in: .whitespacesAndNewlines)
	}

	func name() -> String {
		return "\(subrace?.capitalized ?? "") \(parentRace.capitalized)".trimmingCharacters(in: .whitespaces)
	}

	func languages() -> [LanguageRecord] {
		guard let raceDict = raceData[parentRace] as? [String : Any],
			let languages = raceDict["languages"] as? [String] else { return [LanguageRecord]()}

		var result = [LanguageRecord]()
		for language in languages {
			if let record = LanguageRecord.record(forName: language) {
				result.append( record )
			}}
		return result
	}

	func description() -> String {
		var result: String = ""
		guard let raceDict = raceData[parentRace] as? [String : Any],
			let raceDescription = raceDict["description"] as? String else { return result }

		result = raceDescription

		if let subrace = subrace,
			let subraceDict = raceDict["subraces"] as? [String : Any ],
			let subraceName = subraceDict[subrace] as? [String : Any ],
			let subraceDescription = subraceName["description"] as? String
		{
			result += "\n\n\(subraceDescription)"
		}
		return result
	}

	static let DwarfMountian = Race(fromParent: "dwarf", withSubrace: "mountian")!
	static let DwarfHill = Race(fromParent: "dwarf", withSubrace: "hill")!
	static let ElfHigh = Race(fromParent: "elf", withSubrace: "high")!
	static let ElfWood = Race(fromParent: "elf", withSubrace: "wood")!
	static let HalflingLightfoot = Race(fromParent: "halfling", withSubrace: "lightfoot")!
	static let HalflingStout = Race(fromParent: "halfling", withSubrace: "stout")!
	static let Human = Race(fromParent: "human", withSubrace: nil)!

}

@objcMembers
class RaceRecord: Object {
	enum Property: String {
		case id, name, detail, modifiers, subrace }

	dynamic var id: String				= UUID().uuidString
	dynamic var name: String			= ""
	dynamic var summary: String			= ""
	dynamic var modifiers: [Modifier]	= [Modifier]()
	dynamic var subrace: [Subrace]		= [Subrace]()
//	dynamic var languages: 

	override static func primaryKey() -> String? {
		return RaceRecord.Property.id.rawValue
	}
}
@objcMembers
class SubraceRecord: Object {
	enum Property: String {
		case id, name, detail, modifiers, subrace }

	dynamic var id: String				= UUID().uuidString
	dynamic var name: String			= ""
	dynamic var summary: String			= ""
	dynamic var modifiers: [Modifier]	= [Modifier]()

	override static func primaryKey() -> String? {
		return SubraceRecord.Property.id.rawValue
	}
}

let raceData: [String: Any] = [
	"dwarf": [
		"description": "Stout and stubborn, a dwarf is known for their tenacity with metalwork and ores.  They can often be found in deep recesses of mountains, underground and generally keeping to themselves.",
		"modifiers": [
			"con"				: 2	],
		"subraces": [
			"hill": [
				"description": "Hill dwarves have left the mountianous caverns in favor of rolling hills.  In doing so, they've traded some of their natrual strenth for a broader world view and increased stamina.",
				"modifiers": [
					"wis"		: 1,
					"hp"		: 1	]],
			"mountian": [
				"description": "Mountian dwarves are strong and hardy, accustomed to a difficult life in rugged terrain.  They are protective of their own territory, and will defend an ally with fierce abbandon.",
				"modifiers": [
					"str"		: 2,]]]],

	"elf": [
		"description": "The elves posess grace unlike any other, seeming to move quickly through sunbeams without so much as a hint of disruption.  Learning new magicks come easily to them, as do many other works that marry art, craft and deep wisdom.",
		"modifiers": [
			"dex"				: 2 ],
		"subraces": [
			"high": [
				"description": "The high elves have renounced their woodland ancestry in favor of the acadamies, politics, and labratories of large cities.  They prefer the comforts of modern life while spending a great amount of time engaged in their work.",
				"modifiers": [
					"int"		: 1	] ],
			"wood": [
				"description": "The wood elves embrace the natural order of the world, living amonst the treetops of thick-wooded forests. They've attuned their survival instints, granting them intuitive awareness, quick reaction time, and the stealth of an experianced hunter.",
				"modifiers": [
					"wis"		: 1	] ] ] ],

	"halfling": [
		"description": "A comfortable home and the happiness of friends are what most halflings desire.  They tend to avoid the adventuring life, though some are willing to ignore the expectation of the domestic life to see the world.",
		"modifiers": [
			"dex"				: 2	],
		"subraces": [
			"lightfoot": [
				"description": "Lightfoot halflings use their tiny stature to their advantage, allowing them to hide in event the smallest of places.  They tend to be extremely friendly and easy to get along with.",
				"modifiers": [
					"cha"		: 1	] ],
			"stout": [
				"description": "Stout halflings are said to be desendant of dwarves, which give them a resistance to poison and a heightened stamina.  Because of this, their ability to win a drinking contest is unmatched.",
				"modifiers": [
					"con"		: 1	] ] ] ],

	"human": [
		"description": "Humankind has reached every corner of the world, giving them an advantage in numbers, and unmatched diversity in their abilities.  Wise scholars, brave fighters and famous performers have been humans.  Their great ambition and innovation is unlike any other race and has allowed them to make a significant impact in the state of the world.",
		"modifiers": [
			"all_stats"			: 1	]]
]

enum RaceKey: String {
	case description, modifiers, subraces
}


