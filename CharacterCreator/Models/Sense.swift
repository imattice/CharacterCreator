//
//  Sense.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/7/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
enum Sense: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let key = container.allKeys.first
        
        switch key {
        case .blindsense:
            let distance = try container.decode(Int.self, forKey: .blindsense)
            self = .blindsense(distance)
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
                    debugDescription: "Unabled to decode sense enum."
                )
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .blindsense(let distance):
            try container.encode(distance, forKey: .blindsense)
        case .darkvision(let distance):
            try container.encode(distance, forKey: .darkvision)
        case .tremorsense(let distance):
            try container.encode(distance, forKey: .tremorsense)
        case .truesight(let distance):
            try container.encode(distance, forKey: .truesight)
        }
    }
    
    case blindsense(Int), darkvision(Int), tremorsense(Int), truesight(Int)
    
    enum CodingKeys: CodingKey {
        case blindsense, darkvision, tremorsense, truesight
    }
}

