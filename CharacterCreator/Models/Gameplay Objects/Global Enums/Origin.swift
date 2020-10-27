//
//  Origin.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/27/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation

///options for where a specific object can be from
enum Origin: String, Codable {
    case race,
         subrace,
         `class`
}
