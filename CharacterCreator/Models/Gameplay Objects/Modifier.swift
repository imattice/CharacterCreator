//
//  Modifier.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

///holds attributes that affect other character attributes
class Modifier: Codable {
    ///the source of the modifier
    let origin: Origin
    
    init(origin: Origin) {
        self.origin = origin
    }
}


//MARK: - Ability Score Modifier
///holds attributes that affect ability scores
class AbilityScoreModifier: Modifier {
    ///the score to be adjusted
    let abilityScore: AbilityScore.Name
    ///how much the score should be affected
    let value: Int
    ///if the score should increase or decrease
    let adjustment: Adjustment
    ///if this adjustement can be removed at a later time
    let isTemporary: Bool
    
    required
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.abilityScore   = AbilityScore.Name(rawValue: try container.decode(String.self, forKey: .abilityScore))!
        self.value          = try container.decode(Int.self, forKey: .value)
        self.adjustment     = Adjustment(rawValue: try (container.decodeIfPresent(String.self, forKey: CodingKeys.adjustment) ?? "increase"))!
        self.isTemporary    = try container.decode(Bool.self, forKey: CodingKeys.adjustment)
        
        try super.init(from: decoder)
    }
    
    init(name: AbilityScore.Name, value: Int, adjustment: Adjustment = .increase, isTemp: Bool = false, origin: Origin) {
        self.abilityScore    = name
        self.value           = value
        self.adjustment      = adjustment
        self.isTemporary     = isTemp
    
        super.init(origin: origin)
    }
    
    ///decodes an Unkeyed JSON decoding container into an array of AbilityScoreModifiers
    static
    func decoded(from container: KeyedDecodingContainer<AbilityScore.Name>) -> [AbilityScoreModifier] {
        var modifiers = [AbilityScoreModifier]()
        for key in AbilityScore.Name.allCases {
            guard let value = try? container.decodeIfPresent(Int.self, forKey: key)
            else { continue }
            modifiers.append(AbilityScoreModifier(name: key, value: value, origin: .race))
        }
        
        return modifiers
    }
    
    enum Adjustment: String {
        case increase, decrease }
    enum CodingKeys: CodingKey {
        case abilityScore, value, adjustment, isTemporary       }
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
