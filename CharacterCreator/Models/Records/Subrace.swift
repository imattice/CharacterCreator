//
//  Subrace.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/29/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

@objc(SubraceRecord)
final
class SubraceRecord: NSManagedObject, Record, Codable {
    ///An identifier for the record
    @NSManaged public var id: String
    ///A name of the record
    @NSManaged public var name: String
    ///A description of the record
    @NSManaged public var summary: String
    ///The name of the parent race for this subrace
    @NSManaged public var parent: String
    ///A reference to the parent RaceRecord
    @NSManaged public var parentRecord: RaceRecord?
    ///The core data representation of the features property
    @NSManaged private var cdFeatures: String
    ///The gameplay features granted by this race
    var features: [Feature] {
        get { return (try? JSONDecoder().decode([Feature].self, from: Data(cdFeatures.utf8)))!  }
        set {
            do {
                cdFeatures = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdFeatures = "" }
        }
    }
    ///The core data representation of the modifiers property
    @NSManaged private var cdModifiers: String
    ///The gameplay modifiers grated by this subrace
    var modifiers: [Modifier] {
        get { return (try? JSONDecoder().decode([Modifier].self, from: Data(cdFeatures.utf8))) ?? [Modifier]()  }
        set {
            do {
                cdModifiers = String(data: try JSONEncoder().encode(newValue), encoding:.utf8)!
           } catch { cdModifiers = "" }
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
        
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.name           = try container.decode(String.self, forKey: .name)
        self.summary    = try container.decode(String.self, forKey: .summary)
       
        self.modifiers       = try container.decodeIfPresent([AbilityScoreModifier].self, forKey: .abilityScoreIncrease) ?? [Modifier]()
        modifiers.forEach { $0.origin = .subrace }

        self.features       = try container.decode([Feature].self, forKey: .features)
        features.forEach { $0.origin = .subrace}
    }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(summary, forKey: .summary)
        try container.encode(features, forKey: .features)
        try container.encode(modifiers, forKey: .modifiers)
    }

    enum CodingKeys: CodingKey {
        case id, parent, name, summary, abilityScoreIncrease, features, modifiers
    }
}
