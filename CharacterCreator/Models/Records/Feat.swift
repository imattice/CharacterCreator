//
//  Feat.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/26/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//
import Foundation
import CoreData

///An object representing static information for a selectable feat
@objc(FeatRecord)
final class FeatRecord: NSManagedObject, Record {
    ///The id for the record
    @NSManaged public var id: String
    ///The name of the feat
    @NSManaged public var name: String
    ///A description of the feat
    @NSManaged public var summary: String
    ///A required prerequisite for the feat
    @NSManaged public var prerequisite: String?
    
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
        self.summary    = try container.decode(String.self, forKey: .summary)
        self.prerequisite   = try container.decodeIfPresent(String.self, forKey: .prerequisite)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(summary, forKey: .summary)
        try container.encode(prerequisite, forKey: .prerequisite)
    }
    
    enum CodingKeys: CodingKey {
        case id, name, summary, prerequisite
    }
    
}
