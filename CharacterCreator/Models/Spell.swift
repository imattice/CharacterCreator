//
//  Spell.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/7/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation

///An object holding data for spells
final
class SpellRecord: Record {
    ///An id for the spell
    let id: String = UUID().uuidString
    ///The name of the spell
    let name: String
    ///The level of the spell
    let level: Int
    ///The school of magic for the spell
    let school: SpellSchool
    ///Indicates if the spell can be cast as ritual
    let isRitual: Bool
    ///The time it takes to cast the spell in seconds
    ///0 indicates the spell can be cast as a reaction
    ///3 indicates the spell can be cast as a bonus action
    let castTime: Int
    ///The maximum range of the spell in feet
    ///-1 indicates the spell's range is infinite
    ///0 indicates the spell can only be cast on self
    let range: Int
    ///Indicates if the spell requires the caster use concentration to maintain the spell for the duration
    let requiresConcentration: Bool
    ///The maxium duration the spell can last, in seconds
    ///-1 indicates the spell lasts until it is dispelled
    ///0 indicates that the spell is instantaneous and does not linger
    let duration: Int
    ///The list of components that is required by the spell
    ///V = Verbal, S = Somatic, M = Material
    let components: String
    ///The list of materials, if necessary
    let materials: String?
    ///The full description of the spell
    let description: String
    ///A description of the effect if the spell is cast using a slot above its level
    let upcast: String?
//    let target: Target
//    enum Target {
//        case area(Shape), creature(Int), caster
//    }
    
    required
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name       = try container.decode(String.self, forKey: .name)
        self.level      = try container.decode(Int.self, forKey: .level)
        self.school     = try container.decode(SpellSchool.self, forKey: .school)
        self.isRitual   = try container.decodeIfPresent(Bool.self, forKey: .isRitual) ?? false
        self.castTime   = try container.decode(Int.self, forKey: .castTime)
        self.range      = try container.decode(Int.self, forKey: .range)
        self.requiresConcentration  = try container.decodeIfPresent(Bool.self, forKey: .requiresConcentration) ?? false
        self.duration               = try container.decode(Int.self, forKey: .duration)
        self.components             = try container.decode(String.self, forKey: .components)
        self.materials              = try container.decodeIfPresent(String.self, forKey: .materials)
        self.description            = try container.decode(String.self, forKey: .description)
        self.upcast                 = try container.decodeIfPresent(String.self, forKey: .upcast)
    }
}


struct Spell {

}

enum SpellSchool: String, Codable {
    case abjuration, conjuration, divination, enchantment, illusion, evocation, necromancy, transmutation
}

enum SpellComponent: String, Codable {
    case verbal, somatic, material
}



