//
//  Modifier.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
import Foundation

//MARK: - Modifier
///holds attributes that affect other character attributes
class Modifier: Codable, Identifiable {
    ///an id for the modifier
    private(set)
    var id: String = UUID().uuidString
    ///the source of the modifier
    var origin: Origin
    
    init(origin: Origin) {
       // self.id = UUID().uuidString
        self.origin = origin
    }
    
    required init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.origin         = Origin(rawValue: try container.decode(String.self, forKey: .origin))!
    }
    
    enum CodingKeys: CodingKey { case origin }
}


//MARK: - Ability Score Modifier
///holds attributes that affect ability scores
class AbilityScoreModifier: Modifier, Hashable {
    ///the score to be adjusted
    let stat: Stat
    ///how much the score should be affected
    let value: Int
    
    required
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.stat           = Stat(rawValue: try container.decode(String.self, forKey: .stat))!
        self.value          = try container.decode(Int.self, forKey: .value)
        
        try super.init(from: decoder)
    }
    
    init(name: Stat, value: Int, isTemp: Bool = false, origin: Origin) {
        self.stat    = name
        self.value           = value
    
        super.init(origin: origin)
    }
    
    ///decodes an Unkeyed JSON decoding container into an array of AbilityScoreModifiers
//    static
//    func decoded(from container: KeyedDecodingContainer<Stat>) -> [AbilityScoreModifier] {
//        var modifiers = [AbilityScoreModifier]()
//        for key in Stat.allCases {
//            guard let value = try? container.decodeIfPresent(Int.self, forKey: key)
//            else { continue }
//            modifiers.append(AbilityScoreModifier(name: key, value: value, origin: .race))
//        }
//
//        return modifiers
//    }
//MARK: -- Hashable
    static func == (lhs: AbilityScoreModifier, rhs: AbilityScoreModifier) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: CodingKey {
        case stat, value, origin       }
}


//MARK: - HP Modifier
///holds attributes that affect raw HP values
class HPModifier: Modifier {
    ///how much the HP should be affected
    let value: Int
    ///if this adjustement can be removed at a later time
    let isTemporary: Bool
    
    init(value: Int, isTemp: Bool, origin: Origin) {
        self.value          = value
        self.isTemporary    = isTemp
        
        super.init(origin: origin)
    }
    
    required
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.value   = try container.decode(Int.self, forKey: .value)
        self.isTemporary    = try container.decode(Bool.self, forKey: .isTemporary)
        try super.init(from: decoder)
    }
    
    enum CodingKeys: CodingKey {
        case value, isTemporary
    }
}
