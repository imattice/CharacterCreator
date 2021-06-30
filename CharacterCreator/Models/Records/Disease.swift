//
//  Disease.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/11/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

///An model representing static data for a specific disease
@objc(DiseaseRecord)
final class DiseaseRecord: NSManagedObject, Record, Codable {
    ///A unique identifier for the disease
    @NSManaged public var id: String
    ///A name for the disease
    @NSManaged public var name: String
    ///A descriptive summary for the disease
    @NSManaged public var summary: String
    
    required convenience init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.name   = try container.decode(String.self, forKey: .name)
        self.summary = try container.decode(String.self, forKey: .summary)
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
