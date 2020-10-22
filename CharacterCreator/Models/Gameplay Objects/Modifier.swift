//
//  Modifier.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

///holds attributes that affect other character attributes
class Modifier {
    let origin: Origin
    
    enum Origin: String, Codable {
        case race,
             subrace,
             `class`
    }
    
    init(origin: Origin) {
        self.origin = origin
    }
}

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
    
    enum Adjustment {
        case increase, decrease }
    
    init(name: AbilityScore.Name, value: Int, adjustment: Adjustment = .increase, isTemp: Bool = false, origin: Origin) {
        self.abilityScore    = name
        self.value           = value
        self.adjustment      = adjustment
        self.isTemporary     = isTemp
    
        super.init(origin: origin)
    }
    
    static
    func decoded(from container: KeyedDecodingContainer<AbilityScore.Name>) -> [AbilityScoreModifier] {
        var modifiers = [AbilityScoreModifier]()
//        let statModifierContainer = try container.nestedContainer(keyedBy: AbilityScore.Name.self, forKey: .statIncrease)
        for key in AbilityScore.Name.allCases {
            guard let value = try? container.decodeIfPresent(Int.self, forKey: key)
            else { continue }
            modifiers.append(AbilityScoreModifier(name: key, value: value, origin: .race))
        }
        
        return modifiers
    }
}

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
}
