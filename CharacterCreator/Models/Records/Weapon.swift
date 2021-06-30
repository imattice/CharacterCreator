//
//  Weapon.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/22/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

/// An equippable item that can be used to grant attack actions
struct Weapon {
    
}


//MARK: - Weapon Record
///An model representing static data for a specific weapon
@objc(WeaponRecord)
final class WeaponRecord: ObjectRecord, Record {
    ///The core data representation of the tags property
    @NSManaged private var cdTags: String
    ///Contains the attribute tags of the weapon
    var tags: [Tag] {
        get { return (try? JSONDecoder().decode([Tag].self, from: Data(cdTags.utf8))) ?? [Tag]() }
        set {
            do {
               let json = try JSONEncoder().encode(newValue)
               cdTags = String(data: json, encoding:.utf8)!
           } catch { cdTags = "" }
        }
    }
    ///The core data representation of the damage property
    @NSManaged private var cdDamage: String
    ///Indicates the base damage of the weapon
    var damage: Damage {
        get { return try! Damage(cdDamage) }
        set { cdDamage = newValue.rollString(withType: true) }
    }
    ///Determines if the weapon requires martial training to use
    @NSManaged public var isSimple: Bool
    ///The core data representation of the range of the weapon
    @NSManaged private var cdRange: String
    ///Contains the normal and extended range of the weapon, if it can be used at a distance
    var range: Range {
        get { return (try? JSONDecoder().decode(Range.self, from: Data(cdRange.utf8))) ?? Range(normal: 5, extended: 5) }
        set {
            do {
               let json = try JSONEncoder().encode(newValue)
               cdRange = String(data: json, encoding:.utf8)!
           } catch { cdRange = "" }
        }
    }
    ///Indicates if the weapon can be used at range
    var isRanged: Bool {
        return range.normal > 10 }

    ///Idenitfies a specific property of the weapon
    enum Tag: String, Codable {
        case ammunition, finesse, heavy, light, loading, thrown, twoHanded, versatile, ranged, reach, special
        ///Describes the parameters of the tag
        var description: String {
            switch self {
            case .ammunition: return "You can use a weapon that has the ammunition property to make a ranged attack only if you have ammunition to fire from the weapon. Each time you attack with the weapon, you expend one piece of ammunition. Drawing the ammunition from a quiver, case, or other container is part of the attack (you need a free hand to load a one-handed weapon). At the end of the battle, you can recover half your expended ammunition by taking a minute to search the battlefield.\nIf you use a weapon that has the ammunition property to make a melee attack, you treat the weapon as an improvised weapon. A sling must be loaded to deal any damage when used in this way."
            case .finesse: return "When making an attack with a finesse weapon, you use your choice of your Strength or Dexterity modifier for the attack and damage rolls. You must use the same modifier for both rolls."
            case .heavy: return "Small creatures have disadvantage on attack rolls with heavy weapons. A heavy weapon’s size and bulk make it too large for a Small creature to use effectively."
            case .light: return "A light weapon is small and easy to handle, making it ideal for use when fighting with two weapons."
            case .loading: return "Because of the time required to load this weapon, you can fire only one piece of ammunition from it when you use an action, bonus action, or reaction to fire it, regardless of the number of attacks you can normally make."
            case .ranged: return "A weapon that can be used to make a ranged attack has a range in parentheses after the ammunition or thrown property. The range lists two numbers. The first is the weapon’s normal range in feet, and the second indicates the weapon’s long range. When attacking a target beyond normal range, you have disadvantage on the attack roll. You can’t attack a target beyond the weapon’s long range."
            case .reach: return "This weapon adds 5 feet to your reach when you attack with it, as well as when determining your reach for opportunity attacks with it."
            case .special: return "A weapon with the special property has unusual rules governing its use, explained in the weapon’s description."
            case .thrown: return "If a weapon has the thrown property, you can throw the weapon to make a ranged attack. If the weapon is a melee weapon, you use the same ability modifier for that attack roll and damage roll that you would use for a melee attack with the weapon. For example, if you throw a handaxe, you use your Strength, but if you throw a dagger, you can use either your Strength or your Dexterity, since the dagger has the finesse property."
            case .twoHanded: return "This weapon requires two hands when you attack with it."
            case .versatile: return "This weapon can be used with one or two hands. A damage value in parentheses appears with the property—the damage when the weapon is used with two hands to make a melee attack."
            }
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

        let container   = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.name       = try container.decode(String.self, forKey: .name)
        self.summary    = try container.decode(String.self, forKey: .summary)
        self.details    = try container.decode(String.self, forKey: .details)
        self.cost       = try container.decodeIfPresent(Int.self, forKey: .cost)
        self.weight     = try container.decodeIfPresent(Double.self, forKey: .weight)
        self.tags       = try container.decodeIfPresent([Tag].self, forKey: .tags) ?? [Tag]()
        self.damage     = try container.decode(Damage.self, forKey: .damage)
        self.isSimple   = try container.decodeIfPresent(Bool.self, forKey: .isSimple)                       ?? true
        self.range      = try container.decodeIfPresent(Range.self, forKey: .range) ?? Range(normal: 5, extended: 5)
    }
    
    struct Range: Codable {
        ///The normal range of the weapon
        let normal: Int
        ///The extended range of the weapon
        let extended: Int
    }
    
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(tags, forKey: .tags)
        try container.encode(damage, forKey: .damage)
        try container.encode(isSimple, forKey: .isSimple)
        try container.encode(range, forKey: .range)
    }
        
    enum CodingKeys: CodingKey {
        case id, name, summary, details, cost, weight, tags, damage, isSimple, range
    }
}
