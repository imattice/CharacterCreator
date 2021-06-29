//
//  Spell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/7/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData


struct Spell {

}
///An object holding data for spells
@objc(SpellRecord)
final
class SpellRecord: NSManagedObject, Record {
    ///An id for the spell
    @NSManaged public var id: String
    ///The name of the spell
    @NSManaged public var name: String
    ///A description of the spell
    @NSManaged public var summary: String
    ///The level of the spell
    @NSManaged public var level: Int
    ///The core data representation of the school property
    @NSManaged private var cdSchool: String
    ///The school of magic for the spell
    var school: SpellSchool {
        get { return SpellSchool(rawValue: cdSchool)! }
        set { cdSchool = newValue.rawValue }
    }
    ///Indicates if the spell can be cast as ritual
    @NSManaged public var isRitual: Bool
    ///The time it takes to cast the spell in seconds
    ///0 indicates the spell can be cast as a reaction
    ///3 indicates the spell can be cast as a bonus action
    @NSManaged public var castTime: Int
    ///The maximum range of the spell in feet
    ///-1 indicates the spell's range is infinite
    ///0 indicates the spell can only be cast on self
    @NSManaged public var range: Int
    ///Indicates if the spell requires the caster use concentration to maintain the spell for the duration
    @NSManaged public var requiresConcentration: Bool
    ///The maxium duration the spell can last, in seconds
    ///-1 indicates the spell lasts until it is dispelled
    ///0 indicates that the spell is instantaneous and does not linger
    @NSManaged public var duration: Int
    ///The list of components that is required by the spell
    ///V = Verbal, S = Somatic, M = Material
    @NSManaged public var components: String
    ///The list of materials, if necessary
    @NSManaged public var materials: String?
    ///A description of the effect if the spell is cast using a slot above its level
    @NSManaged public var upcast: String?
    
    required convenience
    init(from decoder: Decoder) throws {
        guard
        let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
        let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
        let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
    else { fatalError("Failed to decode User") }

    self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id                     = UUID().uuidString
        self.name                   = try container.decode(String.self, forKey: .name)
        self.level                  = try container.decode(Int.self, forKey: .level)
        self.school                 = try container.decode(SpellSchool.self, forKey: .school)
        self.isRitual               = try container.decodeIfPresent(Bool.self, forKey: .isRitual) ?? false
        self.castTime               = try container.decode(Int.self, forKey: .castTime)
        self.range                  = try container.decode(Int.self, forKey: .range)
        self.requiresConcentration  = try container.decodeIfPresent(Bool.self, forKey: .requiresConcentration) ?? false
        self.duration               = try container.decode(Int.self, forKey: .duration)
        self.components             = try container.decode(String.self, forKey: .components)
        self.materials              = try container.decodeIfPresent(String.self, forKey: .materials)
        self.summary                = try container.decode(String.self, forKey: .summary)
        self.upcast                 = try container.decodeIfPresent(String.self, forKey: .upcast)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(level, forKey: .level)
        try container.encode(school, forKey: .school)
        try container.encode(isRitual, forKey: .isRitual)
        try container.encode(castTime, forKey: .castTime)
        try container.encode(range, forKey: .range)
        try container.encode(requiresConcentration, forKey: .requiresConcentration)
        try container.encode(duration, forKey: .duration)
        try container.encode(components, forKey: .components)
        try container.encode(materials, forKey: .materials)
        try container.encode(summary, forKey: .summary)
        try container.encode(upcast, forKey: .upcast)
    }
    
    enum CodingKeys: CodingKey {
        case name, level, school, isRitual, castTime, range, requiresConcentration, duration, components, materials, summary, upcast
    }
    
    
}

enum SpellSchool: String, Codable {
    case abjuration, conjuration, divination, enchantment, illusion, evocation, necromancy, transmutation
}

enum SpellComponent: String, Codable {
    case verbal, somatic, material
}



