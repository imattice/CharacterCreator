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
    let name: String
    let description: String
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}

class LegendaryAction: Action {
    let cost: Int
    
    init(name: String, description: String, cost: Int) {
        self.cost = cost
        
        super.init(name: name, description: description)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.cost   = try container.decode(Int.self, forKey: .cost)
        try super.init(from: decoder)
    }
    
    enum CodingKeys: CodingKey {
        case cost
    }
}
