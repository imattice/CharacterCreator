//
//  Item.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 9/2/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//


//Option 1: Mark ItemRecord as final; add ItemRecord properties to all subclasses
//Option 2: Prevent ItemRecord from conforming to Record; find another way to get Record confirmance, such as duplicating Record protocol code, which would be bad form
//Option 3: Ignore the problem for now, since the ideal data flow will not be to call Records from JSON and instead from a data store like Core Data


import Foundation

class Item {
    let name: String
    var count: Int
    
    internal init(name: String, count: Int) {
        self.name = name
        self.count = count
    }
}
//MARK: - Item Record
///defines an object that can be collected, disposed and used by a character
class ItemRecord: Codable {
    ///An identifier for the item
    let id: String //= UUID().uuidString
    ///A name for the item
	let name: String
    ///A description of the item
	let description: String
    ///Provides details on the gameplay mechanics of the item
    let details: String
    ///The cost of the item in copper
    let cost: Int
    ///The weight of the item in pounds
    let weight: Double
    ///Determinees if the item has magical properties
    let isMagical: Bool //= false
    ///Determines if the item requires attunement by the character
    let requiresAttunement: Bool //= false
    ///A type that describes the rarity of the item
    let rarity: Rarity //= .common
    ///Indicates the rarity of the item
    enum Rarity: String, Codable {
        case common, uncommon, rare, legendary, artifact
    }
    
    internal init(id: String = UUID().uuidString, name: String, description: String, details: String, cost: Int, weight: Double, isMagical: Bool = false, requiresAttunement: Bool, rarity: ItemRecord.Rarity = .common) {
        self.id = id
        self.name = name
        self.description = description
        self.details = details
        self.cost = cost
        self.weight = weight
        self.isMagical = isMagical
        self.requiresAttunement = requiresAttunement
        self.rarity = rarity
    }
    
    ///Return all records parsed from JSON
    static
    func all() -> [ItemRecord] {
        do {
            return try parseAllFromJSON()
        } catch {
            print(error)
            return [Self]()
        }
    }

    ///Returns a specific record of the given name
    static
    func record(for name: String) -> ItemRecord? {
        return all().filter { $0.name == name }.first
    }
    
    ///Converts JSON file data to Objects
    static
    func parseAllFromJSON() throws -> [ItemRecord] {
        //a simplistic pluralizer to transform the class record name into the json file name
        //i.e. this should return languages.json from LanguageRecord and classes.json from ClassRecord
        let filename: String = {
            let name = String(describing: Self.self).dropLast(6).lowercased()
            return name.last == "s" ? name + "es" : name + "s"
        }()

        guard let path = Bundle.main.path(forResource: filename, ofType: "json")
        else { print("file not found for \(filename).json"); throw JSONError.fileNotFound }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
            return try JSONDecoder().decode([Self].self, from: data)
        }
        catch {
            print("error while parsing JSON for file \(filename).json")
            print(error)
            throw JSONError.parsingError
        }
    }
}

//MARK: - Weapon Record
/// A held item that can be used to grant attack actions
final
class WeaponRecord: ItemRecord, Record {
    ///Contains the properties of the weapon
    let tags: [Tag]
    ///Indicates the base damage of the weapon
    let damage: Damage
    ///Determines if the weapon requires training to use
    let isSimple: Bool = true
    ///Contains the normal and extended range of the weapon, if it can be used at a distance
    let range: (normal: Int, extended: Int)  = (normal: 5, extended: 5)
    ///Indicates if the weapon can be used at range
    lazy var isRanged: Bool {
        return range.normal > 10 }

    ///Idenitfies a specific property of the weapon
    enum Tag: String {
        case ammunition, finesse, heavy, light, loading, thrown, twoHanded, versatile, ranged, reach, special
    }
    
    ///Calculates a tuple containing a range from a string
    /// - Parameter string: Formatted as '000:000'
    /// - Returns: A tuple with maximum normal range (Int) and a maximum extended range (int) based on the point the user is located
    private func range(from string: String) -> (normal: Int, extended: Int)? {
        //ensure the string is formatted correctly
        guard string.matches("^[0-9]+:[0-9]+")
            else { print("Range string does not match pattern '000:000': '\(String(describing: string))'"); return nil }
        let mapped = trimmed.componentes(separatedBy: ":").map{ Int($0)! }
        return (normal: mapped.first ?? 0, extended: mapped.last ?? 0)
    }
}

//MARK: - Armor Record
/// A worn item that can be used to increase Armor Class
final
class ArmorRecord: Item, Record {
    ///The base AC that is granted by the armor
    let baseAC: Int
    ///Indicates if the armor is ligh, medium, or heavy
    let armorStyle: ArmorStyle
    ///Indicates if the armor imposes disadvantage on Stealth checks
    let imposesStealthDisadvantage: Bool                = false
    ///Indicates if DEX can be used when determining total AC
    let addsDex: Bool                                   = true
    ///Indicates the maxium DEX modifier value that can be applied to the total AC when using this armor
    let dexMax: Int?                                    = nil
    ///The value of STR that is required in order to use this armor
    let strRequired: Int                                = 0

    ///Indicates if the armor is ligh, medium, or heavy
    enum ArmorStyle: String {
        case light, medium, heavy
    }
}

//MARK: - Shield Record
/// A held item that can be used to increase Armor Class
final
class ShieldRecord: Item, Record {
    ///The AC bonus that the shield grants when equipped
    let bonusAC: Int
}

//MARK: - Pack Record
///A collection of items that are purchased together
final
class PackRecord: Record {
    ///An identifier for the pack
    let id: String = UUID().uuidString
    ///The name of the pack
    let name: String
    ///A description for the pack
    let description: String
    ///The cost of the pack in copper
    let cost: Int
    ///The contents of the pack
    let contents: [Item]
}

//MARK: - Tool Record
///An item that can be used with proficiency
final
class ToolRecord: Item, Record {
    ///Indicates if the tool is artisan, musical, or gaming
    let category: Category?
    
    enum Category {
        case artisan, musical, gaming
    }
}
