//
//  Trap.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/11/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

///An model representing static data for a specific trap
@objc(TrapRecord)
final class TrapRecord: NSManagedObject, Record, Codable {
    ///A unique identifier for the disease
    @NSManaged public var id: String
    ///A name for the trap
    @NSManaged public var name: String
    ///A descriptive summary for the trap
    @NSManaged public var summary: String
    ///Indicates the type of trap (used to store value to Core Data)
    @NSManaged private var cdType: String
    ///Indicates the type of trap
    var type: TrapType {
        get { return TrapType(rawValue: cdType)! }
        set { cdType = newValue.rawValue }
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.id             = UUID().uuidString
        self.name           = try container.decode(String.self, forKey: .name)
        self.summary        = try container.decode(String.self, forKey: .summary)
        self.type           = try container.decode(TrapType.self, forKey: .type)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(summary, forKey: .summary)
        try container.encode(type.rawValue, forKey: .type)
    }
    
    enum CodingKeys: CodingKey {
        case name, summary, type
    }
    enum TrapType: String, Codable {
        case mechanical, magic
    }
}
