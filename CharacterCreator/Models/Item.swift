//
//  Item.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 9/2/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation

struct Item: Codable {
    let name: String
    var count: Int = 1

    internal init(name: String, count: Int) {
        self.name = name
        self.count = count
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.count  = try container.decodeIfPresent(Int.self, forKey: .count) ?? 1
    }
    
}

//MARK: - Object Record
///A common ancestor class that holds common properties for all items
///ItemRecord should be used  rather than calling this class directly
class ObjectRecord: Codable {
    ///An identifier for the item
    let id: String = UUID().uuidString
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
    let isMagical: Bool
    ///Determines if the item requires attunement by the character
    let requiresAttunement: Bool
    ///A type that describes the rarity of the item
    let rarity: Rarity
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name               = try container.decode(String.self, forKey: .name)
        self.description        = try container.decode(String.self, forKey: .description)
        self.details            = try container.decode(String.self, forKey: .details)
        self.cost               = try container.decode(Int.self, forKey: .cost)
        self.weight             = try container.decode(Double.self, forKey: .weight)
        self.isMagical          = try container.decodeIfPresent(Bool.self, forKey: .isMagical) ?? false
        self.requiresAttunement = try container.decodeIfPresent(Bool.self, forKey: .requiresAttunement) ?? false
        self.rarity             = try container.decodeIfPresent(Rarity.self, forKey: .rarity) ?? .common
    }
}

///Defines an object that can be collected, disposed and used by a character
final
class ItemRecord: ObjectRecord, Record {
    required
    init(from decoder: Decoder) throws {
        try super.init(from: decoder)
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
    let isSimple: Bool
    ///Contains the normal and extended range of the weapon, if it can be used at a distance
    let range: (normal: Int, extended: Int)
    ///Indicates if the weapon can be used at range
    var isRanged: Bool {
        return range.normal > 10 }

    ///Idenitfies a specific property of the weapon
    enum Tag: String, Decodable {
        case ammunition, finesse, heavy, light, loading, thrown, twoHanded, versatile, ranged, reach, special
    }
    
    required
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        
        self.tags           = try container.decodeIfPresent([Tag].self, forKey: .tags)                          ?? [Tag]()
        self.damage         = try container.decode(Damage.self, forKey: .damage)
        self.isSimple       = try container.decodeIfPresent(Bool.self, forKey: .isSimple)                       ?? true
        if let rangeContainer  = try? container.nestedContainer(keyedBy: RangedCodingKeys.self, forKey: .range) {
            let normalRange     = try rangeContainer.decodeIfPresent(Int.self, forKey: .normal)                     ?? 5
            let extendedRange   = try rangeContainer.decodeIfPresent(Int.self, forKey: .extended)                   ?? 5
            self.range      = (normal: normalRange, extended: extendedRange)
        } else {
            self.range      = (normal: 5, extended: 5)
        }
        try super.init(from: decoder)
    }
    
    enum CodingKeys: CodingKey {
        case tags, damage, isSimple, range
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
    let imposesStealthDisadvantage: Bool
    ///Indicates if DEX can be used when determining total AC
    let addsDex: Bool
    ///Indicates the maxium DEX modifier value that can be applied to the total AC when using this armor
    let dexMax: Int?
    ///The value of STR that is required in order to use this armor
    let strRequired: Int

    ///Indicates if the armor is ligh, medium, or heavy
    enum ArmorStyle: String, Codable {
        case light, medium, heavy
    }
    
    required
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.baseAC       = try container.decode(Int.self, forKey: .baseAC)
        self.armorStyle     = try container.decode(ArmorStyle.self, forKey: .armorStyle)
        self.imposesStealthDisadvantage   = try container.decodeIfPresent(Bool.self, forKey: .imposesStealthDisadvantage) ?? false
        self.addsDex   = try container.decodeIfPresent(Bool.self, forKey: .addsDex) ?? true
        self.dexMax   = try container.decodeIfPresent(Int.self, forKey: .dexMax)
        self.strRequired   = try container.decodeIfPresent(Int.self, forKey: .strRequired) ?? 0

        try super.init(from: decoder)
    }
    
    enum CodingKeys: CodingKey {
        case baseAC, armorStyle, imposesStealthDisadvantage, addsDex, dexMax, strRequired
    }
}

//MARK: - Shield Record
/// A held item that can be used to increase Armor Class
final
class ShieldRecord: ObjectRecord, Record {
    ///The AC bonus that the shield grants when equipped
    let bonusAC: Int
    
    required
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bonusAC       = try container.decode(Int.self, forKey: .bonusAC)

        try super.init(from: decoder)
    }
    
    enum CodingKeys: CodingKey {
        case bonusAC
    }
}

//MARK: - Pack Record
///A collection of items that are purchased together
final
class PackRecord: ObjectRecord, Record {
    ///The contents of the pack
    let contents: [Item]
    
    required
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.contents       = try container.decode([Item].self, forKey: .contents)

        try super.init(from: decoder)    }
    
    enum CodingKeys: CodingKey {
        case contents
    }
}

//MARK: - Tool Record
///An item that can be used with proficiency
final
class ToolRecord: ObjectRecord, Record {
    ///Indicates if the tool is artisan, musical, or gaming
    let category: Category?
    
    required
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.category       = try container.decodeIfPresent(Category.self, forKey: .category)

        try super.init(from: decoder)
    }
    
    enum CodingKeys: CodingKey {
        case category
    }
    
    enum Category: String, Codable {
        case artisan, musical, gaming
    }
}

//MARK: - Poison Record
///An object representing static information for a poison that can be used in game
final
class PoisonRecord: ObjectRecord, Record {
    ///Indicates how the poison's effects are applied
    let applicationType: PoisonApplication
    
    ///Indicates how the poison's effects are applied
    enum PoisonApplication: String, Codable {
        case contact, ingested, inhaled, injury
        
        var description: String {
            switch self {
            case .contact: return "Contact poison can be smeared on an object and remains potent until it is touched or washed off. A creature that touches contact poison with exposed skin suffers its effects."
            case .ingested: return "A creature must swallow an entire dose of ingested poison to suffer its effects. The dose can be delivered in food or a liquid. You may decide that a partial dose has a reduced effect, such as allowing advantage on the saving throw or dealing only half damage on a failed save."
            case .inhaled: return "These poisons are powders or gases that take effect when inhaled. Blowing the powder or releasing the gas subjects creatures in a 5-­‐‑foot cube to its effect. The resulting cloud dissipates immediately afterward. Holding one’s breath is ineffective against inhaled poisons, as they affect nasal membranes, tear ducts, and other parts of the body."
            case .injury: return "Injury poison can be applied to weapons, ammunition, trap components, and other objects that deal piercing or slashing damage and remains potent until delivered through a wound or washed off. A creature that takes piercing or slashing damage from an object coated with the poison is exposed to its effects."
            }
        }
    }
    
    required
    init(from decoder: Decoder) throws {
        let container               = try decoder.container(keyedBy: CodingKeys.self)
        self.applicationType        = try container.decode(PoisonApplication.self, forKey: .applicationType)

        try super.init(from: decoder)
    }
    enum CodingKeys: CodingKey {
        case applicationType
    }
}
