//
//  Race.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation

final
class Race {
    ///a reference to static attributes for this race
    let record: RaceRecord
    ///a reference to static attributes for the chosen subrace
    var subrace: SubraceRecord?
    ///the languages that the user selected for this race
    var selectedLanguages: [Language] = [Language]()

    
    ///the full name of the race, including the subrace
    var label: String {
        guard let subrace = subrace else { return "\(record.name)" }
        return "\(subrace.name) \(record.name)"
    }
    
    init(race: RaceRecord, subrace: SubraceRecord?) {
        self.record     = race
        self.subrace    = subrace
    }
    
    ///adds a specific language to the selectedLanguage
    func addLanguage(_ language: Language) {
        selectedLanguages.append(language)
    }
    ///removes a specific language from the selectedLanguages
    func removeLanguage(_ language: Language) {
        guard let index = selectedLanguages.firstIndex(where: { $0.name == language.name }) else { return }
        selectedLanguages.remove(at: index)
    }
}

///An object representing static data for a specific race
final
class RaceRecord: Record, Codable, Identifiable {
    ///used to identify the record
    let id: String = UUID().uuidString
    ///the name of the race
    let name: String
    ///a  paragraph containing descriptive details about the race
    let description: String
    ///indicates if the race can see 60 ft in dim light
    let hasDarkvision: Bool
    ///contains descriptive information on average features of the race
    let descriptive: Descriptive
    ///incdicates the size of the creature
    let size: CreatureSize
    ///how far the creature can travel in 6 seconds in feet
    let speed: Int
    ///which languages are typically learned by this race
    let baseLanguages: [Language]
    ///contains features granted by this race which will affect gameplay
    let features: [Feature]
    ///contains modifiers grated by this race which will affect other parts of the character sheet
    let modifiers: [Modifier]
    ///contains all available subrace records for this race
    let subraces: [SubraceRecord]?
    
    ///contains abilityScoreModifiers filtered from the modifiers
    var abilityScoreModifiers: [AbilityScoreModifier] {
        modifiers.ofType(AbilityScoreModifier.self)
    }
    

    
    required
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.name           = try container.decode(String.self, forKey: .name)
        self.description    = try container.decode(String.self, forKey: .description)

        let age             = try container.decode(String.self, forKey: .age)
        let alignment       = try container.decode(String.self, forKey: .alignment)
        let physique        = try container.decode(String.self, forKey: .physique)
        self.descriptive    = Descriptive(age: age, alignment: alignment, physique: physique)

        self.size           =  CreatureSize(rawValue: try container.decode(String.self, forKey: .size))!
        self.hasDarkvision  = try container.decodeIfPresent(Bool.self, forKey: .hasDarkvision) ?? false
        
        self.speed          = try container.decode(Int.self, forKey: .speed)
        
        self.modifiers      = try container.decode([AbilityScoreModifier].self, forKey: .abilityScoreModifiers)
        modifiers.forEach { $0.origin = .race }
        
        self.features       = try container.decode([Feature].self, forKey: .features)
        features.forEach { $0.origin = .race}
    
        let languageStrings = try container.decode([String].self, forKey: .baseLanguages)
        self.baseLanguages  = languageStrings.map {
            Language(name: $0, isSelectable: $0 == "choice" ? true : false, source: .race) }
        
        self.subraces       = try container.decodeIfPresent([SubraceRecord].self, forKey: .subraces)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(hasDarkvision, forKey: .hasDarkvision)
        try container.encode(descriptive.age, forKey: .age)
        try container.encode(descriptive.alignment, forKey: .alignment)
        try container.encode(descriptive.physique, forKey: .physique)
        try container.encode(size.rawValue, forKey: .size)
        try container.encode(baseLanguages.map { $0.name }, forKey: .baseLanguages)
        try container.encode(features, forKey: .features)
        try container.encode(modifiers, forKey: .modifiers)
    }
    
    ///holds descriptive references of average attributes for this race
    struct Descriptive: Codable {
        ///average ages of this race
        let age: String
        ///average alignments for this race
        let alignment: String
        ///typical physical attributes for this race
        let physique: String
    }

    
    enum CodingKeys: CodingKey {
        case id, name, description, age, alignment, physique, modifiers, size, speed, hasDarkvision, features, baseLanguages, abilityScoreModifiers, subraces
    }
}



final
class SubraceRecord: Record, Codable {
    ///used to identify the record
    let id: String = UUID().uuidString
    ///the name of the subrace
    var name: String
    ///a  paragraph containing descriptive details about the subrace
    let description: String
    ///contains features granted by this subrace which will affect gameplay
    let features: [Feature]
    ///contains modifiers grated by this subrace which will affect other parts of the character sheet
    let modifiers: [Modifier]
    ///contains abilityScoreModifiers filtered from the modifiers
    var abilityScoreModifiers: [AbilityScoreModifier] {
        modifiers.ofType(AbilityScoreModifier.self)
    }
    
    required
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.name           = try container.decode(String.self, forKey: .name)
        self.description    = try container.decode(String.self, forKey: .description)
       
        self.modifiers       = try container.decodeIfPresent([AbilityScoreModifier].self, forKey: .abilityScoreIncrease) ?? [Modifier]()
        modifiers.forEach { $0.origin = .subrace }

        self.features       = try container.decode([Feature].self, forKey: .features)
        features.forEach { $0.origin = .subrace}
    }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(features, forKey: .features)
        try container.encode(modifiers, forKey: .modifiers)
    }

    enum CodingKeys: CodingKey {
        case parent, name, description, abilityScoreIncrease, features, modifiers
    }
}
