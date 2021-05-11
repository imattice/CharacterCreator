//
//  CreatureRecord.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/6/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation

///An object representing static information for a non-playable character
struct CreatureRecord: Record {
    ///The id for the record
    let id: String = UUID().uuidString
    ///The name of the creature
    let name: String
    ///The size class of the creature
    let size: CreatureSize
    ///Indicates the type of the creature
    let type: CreatureType
    ///Contains any creature-specific tags that may affect specific interactions
    let tags: [String]?
    ///Indicates the alignment of the creature
    let alignment: Alignment
    ///The base armor class for the creature, including any natural armor and dexterity bonus
    let armorClass: Int
    ///Descirbes the type of armor
    let armorType: String?
    ///The maximum level of HP for the creature
    let maxHP: Int
    ///The creatures recorvery die
    let hitDie: Die
    ///An object containing the speeds for the creature
    let speed: Speed
    ///Contains the 6 ability scores for the creature
    let abilityScores: Set<AbilityScore>
    ///Contains the saving throws that this creature is proficient in
    let savingThrows: [Stat]
    ///Contains the skills the creature is proficient in
    let skills: [String]
    ///Contains the damage types the creature is vulnurable to
    let vulnerablilities: [String]
    ///Contains the damage types the creature is resistant to
    let resistances: [String]
    ///Contains the conditions the creature is immune to
    let immunities: [String]
    ///Contains the senses the creature has
    let senses: [Sense]
    ///Contains the languages the creature can speak and understand
    let languages: [String]
    ///Indicates if the creature is capable of communicating telepathically
    let hasTelepathy: Bool
    ///The challenge rating for the creature
    let challengeRating: Int
    ///The number of experiance points granted for defeating this creature
    let experiancePoints: Int
    ///Contains the features that are available for this creature
    let features: [Feature]
    ///Contains the actions that are available for this creature
    let actions: [Action]
    ///Contains any reactions available to this creature
    let reactions: [Action]
    ///Describes the equiptment for this creature
    let equipment: String
    ///Contains any legendary actions for this creature
    let legendaryAbilities: LegendaryAbilities?

    var proficiencyBonus: Int {
       return Int((Double(challengeRating) / 4.0).rounded(.up)) + 1
    }
    
    struct Speed: Codable {
        let walking: Int
        let burrow: Int?
        let climb: Int?
        let fly: Int?
        let swim: Int?
    }
    
    struct LegendaryAbilities: Codable {
        let maxActions: Int
        let actions: [LegendaryAction]
    }
    
    
    
    enum CreatureType: String, Codable {
        case abberation, beast, celestial, construct, dragon, elemental, fey, fiends, humanoid, monstrocity, ooze, plats, undead
    }
}
