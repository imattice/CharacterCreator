//
//  Disease.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/11/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation

struct DiseaseRecord: Record, Codable {
    let id: String = UUID().uuidString
    let name: String
    let description: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
    }
}
