//
//  Item.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 9/2/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData

class Item: Codable {
    let name: String
    var count: Int = 1

    internal init(name: String, count: Int) {
        self.name = name
        self.count = count
    }
    
    //MARK: CODABLE
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.count  = try container.decodeIfPresent(Int.self, forKey: .count) ?? 1
    }
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(count, forKey: "count")
    }
}

//MARK: - Item Record
///Defines an object that can be collected, disposed and used by a character
@objc(ItemRecord)
final class ItemRecord: ObjectRecord, Record {
    required convenience init(from decoder: Decoder) throws {
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
    }
}


//MARK: - Object Record
///A common ancestor class that holds common properties for all items
///ItemRecord should be used rather than calling this class directly
@objc(ObjectRecord)
class ObjectRecord: NSManagedObject, Codable {
    ///A unique identifier for the object
    @NSManaged public var id: String
    ///A name for the object
    @NSManaged public var name: String
    ///A descriptive summary of the appearance of the object
    @NSManaged public var summary: String
    ///Details on the gameplay mechanics of the item
    @NSManaged public var details: String
    ///The core data representation of the cost property
    @NSManaged private var cdCost: NSNumber?
    ///The cost of the item in copper
    var cost: Int? {
        get {
            guard let cost = cdCost else { return nil }
            return Int(truncating: cost) }
        set {
            guard let cost = newValue else { cdCost = nil; return }
            cdCost = NSNumber(value: cost) }
    }
    ///The core data representation of the weight property
    @NSManaged private var cdWeight: NSNumber?
    ///The weight of the item in pounds
    var weight: Double? {
        get {
            guard let weight = cdWeight else { return nil }
            return Double(exactly: weight) }
        set {
            guard let weight = newValue else { cdWeight = nil; return }
            cdWeight = NSNumber(value: weight) }
    }
    
    required convenience init(from decoder: Decoder) throws {
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
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(summary, forKey: .summary)
        try container.encode(details, forKey: .details)
        try container.encodeIfPresent(cost, forKey: .cost)
        try container .encodeIfPresent(weight, forKey: .weight)
    }
    
    enum CodingKeys: CodingKey {
        case name, summary, details, cost, weight
    }
}
