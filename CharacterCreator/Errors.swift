//
//  Errors.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/14/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case fileNotFound,
         parsingError,
         missingManagedObjectContextForDecoder

}
