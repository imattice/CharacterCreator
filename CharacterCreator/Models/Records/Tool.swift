//
//  Tool.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/22/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

///An item that can be used with proficiency
struct Tool {
    
}

//MARK: - Tool Record
///An model representing static data for a specific tool
@objc(ToolRecord)
final
class ToolRecord: ObjectRecord, Record {
    @NSManaged private var cdCategory: String
    ///Indicates if the tool is artisan, musical, or gaming
    var category: Category {
        get { return Category(rawValue: cdCategory)! }
        set { cdCategory = newValue.rawValue }
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
        self.category       = try container.decodeIfPresent(Category.self, forKey: .category) ?? .other
    }
    
    enum CodingKeys: CodingKey {
        case name, summary, details, cost, weight, category
    }
    
    enum Category: String, Codable {
        case artisan, musical, gaming, other
    }
}
