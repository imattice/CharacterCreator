//
//  MagicItem.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/22/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

struct MagicItem {
    
}

//MARK: - Magic Item Record
///An model representing static data for a specific magical item
@objc(MagicItemRecord)
final
class MagicItemRecord: NSManagedObject, Record {
    ///An identifier for the item
    @NSManaged public var id: String
    ///A name for the item
    @NSManaged public var name: String
    ///A description of the item
    @NSManaged public var summary: String
    ///Provides details on the gameplay mechanics of the item
    @NSManaged public var details: String
    ///The core data representation of the itemType property
    @NSManaged private var cdItemType: String
    var itemType: ItemType {
        get { return ItemType(rawValue: cdItemType)! }
        set { cdItemType = newValue.rawValue }
    }
    ///Indicates any restictions for the item, such as only being plate armor
    @NSManaged public var restrictions: String?
    ///The core data representation of the itemType property
    @NSManaged private var cdRarity: String
    ///Indicates the rarity of the item
    var rarity: Rarity {
        get { return Rarity(rawValue: cdRarity)! }
        set { cdRarity = newValue.rawValue }
    }
    ///Indicates if the item requires attunemnt to be used
    @NSManaged public var requiresAttunement: Bool
    
    required convenience
    init(from decoder: Decoder) throws {
        guard
            let managedObjectContextKey = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[managedObjectContextKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: String(describing: Self.self), in: managedObjectContext)
        else { fatalError("Failed to decode User") }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        self.name = try container.decode(String.self, forKey: .name)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.details = try container.decode(String.self, forKey: .details)
        self.restrictions = try container.decodeIfPresent(String.self, forKey: .restrictions)
        self.rarity = try container.decode(Rarity.self, forKey: .rarity)
        self.requiresAttunement = try container.decodeIfPresent(Bool.self, forKey: .requiresAttunement) ?? false
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(summary, forKey: .summary)
        try container.encode(details, forKey: .details)
        try container.encode(restrictions, forKey: .restrictions)
        try container.encode(rarity, forKey: .rarity)
        try container.encode(requiresAttunement, forKey: .requiresAttunement)
    }
    
    ///Indicates the rarity of the item
    enum Rarity: String, Codable {
        case common, uncommon, rare, veryRare, legendary, artifact
    }
    
    enum CodingKeys: CodingKey {
        case name, summary, details, restrictions, rarity, requiresAttunement
    }
    
    enum ItemType: String, Codable {
        case armor, weapon, item, rod, poison, potion, ring, scroll, staff, wand
    }
}

