//
//  AbilityScore.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/20/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation

struct AbilityScore {
    ///the name of the ability score
    let name: AbilityScore.Name
    ///the value of the attribute after modifiers have been applied
    var value: Int
    ///holds the base value that is set when the Ability Score is created
    let rawValue: Int
    ///the value that is applied to rolls attributed to this Ability Score
    var modifier: Int { value / 2 - 5 }
    
    init(name: AbilityScore.Name, value: Int) {
        self.name = name
        self.value = value
        self.rawValue = value
    }
    
    ///reset the value to the raw value
    mutating
    func resetValue() {
        value = rawValue
    }
    ///contains all valid options for Ability Scores
    enum Name: String, CaseIterable, CodingKey {
        case str, con, dex, cha, wis, int
//        case str = "strength",
//             con = "constitution",
//             dex = "dexterity",
//             cha = "charisma",
//             wis = "wisdom",
//             int = "intelligence"
//
//        ///returns a lowercased string for the name of the Ability Score
//        func label(_ length: Length = .short) -> String {
//            switch length {
//            case .short: return String(describing: Self.self)
//            case .long: return self.rawValue
//            }
//        }
//        ///used to determine if the label name of the Ability Score should be long or short
//        enum Length {
//            case short, long
//        }
    }
}

//enum AbilityScoreCodingKeys: CodingKey, CaseIterable {
//    case str, con, dex, cha, wis, int
//}
