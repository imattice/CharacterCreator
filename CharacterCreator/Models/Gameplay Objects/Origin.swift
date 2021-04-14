//
//  Origin.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/14/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation

///Indicate where a specific object originated
enum Origin: String, Codable {
    case race,
         subrace,
         `class`,
         background
}
