//
//  Errors.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/18/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation


enum JSONError: Error {
    case fileNotFound,
         parsingError,
         missingManagedObjectContextForDecoder

}
