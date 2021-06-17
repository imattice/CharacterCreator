//
//  CodingUserInfoKey.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/14/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation

extension CodingUserInfoKey {
    ///Used to create a managed object context for ManagedObjects that also conform to Codable
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

///Thrown when a Managed Object Context cannot be created from the CodingUserInfoKey
enum DecoderConfigurationError: Error {
  case missingManagedObjectContext, missingCodingUserInfoKey
}

