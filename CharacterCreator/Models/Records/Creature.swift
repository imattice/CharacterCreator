//
//  Creature.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/6/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

struct Creature {
    let record: CreatureRecord
    var averageMaxHP: Int {
        return ((record.hitDie.min + record.hitDie.max)*record.hitDie.count) + (record.abilityScores.con.value * record.hitDie.count)
    }
    var passivePerception: Int {
        return record.abilityScores.wis.modifier + 10
    }
}

///An object representing static information for a non-playable character
@objc(CreatureRecord)
final class CreatureRecord: NSManagedObject, Record, Codable {
    ///An id for the creature
    @NSManaged public var id: String
    ///The name of the creature
    @NSManaged public var name: String
    ///A description of the creature
    @NSManaged public var summary: String
    ///The core data representation of the size property
    @NSManaged private var cdSize: String
    ///The size class of the creature
    var size: CreatureSize {
        get { return CreatureSize(rawValue: cdSize)! }
        set { cdSize = newValue.rawValue }
    }
    ///The core data representation of the type property
    @NSManaged private var cdType: String
    ///Indicates the type of the creature
    var type: CreatureType {
        get { return CreatureType(rawValue: cdType)! }
        set { cdType = newValue.rawValue }
    }
    ///The core data representation of the tags property
    @NSManaged private var cdTags: String
    ///Contains any creature-specific tags that may affect specific interactions
    var tags: [String]? {
        get { return (try? JSONDecoder().decode([String].self, from: Data(cdTags.utf8))) ?? nil  }
        set {
            do {
                cdTags = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdTags = "" }
        }
    }
    ///The core data representation of the alignment property
    @NSManaged private var cdAlignment: String
    ///Indicates the alignment of the creature
    var alignment: Alignment {
        get { return Alignment(rawValue: cdAlignment)! }
        set { cdAlignment = newValue.rawValue }
    }

    ///The base armor class for the creature, including any natural armor and dexterity bonus
    @NSManaged public var armorClass: Int
    ///Descirbes the type of armor
    @NSManaged public var armorType: String?
    ///The core data representation of the hitDie property
    @NSManaged private var cdHitDie: String
    ///The creatures recorvery die
    var hitDie: Die {
        get { return (try? JSONDecoder().decode(Die.self, from: Data(cdHitDie.utf8)))!  }
        set {
            do {
                cdHitDie = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdHitDie = "" }
        }
    }
    ///The core data representation of the speed property
    @NSManaged private var cdSpeed: String
    ///An object containing the speeds for the creature
    var speed: Speed {
        get { return (try? JSONDecoder().decode(Speed.self, from: Data(cdSpeed.utf8)))!  }
        set {
            do {
                cdSpeed = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdSpeed = "" }
        }
    }
    ///The core data representation of the abilityScores property
    @NSManaged private var cdAbilityScores: String
    ///An object containing the speeds for the creature
    var abilityScores: StatBlock {
        get { return (try? JSONDecoder().decode(StatBlock.self, from: Data(cdAbilityScores.utf8)))!  }
        set {
            do {
                cdAbilityScores = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdAbilityScores = "" }
        }
    }
    ///The core data representation of the savingThrows property
    @NSManaged private var cdSavingThrows: String
    ///Contains the saving throws that this creature is proficient in
    var savingThrows: [Stat]? {
        get { return (try? JSONDecoder().decode([Stat].self, from: Data(cdSavingThrows.utf8))) ?? nil  }
        set {
            do {
                cdSavingThrows = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdSavingThrows = "" }
        }
    }
    ///The core data representation of the skills property
    @NSManaged private var cdSkills: String
    ///Contains the skills the creature is proficient in
    var skills: [String]? {
        get { return (try? JSONDecoder().decode([String].self, from: Data(cdSkills.utf8))) ?? nil  }
        set {
            do {
                cdSkills = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdSkills = "" }
        }
    }
    ///The core data representation of the vulnerabilities property
    @NSManaged private var cdVulnerabilities: String
    ///Contains the damage types the creature is vulnurable to
    var vulnerablilities: [String]? {
        get { return (try? JSONDecoder().decode([String].self, from: Data(cdVulnerabilities.utf8))) ?? nil  }
        set {
            do {
                cdVulnerabilities = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdVulnerabilities = "" }
        }
    }
    ///The core data representation of the resistances property
    @NSManaged private var cdResistances: String
    ///Contains the damage types the creature is resistant to
    var resistances: [String]? {
        get { return (try? JSONDecoder().decode([String].self, from: Data(cdResistances.utf8))) ?? nil  }
        set {
            do {
                cdResistances = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdResistances = "" }
        }
    }
    ///The core data representation of the immunities property
    @NSManaged private var cdImmunities: String
    ///Contains the conditions the creature is immune to
    var immunities: [String]? {
        get { return (try? JSONDecoder().decode([String].self, from: Data(cdImmunities.utf8))) ?? nil  }
        set {
            do {
                cdImmunities = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdImmunities = "" }
        }
    }
    ///The core data representation of the senses property
    @NSManaged private var cdSenses: String
    ///Contains the senses the creature has
    var senses: [Sense]? {
        get { return (try? JSONDecoder().decode([Sense].self, from: Data(cdSenses.utf8))) ?? nil  }
        set {
            do {
                cdSenses = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdSenses = "" }
        }
    }
    ///The core data representation of the languages property
    @NSManaged private var cdLanguages: String
    ///Contains the languages the creature can speak and understand
    var languages: [String]? {
        get { return (try? JSONDecoder().decode([String].self, from: Data(cdLanguages.utf8))) ?? nil  }
        set {
            do {
                cdLanguages = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdLanguages = "" }
        }
    }
    ///The challenge rating for the creature
    @NSManaged public var challengeRating: Int
    ///The core data representation of the features property
    @NSManaged private var cdFeatures: String
    ///The gameplay features available to this creature
    var features: [Feature]? {
        get { return (try? JSONDecoder().decode([Feature].self, from: Data(cdFeatures.utf8)))!  }
        set {
            do {
                cdFeatures = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdFeatures = "" }
        }
    }
    ///The core data representation of the actions property
    @NSManaged private var cdActions: String
    ///Contains the actions that are availablefor this creature
    var actions: [Action] {
        get { return (try? JSONDecoder().decode([Action].self, from: Data(cdActions.utf8))) ?? [Action]()  }
        set {
            do {
                cdActions = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdActions = "" }
        }
    }
    ///The core data representation of the reactions property
    @NSManaged private var cdReactions: String
    ///Contains any reactions that are available for this creature
    var reactions: [Action]? {
        get { return (try? JSONDecoder().decode([Action].self, from: Data(cdReactions.utf8))) ?? nil  }
        set {
            do {
                cdReactions = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdReactions = "" }
        }
    }
    ///The core data representation of the legendaryAbilities property
    @NSManaged private var cdLegendaryAbilities: String
    ///Contains any legendary actions for this creature
    var legendaryAbilities: LegendaryAbilities? {
        get { return (try? JSONDecoder().decode(LegendaryAbilities.self, from: Data(cdLegendaryAbilities.utf8))) ?? nil  }
        set {
            do {
                cdActions = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdActions = "" }
        }
    }

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
    
    required convenience
    init(from decoder: Decoder) throws {
        guard
        let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
        let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
        let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
    else { fatalError("Failed to decode User") }

    self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.name = try container.decode(String.self, forKey: .name)
        self.summary = try container.decode(String.self, forKey: .summary)
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
        self.languages = try container.decodeIfPresent([String].self, forKey: .languages)
        self.challengeRating = try container.decode(Int.self, forKey: .challengeRating)
        self.features = try container.decodeIfPresent([Feature].self, forKey: .features)
        self.actions = try container.decode([Action].self, forKey: .actions)
        self.reactions = try container.decodeIfPresent([Action].self, forKey: .reactions)
        self.legendaryAbilities = try container.decodeIfPresent(LegendaryAbilities.self, forKey: .legendaryAbilities)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(summary, forKey: .summary)
        try container.encode(size, forKey: .size)
        try container.encode(type, forKey: .type)
        try container.encode(tags, forKey: .tags)
        try container.encode(alignment, forKey: .alignment)
        try container.encode(armorClass, forKey: .armorClass)
        try container.encode(armorType, forKey: .armorType)
        try container.encode(hitDie, forKey: .hitDie)
        try container.encode(speed, forKey: .speed)
        try container.encode(abilityScores, forKey: .abilityScores)
        try container.encode(savingThrows, forKey: .savingThrows)
        try container.encode(skills, forKey: .skills)
        try container.encode(vulnerablilities, forKey: .vulnerablilities)
        try container.encode(resistances, forKey: .resistances)
        try container.encode(immunities, forKey: .immunities)
        try container.encode(senses, forKey: .senses)
        try container.encode(languages, forKey: .languages)
        try container.encode(challengeRating, forKey: .challengeRating)
        try container.encode(features, forKey: .features)
        try container.encode(actions, forKey: .reactions)
        try container.encode(legendaryAbilities, forKey: .legendaryAbilities)
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
    
    enum CodingKeys: CodingKey {
        case id, name, summary, size, type, tags, alignment, armorClass, armorType, hitDie, speed, abilityScores, savingThrows, skills, vulnerablilities, resistances, immunities, senses, languages, challengeRating, features, actions, reactions, legendaryAbilities
    }
    
    enum CreatureType: String, Codable {
        case aberration, beast, celestial, construct, dragon, elemental, fey, fiend, giant, humanoid, monstrosity, ooze, plant, undead
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

