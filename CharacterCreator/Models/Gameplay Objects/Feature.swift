//
//  Feature.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/27/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation

//MARK: - Feature
/// descrbes unique feature that will affect gameplay
class Feature: Codable, Identifiable {
    ///the id of the feature
    let id: String = UUID().uuidString
    ///the title of the feature
    let title: String
    ///a paragraph describing the feature's effects
    let description: String
    ///The level at which this feature is available to the Character
    let level: Int?
    ///the source of the feature
    var origin: Origin? = nil
    
    init(title: String, description: String, level: Int? = nil, origin: Origin) {
        self.title          = title
        self.description    = description
        self.level          = level
        self.origin         = origin
    }
    
    required
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.title          = try container.decode(String.self, forKey: .title)
        self.description    = try container.decode(String.self, forKey: .description)
        self.level          = try container.decodeIfPresent(Int.self, forKey: .level)
    }
}

//MARK: - SelectableFeature
//class SelectableFeature: Feature, Selectable, ObservableObject {
//    ///holds all potential options for this feature
//    @Published
//    var options: [SelectionOption]
//    ///the maximum number of selections that are allowed to be made
//    let selectionLimit: Int
//
//    init(title: String, description: String, origin: Origin, options: [SelectionOption], limit: Int = 1) {
//        self.options = options
//        self.selectionLimit = limit
//
//        super.init(title: title, description: description, origin: origin)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.options = try container.decode([SelectionOption].self, forKey: .options)
//        self.selectionLimit = try container.decode(Int.self, forKey: .options)
//    }
//
//    enum CodingKeys: CodingKey {
//        case options, selectionLimit
//    }
//}

//MARK: - Spellcasting Feature
//class SpellcastingFeature: Feature {
//    ///The stat used to cast spells
//    let stat: Stat
//    ///The number of slots per class level, where the index of the parent array is the class level and the index of the contained array is the slot level
//    ///The first index of the contained array represents the number of cantrips that are known at that level
//    let slots: [[Int]]
//    ///The maxium number of spells available for the character at a particular level
//    let spellCount: Int
//    ///The list of spells that are either known or prepared by the class
//    let knownSpells: [String]
//    ///The selection of spells available to this class
//    let spellList: [String]
//    ///Indicates if the character can cast rituals
//    let canCastRitual: Bool = false
//    ///Indicates if the class prepares or knows the spells
//    let memoryType: MemoryType
//
//    ///Indicates if the class prepares or knows the spells
//    enum MemoryType {
//        case known, prepared
//    }
//
//    internal init(title: String, description: String, level: Int? = nil, stat: Stat, slots: [[Int]], spellCount: Int, knownSpells: [String], spellList: [String], memoryType: SpellcastingFeature.MemoryType, origin: Origin) {
//        self.stat = stat
//        self.slots = slots
//        self.spellCount = spellCount
//        self.knownSpells = knownSpells
//        self.spellList = spellList
//        self.memoryType = memoryType
//        super.init(title: title, description: description, level: level, origin: origin)
//    }
//}



//MARK: - Protocol Conformance
extension Feature: Equatable, Hashable {
    static func == (lhs: Feature, rhs: Feature) -> Bool {
        return lhs.title == rhs.title && lhs.description == rhs.description && lhs.origin == rhs.origin
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
