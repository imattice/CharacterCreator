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
    ///The title for the action
    let title: String
    ///A description for the action
    let description: String
    ///Indicates how and when the action will recharge
    let recharge: Recharge?
    
    init(title: String, description: String, recharge: Recharge? = nil) {
        self.title = title
        self.description = description
        self.recharge = recharge
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.recharge   = try container.decodeIfPresent(Recharge.self, forKey: .recharge)
    }
    
}

///Describes special actions that can be taken by some NPC's
class LegendaryAction: Action {
    ///The number of legendary points it takes to take this action
    let cost: Int
    
    init(title: String, description: String, cost: Int) {
        self.cost = cost
        
        super.init(title: title, description: description)
    }
    
    required
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.cost   = try container.decodeIfPresent(Int.self, forKey: .cost) ?? 1
        try super.init(from: decoder)
    }
    
    enum CodingKeys: CodingKey {
        case cost
    }
}
