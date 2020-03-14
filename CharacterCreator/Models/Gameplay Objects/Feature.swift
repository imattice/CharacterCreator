//
//  Feature.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 3/13/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation


struct FeatureRecord: Codable {
    let title: String
    let detail: String?
    let bullets: [String]?
    let choice: [String]?
    
    enum CodingKeys: CodingKey {
        case title, detail, bullets, choice
    }
}
