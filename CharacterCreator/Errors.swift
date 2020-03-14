//
//  Errors.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 3/13/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation

enum ParsingError: Error {
    case fileNotFound(filepath: URL)
}
