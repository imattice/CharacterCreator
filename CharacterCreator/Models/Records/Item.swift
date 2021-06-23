//
//  Item.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 9/2/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

class Item: NSObject, Codable, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    let name: String
    var count: Int = 1

    internal init(name: String, count: Int) {
        self.name = name
        self.count = count
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.count  = try container.decodeIfPresent(Int.self, forKey: .count) ?? 1
    }
    required init?(coder: NSCoder) {
        guard
            let name = coder.decodeObject(forKey: "name") as? String,
            let count = coder.decodeObject(forKey: "count") as? Int
        else { return nil }
        
        self.name = name
        self.count = count
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(count, forKey: "count")
    }
}

//MARK: - Object Record
///A common ancestor class that holds common properties for all items
///ItemRecord should be used rather than calling this class directly
@objc(ObjectRecord)
class ObjectRecord: NSManagedObject, Codable {
    ///A unique identifier for the object
    @NSManaged public var id: String
    ///A name for the object
    @NSManaged public var name: String
    ///A descriptive summary of the appearance of the object
    @NSManaged public var summary: String
    ///Details on the gameplay mechanics of the item
    @NSManaged public var details: String
    ///The cost of the item in copper (used to store to Core Data)
    @NSManaged private var costNumber: NSNumber?
    ///The weight of the item in pounds (used to store to Core Data)
    @NSManaged private var weightNumber: NSNumber?
    ///The cost of the item in copper
    var cost: Int? {
        get {
            guard let costNumber = weightNumber else { return nil }
            return Int(truncating: costNumber) }
        set {
            guard let cost = newValue else { weightNumber = nil; return }
            weightNumber = NSNumber(value: cost) }
    }
    ///The weight of the item in pounds
    var weight: Double? {
        get {
            guard let weight = weightNumber else { return nil }
            return Double(exactly: weight) }
        set {
            guard let weight = newValue else { weightNumber = nil; return }
            weightNumber = NSNumber(value: weight) }
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id                 = UUID().uuidString
        self.name               = try container.decode(String.self, forKey: .name)
        self.summary            = try container.decode(String.self, forKey: .summary)
        self.details            = try container.decode(String.self, forKey: .details)
        self.cost               = try container.decodeIfPresent(Int.self, forKey: .cost)
        self.weight             = try container.decodeIfPresent(Double.self, forKey: .weight)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(summary, forKey: .summary)
        try container.encode(details, forKey: .details)
        try container.encodeIfPresent(cost, forKey: .cost)
        try container .encodeIfPresent(weight, forKey: .weight)
    }
    
    enum CodingKeys: CodingKey {
        case name, summary, details, cost, weight
    }
}

///Defines an object that can be collected, disposed and used by a character
@objc(ItemRecord)
final class ItemRecord: ObjectRecord, Record {
    required convenience init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id                 = UUID().uuidString
        self.name               = try container.decode(String.self, forKey: .name)
        self.summary            = try container.decode(String.self, forKey: .summary)
        self.details            = try container.decode(String.self, forKey: .details)
        self.cost               = try container.decodeIfPresent(Int.self, forKey: .cost)
        self.weight             = try container.decodeIfPresent(Double.self, forKey: .weight)
    }
}

//MARK: - Weapon Record
    ///An model representing static data for a specific trap

/// A held item that can be used to grant attack actions
@objc(WeaponRecord)
final class WeaponRecord: ObjectRecord, Record {
    @NSManaged private var tagsString: String?
    ///Contains the properties of the weapon
    var tags: [Tag] {
        get {
            guard let tags = tagsString else { return [Tag]() }
            return tags.split(separator: ",").map { Tag(rawValue: String($0))! } }
        set {
            guard !tags.isEmpty else { tagsString = nil; return }
            tagsString = newValue.map { $0.rawValue }.joined(separator: ",") }
    }
    @NSManaged private var damageString: String
    ///Indicates the base damage of the weapon
    var damage: Damage {
        get { return try! Damage(damageString) }
        set { damageString = newValue.rollString(withType: true)}
    }
    ///Determines if the weapon requires training to use
    @NSManaged public var isSimple: Bool
    @NSManaged private var normalRange: Int64
    @NSManaged private var extendedRange: Int64
    ///Contains the normal and extended range of the weapon, if it can be used at a distance
    
    var range: (normal: Int, extended: Int) {
        get { return (normal: Int(normalRange), extended: Int(extendedRange)) }
        set {   normalRange = Int64(newValue.normal)
            extendedRange = Int64(newValue.extended)
        }
    }
    ///Indicates if the weapon can be used at range
    var isRanged: Bool {
        return range.normal > 10 }

    ///Idenitfies a specific property of the weapon
    enum Tag: String, Decodable {
        case ammunition, finesse, heavy, light, loading, thrown, twoHanded, versatile, ranged, reach, special
    }
    
    required convenience
    init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        
        
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.id                 = UUID().uuidString
        self.name               = try container.decode(String.self, forKey: .name)
        self.summary            = try container.decode(String.self, forKey: .summary)
        self.details            = try container.decode(String.self, forKey: .details)
        self.cost               = try container.decodeIfPresent(Int.self, forKey: .cost)
        self.weight             = try container.decodeIfPresent(Double.self, forKey: .weight)
        self.tagsString         = ""
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
    }
    
    enum CodingKeys: CodingKey {
        case name, summary, details, cost, weight, tags, damage, isSimple, range
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
@objc(ArmorRecord)
final
class ArmorRecord: ObjectRecord, Record {
    ///The base AC that is granted by the armor
    @NSManaged public var baseAC: Int
    @NSManaged private var armorStyleString: String
    ///Indicates if the armor is ligh, medium, or heavy
    var armorStyle: ArmorStyle {
        get { return ArmorStyle(rawValue: armorStyleString)! }
        set { armorStyleString = newValue.rawValue }
    }
    ///Indicates if the armor imposes disadvantage on Stealth checks
    @NSManaged public var imposesStealthDisadvantage: Bool
    ///Indicates if DEX can be used when determining total AC
    @NSManaged public var addsDex: Bool
    ///Indicates the maxium DEX modifier value that can be applied to the total AC when using this armor
    @NSManaged private var dexMaxNumber: NSNumber?
    var dexMax: Int? {
        get {
            guard let dexMax = dexMaxNumber else { return nil }
            return Int(truncating: dexMax) }
        set {
            guard let dexMax = newValue else { dexMaxNumber = nil; return }
            dexMaxNumber = NSNumber(value: dexMax) }
    }
    
    ///The value of STR that is required in order to use this armor
    @NSManaged public var strRequired: Int

    ///Indicates if the armor is ligh, medium, or heavy
    enum ArmorStyle: String, Codable {
        case light, medium, heavy
    }
    
    required convenience
    init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id                 = UUID().uuidString
        self.name               = try container.decode(String.self, forKey: .name)
        self.summary            = try container.decode(String.self, forKey: .summary)
        self.details            = try container.decode(String.self, forKey: .details)
        self.cost               = try container.decodeIfPresent(Int.self, forKey: .cost)
        self.weight             = try container.decodeIfPresent(Double.self, forKey: .weight)
        self.baseAC       = try container.decode(Int.self, forKey: .baseAC)
        self.armorStyle     = try container.decode(ArmorStyle.self, forKey: .armorStyle)
        self.imposesStealthDisadvantage   = try container.decodeIfPresent(Bool.self, forKey: .imposesStealthDisadvantage) ?? false
        self.addsDex   = try container.decodeIfPresent(Bool.self, forKey: .addsDex) ?? true
        self.dexMax   = try container.decodeIfPresent(Int.self, forKey: .dexMax)
        self.strRequired   = try container.decodeIfPresent(Int.self, forKey: .strRequired) ?? 0
    }
    
    enum CodingKeys: CodingKey {
        case name, summary, details, cost, weight, baseAC, armorStyle, imposesStealthDisadvantage, addsDex, dexMax, strRequired
    }
}

//MARK: - Shield Record
/// A held item that can be used to increase Armor Class
@objc(ShieldRecord)
final
class ShieldRecord: ObjectRecord, Record {
    ///The AC bonus that the shield grants when equipped
    @NSManaged public var bonusAC: Int
    
    required convenience
    init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id                 = UUID().uuidString
        self.name               = try container.decode(String.self, forKey: .name)
        self.summary            = try container.decode(String.self, forKey: .summary)
        self.details            = try container.decode(String.self, forKey: .details)
        self.cost               = try container.decodeIfPresent(Int.self, forKey: .cost)
        self.weight             = try container.decodeIfPresent(Double.self, forKey: .weight)
        self.bonusAC       = try container.decode(Int.self, forKey: .bonusAC)
    }
    
    enum CodingKeys: CodingKey {
        case name, summary, details, cost, weight, bonusAC
    }
}

//MARK: - Pack Record
///A collection of items that are purchased together
@objc(PackRecord)
final
class PackRecord: ObjectRecord, Record {
    ///The contents of the pack
    @NSManaged private var contentsJSON: String
    var contents: [Item] {
        get { return (try? JSONDecoder().decode([Item].self, from: Data(contentsJSON.utf8))) ?? [Item]() }
        set {
            do {
               let data = try JSONEncoder().encode(newValue)
               contentsJSON = String(data: data, encoding:.utf8)!
           } catch { contentsJSON = "" }
        }
    }
    
    required convenience
    init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id                 = UUID().uuidString
        self.name               = try container.decode(String.self, forKey: .name)
        self.summary            = try container.decode(String.self, forKey: .summary)
        self.details            = try container.decode(String.self, forKey: .details)
        self.cost               = try container.decodeIfPresent(Int.self, forKey: .cost)
        self.weight             = try container.decodeIfPresent(Double.self, forKey: .weight)
        self.contents       = try container.decode([Item].self, forKey: .contents)
    }
    enum CodingKeys: CodingKey {
        case name, summary, details, cost, weight, contents
    }
}

//MARK: - Tool Record
///An item that can be used with proficiency
@objc(ToolRecord)
final
class ToolRecord: ObjectRecord, Record {
    @NSManaged private var categoryString: String
    ///Indicates if the tool is artisan, musical, or gaming
    var category: Category {
        get { return Category(rawValue: categoryString)! }
        set { categoryString = newValue.rawValue }
    }
    required convenience
    init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id                 = UUID().uuidString
        self.name               = try container.decode(String.self, forKey: .name)
        self.summary            = try container.decode(String.self, forKey: .summary)
        self.details            = try container.decode(String.self, forKey: .details)
        self.cost               = try container.decodeIfPresent(Int.self, forKey: .cost)
        self.weight             = try container.decodeIfPresent(Double.self, forKey: .weight)
        self.category       = try container.decodeIfPresent(Category.self, forKey: .category) ?? .other
    }
    
    enum CodingKeys: CodingKey {
        case name, summary, details, cost, weight, category
    }
    
    enum Category: String, Codable {
        case artisan, musical, gaming, other
    }
}

//MARK: - Poison Record
///An object representing static information for a poison that can be used in game
@objc(PoisonRecord)
final
class PoisonRecord: ObjectRecord, Record {
    @NSManaged private var applicationString: String
    ///Indicates how the poison's effects are applied
    var applicationType: PoisonApplication {
        get { return PoisonApplication(rawValue: applicationString)! }
        set { applicationString = newValue.rawValue }
    }
        
    required convenience
    init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        let container               = try decoder.container(keyedBy: CodingKeys.self)
        self.id                 = UUID().uuidString
        self.name               = try container.decode(String.self, forKey: .name)
        self.summary            = try container.decode(String.self, forKey: .summary)
        self.details            = try container.decode(String.self, forKey: .details)
        self.cost               = try container.decodeIfPresent(Int.self, forKey: .cost)
        self.weight             = try container.decodeIfPresent(Double.self, forKey: .weight)
        self.applicationType        = try container.decode(PoisonApplication.self, forKey: .applicationType)
    }
    
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

    enum CodingKeys: CodingKey {
        case name, summary, details, cost, weight, applicationType
    }
}
//MARK: - Magic Item Record
@objc(MagicalItemRecord)
final
class MagicalItemRecord: NSManagedObject, Record {
    ///An identifier for the item
    @NSManaged public var id: String
    ///A name for the item
    @NSManaged public var name: String
    ///A description of the item
    @NSManaged public var summary: String
    ///Provides details on the gameplay mechanics of the item
    @NSManaged public var details: String
    @NSManaged private var itemTypeString: String
    var itemType: ItemType {
        get { return ItemType(rawValue: itemTypeString)! }
        set { itemTypeString = newValue.rawValue }
    }
    ///Indicates any restictions for the item, such as only being plate armor
    @NSManaged public var restrictions: String?
    @NSManaged private var rarityString: String
    ///Indicates the rarity of the item
    var rarity: Rarity {
        get { return Rarity(rawValue: rarityString)! }
        set { rarityString = newValue.rawValue }
    }
    ///Indicates if the item requires attunemnt to be used
    @NSManaged public var requiresAttunement: Bool
    
    required convenience
    init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        self.name = try container.decode(String.self, forKey: .name)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.details = try container.decode(String.self, forKey: .details)
        self.restrictions = try container.decodeIfPresent(String.self, forKey: .restrictions)
        self.rarity = try container.decode(Rarity.self, forKey: .rarity)
        self.requiresAttunement = try container.decodeIfPresent(Bool.self, forKey: .requiresAttunement) ?? false
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(summary, forKey: .summary)
        try container.encode(details, forKey: .details)
        try container.encode(restrictions, forKey: .restrictions)
        try container.encode(rarity, forKey: .rarity)
        try container.encode(requiresAttunement, forKey: .requiresAttunement)
    }
    
    ///Indicates the rarity of the item
    enum Rarity: String, Codable {
        case common, uncommon, rare, veryRare, legendary, artifact
    }
    
    enum CodingKeys: CodingKey {
        case name, summary, details, restrictions, rarity, requiresAttunement
    }

    
    enum ItemType: String, Codable {
        case armor, weapon, item, rod, poison, potion, ring, scroll, staff, wand
    }
}
