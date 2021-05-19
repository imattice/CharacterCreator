//
//  Action.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/6/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation

///Describes an action that can be used in combat
class Action: Codable {
    let title: String
    let description: String
//    let recharge: Recharge?
//    let charges: Int?
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    //The default recahrge is a d6, so we can use an int to indicate that the recharge is roll based
//    enum Recharge: Codable {
//        case shortRest,
//             longRest,
//             roll(Int)
//        enum CodingKeys: CodingKey {
//            case shortRest, longRest, roll, die, minRoll
//        }
        
//        init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            let key = container.allKeys.first
//
//            switch key {
//            case .shortRest:
//                self = .shortRest
//            case .longRest:
//                self = .longRest
//            case .roll:
//                let die = Die(from: try container.decodeIfPresent(String.self, forKey: .die) ?? "1d6")!
//                let minRoll = try container.decode(Int.self, forKey: .minRoll)
//
//                self = .roll(minRoll, die)
//            default:
//                throw DecodingError.dataCorrupted(
//                    DecodingError.Context(
//                        codingPath: container.codingPath,
//                        debugDescription: "Unabled to decode sense enum."
//                    )
//                )
//            }
//    }
}

class LegendaryAction: Action {
    let cost: Int
    
    init(title: String, description: String, cost: Int) {
        self.cost = cost
        
        super.init(title: title, description: description)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.cost   = try container.decodeIfPresent(Int.self, forKey: .cost) ?? 1
        try super.init(from: decoder)
    }
    
    enum CodingKeys: CodingKey {
        case cost
    }
}
