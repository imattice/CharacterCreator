//
//  Race.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
import RealmSwift
import CoreData

typealias Subrace = OldRace

struct OldRace {
	let parentRace: String
	let subrace: String?
	let modifiers: [Modifier]

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
                    allModifiers.append(  AbilityScoreModifier(name: AbilityScore.Name(rawValue: modifierData.key)!,
                                                               value: modifierData.value,
                                                               adjustment: .increase,
                                                               isTemp: false,
                                                               origin: .subrace))			}}}
		else {
			//set the name to just be the parent race if no subrace is available
			self.subrace 	= nil
			self.parentRace = parentName.lowercased()  }

		//add modifiers from the parent race
		if let modifiers = parentData["modifiers"] as? [String : Int] {

			for modifierData in modifiers {
				allModifiers.append( AbilityScoreModifier(name: AbilityScore.Name(rawValue: modifierData.key)!,
                                                          value: modifierData.value,
                                                          adjustment: .increase,
                                                          isTemp: false,
                                                          origin: .race))
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
        let statModifiers = modifiers.filter { $0 is AbilityScoreModifier }

		for modifier in statModifiers as! [AbilityScoreModifier] {
			result += "+ \(modifier.value) \(modifier.abilityScore)\n"
		}

		return result.trimmingCharacters(in: .whitespacesAndNewlines)
	}

	func name() -> String {
		return "\(subrace?.capitalized ?? "") \(parentRace.capitalized)".trimmingCharacters(in: .whitespaces)
	}

	func languages() -> [Language] {
		guard let raceDict = raceData[parentRace] as? [String : Any],
			let languages = raceDict["languages"] as? [String] else { return [Language]()}

		var result = [Language]()
		for language in languages {
			if let record = LanguageRecord.record(for: language) {
                result.append( Language(name: record.name) )
			}
			if language == "choice" {
				let languageChoice = Language(name: "choice", isSelectable: true)
				result.append(languageChoice)
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


	static let HillDwarf 			= OldRace(fromParent: "dwarf", withSubrace: "hill")!
	static let MountianDwarf		= OldRace(fromParent: "dwarf", withSubrace: "mountian")!
	static let HighElf				= OldRace(fromParent: "elf", withSubrace: "high")!
	static let WoodElf				= OldRace(fromParent: "elf", withSubrace: "wood")!
	static let LightfootHalfling	= OldRace(fromParent: "halfling", withSubrace: "lightfoot")!
	static let StoutHalfling		= OldRace(fromParent: "halfling", withSubrace: "stout")!
	static let Human				= OldRace(fromParent: "human", withSubrace: nil)
}

final
class Race {
    ///a reference to static attributes for this race
    let record: RaceRecord
    ///a reference to static attributes for the chosen subrace
    var subrace: SubraceRecord?
    
    ///the full name of the race, including the subrace
    var label: String {
        guard let subrace = subrace else { return "\(record.name)" }
        return "\(subrace.name) \(record.name)"
    }
    
    init(race: RaceRecord, subrace: SubraceRecord?) {
        self.record     = race
        self.subrace    = subrace
    }
    
}

///an object representing static data for a specific race
final
class RaceRecord: Record, Codable, Identifiable {
    ///used to identify the record
    let id: String = UUID().uuidString
    ///the name of the race
    var name: String
    ///a  paragraph containing descriptive details about the race
    let description: String
    ///indicates if the race can see 60 ft in dim light
    let hasDarkvision: Bool
    ///contains descriptive information on average features of the race
    let descriptive: Descriptive
    ///incdicates the size of the creature
    let size: CreatureSize
    ///how far the creature can travel in 6 seconds in feet
    let speed: Int
    ///which languages are typically learned by this race
    let baseLanguages: [String]
    ///contains features granted by this race which will affect gameplay
    let features: [Feature]
    ///contains modifiers grated by this race which will affect other parts of the character sheet
    let modifiers: [Modifier]
    
    required
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.name           = try container.decode(String.self, forKey: .name)
        self.description    = try container.decode(String.self, forKey: .description)

        let age             = try container.decode(String.self, forKey: .age)
        let alignment       = try container.decode(String.self, forKey: .alignment)
        let physique        = try container.decode(String.self, forKey: .physique)
        self.descriptive    = Descriptive(age: age, alignment: alignment, physique: physique)

        self.size           =  CreatureSize(rawValue: try container.decode(String.self, forKey: .size))!
        self.hasDarkvision  = try container.decodeIfPresent(Bool.self, forKey: .hasDarkvision) ?? false
        
        self.speed          = try container.decode(Int.self, forKey: .speed)
        
        let statModifierContainer = try container.nestedContainer(keyedBy: AbilityScore.Name.self, forKey: .statIncrease)
        self.modifiers      = AbilityScoreModifier.decoded(from: statModifierContainer)
        
        let featureContainer = try container.nestedUnkeyedContainer(forKey: .features)
        self.features       = Feature.decoded(from: featureContainer, source: .race)

        var languages = [String]()
        var languageContainer = try container.nestedUnkeyedContainer(forKey: .baseLanguages)
        while !languageContainer.isAtEnd {
            let language    = try languageContainer.decode(String.self)
            languages.append(language)
        }
        self.baseLanguages  = languages
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(hasDarkvision, forKey: .hasDarkvision)
        try container.encode(descriptive.age, forKey: .age)
        try container.encode(descriptive.alignment, forKey: .alignment)
        try container.encode(descriptive.physique, forKey: .physique)
        try container.encode(size.rawValue, forKey: .size)
        try container.encode(baseLanguages, forKey: .baseLanguages)
        try container.encode(features, forKey: .features)
        try container.encode(modifiers, forKey: .modifiers)
    }
    
    ///holds descriptive references of average attributes for this race
    struct Descriptive: Codable {
        ///average ages of this race
        let age: String
        ///average alignments for this race
        let alignment: String
        ///typical physical attributes for this race
        let physique: String
    }
    
    var languageString: String {
        return baseLanguages.joined(separator: ", ")
    }
    
    enum CodingKeys: CodingKey {
        case id, name, description, age, alignment, physique, modifiers, size, speed, hasDarkvision, features, baseLanguages, statIncrease
    }
}



final
class SubraceRecord: Record, Codable {
    ///used to identify the record
    let id: String = UUID().uuidString
    ///the race that this subrace inherits from
    let parent: String
    ///the name of the subrace
    var name: String
    ///a  paragraph containing descriptive details about the subrace
    let description: String
    ///contains features granted by this subrace which will affect gameplay
    let features: [Feature]
    ///contains modifiers grated by this subrace which will affect other parts of the character sheet
    let modifiers: [Modifier]
    
    required
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.parent         = try container.decode(String.self, forKey: .parent)
        self.name           = try container.decode(String.self, forKey: .name)
        self.description    = try container.decode(String.self, forKey: .description)
       
        let statModifierContainer = try container.nestedContainer(keyedBy: AbilityScore.Name.self, forKey: .statIncrease)
        self.modifiers      = AbilityScoreModifier.decoded(from: statModifierContainer)

        let featureContainer = try container.nestedUnkeyedContainer(forKey: .features)
        self.features       = Feature.decoded(from: featureContainer, source: .subrace)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(features, forKey: .features)
        try container.encode(modifiers, forKey: .modifiers)
    }
    
    enum CodingKeys: CodingKey {
        case parent, name, description, statIncrease, features, modifiers
    }
}

//@objcMembers
//class RaceRecord: Object {
//	enum Property: String {
//		case id, name, detail, modifiers, subrace }
//
//	dynamic var id: String				= UUID().uuidString
//	dynamic var name: String			= ""
//	dynamic var summary: String			= ""
//	dynamic var modifiers: [Modifier]	= [Modifier]()
//	dynamic var subrace: [Subrace]		= [Subrace]()
////	dynamic var languages:
//
//	override static func primaryKey() -> String? {
//		return RaceRecord.Property.id.rawValue
//	}
//}
//@objcMembers
//class SubraceRecord: Object {
//	enum Property: String {
//		case id, name, detail, modifiers, subrace }
//
//	dynamic var id: String				= UUID().uuidString
//	dynamic var name: String			= ""
//	dynamic var summary: String			= ""
//	dynamic var modifiers: [Modifier]	= [Modifier]()
//
//	override static func primaryKey() -> String? {
//		return SubraceRecord.Property.id.rawValue
//	}
//}
