//
//  Feat.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/26/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//
import Foundation

///An object representing static information for a selectable feat
struct FeatRecord: Record {
    ///The id for the record
    let id: String = UUID().uuidString
    ///The name of the feat
    let name: String
    ///A description of the feat
    let description: String
    ///A required prerequisite for the feat
    let prerequisite: String?
    
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.name           = try container.decode(String.self, forKey: .name)
        self.description    = try container.decode(String.self, forKey: .description)
        self.prerequisite   = try container.decodeIfPresent(String.self, forKey: .prerequisite)
    }
}
