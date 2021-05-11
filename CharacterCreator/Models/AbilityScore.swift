//
//  AbilityScore.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/20/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation

///Contains all valid options for Ability Scores
enum Stat: String, CaseIterable, CodingKey {
    case str, con, dex, cha, wis, int
    
    ///returns a lowercased string for the name of the Ability Score
    func label(_ length: Length = .short) -> String {
        switch length {
        case .short: return self.rawValue
        case .long:
            switch self {
            case .str: return "strength"
            case .con: return "constitution"
            case .dex: return "dexterity"
            case .cha: return "charisma"
            case .wis: return "wisdom"
            case .int: return "intelligence"                }
        }
    }
    ///used to determine if the label name of the Ability Score should be long or short
    enum Length {
        case short, long
    }
}

///The score for a particular stat
struct AbilityScore: Hashable {
    ///the name of the ability score
    let name: Stat
    ///the value of the attribute after modifiers have been applied
    var value: Int
    ///holds the base value that is set when the Ability Score is created
    let rawValue: Int
    ///the value that is applied to rolls attributed to this Ability Score
    var modifier: Int { value / 2 - 5 }
    
    init(name: Stat, value: Int) {
        self.name = name
        self.value = value
        self.rawValue = value
    }
    
    ///reset the modified value to the raw value
    mutating
    func resetValue() {
        value = rawValue
    }
}

//struct StatBlock {
//    private
//    let scores: [AbilityScore]
//    
//    let str: AbilityScore
//    let con: AbilityScore
//    let dex: AbilityScore
//    let cha: AbilityScore
//    let int: AbilityScore
//    let wis: AbilityScore
//    
//}
