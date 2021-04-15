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
    let school: String
    ///Indicates if the spell can be cast as ritual
    let isRitual: Bool              = false
    ///The time it takes to cast the spell in seconds
    ///0 indicates the spell can be cast as a reaction
    ///3 indicates the spell can be cast as a bonus action
    let castTime: String
    ///The maximum range of the spell in feet
    ///-1 indicates the spell's range is infinite
    ///0 indicates the spell can only be cast on self
    let range: Int
    ///Indicates if the spell requires the caster use concentration to maintain the spell for the duration
    let requiresConcentration: Bool = false
    ///The maxium duration the spell can last, in seconds
    ///-1 indicates the spell lasts until it is dispelled
    ///0 indicates that the spell is instantaneous and does not linger
    let duration: String
    ///The list of components that is required by the spell
    ///V = Verbal, S = Somatic, M = Material
    let components: String
    ///The list of materials, if necessary
    let materials: String?          = nil
    ///The full description of the spell
    let description: String
    ///A description of the effect if the spell is cast using a slot above its level
    let upcast: String?             = nil
//    let target: Target
//    enum Target {
//        case area(Shape), creature(Int), caster
//    }
}


struct Spell {
	enum School: String {
		case abjuration, conjuration, divination, enchantment, illusion, evocation, necromancy, transmutation
	}
	enum Component: String {
		case verbal, somatic, material
	}
}
