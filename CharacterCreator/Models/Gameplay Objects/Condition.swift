//
//  Condition.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/26/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation

struct ConditionRecord: Record {
    ///The id for the record
    let id: String = UUID().uuidString
    ///The name of the condition
    let name: String
    ///The description of the condition
    let description: String
    
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.name           = try container.decode(String.self, forKey: .name)
        self.description    = try container.decode(String.self, forKey: .description)
    }
}
