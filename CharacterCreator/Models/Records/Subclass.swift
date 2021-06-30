//
//  Subclass.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/29/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

///An object representing static data for a specific subclass
@objc(SubclassRecord)
final
class SubclassRecord: NSManagedObject, Record, Codable {
    ///An id for the subclass
    @NSManaged public var id: String
    ///The name of the subclass
    @NSManaged public var name: String
    ///A description of the subclass
    @NSManaged public var summary: String
    ///The core data representation of the features property
    @NSManaged private var cdFeatures: String
    ///The gameplay features granted by this race
    var features: [Feature] {
        get { return (try? JSONDecoder().decode([Feature].self, from: Data(cdFeatures.utf8)))! }
        set {
            do {
               let json = try JSONEncoder().encode(newValue)
               cdFeatures = String(data: json, encoding:.utf8)!
           } catch { cdFeatures = "" }
        }

    }
    ///The name of the parent class for this subclass
    @NSManaged public var parent: String
    ///A reference to the parent ClassRecord
    @NSManaged public var parentRecord: ClassRecord?
    
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
        
        self.features       = try container.decode([Feature].self, forKey: .features)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(summary, forKey: .summary)
        try container.encode(features, forKey: .features)
    }
    enum CodingKeys: CodingKey {
        case id, name, summary, features
    }
}

