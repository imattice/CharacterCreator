//
//  Trap.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/11/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation

struct TrapRecord: Record, Codable {
    let id: String = UUID().uuidString
    let name: String
    let description: String
    let type: TrapType
    
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.name           = try container.decode(String.self, forKey: .name)
        self.description    = try container.decode(String.self, forKey: .description)
        self.type           = try container.decode(TrapType.self, forKey: .type)
    }
    
    enum TrapType: String, Codable {
        case mechanical, magic
    }
}
