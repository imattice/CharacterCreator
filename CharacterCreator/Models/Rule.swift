//
//  Rule.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/5/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation

struct RulesRecord: Record {
    let id: String = UUID().uuidString
    let name: String
    let description: String
    let subsection: [RulesRecord]
}
