//
//  Race.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
import RealmSwift
import CoreData

typealias Subrace = Race

struct Race {
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
                result.append( Language(name: record.name!) )
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


	static let HillDwarf 			= Race(fromParent: "dwarf", withSubrace: "hill")!
	static let MountianDwarf		= Race(fromParent: "dwarf", withSubrace: "mountian")!
	static let HighElf				= Race(fromParent: "elf", withSubrace: "high")!
	static let WoodElf				= Race(fromParent: "elf", withSubrace: "wood")!
	static let LightfootHalfling	= Race(fromParent: "halfling", withSubrace: "lightfoot")!
	static let StoutHalfling		= Race(fromParent: "halfling", withSubrace: "stout")!
	static let Human				= Race(fromParent: "human", withSubrace: nil)
}

final
class RaceRecord: NSManagedObject, Record, Decodable {
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var detail: String?
    @NSManaged public var hasDarkvision: Bool
    @NSManaged public var descriptive: Descriptive?
    @NSManaged private var sizeString: String?
    @NSManaged public var baseLanguages: [String]?
    @NSManaged public var features: [Feature]?


    //https://medium.com/@rezafarahani/store-array-of-custom-object-in-coredata-bea77b9eb629
    var modifiers: [Modifier]?
    
    var size: CreatureSize  {
        get { return CreatureSize(rawValue: sizeString!) ?? .tiny }
        set { sizeString = newValue.rawValue }
    }
    
//    var baseLanguages: [String] {
//        get { return languagesString!.split(separator: ",") }
//        set { sizeString = newValue.rawValue }
//    }
    
    required convenience
    init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw JSONError.missingManagedObjectContextForDecoder }

        self.init(context: context)
        
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.id             = UUID().uuidString
        self.name           = try container.decode(String.self, forKey: .name)
        self.detail         = try container.decode(String.self, forKey: .description)

        let age             = try container.decode(String.self, forKey: .age)
        let alignment       = try container.decode(String.self, forKey: .alignment)
        let physique        = try container.decode(String.self, forKey: .physique)
        self.descriptive    = Descriptive(age: age, alignment: alignment, physique: physique)

        self.sizeString     =  try container.decode(String.self, forKey: .size)
//CreatureSize(rawValue: try container.decode(String.self, forKey: .size))!
        self.hasDarkvision  = try container.decodeIfPresent(Bool.self, forKey: .hasDarkvision) ?? false
        
        let statModifierContainer = try container.nestedContainer(keyedBy: AbilityScore.Name.self, forKey: .statIncrease)
        self.modifiers = AbilityScoreModifier.decoded(from: statModifierContainer)
        
        let featureContainer = try container.nestedUnkeyedContainer(forKey: .features)
        self.features = try Feature.decoded(from: featureContainer)

        var languages = [String]()
        var languageContainer = try container.nestedUnkeyedContainer(forKey: .baseLanguages)
        while !languageContainer.isAtEnd {
            let language = try languageContainer.decode(String.self)
            languages.append(language)
        }
        self.baseLanguages = languages
    }
    
    ///holds descriptive references of average attributes for this race
    @objc(RaceRecordDescriptive)
    class Descriptive: NSObject, NSSecureCoding {
        let age: String
        let alignment: String
        let physique: String
        
        init(age: String, alignment: String, physique: String) {
            self.age = age
            self.alignment = alignment
            self.physique = physique
        }
        
        static var supportsSecureCoding: Bool = true
        
        required init?(coder: NSCoder) {
            guard
                let age = coder.decodeObject(of: [NSString.self], forKey: "age") as? String,
                let alignment = coder.decodeObject(of: [NSString.self], forKey: "alignment") as? String,
                let physique = coder.decodeObject(of: [NSString.self], forKey: "physique") as? String
            else {  return nil  }
            
            self.age = age
            self.alignment = alignment
            self.physique = physique
        }
        
        func encode(with coder: NSCoder) {
            coder.encode(age, forKey: "age")
            coder.encode(alignment, forKey: "alignment")
            coder.encode(physique, forKey: "physique")
        }
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RaceRecord> {
        return NSFetchRequest<RaceRecord>(entityName: "RaceRecord")
    }
    
    enum CodingKeys: CodingKey {
        case id, name, description, age, alignment, physique, modifiers, size, hasDarkvision, features, baseLanguages, statIncrease
    }
}


///descrbes unique attribtue for a specific race or class
class Feature: NSObject {
    let title: String
    let detail: String
    
    init(title: String, detail: String) {
        self.title = title
        self.detail  = detail
    }
    
    static
    func decoded(from container: UnkeyedDecodingContainer) throws -> [Feature] {
        var mutableContainer = container
        var features = [Feature]()
        while !mutableContainer.isAtEnd {
            do {
                let feature = try mutableContainer.nestedContainer(keyedBy: FeatureCodingKeys.self)
                let title = try feature.decode(String.self, forKey: .title)
                let description = try feature.decode(String.self, forKey: .description)
                features.append(Feature(title: title, detail: description))
            } catch {
                throw error
            }
        }
        return features
    }

    
    enum FeatureCodingKeys: CodingKey {
        case title, description
    }
}

enum CreatureSize: String {
    case tiny, small, medium, large, huge, gargantuan
}
//
//struct SubraceRecord: Codable {
//    let id: String
//    let name: String
//    let description: String
//    let modifiers: [Modifier]
//}

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
