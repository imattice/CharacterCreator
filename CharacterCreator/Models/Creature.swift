//
//  Creature.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/6/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation

struct Creature {
    let record: CreatureRecord
    var averageMaxHP: Int {
        return ((record.hitDie.min + record.hitDie.max)*record.hitDie.count) + (record.abilityScores.con.value * record.hitDie.count)
    }
}

///An object representing static information for a non-playable character
struct CreatureRecord: Record, Codable {
    ///The id for the record
    let id: String = UUID().uuidString
    ///The name of the creature
    let name: String
    ///A description of the creature
    let description: String
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
    ///The creatures recorvery die
    let hitDie: Die
    ///An object containing the speeds for the creature
    let speed: Speed
    ///Contains the 6 ability scores for the creature
    let abilityScores: StatBlock
    ///Contains the saving throws that this creature is proficient in
    let savingThrows: [Stat]?
    ///Contains the skills the creature is proficient in
    let skills: [String]?
    ///Contains the damage types the creature is vulnurable to
    let vulnerablilities: [String]?
    ///Contains the damage types the creature is resistant to
    let resistances: [String]?
    ///Contains the conditions the creature is immune to
    let immunities: [String]?
    ///Contains the senses the creature has
    let senses: [Sense]?
    ///Contains the languages the creature can speak and understand
    let languages: [String]
    ///The challenge rating for the creature
    let challengeRating: Int
    ///Contains the features that are available for this creature
    let features: [Feature]
    ///Contains the actions that are availablefor this creature
    let actions: [Action]
    ///Contains any reactions available to this creature
    let reactions: [Action]?
    ///Describes the equiptment for this creature
    let equipment: String?
    ///Contains any legendary actions for this creature
    let legendaryAbilities: LegendaryAbilities?
    ///The bonus that is applied to proficiencies
    var proficiencyBonus: Int {
       return Int((Double(challengeRating) / 4.0).rounded(.up)) + 1
    }
    ///The number of experiance points granted for defeating this creature
    var experiancePoints: Int {
        return crToEXP[challengeRating] ?? 0
    }
    
    ///Returns a label that represents the cr
    var crLabel: String {
        switch challengeRating {
        case -1: return "1/2"
        case -2: return "1/4"
        case -3: return "1/8"
        case -4: return "0"
        default: return "\(challengeRating)"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.size = try container.decode(CreatureSize.self, forKey: .size)
        self.type = try container.decode(CreatureType.self, forKey: .type)
        self.tags = try container.decodeIfPresent([String].self, forKey: .tags)
        self.alignment = try container.decode(Alignment.self, forKey: .alignment)
        self.armorClass = try container.decode(Int.self, forKey: .armorClass)
        self.armorType = try container.decodeIfPresent(String.self, forKey: .armorType)
        self.hitDie = Die(from: try container.decode(String.self, forKey: .hitDie)) ?? Die(count: 0, value: 4)
        self.speed = try container.decode(Speed.self, forKey: .speed)
        self.abilityScores = StatBlock(try container.decode([Int].self, forKey: .abilityScores)) ?? StatBlock([0,0,0,0,0,0])!
        self.savingThrows = try container.decodeIfPresent([Stat].self, forKey: .savingThrows)
        self.skills = try container.decodeIfPresent([String].self, forKey: .skills)
        self.vulnerablilities = try container.decodeIfPresent([String].self, forKey: .vulnerablilities)
        self.resistances = try container.decodeIfPresent([String].self, forKey: .resistances)
        self.immunities = try container.decodeIfPresent([String].self, forKey: .immunities)
        self.senses = try container.decodeIfPresent([Sense].self, forKey: .senses)
        self.languages = try container.decode([String].self, forKey: .languages)
        self.challengeRating = try container.decode(Int.self, forKey: .challengeRating)
        self.features = try container.decode([Feature].self, forKey: .features)
        self.actions = try container.decode([Action].self, forKey: .actions)
        self.reactions = try container.decodeIfPresent([Action].self, forKey: .reactions)
        self.equipment = try container.decodeIfPresent(String.self, forKey: .equipment)
        self.legendaryAbilities = try container.decodeIfPresent(LegendaryAbilities.self, forKey: .legendaryAbilities)
    }

    struct Speed: Codable {
        let walk: Int
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
        case aberration, beast, celestial, construct, dragon, elemental, fey, fiends, humanoid, monstrocity, ooze, plats, undead
    }
}

///A dictionary used to convert challenge rating to experiance points
fileprivate
let crToEXP: [Int: Int] = [
    -4 : 0,
    -3 : 25,
    -2 : 50,
    -1 : 100,
    0  : 10,
    1  : 200,
    2  : 450,
    3  : 700,
    4  : 1100,
    5  : 1800,
    6  : 2300,
    7  : 2900,
    8  : 3900,
    9  : 5000,
    10 : 5900,
    11 : 7200,
    12 : 8400,
    13 : 10000,
    14 : 11500,
    15 : 13000,
    16 : 15000,
    17 : 18000,
    18 : 20000,
    19 : 22000,
    20 : 25000,
    21 : 33000,
    22 : 41000,
    23 : 50000,
    24 : 62000,
    25 : 75000,
    26 : 90000,
    27 : 105000,
    28 : 120000,
    29 : 135000,
    30 : 155000
]

