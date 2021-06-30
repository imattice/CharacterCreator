//
//  Condition.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/26/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

@objc(ConditionRecord)
final class ConditionRecord: NSManagedObject, Record {
    ///The id for the record
    @NSManaged public var id: String
    ///The name of the condition
    @NSManaged public var name: String
    ///The description of the condition
    @NSManaged public var summary: String
    
    required convenience
    init(from decoder: Decoder) throws {
        guard
        let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
        let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
        let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
    else { fatalError("Failed to decode User") }

    self.init(entity: entity, insertInto: managedObjectContext)
        
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.name           = try container.decode(String.self, forKey: .name)
        self.summary        = try container.decode(String.self, forKey: .summary)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(summary, forKey: .summary)
    }
    
    enum CodingKeys: CodingKey {
        case id, name, summary
    }
}
