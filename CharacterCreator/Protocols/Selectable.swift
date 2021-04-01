//
//  Selectable.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 12/17/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation

protocol Selectable {
    var selection: String? { get set}
    var options: [String] { get }
}
