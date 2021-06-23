//
//  Poison.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/22/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

struct Poison {
    
}

//MARK: - Poison Record
///An model representing static data for a specific poison
@objc(PoisonRecord)
final
class PoisonRecord: ObjectRecord, Record {
    ///The core data representation of the applicationType property
    @NSManaged private var cdApplication: String
    ///Indicates how the poison's effects are applied
    var applicationType: PoisonApplication {
        get { return PoisonApplication(rawValue: cdApplication)! }
        set { cdApplication = newValue.rawValue }
    }
        
    required convenience
    init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        let container               = try decoder.container(keyedBy: CodingKeys.self)
        self.id                 = UUID().uuidString
        self.name               = try container.decode(String.self, forKey: .name)
        self.summary            = try container.decode(String.self, forKey: .summary)
        self.details            = try container.decode(String.self, forKey: .details)
        self.cost               = try container.decodeIfPresent(Int.self, forKey: .cost)
        self.weight             = try container.decodeIfPresent(Double.self, forKey: .weight)
        self.applicationType        = try container.decode(PoisonApplication.self, forKey: .applicationType)
    }
    
    ///Indicates how the poison's effects are applied
    enum PoisonApplication: String, Codable {
        case contact, ingested, inhaled, injury
        
        var description: String {
            switch self {
            case .contact: return "Contact poison can be smeared on an object and remains potent until it is touched or washed off. A creature that touches contact poison with exposed skin suffers its effects."
            case .ingested: return "A creature must swallow an entire dose of ingested poison to suffer its effects. The dose can be delivered in food or a liquid. You may decide that a partial dose has a reduced effect, such as allowing advantage on the saving throw or dealing only half damage on a failed save."
            case .inhaled: return "These poisons are powders or gases that take effect when inhaled. Blowing the powder or releasing the gas subjects creatures in a 5-­‐‑foot cube to its effect. The resulting cloud dissipates immediately afterward. Holding one’s breath is ineffective against inhaled poisons, as they affect nasal membranes, tear ducts, and other parts of the body."
            case .injury: return "Injury poison can be applied to weapons, ammunition, trap components, and other objects that deal piercing or slashing damage and remains potent until delivered through a wound or washed off. A creature that takes piercing or slashing damage from an object coated with the poison is exposed to its effects."
            }
        }
    }

    enum CodingKeys: CodingKey {
        case name, summary, details, cost, weight, applicationType
    }
}
