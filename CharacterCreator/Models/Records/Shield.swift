//
//  Shield.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/22/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

/// An equippable item that can be used to increase Armor Class
struct Shield {
    
    
}

//MARK: - Shield Record
///An model representing static data for a specific shield
@objc(ShieldRecord)
final
class ShieldRecord: ObjectRecord, Record {
    ///The AC bonus that the shield grants when equipped
    @NSManaged public var bonusAC: Int
    
    required convenience
    init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id                 = UUID().uuidString
        self.name               = try container.decode(String.self, forKey: .name)
        self.summary            = try container.decode(String.self, forKey: .summary)
        self.details            = try container.decode(String.self, forKey: .details)
        self.cost               = try container.decodeIfPresent(Int.self, forKey: .cost)
        self.weight             = try container.decodeIfPresent(Double.self, forKey: .weight)
        self.bonusAC       = try container.decode(Int.self, forKey: .bonusAC)
    }
    
    enum CodingKeys: CodingKey {
        case name, summary, details, cost, weight, bonusAC
    }
}

