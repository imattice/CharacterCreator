//
//  Item.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 9/2/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation

struct Item: Codable{
    let name: String
    var count: Int

    internal init(name: String, count: Int) {
        self.name = name
        self.count = count
    }
}

//MARK: - Object Record
///A common ancestor class that holds common properties for all items
///ItemRecord should be used  rather than calling this class directly
class ObjectRecord: Codable {
    ///An identifier for the item
    private(set)
    var id: String = UUID().uuidString
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
    private(set)
    var isMagical: Bool = false
    ///Determines if the item requires attunement by the character
    private(set)
    var requiresAttunement: Bool = false
    ///A type that describes the rarity of the item
    private(set)
    var rarity: Rarity = .common
    ///Indicates the rarity of the item
    enum Rarity: String, Codable {
        case common, uncommon, rare, legendary, artifact
    }
    
    enum CodingKeys: CodingKey {
        case name, description, details, cost, weight, isMagical, requiresAttunement, rarity
    }
    
    internal init(name: String, description: String, details: String, cost: Int, weight: Double, isMagical: Bool = false, requiresAttunement: Bool = false, rarity: ObjectRecord.Rarity = .common) {
        self.name = name
        self.description = description
        self.details = details
        self.cost = cost
        self.weight = weight
        self.isMagical = isMagical
        self.requiresAttunement = requiresAttunement
        self.rarity = rarity
    }
}

///Defines an object that can be collected, disposed and used by a character
final
class ItemRecord: ObjectRecord, Record {
    
    
    enum CodingKeys: CodingKey {
        case name, description, details, cost, weight, isMagical, requiresAttunement, rarity
    }
}

//MARK: - Weapon Record
/// A held item that can be used to grant attack actions
final
class WeaponRecord: ObjectRecord, Record {
    ///Contains the properties of the weapon
    let tags: [Tag]
    ///Indicates the base damage of the weapon
    let damage: Damage
    ///Determines if the weapon requires training to use
    private(set)
    var isSimple: Bool = true
    ///Contains the normal and extended range of the weapon, if it can be used at a distance
    private(set)
    var range: (normal: Int, extended: Int)  = (normal: 5, extended: 5)
    ///Indicates if the weapon can be used at range
    var isRanged: Bool {
        return range.normal > 10 }

    ///Idenitfies a specific property of the weapon
    enum Tag: String, Decodable {
        case ammunition, finesse, heavy, light, loading, thrown, twoHanded, versatile, ranged, reach, special
    }
    
    internal init(name: String, description: String, details: String, cost: Int, weight: Double, isMagical: Bool = false, requiresAttunement: Bool = false, rarity: ObjectRecord.Rarity = .common, tags: [WeaponRecord.Tag], damage: Damage) {
        self.tags = tags
        self.damage = damage
        
        super.init(name: name, description: description, details: details, cost: cost, weight: weight, isMagical: isMagical, requiresAttunement: requiresAttunement, rarity: rarity)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tags       = try container.decode([Tag].self, forKey: .tags)
        self.damage     = try container.decode(Damage.self, forKey: .tags)
        self.isSimple   = try container.decode(Bool.self, forKey: .tags)
        let rangeContainer = try container.nestedContainer(keyedBy: RangedCodingKeys.self, forKey: .range)
        let normalRange = try rangeContainer.decode(Int.self, forKey: .normal)
        let extendedRange = try rangeContainer.decode(Int.self, forKey: .extended)

        self.range      = (normal: normalRange, extended: extendedRange)

        try super.init(from: decoder)
    }
    
    enum CodingKeys: CodingKey {
        case name, description, details, cost, weight, isMagical, requiresAttunement, rarity, tags, damage, isSimple, range
    }
    enum RangedCodingKeys: CodingKey {
        case normal, extended
    }
    
    ///Calculates a tuple containing a range from a string
    /// - Parameter string: Formatted as '000:000'
    /// - Returns: A tuple with maximum normal range (Int) and a maximum extended range (int) based on the point the user is located
    private func range(from string: String) -> (normal: Int, extended: Int)? {
        //ensure the string is formatted correctly
        guard string.matches("^[0-9]+:[0-9]+")
            else { print("Range string does not match pattern '000:000': '\(String(describing: string))'"); return nil }
        let mapped = string.components(separatedBy: ":").map{ Int($0)! }
        return (normal: mapped.first ?? 0, extended: mapped.last ?? 0)
    }
}

//MARK: - Armor Record
/// A worn item that can be used to increase Armor Class
final
class ArmorRecord: ObjectRecord, Record {
    ///The base AC that is granted by the armor
    let baseAC: Int
    ///Indicates if the armor is ligh, medium, or heavy
    let armorStyle: ArmorStyle
    ///Indicates if the armor imposes disadvantage on Stealth checks
    private(set)
    var imposesStealthDisadvantage: Bool                = false
    ///Indicates if DEX can be used when determining total AC
    private(set)
    var addsDex: Bool                                   = true
    ///Indicates the maxium DEX modifier value that can be applied to the total AC when using this armor
    private(set)
    var dexMax: Int?                                    = nil
    ///The value of STR that is required in order to use this armor
    private(set)
    var strRequired: Int                                = 0

    ///Indicates if the armor is ligh, medium, or heavy
    enum ArmorStyle: String, Codable {
        case light, medium, heavy
    }
    
    internal init(name: String, description: String, details: String, cost: Int, weight: Double, isMagical: Bool = false, requiresAttunement: Bool = false, rarity: ObjectRecord.Rarity = .common, baseAC: Int, armorStyle: ArmorRecord.ArmorStyle) {
        self.baseAC = baseAC
        self.armorStyle = armorStyle
        
        super.init(name: name, description: description, details: details, cost: cost, weight: weight, isMagical: isMagical, requiresAttunement: requiresAttunement, rarity: rarity)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.baseAC       = try container.decode(Int.self, forKey: .baseAC)
        self.armorStyle     = try container.decode(ArmorStyle.self, forKey: .armorStyle)
        self.imposesStealthDisadvantage   = try container.decode(Bool.self, forKey: .imposesStealthDisadvantage)
        self.addsDex   = try container.decode(Bool.self, forKey: .addsDex)
        self.dexMax   = try container.decode(Int.self, forKey: .dexMax)
        self.strRequired   = try container.decode(Int.self, forKey: .strRequired)

        try super.init(from: decoder)
    }
    
    enum CodingKeys: CodingKey {
        case name, description, details, cost, weight, isMagical, requiresAttunement, rarity, baseAC, armorStyle, imposesStealthDisadvantage, addsDex, dexMax, strRequired
    }
}

//MARK: - Shield Record
/// A held item that can be used to increase Armor Class
final
class ShieldRecord: ObjectRecord, Record {
    ///The AC bonus that the shield grants when equipped
    let bonusAC: Int
    
    internal init(name: String, description: String, details: String, cost: Int, weight: Double, isMagical: Bool = false, requiresAttunement: Bool = false, rarity: ObjectRecord.Rarity = .common, bonusAC: Int) {
        self.bonusAC = bonusAC
        
        super.init(name: name, description: description, details: details, cost: cost, weight: weight, isMagical: isMagical, requiresAttunement: requiresAttunement, rarity: rarity)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bonusAC       = try container.decode(Int.self, forKey: .bonusAC)

        try super.init(from: decoder)
    }
    
    enum CodingKeys: CodingKey {
        case name, description, details, cost, weight, isMagical, requiresAttunement, rarity, bonusAC
    }
}

//MARK: - Pack Record
///A collection of items that are purchased together
final
class PackRecord: ObjectRecord, Record {
    ///The contents of the pack
    let contents: [Item]
    
    internal init(name: String, description: String, details: String, cost: Int, weight: Double, isMagical: Bool = false, requiresAttunement: Bool = false, rarity: ObjectRecord.Rarity = .common, contents: [Item]) {
        self.contents = contents
        
        super.init(name: name, description: description, details: details, cost: cost, weight: weight, isMagical: isMagical, requiresAttunement: requiresAttunement, rarity: rarity)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contents       = try container.decode([Item].self, forKey: .contents)

        try super.init(from: decoder)    }
    
    enum CodingKeys: CodingKey {
        case name, description, details, cost, weight, isMagical, requiresAttunement, rarity, contents
    }
}

//MARK: - Tool Record
///An item that can be used with proficiency
final
class ToolRecord: ObjectRecord, Record {
    ///Indicates if the tool is artisan, musical, or gaming
    let category: Category?
    
    internal init(name: String, description: String, details: String, cost: Int, weight: Double, isMagical: Bool = false, requiresAttunement: Bool = false, rarity: ObjectRecord.Rarity = .common, category: ToolRecord.Category?) {
        self.category = category
        
        super.init(name: name, description: description, details: details, cost: cost, weight: weight, isMagical: isMagical, requiresAttunement: requiresAttunement, rarity: rarity)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.category       = try container.decode(Category.self, forKey: .category)

        try super.init(from: decoder)
    }
    
    enum CodingKeys: CodingKey {
        case name, description, details, cost, weight, isMagical, requiresAttunement, rarity, category
    }
    
    enum Category: String, Codable {
        case artisan, musical, gaming
    }
}
