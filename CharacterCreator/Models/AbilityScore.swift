//
//  AbilityScore.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/20/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation

///Contains all valid options for Ability Scores
enum Stat: String, CaseIterable, CodingKey, Codable {
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
struct AbilityScore: Hashable, Codable {
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

///Contains the 6 stats for the creature
struct StatBlock: Codable {
    var str: AbilityScore
    var con: AbilityScore
    var dex: AbilityScore
    var cha: AbilityScore
    var int: AbilityScore
    var wis: AbilityScore
    
    ///initialize from an array where the ordered values are [str, dex, con, int, wis, cha]
    init?(_ statArray: [Int]) {
    guard statArray.count == 6 else { print("invalid array size"); return nil }
        self.str    = AbilityScore(name: .str, value: statArray[0])
        self.con    = AbilityScore(name: .str, value: statArray[1])
        self.dex    = AbilityScore(name: .str, value: statArray[2])
        self.cha    = AbilityScore(name: .str, value: statArray[3])
        self.int    = AbilityScore(name: .str, value: statArray[4])
        self.wis    = AbilityScore(name: .str, value: statArray[5])
    }
    
}
