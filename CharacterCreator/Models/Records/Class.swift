//
//  Class.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
import UIKit
import CoreData

///An object representing static data for a specific class
@objc(ClassRecord)
final
class ClassRecord: NSManagedObject, Record, Codable {
    ///An id for the class
    @NSManaged public var id: String
    ///The name of the class
    @NSManaged public var name: String
    ///A description of the class
    @NSManaged public var summary: String
    ///The base value of the hit die for the class
    @NSManaged public var hitDie: Int
    ///The core data representation of the proficiencies property
    @NSManaged private var cdProficiencies: String
    ///Proficiencies granted by this class
    var proficiencies: ClassProficiencies {
        get { return (try? JSONDecoder().decode(ClassRecord.ClassProficiencies.self, from: Data(cdProficiencies.utf8)))! }
        set {
            do {
               let json = try JSONEncoder().encode(newValue)
               cdProficiencies = String(data: json, encoding:.utf8)!
           } catch { cdProficiencies = "" }
        }
    }
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
    ///The core data representation of the subclasses property
    @NSManaged private var cdSubclassRecords: NSSet
    ///The subclass records for this class
    var subclasses: [SubclassRecord] {
        get { return cdSubclassRecords.allObjects as! [SubclassRecord] }
    }

    ///The core data representation of the equipmentOptions property
    @NSManaged private var cdEquipmentOptions: String
    ///The starting equipment for this class
    var equipmentOptions: [Selection] {
        get { return (try? JSONDecoder().decode([Selection].self, from: Data(cdEquipmentOptions.utf8)))! }
        set {
            do {
               let json = try JSONEncoder().encode(newValue)
               cdEquipmentOptions = String(data: json, encoding:.utf8)!
           } catch { cdEquipmentOptions = "" }
        }
    }
    
    ///An object containing the proficiency granted by this class
    struct ClassProficiencies: Codable {
        ///The basic armor proficiencies provided by this class, if any
        let armor: [String]?
        ///The basic weapon proficiencies provided by this class
        let weapons: [String]
        ///The basic tool proficiencies provided by this class, if any
        let tools: [String]?
        ///The basic saving throw proficiencies provided by this class
        let savingThrows: [String]
        ///The basic skill proficiencies provided by this class
        let skills: Selection
                
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(armor,         forKey: .armor)
            try container.encode(weapons,       forKey: .weapons)
            try container.encode(tools,         forKey: .tools)
            try container.encode(savingThrows,  forKey: .savingThrows)
            try container.encode(skills,        forKey: .skills)
        }
        
        enum CodingKeys: CodingKey {
            case armor, weapons, tools, savingThrows, skills
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
        self.id              = UUID().uuidString
        self.name           = try container.decode(String.self, forKey: .name)
        self.summary    = try container.decode(String.self, forKey: .summary)
        self.hitDie         = try container.decode(Int.self, forKey: .hitDie)
        
        self.proficiencies   = try container.decode(ClassProficiencies.self, forKey: .proficiencies)

        self.features       = try container.decode([Feature].self, forKey: .features)
        features.forEach { $0.origin = .class}
        
        self.equipmentOptions = try container.decode([Selection].self, forKey: .equipmentOptions)
        
        linkSubclassRecords(in: managedObjectContext)
    }
    
    @objc(addCdSubclassRecordsObject:)
    @NSManaged public func addToCdSubclassRecords(_ value: SubclassRecord)

    @objc(removeCdSubclassRecordsObject:)
    @NSManaged public func removeFromCdSubclassRecords(_ value: SubclassRecord)

    @objc(addCdSubclassRecords:)
    @NSManaged public func addToCdSubclassRecords(_ values: NSSet)

    @objc(removeCdSubclassRecords:)
    @NSManaged public func removeFromCdSubclassRecords(_ values: NSSet)

    func linkSubclassRecords(in context: NSManagedObjectContext = CoreDataStack.shared.context) {
        let request = NSFetchRequest<SubclassRecord>(entityName: String(describing: SubclassRecord.self))
        guard let records = try? context.fetch(request),
              !records.isEmpty else { return }

        addToCdSubclassRecords(NSSet(array: records))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name,              forKey: .name)
        try container.encode(summary,           forKey: .summary)
        try container.encode(hitDie,            forKey: .hitDie)
        try container.encode(proficiencies,      forKey: .proficiencies)
        try container.encode(features,          forKey: .features)
        try container.encode(equipmentOptions,  forKey: .equipmentOptions)
    }
    
    enum CodingKeys: CodingKey {
        case name, summary, hitDie, proficiencies, features, subclasses, equipmentOptions
    }
}
