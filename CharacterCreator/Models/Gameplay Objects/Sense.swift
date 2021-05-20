//
//  Sense.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/7/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
///Indicates the type of sense as well as the maximum range for that sense
enum Sense: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let key = container.allKeys.first
        
        switch key {
        case .blindsight:
            let distance = try container.decode(Int.self, forKey: .blindsight)
            self = .blindsight(distance)
        case .darkvision:
            let distance = try container.decode(Int.self, forKey: .darkvision)
            self = .darkvision(distance)
        case .tremorsense:
            let distance = try container.decode(Int.self, forKey: .tremorsense)
            self = .tremorsense(distance)
        case .truesight:
            let distance = try container.decode(Int.self, forKey: .truesight)
            self = .truesight(distance)
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unable to decode sense enum for key: \(String(describing: key))."
                )
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .blindsight(let distance):
            try container.encode(distance, forKey: .blindsight)
        case .darkvision(let distance):
            try container.encode(distance, forKey: .darkvision)
        case .tremorsense(let distance):
            try container.encode(distance, forKey: .tremorsense)
        case .truesight(let distance):
            try container.encode(distance, forKey: .truesight)
        }
    }
    
    case blindsight(Int), darkvision(Int), tremorsense(Int), truesight(Int)
    
    enum CodingKeys: CodingKey {
        case blindsight, darkvision, tremorsense, truesight
    }
}

