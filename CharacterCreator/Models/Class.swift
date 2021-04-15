//
//  Class.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
import UIKit

///An object representing static data for a specific class
final
class ClassRecord: Record, Codable {
    ///An id for the class
    let id: String = UUID().uuidString
    ///The name of the class
    let name: String
    ///A description of the class
    let description: String
    ///The base value of the hit die for the class
    let hitDie: Int
    ///An object containing the proficiency granted by this class
    let proficincies: ClassProficiencies
    ///The features that are available to this class with the associated level they are gained at
    let features: [Feature]
    ///The subclasses that are available for this class
    let subClasses: [SubclassRecord]
    ///The starting equipment for this class
    let equipmentOptions: [Selection]
    
    ///An object containing the proficiency granted by this class
    struct ClassProficiencies: Codable {
        ///The basic armor proficiencies provided by this class, if any
        let armor: [String]?
        ///The basic weapon proficiencies provided by this class
        let weapons: [String]
        ///The basic tool proficiencies provided by this class, if any
        let tools: [String]?
        ///The basic saving throw proficiencies provided by this class
        let savingThrows: [String]
        ///The basic skill proficiencies provided by this class
        let skills: [Selection]
        
        /// Decodes an Unkeyed JSON decoding container into a ClassProficidnecies object
        /// If any decoding fails, an empty [String] is initialized for the proficiency
        /// - Parameters:
        ///   - container: An UnkeyedDecodingContainer from Decoded JSON
        ///   - source: The Source of the data, such as from a particular Race or Class
        /// - Returns: Returns an array of decoded Features
        static
        func decoded(from container: KeyedDecodingContainer<CodingKeys>) -> ClassProficiencies {
            let armor =     try? container.decodeIfPresent([String].self, forKey: .armor)
            let weapons =   try? container.decode([String].self, forKey: .weapons)
            let tools =     try? container.decodeIfPresent([String].self, forKey: .tools)
            let savingThrows = try? container.decode([String].self, forKey: .savingThrows)
            
            let skillsContainer = try! container.nestedUnkeyedContainer(forKey: .skills)
            let skills = Selection.decoded(from: skillsContainer)
            
            return ClassProficiencies(armor: armor, weapons: weapons ?? [String](), tools: tools, savingThrows: savingThrows ?? [String](), skills: skills )
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(armor,         forKey: .armor)
            try container.encode(weapons,       forKey: .weapons)
            try container.encode(tools,         forKey: .tools)
            try container.encode(savingThrows,  forKey: .savingThrows)
            try container.encode(skills,        forKey: .skills)
        }
        
        enum CodingKeys: CodingKey {
            case armor, weapons, tools, savingThrows, skills
        }
    }
    
    internal init(name: String, description: String, hitDie: Int, proficincies: ClassRecord.ClassProficiencies, features: [Feature], subClasses: [SubclassRecord], equipment: [Selection]) {
        self.name = name
        self.description = description
        self.hitDie = hitDie
        self.proficincies = proficincies
        self.features = features
        self.subClasses = subClasses
        self.equipmentOptions = equipment
    }
    
    required
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.name           = try container.decode(String.self, forKey: .name)
        self.description    = try container.decode(String.self, forKey: .description)
        self.hitDie         = try container.decode(Int.self, forKey: .hitDie)
        
        let proficiencyContainer   = try container.nestedContainer(keyedBy: ClassProficiencies.CodingKeys.self, forKey: .proficincies)
        self.proficincies   = ClassProficiencies.decoded(from: proficiencyContainer)
        
        let featureContainer = try container.nestedUnkeyedContainer(forKey: .features)
        self.features       = Feature.decoded(from: featureContainer, source: .race)
        
        self.subClasses     = try container.decode([SubclassRecord].self, forKey: .subclasses)
        self.equipmentOptions = try container.decode([Selection].self, forKey: .equipmentOptions)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name,              forKey: .name)
        try container.encode(description,       forKey: .description)
        try container.encode(hitDie,            forKey: .hitDie)
        try container.encode(proficincies,      forKey: .proficincies)
        try container.encode(features,          forKey: .features)
        try container.encode(subClasses,        forKey: .subclasses)
        try container.encode(equipmentOptions,  forKey: .equipmentOptions)
    }
    
    enum CodingKeys: CodingKey {
        case name, description, hitDie, proficincies, features, subclasses, equipmentOptions
    }
}

///An object representing static data for a specific subclass
final
class SubclassRecord: Record, Codable {
    ///An id for the subclass
    let id: String = UUID().uuidString
    ///The name of the subclass
    let name: String
    ///A description of the subclass
    let description: String
    ///The features that are available to this subclass
    let features: [Feature]
    
    internal init(name: String, description: String, features: [Feature]) {
        self.name = name
        self.description = description
        self.features = features
    }

//MARK: - SubClassRecord - Codable
    required
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.name           = try container.decode(String.self, forKey: .name)
        self.description    = try container.decode(String.self, forKey: .description)
        
        let featureContainer = try container.nestedUnkeyedContainer(forKey: .features)
        self.features       = Feature.decoded(from: featureContainer, source: .subclass)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(features, forKey: .features)
    }
    enum CodingKeys: CodingKey {
        case id, name, description, features
    }
}

//struct Class {
//	let base: String
//	let path: String
//	let availableClass: AvailableClass
//	var castingAttributes: SpellCastingAttributes?
//
//	var features: [Int: [ClassFeature]] 	{ return getAllLevelFeatures() }
//
//	init?(fromString className: String, withPath pathName: String) {
//
//		//set the name to a subrace friendly name
//		self.base 				= className.lowercased()
//		self.path				= pathName.lowercased()
//		self.availableClass 	= AvailableClass(rawValue: base.lowercased())!
//
//		if let spellcastingAttributes = SpellCastingAttributes(for: base) {
//			self.castingAttributes = spellcastingAttributes						}
//		else {
//			print("failed to create casting attributes")
//			self.castingAttributes = nil 										}
//	}
//
//	public func getAllLevelFeatures() -> [Int: [ClassFeature]] {
//		var result = [Int: [ClassFeature]]()
//
//		//make sure we have the data we need
//		guard let classDict = classData[base] as? [String:Any],
//			let classLevelDict = classDict["levels"] as? [String:Any] 	else { print("Could not initialize class data for the \(base) class"); return result}
//
//		guard let paths = classDict["paths"] as? [String:Any],
//			let pathDict = paths[path] as? [String:Any],
//			let pathLevelDict = pathDict["levels"] as? [String:Any] 	else { print("could not initialize path data for the \(base) class"); return result}
//
//
//		// get features for each level
//		for level in 1...Character.levelMax {
//			var levelFeatures = [ClassFeature]()
//
//			//check for features for all classes
//			if [4, 8, 12, 16, 19].contains(level) {
//				let title = AllClassKey.abilityScoreIncrease.rawValue
//				let dict = allClassLevels[title] as! [String: String]
//				let description = dict["description"]!
//
//				let levelFeature = ClassFeature(title: title, description: description, source: "All Classes")
//
//				levelFeatures.append(levelFeature)
//			}
//
//			//check for class specific features
//			if let classLevel = classLevelDict[String(level)] as? [String:Any] {
//				let levelFeature = getFeatures(forDict: classLevel, source: base)
//
//				levelFeatures.append(contentsOf: levelFeature)
//			}
//
//			//check for path specific features
//			if let pathLevel = pathLevelDict[String(level)] as? [String:Any] {
//				let levelFeature = getFeatures(forDict: pathLevel, source: path)
//
//				levelFeatures.append(contentsOf: levelFeature)
//			}
//
//			// if we haven't found any features, skip this level
//			if levelFeatures.isEmpty { continue }
//			
//			// add the level data to the dictionary
//			// if there's alreay a key for this level, just add the contents
//			if let _ = result[level] {
//				result[level]!.append(contentsOf: levelFeatures) }
//			// if there isn't a key, then we replace the contents with the new group of features
//			else {
//				result[level] = levelFeatures
//			}
//		}
//
//		return result
//	}
//
//	private func getFeatures(forDict dict: [String: Any], source: String) -> [ClassFeature] {
//		var result = [ClassFeature]()
//
//		for feature in dict {
//			guard let description = feature.value as? String
//				else { print("invalid level value for \(source) at level \(feature.key)"); return result }
//
//			let levelFeature = ClassFeature(title: feature.key, description: description, source: source)
//
//			result.append(levelFeature)
//		}
//
//		return result
//	}
//
//	func name() -> String {
//		return "\(path.capitalized) \(base.capitalized)"
//	}
//
//	func baseDescription() -> String {
//		guard let classDict = classData[base] as? [String : Any],
//			let description = classDict["description"] as? String
//			else { print("could not initialize description for \(base)"); return ""	}
//
//		return description
//	}
//
//	func pathDescription() -> String {
//		guard let classDict = classData[base] as? [String : Any],
//			let pathsDict	= classDict["paths"] as? [String : Any],
//			let pathDict	= pathsDict[path] as? [String : Any],
//			let description = pathDict["description"] as? String
//			else { print("could not initialize description for \(path)"); return ""	}
//
//		return description
//	}
//	func color() -> UIColor.AppColor {
//		return UIColor.color(for: availableClass)
//	}
//	func gradient() -> [UIColor] {
//		return UIColor.gradient(for: availableClass)
//	}
//	func skillSelection() -> [String]? {
//		guard let dict = classData[base] as? [String: Any] else { print("could not create dict from \(base)"); return nil }
//		guard let skills = dict["skills"] as? [String] else { print("could not get skills for \(base)"); return nil }
//
//		return skills
//	}
//}
//
//extension Class {
//	struct SpellCastingAttributes {
//		let castingAbility: StatType
//		let initialSpellCount: Int
//		let spellSlots: [(SpellLevel: Int, SlotCount: Int)]
//
//		init?(for base: String) {
//
//			guard let classDict = classData[base] as? [String: Any],
//				let spellcastingDict = classDict["spellcasting"] as? [String : Any]
//				else { return nil }
//			guard let castingAbilityData = spellcastingDict["casting_ability"] as? String,
//				let castingAbility = StatType(rawValue: castingAbilityData),
//				let spellCountData = spellcastingDict["initialSpellCount"] as? String,
//				let initialSpellCount = Int(spellCountData)
//				else { print("failed to initialize casting data for class \(base)."); return nil }
//			guard let slotDict = spellcastingDict["spellSlots"] as? [String : Any ],
//				let slotsForLevel = slotDict["1"] as? [String : String]
//				else { print("failed to initialize spell slot data for class \(base)."); return nil }
//
//			//process the spell slot data
//			var result = [(SpellLevel: Int, SlotCount: Int)]()
//			for (level, slot) in slotsForLevel {
//				guard let level = Int(level), let slot = Int(slot)
//					else { print("could not create spell slot tuple"); continue }
//				result.append((SpellLevel: level, SlotCount: slot))
//			}
//
//			self.castingAbility 		= castingAbility
//			self.initialSpellCount 		= initialSpellCount
//			self.spellSlots				= result
//		}
//	}
//
//	static let EvocationWizard = Class(fromString: "wizard", withPath: "school of evocation")!
//	static let LifeCleric = Class(fromString: "cleric", withPath: "life domain")!
//	static let ChampionFighter = Class(fromString: "fighter", withPath: "champion")!
//	static let RogueThief = Class(fromString: "rogue", withPath: "thief")!
//
//}
//
//enum AvailableClass: String {
//	case fighter, cleric, wizard, rogue
//}
//
//struct ClassFeature {
//	let title: String
//	let description: String
//	let source: String
//}
