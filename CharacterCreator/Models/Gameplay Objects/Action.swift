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
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
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
