//
//  ValueTransformers.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/23/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData


//Custom ValueTransformers prevent the Core Data warning from the default transformer


//MARK: - RaceRecord
@objc(RaceDescriptiveTransformer)
final class RaceDescriptiveTransformer: NSSecureUnarchiveFromDataTransformer {

    /// The name of the transformer. This is the name used to register the transformer using `ValueTransformer.setValueTrandformer(_"forName:)`.
    static let name = NSValueTransformerName(rawValue: String(describing: RaceDescriptiveTransformer.self))

    // 2. Make sure the class is in the allowed class list.
    override static var allowedTopLevelClasses: [AnyClass] {
        return [RaceRecord.Descriptive.self]
    }

    /// Registers the transformer.
    public static func register() {
        let transformer = RaceDescriptiveTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}

