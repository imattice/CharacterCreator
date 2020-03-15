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
                    allModifiers.append( Modifier(.increaseStat(stat: Stat(rawValue: modifierData.key)!, value: modifierData.value), from: .race)) }}}
		else {
			//set the name to just be the parent race if no subrace is available
			self.subrace 	= nil
			self.parentRace = parentName.lowercased()  }

		//add modifiers from the parent race
		if let modifiers = parentData["modifiers"] as? [String : Int] {

			for modifierData in modifiers {
                allModifiers.append( Modifier(.increaseStat(stat: Stat(rawValue: modifierData.key)!, value: modifierData.value), from: .race))
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

//		for modifier in modifiers {
//            result += "+ \(modifier.value) \(modifier.type)\n"
//		}

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
				result.append( record.language() )
			}
			if language == "choice" {
				var languageChoice = Language(name: "choice", isSelectable: true)
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

struct RaceRecord {
    let name: String
    let detail: String
    let statModifiers: [Modifier]
    let physicalAttributes: PhysicalAttributes
    let speed: Int
    let hasDarkvision: Bool
    let alignment: Alignment
    let languages: [LanguageChoices]
    let features: [FeatureRecord]
    let subraces: [SubraceRecord]
    
    struct PhysicalAttributes: Codable {
        let age: Age
        let height: String
        let weight: String
        let size: Size
        
        init(from decoder: Decoder) throws {
            do {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let ageArray = try container.decode([String].self, forKey: .age)
                let height = try container.decode(String.self, forKey: .height)
                let weight = try container.decode(String.self, forKey: .weight)
                let maturity = Int(ageArray.first!)!
                let expectancy = Int(ageArray.last!)!
                let size = try container.decode(Size.self, forKey: .size)
                
                self.init(age: Age(maturity: maturity, expectancy: expectancy), height: height, weight: weight, size: size)
            } catch {
                print("error:\(error)")
                throw error
            }
        }
        init(age: Age, height: String, weight: String, size: Size) {
            self.age    = age
            self.height   = height
            self.weight = weight
            self.size   = size
        }
        
        struct Age: Codable {
            let maturity: Int
            let expectancy: Int
        }
    }
 
    static func recordFor(_ race: String) -> RaceRecord? {
        return try! RaceRecord.all()?.filter { $0.name == race }.first
    }

    static func all() throws -> [RaceRecord]? {
        guard let url = Bundle.main.url(forResource: "race",
                                        withExtension: "json")
            else { print("resource not found");
                throw ParsingError.fileNotFound(filepath: Bundle.main.url(forResource: "race", withExtension: "json")!)}
        do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([RaceRecord].self,
                                                  from: data)
                return jsonData
            } catch {
                print("error:\(error)")
                throw error
            }
    }
}

struct SubraceRecord {
    let name: String
    let detail: String
    let statModifiers: [Modifier]
    let features: [FeatureRecord]
}

extension RaceRecord: Codable {
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let name = try container.decode(String.self, forKey: .name)
            let detail = try container.decode(String.self, forKey: .detail)
            
            var modifiers = [Modifier]()
            let modifierData = try container.nestedContainer(keyedBy: Stat.self, forKey: .statModifiers)
            for key in modifierData.allKeys {
                let value = try modifierData.decode(Int.self, forKey: key)
                let effect: Effect = value >= 0 ? .increaseStat(stat: key, value: value) : .decreaseStat(stat: key, value: value)
                modifiers.append(Modifier(effect, from: .race))
            }
            
            let physicalAttributes = try container.decode(PhysicalAttributes.self, forKey: .physicalAttributes)

            let speed = try container.decode(Int.self, forKey: .speed)
            let hasDarkvision = try container.decode(Bool.self, forKey: .hasDarkvision)
            let alignment = try container.decode(Alignment.self, forKey: .alignment)
            let languages = try container.decode([LanguageChoices].self, forKey: .languages)
            
            let features = try container.decode([FeatureRecord].self, forKey: .features)
            
            let subraces = try container.decode([SubraceRecord].self, forKey: .subraces)

            self.init(name: name, detail: detail, statModifiers: modifiers, physicalAttributes: physicalAttributes, speed: speed, hasDarkvision: hasDarkvision, alignment: alignment, languages: languages, features: features, subraces: subraces)
        } catch {
            print("error:\(error)")
            throw error
        }
    }
//    enum CodingKeys: String, CodingKey {
//         case name, detail, physicalAttributes, statModifiers, speed, hasDarkvision, alignment, languages, features, subraces
//     }

}

extension SubraceRecord: Codable {
        init(from decoder: Decoder) throws {
            do {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                
                let name = try container.decode(String.self, forKey: .name)
                let detail = try container.decode(String.self, forKey: .detail)
                let features = try container.decode([FeatureRecord].self, forKey: .features)

                let modifiers = try container.decode([Modifier].self, forKey: .statModifiers)

    //            let modifierContainer = try container.nestedContainer(keyedBy: StatModifier.CodingKeys.self, forKey: .statModifier)
    //            let effect = try modifierContainer.decode(StatModifier.Effect.self, forKey: .effect)
    //            let stat = try modifierContainer.decode(StatModifier.Stat.self, forKey: StatModifier.CodingKeys.stat)
    //            let value = try modifierContainer.decode(Int.self, forKey: StatModifier.CodingKeys.value)
    //            let modifier = StatModifier(effect: effect, stat: stat, value: value, source: .race)
               
                self.init(name: name, detail: detail, statModifiers: modifiers, features: features)
            } catch {
                print("error:\(error)")
                throw error
            }
        }
}


