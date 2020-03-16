//
//  Effect.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/15/19.
//  Copyright © 2019 Ike Mattice. All rights reserved.
//

import Foundation

///An enum of the 6 core stats
enum Stat: String, Codable, CodingKey {
    case str, con, dex, cha, wis, int
}

///A collection of effects that can impact calculations and options
enum Effect {
    case increaseStat(stat: Stat, value: Int)
    case decreaseStat(stat: Stat, value: Int)
    //grantProficiency(String), grantExpertise(String), addAction(String), addResistance(String), addImmunity(String), atLevelUp(String), increaseAbility(String, value: Int), decreaseAbility(String, value: Int), addSpell(String)
}

extension Effect: Equatable {
    
}


///An enum of the 9 primary alignment combinations
enum Alignment: String, Codable {
    case lawfulGood, lawfulNeutral, lawfulEvil, neutralGood, neutral, neutralEvil, chaoticGood, chaoticNeutral, chaoticEvil
}

///An enum of the default languages available to the player
enum LanguageChoices: String, Codable {
    case common, dwarvish, elvish, draconic, halfling, gnomish, orc, giant, infernal
}
//enum LanguageChoices: String, Codable {
//    case common, dwarvish, elvish, draconic, halfling, gnomish, orc, giant
//
//    ///An enum with default exotic languages that may be available to the player
//    enum Exotic: String, Codable {
//        case abyssal, celestial, draconic, deepSpeech, infernal, primordial, sylvan, undercommon
//    }
//}

///An enum with the primary size groupings
enum Size: String, Codable {
    case tiny, small, medium, large, huge, gigantic
}


extension Effect: Codable {
    ///An enum used as keys for decoding and encoding Effects with parameters
    private enum Effect: String, Codable {
       case increaseStat, decreaseStat
    }

       ///A struct used to hold parameters for the .incraseStat and .decreaseStat cases
       struct StatAdjustment: Codable {
           let stat: Stat
           let value: Int
        }
       
       ///Declares the primary case as well as the parameters to they can be encoded and decoded seperately
       private enum CodingKeys: String, CodingKey {
           case effect, statAdjustment
       }

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      let effect = try container.decode(Effect.self, forKey: .effect)

      switch effect {
      case .increaseStat:
        let statAdjustment = try container.decode(StatAdjustment.self, forKey: .statAdjustment)
        self = .increaseStat(stat: statAdjustment.stat, value: statAdjustment.value)
       case .decreaseStat:
         let statAdjustment = try container.decode(StatAdjustment.self, forKey: .statAdjustment)
         self = .decreaseStat(stat: statAdjustment.stat, value: statAdjustment.value)
      }
    }

    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)

      switch self {
      case .increaseStat(let stat, let value):
        try container.encode(Effect.increaseStat, forKey: .effect)
        try container.encode(StatAdjustment(stat: stat, value: value), forKey: .statAdjustment)
      case .decreaseStat(let stat, let value):
       try container.encode(Effect.decreaseStat, forKey: .effect)
       try container.encode(StatAdjustment(stat: stat, value: value), forKey: .statAdjustment)
      }
    }


}
