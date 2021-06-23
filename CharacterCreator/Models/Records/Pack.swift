//
//  Pack.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/22/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData
///A collection of items that are purchased together
struct Pack {
    
}

//MARK: - Pack Record
///An model representing static data for a specific pack
@objc(PackRecord)
final
class PackRecord: ObjectRecord, Record {
    ///The core data representation of the armorStyle property
    @NSManaged private var cdContents: String
    ///A collection of items contained in the pack
    var contents: [Item] {
        get { return (try? JSONDecoder().decode([Item].self, from: Data(cdContents.utf8))) ?? [Item]() }
        set {
            do {
               let data = try JSONEncoder().encode(newValue)
               cdContents = String(data: data, encoding:.utf8)!
           } catch { cdContents = "" }
        }
    }
    
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
        self.contents       = try container.decode([Item].self, forKey: .contents)
    }
    enum CodingKeys: CodingKey {
        case name, summary, details, cost, weight, contents
    }
}
